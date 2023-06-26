*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL46DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6001_sol46demo.


TYPES: BEGIN OF gty_flights,
         connect TYPE spfli-connid,
         name    TYPE scarr-carrname,
         arrcty  TYPE spfli-cityfrom,
         depcty  TYPE spfli-cityto,
         "avgocc  TYPE f,
         avgocc  TYPE p DECIMALS 2,
       END OF gty_flights.


DATA: wa_sflight    TYPE sflight,
      wa_spfli      TYPE spfli,
      wa_scarr      TYPE scarr,
      gt_flights    TYPE TABLE OF gty_flights,
      name          TYPE c LENGTH 20,
      gv_occupation TYPE p DECIMALS 2.



*
*SELECT carrname AS name FROM scarr INTO name.
*
*  WRITE: /, name.
*
*ENDSELECT.



***with inline declarations
SELECT sp~connid AS connect, sc~carrname AS name, cityfrom AS depcty, cityto AS arrcty, AVG( seatsocc ) AS avgocc
  FROM spfli AS sp
  JOIN sflight AS sf ON sp~connid = sf~connid
  JOIN scarr AS sc ON sc~carrid = sp~carrid
GROUP BY sp~connid, sc~carrname, cityfrom, cityto
INTO TABLE @DATA(itab).


WRITE:/, 1'Conncetion', 21'Ariline', 41'City From', 61'City To', 81'Avg Occ'.
ULINE.
LOOP AT itab INTO DATA(gs_itab).
  gv_occupation = gs_itab-avgocc.

  WRITE:/, 1 gs_itab-connect, 21 gs_itab-name, 41 gs_itab-depcty, 61 gs_itab-arrcty, 71 gv_occupation.

ENDLOOP.


**Note always need to specify with alias~ if ambiguous column
*SELECT sp~connid AS connect, carrname AS name, cityfrom AS depcty, cityto AS arrcty,
*   AVG( seatsocc )  AS avgocc
*FROM spfli AS sp
*JOIN sflight AS sf ON sp~connid = sf~connid
*JOIN scarr AS sc ON sc~carrid = sp~carrid
*GROUP BY sp~connid, sc~carrname, cityfrom, cityto
*INTO TABLE @gt_flights.
*
*
*WRITE:/, 1'Conncetion', 21'Ariline', 41'City From', 61'City To', 81'Avg Occ'.
*ULINE.
*
*
*
*LOOP AT gt_flights INTO DATA(gs_flights).
*
*
*  WRITE:/, 1 gs_flights-connect, 21 gs_flights-name, 41 gs_flights-depcty, 61 gs_flights-arrcty, 71 gs_flights-avgocc.
*
*ENDLOOP.


**********************************************************************
***Check
**********************************************************************


SELECT AVG( seatsocc ) FROM sflight INTO gv_occupation WHERE carrid = 'LH' AND connid = '0400'.


WRITE: /, 'Check for LH the average occ is', ` `, gv_occupation.
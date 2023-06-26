*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL46
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6001_sol46.

TYPES: BEGIN OF gty_s_flights,
         carrier       TYPE scarr-carrname,
         connection    TYPE spfli-connid,
         cityfrom      TYPE spfli-cityfrom,
         cityto        TYPE spfli-cityto,
         avgoccupation TYPE sflight-seatsocc,
       END OF gty_s_flights.

DATA: gt_flights     TYPE TABLE OF gty_s_flights,
      wa_flights     LIKE LINE OF gt_flights,
      wa_scarr       TYPE scarr,
      wa_spfli       TYPE spfli,
*      gv_seatsocc     TYPE sflight-seatsocc,
*      gv_sumsflight   TYPE sflight-seatsocc,
      gv_seatsoccavg TYPE sflight-seatsocc.

SELECT * FROM scarr INTO wa_scarr.

  SELECT * FROM spfli INTO wa_spfli WHERE carrid = wa_scarr-carrid.


    SELECT AVG( seatsocc ) FROM sflight INTO gv_seatsoccavg WHERE connid = wa_spfli-connid.

    wa_flights-carrier = wa_scarr-carrname.
    wa_flights-connection = wa_spfli-connid.
    wa_flights-cityfrom = wa_spfli-cityfrom.
    wa_flights-cityto = wa_spfli-cityto.
    wa_flights-avgoccupation = gv_seatsoccavg.

    APPEND wa_flights TO gt_flights.
  ENDSELECT.
ENDSELECT.

CLEAR wa_flights.

SORT gt_flights BY avgoccupation ASCENDING.

LOOP AT gt_flights INTO wa_flights.

WRITE: /, wa_flights-carrier, wa_flights-connection, wa_flights-avgoccupation.

ENDLOOP.


**********************************************************************
***Check
**********************************************************************


DATA: gv_avg TYPE INT4.

SELECT AVG( seatsocc ) FROM sflight INTO  gv_avg WHERE carrid = 'AA'.

WRITE: /, 'Check 1', gv_avg.

SELECT AVG( seatsocc ) FROM sflight INTO  gv_avg WHERE connid = 0017.

 WRITE: /, 'Check 2', gv_avg.
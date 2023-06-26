*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL62
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6001_sol62.



TYPES: BEGIN OF t_flight,
         carrname TYPE scarr-carrname,
         connid   TYPE spfli-connid,
         cityto   TYPE spfli-cityto,
         cityfrom TYPE spfli-cityfrom,
         fldate   TYPE sflight-fldate,
         price    TYPE sflight-price,
         currency TYPE sflight-currency,
         free     TYPE p DECIMALS 1,
       END OF t_flight.

DATA: wa_scarr      TYPE scarr,
      wa_spfli      TYPE spfli,
      wa_sflight    TYPE sflight,
      itab_t_flight TYPE TABLE OF t_flight,
      wa_t_flight   LIKE LINE OF itab_t_flight,
      sparerel      TYPE p DECIMALS 1.

SELECT-OPTIONS: s_cfrom FOR wa_t_flight-cityfrom DEFAULT 'FRANKFURT' NO INTERVALS,
                s_cto FOR wa_t_flight-cityto DEFAULT 'NEW YORK' NO INTERVALS,
                s_date FOR wa_t_flight-fldate DEFAULT '20200701' TO '20201231'.

START-OF-SELECTION.

  SELECT * FROM scarr INTO wa_scarr.

    SELECT * FROM spfli INTO @wa_spfli
      WHERE cityfrom IN @s_cfrom AND cityto IN @s_cto AND carrid = @wa_scarr-carrid.

      SELECT * FROM sflight INTO wa_sflight
        WHERE connid = wa_spfli-connid AND fldate IN s_date.

        sparerel = ( wa_sflight-seatsocc * 100 ) / wa_sflight-seatsmax.

        wa_t_flight-fldate = wa_sflight-fldate.
        wa_t_flight-price = wa_sflight-price.
        wa_t_flight-currency = wa_sflight-currency.
        wa_t_flight-free = sparerel.
        wa_t_flight-carrname = wa_scarr-carrname.
        wa_t_flight-connid = wa_spfli-connid.
        wa_t_flight-cityfrom = wa_spfli-cityfrom.
        wa_t_flight-cityto = wa_spfli-cityto.

        APPEND wa_t_flight TO itab_t_flight.

      ENDSELECT.
    ENDSELECT.
  ENDSELECT.

SORT itab_t_flight BY price ASCENDING fldate DESCENDING.

  PERFORM ausgabe.

FORM ausgabe.
  LOOP AT itab_t_flight INTO wa_t_flight.
    WRITE: / wa_t_flight-carrname, wa_t_flight-connid, wa_t_flight-cityfrom, wa_t_flight-cityto,
    wa_t_flight-fldate, wa_t_flight-price, wa_t_flight-currency, wa_t_flight-free.

    IF sparerel > 80.
      WRITE: '*'.
    ENDIF.
  ENDLOOP.
ENDFORM.

*Oder:
*
*
*"Typen Deklaration
*TYPES: BEGIN OF t_flight,
*         carrname TYPE scarr-carrname,
*         connid   TYPE spfli-connid,
*         cityfrom TYPE spfli-cityfrom,
*         cityto   TYPE spfli-cityto,
*         belegung TYPE p DECIMALS 2,
*         fldate   TYPE sflight-fldate,
*         currency TYPE sflight-currency,
*         price    TYPE sflight-price,
*       END OF t_flight.
*
* "VAriablen Deklaration, mit WA und itab
*
*DATA: wa_spfli    TYPE spfli,
*      wa_sflight  TYPE sflight,
*      wa_scarr    TYPE scarr,
*      wa_fluege   TYPE t_flight,
*      itab_fluege TYPE TABLE OF t_flight. "Interne Tabelle
*
*SELECT-OPTIONS:
*s_cfrom FOR wa_spfli-cityfrom NO INTERVALS,
*s_cto FOR wa_spfli-cityto NO INTERVALS,
*s_date FOR wa_sflight-fldate.
*
*
*"Selekt - Befehle mit joins
*SELECT * FROM scarr INTO wa_scarr.
*SELECT * FROM spfli INTO wa_spfli WHERE carrid = wa_scarr-carrid AND cityfrom IN s_cfrom AND cityto IN s_cto.
*SELECT * FROM sflight INTO wa_sflight WHERE carrid = wa_spfli-carrid AND connid = wa_spfli-connid AND fldate IN s_date.
*
*
*"Befüllung de WA
*
*"Berechnung der Belegung
*      wa_fluege-belegung = ( wa_sflight-seatsocc / wa_sflight-seatsmax ) * 100.
*
*      wa_fluege-carrname = wa_scarr-carrname.
*      wa_fluege-cityfrom = wa_spfli-cityfrom.
*      wa_fluege-cityto =  wa_spfli-cityto.
*      wa_fluege-connid =  wa_spfli-connid.
*      wa_fluege-currency = wa_sflight-currency.
*      wa_fluege-fldate = wa_sflight-fldate.
*      wa_fluege-price = wa_sflight-price.
*
*
*      APPEND wa_fluege TO itab_fluege.  "Einfügegen in die inerene Tablle Flüge
*    ENDSELECT.
*  ENDSELECT.
*ENDSELECT.
*
*"Absteigende Sortierung der itab beim preis aufsteigen und datum absteigend
*SORT itab_fluege BY price ASCENDING fldate DESCENDING.
*
*
*"Ausgeben durch die itab
*LOOP AT itab_fluege INTO wa_fluege.
*  WRITE:/  wa_fluege-carrname, wa_fluege-connid, wa_fluege-cityfrom, wa_fluege-cityto, wa_fluege-fldate,wa_fluege-price, wa_fluege-currency, wa_fluege-belegung.
*  IF wa_fluege-belegung >= 80.
*    WRITE: '*'.
*  ENDIF.
*ENDLOOP.
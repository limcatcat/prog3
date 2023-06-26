*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL61
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6001_sol61.

DATA: wa_scarr   TYPE scarr,
      wa_spfli   TYPE spfli,
      wa_sflight TYPE sflight,
      sparerel   TYPE p DECIMALS 1.

SELECT-OPTIONS: s_cfrom FOR wa_spfli-cityfrom DEFAULT 'FRANKFURT' NO INTERVALS,
                s_cto FOR wa_spfli-cityto DEFAULT 'NEW YORK' NO INTERVALS,
                s_date FOR wa_sflight-fldate DEFAULT '20120701' TO '20121231'.

SELECT * FROM scarr INTO wa_scarr.

  SELECT * FROM spfli INTO @wa_spfli
    WHERE cityfrom IN @s_cfrom AND cityto IN @s_cto AND carrid = @wa_scarr-carrid.

    WRITE: /, wa_scarr-carrname, wa_spfli-connid, wa_spfli-cityfrom, wa_spfli-cityto.

    SELECT * FROM sflight INTO wa_sflight
      WHERE connid = wa_spfli-connid AND fldate IN s_date.

      sparerel = ( wa_sflight-seatsocc * 100 ) / wa_sflight-seatsmax.

      WRITE: / wa_sflight-fldate, wa_sflight-price, wa_sflight-currency, sparerel, '%'.

      IF sparerel > 80.
        WRITE: '*'.
      ENDIF.

    ENDSELECT.
  ENDSELECT.
ENDSELECT.


* Deklaration der Variablen
*DATA: wa_spfli   TYPE spfli,
*      wa_sflight TYPE sflight,
*      wa_scarr   TYPE scarr,
*      belegung   TYPE p DECIMALS 2.
*
*SELECT-OPTIONS:
*s_cfrom FOR wa_spfli-cityfrom NO INTERVALS, "wollen ja nicht mehrere Städte
*s_cto FOR wa_spfli-cityto NO INTERVALS,
*s_date FOR wa_sflight-fldate. "ein Intervall
*
*Select-Befehle mit joins
*SELECT * FROM scarr INTO wa_scarr.
*
*Stadtname, Ablufstart usw
*SELECT * FROM spfli INTO wa_spfli WHERE carrid = wa_scarr-carrid AND cityfrom IN s_cfrom AND cityto IN s_cto.
*WRITE:/  wa_scarr-carrname, wa_spfli-connid, wa_spfli-cityfrom, wa_spfli-cityto.
*
*SELECT * FROM sflight INTO wa_sflight WHERE carrid = wa_spfli-carrid AND connid = wa_spfli-connid AND fldate IN s_date.
*
*Belegung berechnen
*belegung = ( wa_sflight-seatsocc / wa_sflight-seatsmax ) * 100.
*Ausgbae
*WRITE:/ wa_sflight-fldate, wa_sflight-price, wa_sflight-currency, belegung , '%‘
*    IF belegung > 80.
*      WRITE: '*'.
*    ENDIF.
*    ENDSELECT.
*  ENDSELECT.
*ENDSELECT.
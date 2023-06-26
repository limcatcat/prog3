*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL43DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6001_sol43demo.


DATA: wa_sflight TYPE sflight,
      wa_spfli   TYPE spfli,
      gv_occupation TYPE p DECIMALS 2.



WRITE: /, 1 'From', 21 'To',  61 'Date', 74 'Occupied', 89 'Free'.

SELECT * FROM spfli INTO wa_spfli.

WRITE: /, 1 wa_spfli-cityfrom, 21 wa_spfli-cityto.


  SELECT * FROM sflight INTO wa_sflight WHERE carrid = wa_spfli-carrid AND connid = wa_spfli-connid.

  IF ( ( wa_sflight-seatsmax - wa_sflight-seatsocc ) * 100 ) < 90 .

    WRITE: /,  61 wa_sflight-fldate COLOR COL_NEGATIVE, 69 wa_sflight-seatsocc, 89 |{ wa_sflight-seatsmax - wa_sflight-seatsocc } |.

  ENDIF.

    WRITE: /,  61 wa_sflight-fldate, 69 wa_sflight-seatsocc, 89 |{ wa_sflight-seatsmax - wa_sflight-seatsocc } |.

  ENDSELECT.

ENDSELECT.
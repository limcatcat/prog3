*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL44
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z30922_6001_SOL44.

PARAMETERS p_carrid TYPE spfli-carrid.

DATA: wa_spfli   TYPE spfli,
      wa_sflight TYPE sflight,
      wa_book    TYPE sbook,
      gv_occupation TYPE p DECIMALS 2.

WRITE: 'Airline selected ', p_carrid.
ULINE.

***Nested SQL Statement
SELECT * FROM spfli INTO wa_spfli WHERE carrid = p_carrid.
  WRITE:/, 1 'City from', 21 'City to',41 'Connection ID'.
  WRITE:/, 1 wa_spfli-cityfrom, 21 wa_spfli-cityto, 41 wa_spfli-connid.
  ULINE.

  WRITE:/, 1 'Flight Date', 15 'Price', 24 '#avail.', 40 'occupation'.

  SELECT * FROM sflight INTO wa_sflight WHERE carrid = wa_spfli-carrid AND connid = wa_spfli-connid.
    gv_occupation = ( wa_sflight-seatsocc / wa_sflight-seatsmax ) * 100.

    IF gv_occupation >= 90.
      WRITE:/ wa_sflight-fldate, (10) wa_sflight-price, (10) |{ wa_sflight-seatsmax - wa_sflight-seatsocc }|,  gv_occupation COLOR COL_NEGATIVE, '%' COLOR COL_NEGATIVE.

    ELSEIF 90 > gv_occupation AND gv_occupation >= 80.
      WRITE:/ wa_sflight-fldate, (10) wa_sflight-price, (10) |{ wa_sflight-seatsmax - wa_sflight-seatsocc }|, gv_occupation COLOR COL_TOTAL, '%' COLOR COL_TOTAL.
    ELSE.
      WRITE:/ wa_sflight-fldate, (10) wa_sflight-price, (10) |{ wa_sflight-seatsmax - wa_sflight-seatsocc }|, gv_occupation COLOR COL_POSITIVE, '%' COLOR COL_POSITIVE.
    ENDIF.
  ENDSELECT.
ENDSELECT.
*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL32
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6001_sol32.

**********************************************************************
***3.2 - currency conversion DD
**********************************************************************




PARAMETERS: p_fcurr(3) TYPE c,
            p_tcurr(3) TYPE c,
            p_amount   TYPE p DECIMALS 3.

**Data Dictionary -
DATA: wa_conversion TYPE z30920768_currency,
      gt_conversion TYPE TABLE OF z30920768_currency,
      wa_tcurr      TYPE tcurr,
      wa_tcurt      TYPE tcurt,
      gv_ltext      TYPE ltext,
      gv_oamount    TYPE p DECIMALS 3,
      gv_camount    TYPE p DECIMALS 3.

gv_oamount = p_amount.

SELECT * FROM tcurr INTO wa_tcurr.

  SELECT SINGLE ltext FROM tcurt INTO gv_ltext WHERE waers = wa_tcurr-fcurr.
  wa_conversion-from_name = gv_ltext.
  wa_conversion-from_currency = wa_tcurr-fcurr.
  wa_conversion-to_currency = wa_tcurr-tcurr.
  wa_conversion-rate = wa_tcurr-ukurs.

  APPEND wa_conversion TO gt_conversion.

ENDSELECT.


LOOP AT gt_conversion INTO wa_conversion.

  IF wa_conversion-from_currency = p_fcurr AND wa_conversion-to_currency = p_tcurr.
    gv_camount = gv_oamount * wa_conversion-rate.
    WRITE:/ 'Betrag: ', gv_camount,  wa_conversion-to_currency.

*    WRITE:/ 'Betrag: ', |{ conversion_wa-rate * p_value }|,  conversion_wa-to_currency.
  ENDIF.

ENDLOOP.
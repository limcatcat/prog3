*&---------------------------------------------------------------------*
*& Report Z309_6001_SOL31
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6001_sol31.


**********************************************************************
***3.1 - currency conversion
**********************************************************************


**define structure type
TYPES: BEGIN OF gty_currency_conversion,
         from_currency(3) TYPE c,
         to_currency(3)   TYPE c,
         from_name(20)    TYPE c,
         to_name(20)      TYPE c,
         rate             TYPE p DECIMALS 4,
       END OF gty_currency_conversion.


**read input data
PARAMETERS: p_fcurr(3) TYPE c,
            p_tcurr(3) TYPE c,
            p_amount   TYPE p DECIMALS 3.

**declare work area and table
DATA: wa_conversion TYPE gty_currency_conversion, "or gs_conversion
      gt_conversion TYPE TABLE OF gty_currency_conversion.

DATA: gv_fcurr(3) TYPE c, gv_tcurr(3) TYPE c, gv_oamount TYPE p DECIMALS 3, gv_camount TYPE p DECIMALS 3, gv_nodataset(1) TYPE c.

gv_fcurr = p_fcurr.
gv_tcurr = p_tcurr.
gv_oamount = p_amount.

*or
*	conversion_itab     TYPE TABLE OF T_CURRENCY_CONVERSION,
*     conversion_wa       LIKE LINE OF conversion_itab ,

*Conversion rates as of 21.10.2022:
*EUR/AUD = 1.55
*EUR/CAD = 1.35
*EUR/CHF = 0.99
*EUR/JPY = 147,56
*EUR/GBP = 0.88
*EUR/USD = 0.98

wa_conversion-from_currency = 'EUR'.
wa_conversion-to_currency = 'AUD'.
wa_conversion-from_name =  'European Euro'.
wa_conversion-to_name = 'Australian Dollar'.
wa_conversion-rate = '1.55'.

APPEND wa_conversion TO gt_conversion.

wa_conversion-from_currency = 'EUR'.
wa_conversion-to_currency = 'CAD'.
wa_conversion-from_name =  'European Euro'.
wa_conversion-to_name = 'Canadian Dollar'.
wa_conversion-rate = '1.35'.

APPEND wa_conversion TO gt_conversion.


wa_conversion-from_currency = 'EUR'.
wa_conversion-to_currency = 'CHF'.
wa_conversion-from_name =  'European Euro'.
wa_conversion-to_name = 'Swiss Francs'.
wa_conversion-rate = '0.99'.

APPEND wa_conversion TO gt_conversion.

*** + do same for other currencies


*Iteration über die interne Tabelle
LOOP AT gt_conversion INTO wa_conversion.
*Write: sy-tabix.
  IF wa_conversion-from_currency = gv_fcurr AND wa_conversion-to_currency = gv_tcurr.
    gv_camount = gv_oamount * wa_conversion-rate.
    WRITE: /, 5 'Conversion of',wa_conversion-from_name, 'to' , wa_conversion-to_name.
    WRITE: /, 10 gv_oamount, gv_fcurr, gv_camount,  gv_tcurr.
    ULINE: /, 5(20).
*    WRITE:/ 'Betrag: ', |{ conversion_wa-rate * p_value }|,  conversion_wa-to_currency.
    gv_nodataset = ' '.
    EXIT.
  ELSE.
    gv_nodataset = 'x'.
  ENDIF.
ENDLOOP.

IF gv_nodataset = 'x'.

  WRITE: 'Conversion rate not available'.

ENDIF.



*Alternative with READ

*READ TABLE gt_conversion INTO wa_conversion WITH KEY from_currency = p_fcurr to_currency = p_tcurr.
*
*IF sy-subrc = 4.
*  WRITE: 'dataset not available'.
*
**careful p_value wurde vorher verändert, deswegen unterschiedliche Werte
*ELSE.
*  p_value = wa_conversion-rate * p_value.
*  WRITE:/ 'Amount ', p_value,  wa_conversion-to_currency.
*
*ENDIF.
*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL33
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6001_sol33.

**********************************************************************
***3.3 - currency conversion Open SQL / Database Table
**********************************************************************


*3.3 -> update! like 3.1

"Input parameters
PARAMETERS:
  p_fcurr  TYPE c LENGTH 3,
  p_tcurr  TYPE c LENGTH 3,
  p_amount TYPE p LENGTH 5 DECIMALS 3.

"Create work areas and result variables
" + Variable für Ergebnis
DATA: wa_tcurr    TYPE tcurr,
      wa_tcurt_fr TYPE tcurt,
      wa_tcurt_to TYPE tcurt,
      gv_camount  TYPE p DECIMALS 4,
      gv_oamount  TYPE p DECIMALS 3.

gv_oamount = p_amount.

"Get data from tables and store in work area with Open SQL

SELECT SINGLE * FROM tcurr INTO wa_tcurr WHERE tcurr = p_tcurr AND fcurr = p_fcurr.
SELECT SINGLE * FROM tcurt INTO wa_tcurt_fr WHERE waers = p_fcurr.
SELECT SINGLE * FROM tcurt INTO wa_tcurt_to WHERE waers = p_tcurr.

"Calculate end result
IF sy-subrc = 4.
  WRITE 'conversion rated not available '.
ELSE.
  gv_camount = wa_tcurr-ukurs * gv_oamount.
  WRITE: / wa_tcurt_fr-ltext, 'to', wa_tcurt_to-ltext.
  WRITE: / gv_oamount, wa_tcurr-fcurr, 'to', wa_tcurr-tcurr, '=', gv_camount.
ENDIF.
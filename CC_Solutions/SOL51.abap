*&---------------------------------------------------------------------*
*& Report z30922_6001_SOL51
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT z30922_6001_sol51.

PARAMETERS: p_length TYPE p DECIMALS 2, p_width TYPE p DECIMALS 2.

DATA: gv_area   TYPE p DECIMALS 2, gv_circum TYPE p DECIMALS 2.

CALL FUNCTION 'Z30922_6001FM_RECTCAL'
  EXPORTING
    ip_length     = p_length
    ip_width     = p_width
  IMPORTING
    ep_area      = gv_area
    ep_circum    = gv_circum
  EXCEPTIONS
    number_error = 1.

IF sy-subrc = 1.
  WRITE: /, ' Wrong Number format'.

ELSE.
  WRITE: /, `The rectangle has an area of: ` , gv_area.
  WRITE: /, `The rectangle has an circumference of: ` , gv_circum.
ENDIF.
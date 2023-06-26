FUNCTION Z30922_6001FM_RECTCAL. "ist jetzt 062
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IP_LENGTH) TYPE  P
*"     REFERENCE(IP_WIDTH) TYPE  P
*"  EXPORTING
*"     REFERENCE(EP_AREA) TYPE  P
*"     REFERENCE(EP_CIRCUM) TYPE  P
*"  EXCEPTIONS
*"      NUMBER_ERROR
*"----------------------------------------------------------------------


if ip_length <= 0 or ip_width <= 0.
  raise NUMBER_ERROR.
else.
  ep_area = ip_length * ip_width.
  ep_circum = 2 * ( ip_length + ip_width ).
endif.



ENDFUNCTION.
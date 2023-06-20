*&---------------------------------------------------------------------*
*& Report Z30922_6009_NEW_TRYCONTROL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6009_new_trycontrol.

DATA: gv_number1 TYPE i, gv_number2 TYPE i.


DO 10 TIMES.
  WRITE: sy-vline. " = '|'
  gv_number1 = sy-index. " index starts with 1
  WRITE: (5) gv_number1 COLOR COL_NEGATIVE.
ENDDO.

ULINE.

DO 10 TIMES.
  WRITE: sy-vline. " = '|'
  gv_number2 = sy-index.
  WRITE: (5) gv_number2 CENTERED.
ENDDO.

ULINE.
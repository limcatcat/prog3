*&---------------------------------------------------------------------*
*& Report Z30922_6009_NEW_STRING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6009_new_string.


DATA gv_text1 TYPE string.
DATA gv_text2 TYPE string.
DATA gv_text3 TYPE string.
DATA gv_text4 TYPE string.

gv_text1 = 'Quokka Master'.
gv_text2 = 'Quokka'.

CONCATENATE gv_text1 gv_text2 INTO gv_text3 SEPARATED BY space.

gv_text4 = gv_text1 && ' ' && gv_text2.

WRITE: gv_text3, /, gv_text4.



FIND 'Q' IN gv_text1.

IF sy-subrc = 0.
  WRITE: /, 'pattern found'.

ELSE.
  WRITE: /, 'pattern not found'.

ENDIF.



REPLACE 'Master' IN gv_text1 WITH 'Owner'.

IF sy-subrc = 0.
  WRITE: /, gv_text1.

ELSE.
  WRITE: /, 'pattern not found'.

ENDIF.



TRANSLATE gv_text1 TO LOWER CASE.
WRITE: /, gv_text1.

TRANSLATE gv_text1 TO UPPER CASE.
WRITE: /, gv_text1.

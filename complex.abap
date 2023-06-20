*&---------------------------------------------------------------------*
*& Report Z30922_6009_NEW_COMPLEX
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6009_new_complex.


TYPES: BEGIN OF gty_s_employee,
         pernr     TYPE i,
         firstname TYPE string,
         name      TYPE string,
         age       TYPE i,
       END OF gty_s_employee.


TYPES gty_t_employee TYPE TABLE OF gty_s_employee.


DATA gs_employee TYPE gty_s_employee.
DATA gs_employee1 TYPE gty_s_employee.
DATA gt_employee TYPE gty_t_employee.
DATA gt_employee1 TYPE TABLE OF gty_s_employee. "WITH UNIQUE KEY pernr.




gs_employee-pernr = 1.
gs_employee-firstname = 'Quokka'.
gs_employee-name = 'The Pug'.
gs_employee-age = 32.

APPEND gs_employee TO gt_employee.
CLEAR gs_employee.

gs_employee-pernr = 3.
gs_employee-firstname = 'Lionel'.
gs_employee-name = 'Messi'.
gs_employee-age = 36.

APPEND gs_employee TO gt_employee.
CLEAR gs_employee.

gs_employee-pernr = 2.
gs_employee-firstname = 'Nara'.
gs_employee-name = 'Han'.
gs_employee-age = 32.

INSERT gs_employee INTO gt_employee INDEX 2.


"copy values with MOVE TO
MOVE gs_employee-pernr TO gs_employee1-pernr.
WRITE gs_employee1-pernr.

WRITE: /, gs_employee1-pernr, gs_employee1-firstname, gs_employee1-name, gs_employee1-age.
MOVE-CORRESPONDING gs_employee TO gs_employee1.
WRITE: /, gs_employee1-pernr, gs_employee1-firstname, gs_employee1-name, gs_employee1-age.



READ TABLE gt_employee INDEX 2 INTO gs_employee.

"READ TABLE gt_employee WITH TABLE KEY pernr = 1 INTO gs_employee1. "This only works when you've already set a primary key for the table

READ TABLE gt_employee WITH KEY name = 'The Pug' INTO gs_employee.
WRITE: /, gs_employee-pernr, gs_employee-firstname, gs_employee-name, gs_employee-age.





LOOP AT gt_employee INTO gs_employee. "WHERE can be added

  ULINE.
  WRITE: /, gs_employee-pernr, gs_employee-firstname, gs_employee-name, gs_employee-age.

ENDLOOP.




READ TABLE gt_employee INDEX 2 INTO gs_employee.

MODIFY gt_employee FROM gs_employee INDEX 3.


LOOP AT gt_employee INTO gs_employee. "WHERE can be added

  ULINE.
  WRITE: /, gs_employee-pernr, gs_employee-firstname, gs_employee-name, gs_employee-age.

ENDLOOP.


gs_employee1-pernr = 3.
gs_employee1-firstname = 'Lionel'.
gs_employee1-name = 'Messi'.
gs_employee1-age = 36.

DELETE TABLE gt_employee FROM gs_employee1.

IF sy-subrc <> 0.
  WRITE: /, 'Deletion did not work'.

ENDIF.


LOOP AT gt_employee INTO gs_employee. "WHERE can be added

  ULINE.
  WRITE: /, gs_employee-pernr, gs_employee-firstname, gs_employee-name, gs_employee-age.

ENDLOOP.




APPEND LINES OF gt_employee TO gt_employee1.

LOOP AT gt_employee1 INTO gs_employee1. "WHERE can be added

  ULINE.
  WRITE: /'Table employee1', gs_employee1-pernr, gs_employee1-firstname, gs_employee1-name, gs_employee1-age.

ENDLOOP.
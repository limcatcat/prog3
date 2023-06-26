*&---------------------------------------------------------------------*
*& Report Z30922_6009_NEW_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*


INCLUDE Z30922_6009_NEW_ALV_TOP                 .    " Global Data

* INCLUDE Z30922_6009_NEW_ALV_O01                 .  " PBO-Modules
* INCLUDE Z30922_6009_NEW_ALV_I01                 .  " PAI-Modules
* INCLUDE Z30922_6009_NEW_ALV_F01                 .  " FORM-Routines

DATA: lo_container TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      gt_sflight TYPE TABLE OF sflight.

SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_sflight UP TO 300 ROWS.


CREATE OBJECT lo_container
EXPORTING
  container_name = 'MYCONTAINER'.



DATA: lt_fcat TYPE lvc_t_fcat.

CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
EXPORTING
  i_structure_name = 'SFLIGHT'
CHANGING
  ct_fieldcat = lt_fcat.



DATA: lo_alv TYPE REF TO CL_GUI_ALV_GRID.

*CREATE OBJECT lo_alv
*EXPORTING
*  i_parent = lo_container.

lo_alv = NEW CL_GUI_ALV_GRID( lo_container ).



lo_alv->SET_TABLE_FOR_FIRST_DISPLAY(
  CHANGING
    it_outtab = gt_sflight
    it_fieldcatalog = lt_fcat
).


CALL SCREEN 0100. "THIS LINE IS NECESSARY!!!


INCLUDE z30922_6009_new_alv_usc100.

INCLUDE z30922_6009_new_alv_stat100.
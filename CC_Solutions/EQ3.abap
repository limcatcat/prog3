*&---------------------------------------------------------------------*
*& Report Z30922_6001_EQ3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6001_eq3.

**********************************************************************
***Test Exam Example Question 3
**********************************************************************

TABLES: scustom.

SET SCREEN 100.

*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '100'.
* SET TITLEBAR 'xxx'.

  DATA: cc_log      TYPE REF TO cl_gui_custom_container,
        alv_grid    TYPE REF TO cl_gui_alv_grid,
        custom_itab TYPE TABLE OF scustom,
        ok_code     TYPE sy-ucomm.


  PERFORM load.

  IF cc_log IS INITIAL.
    CREATE OBJECT cc_log EXPORTING container_name = 'CC_LOG'.
    CREATE OBJECT alv_grid EXPORTING i_parent = cc_log.
    CALL METHOD alv_grid->set_table_for_first_display EXPORTING i_structure_name = 'scustom' CHANGING it_outtab = custom_itab.
  ELSE.
    CALL METHOD alv_grid->refresh_table_display.
  ENDIF.



ENDMODULE.

FORM load.
  SELECT * FROM scustom INTO TABLE @custom_itab.
ENDFORM.

FORM clean_up.
  alv_grid->free( ).
  cc_log->free( ).
  CLEAR: custom_itab,alv_grid,cc_log.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'BACK'.
      PERFORM clean_up.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      PERFORM clean_up.
      LEAVE PROGRAM.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
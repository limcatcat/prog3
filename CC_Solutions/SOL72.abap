*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL72
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z30922_6001_SOL72.


DATA: vorname        TYPE z30921_815t_stdb-vorname,
      nachname       TYPE z30921_815t_stdb-nachname,
      geburtsdatum   TYPE z30921_815t_stdb-geburtsdatum,
      semester       TYPE z30921_815t_stdb-semester,
      fakultaet      TYPE z30921_815t_stdb-fakultaet,
      matrikelnummer TYPE z30921_815t_stdb-matrikelnummer,
      ok_code           TYPE sy-ucomm.

SET SCREEN 100.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.


  CASE ok_code.
    WHEN 'ADD'.
      CALL FUNCTION 'Z_30921_815FB_065_STDVERT'
        EXPORTING
          ip_vorname      = vorname
          ip_nachname     = nachname
          ip_geburtsdatum = geburtsdatum
          ip_semester     = semester
          ip_fakultaet    = fakultaet
        IMPORTING
          ex_mat          = matrikelnummer
        EXCEPTIONS
          infos_fehler    = 1
          modify_fehler   = 2
          OTHERS          = 3.

      IF sy-subrc = 1.
        MESSAGE 'Please fill all fields!' TYPE 'E'.
      ELSEIF sy-subrc = 2.
        MESSAGE 'Error in table!' TYPE 'E'.
      ELSEIF sy-subrc = 3.
        MESSAGE 'System error' TYPE 'E'.
      ELSE.
        PERFORM clearfields.
        MESSAGE |student added successfully with matriculation number: { matrikelnummer } | TYPE 'I'.
      ENDIF.

    WHEN 'CLEAR'.
      PERFORM clearfields.

    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN OTHERS.
      "egal
  ENDCASE.

ENDMODULE.


*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
  SET TITLEBAR '0100'.
ENDMODULE.


FORM clearfields.
  vorname = ''.
  nachname = ''.
  geburtsdatum = ''.
  semester = ''.
  fakultaet = ''.
ENDFORM.
*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL71
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z30922_6001_SOL71.



DATA: ok_code  TYPE sy-ucomm,
      zahl1    TYPE i,
      zahl2    TYPE i,
      operator TYPE c,
      ergebnis TYPE z30921_801_071a_t_result.

SET SCREEN 100.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'OK_CALC'.

      CALL FUNCTION 'Z_30921_801_071A_F_CALC'
        EXPORTING
          iv_operand1       = zahl1
          iv_operand2       = zahl2
          iv_operator       = operator
        IMPORTING
          ev_result         = ergebnis
        EXCEPTIONS
          ex_div_null       = 1
          ex_wrong_operator = 2.

      IF sy-subrc = 1.
        MESSAGE: 'Eine Division durch 0 ist nicht möglich' TYPE 'W'.
      ELSEIF sy-subrc = 2.
        MESSAGE: 'Unbekannter Operator. Bitte benutzen Sie einen der Folgenden: +,-,*,/' TYPE 'W'.
      ENDIF.

    WHEN 'EXIT'.
      LEAVE PROGRAM.

    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
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
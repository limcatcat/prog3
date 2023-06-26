*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z30922_6001_SOL1.


*Aufgabe 011
WRITE 'Hello World'.

*Kettensatz, dann wird ein : benötigt
WRITE: 'Hello World', ' 2021', / 'Neue Zeile'.

*Aufgabe 012
*Hello World mit Parameters, ohne Lower Case wird die Eingabe immer in Großbuchstaben ausgegeben
PARAMETERS p_name TYPE c LENGTH 20." LOWER CASE.
*es geht auch PARAMETERS p_name TYPE String LOWER CASE

DATA gv_name TYPE string.
gv_name = p_name.

WRITE: /'Hallo,', gv_name.

*Aufgabe 013
IF sy-uzeit >= '000000' AND sy-uzeit < '110000'.
  WRITE: 'Guten Morgen ', gv_name.
ELSEIF sy-uzeit >= '110000' AND sy-uzeit < '160000'.
  WRITE: 'Guten Tag ', gv_name.
ELSE.
  WRITE: 'Guten Abend ', gv_name.
ENDIF.

*oder kurz
IF sy-uzeit < '1100'.
  WRITE 'Guten Morgen'.
ELSEIF sy-uzeit < '1800'.
  WRITE 'Guten Tag'.
ELSEIF sy-uzeit >= '1800'.
  WRITE 'Guten Abend'.
ENDIF.
WRITE gv_name.
WRITE sy-uzeit.

*Aufgabe 014
*Taschenrechner
PARAMETERS op1 TYPE p DECIMALS 3.
PARAMETERS op2 TYPE p DECIMALS 4.
PARAMETERS op TYPE c.

DATA erg TYPE p LENGTH 7 DECIMALS 3.

IF op = '/' AND op2 = 0.
  WRITE 'Teilen durch 0 ist nicht erlaubt' COLOR COL_NEGATIVE.
ELSE.

  IF op = '+'.
    erg = op1 + op2.
    WRITE: op1, op, op2, '=' , erg.
  ELSEIF op = '-'.
    erg = op1 - op2.
    WRITE: op1, op, op2, '=' , erg.
  ELSEIF op = '*'.
    erg = op1 * op2.
    WRITE: op1, op, op2, '=' , erg.
  ELSEIF op = '/'.
    erg = op1 / op2.
  ELSE.
    WRITE 'Operand ungültig'.
  ENDIF.

ENDIF.
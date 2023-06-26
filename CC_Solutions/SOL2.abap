*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6001_sol2.

**********************************************************************
****2.1
**********************************************************************


PARAMETERS: operator TYPE c.
DATA: number1 TYPE p, number2 TYPE p, result TYPE p DECIMALS 1, number3 TYPE p.

ULINE /(97).
WRITE: / sy-vline, (5) operator.


*Write the first line
DO 11 TIMES.
  WRITE: sy-vline.
  number1 = sy-index - 1.
  WRITE: (5) number1.
ENDDO.
WRITE: sy-vline.
ULINE.

number1 = 0.

*Write the calculated lines
DO 11 TIMES.
  WRITE: sy-vline.
  number2 = sy-index - 1.
  WRITE: (5) number2, sy-vline.
  DO 11 TIMES.
    number1 = sy-index - 1.
    IF operator = '+'.
      result = number2 + number1.
    ELSEIF operator = '-'.
      result = number1 - number2.
    ENDIF.
    WRITE: (5) result, sy-vline.
  ENDDO.
  ULINE.
ENDDO.

**********************************************************************
****2.2
**********************************************************************



PARAMETERS:
input TYPE c LENGTH 15.

DATA:
  entry  TYPE c LENGTH 15,
  length TYPE i,
  csum   TYPE i.

WRITE /.
WRITE: 'Checksum'.
ULINE /(40).
WRITE /.

* "STRLEN( arg )" is a function that counts the characters in a string argument
length = strlen( input ).
entry = input.

DO length TIMES.
  csum = csum + input(1).
  SHIFT input BY 1 PLACES LEFT.
ENDDO.

WRITE: 'Checksum of ', entry, 'is: ', csum.

**********************************************************************
****2.3
**********************************************************************


**structure type
TYPES: BEGIN OF lty_fibrow,
         fibpos TYPE i,
         fibval TYPE i,
       END OF lty_fibrow.

**primitive variables
DATA: gv_sum      TYPE i,
      gv_summand1 TYPE i VALUE 0,
      gv_summand2 TYPE i VALUE 1.

**structures and tables
DATA: gs_fibrow        TYPE lty_fibrow,
      gt_fibtable      TYPE TABLE OF lty_fibrow,
      gt_fibtable_head TYPE TABLE OF lty_fibrow WITH HEADER LINE.

**specific break point for user
BREAK jlauterb.

**do loop for fibonacci - only valid if >= 45 times
DO 45 TIMES.

  gv_sum = gv_summand1 + gv_summand2.

  gs_fibrow-fibpos = sy-index.
  gs_fibrow-fibval = gv_sum.
  APPEND gs_fibrow TO gt_fibtable.

  gt_fibtable_head-fibpos = sy-index.
  gt_fibtable_head-fibval = gv_sum.
  APPEND gt_fibtable_head.


  WRITE: / gv_sum.

  gv_summand1 = gv_summand2.
  gv_summand2 = gv_sum.





ENDDO.
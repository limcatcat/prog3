*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL41
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6001_sol41.

**UPDATE
**Create a table - use student table

PARAMETERS: p_name TYPE string, p_bday TYPE dats.

DATA: gv_wa  TYPE z30920685_u_stud,
      count  TYPE i,
      anzahl TYPE i.

WRITE: /, 40 'MatNr', 16 'LastName', 31 'FirstName', 46 'B-Day'.
SELECT * FROM z30920685_u_stud INTO gv_wa WHERE nachname = p_name OR gebdat = p_bday ORDER BY nachname vorname gebdat.
  WRITE: /, gv_wa-manr, 16 gv_wa-nachname(15), 31 gv_wa-vorname(15), 46 gv_wa-gebdat(8).
  count = count + 1.
ENDSELECT.


ULINE.
WRITE:/ 'Total number of students', count.

*so sollte es sein
SELECT COUNT(*) FROM z30920685_u_stud INTO anzahl.

WRITE:/ 'Total number of students', anzahl.
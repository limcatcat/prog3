*&---------------------------------------------------------------------*
*& Report Z30922_6001_42
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6001_42.

**********************************************************************
***Create new data entries in the student database table
**********************************************************************


PARAMETERS: mat_nr  TYPE z30920685_041a_u_matrikel , "OBLIGATORY
            vname   TYPE z30920685_041a_u_vorname,
            nname   TYPE z30920685_041a_u_nachname,
            geb_dat TYPE z30920685_041a_u_geburtsdatum.


DATA: gv_wa     TYPE z30920685_u_stud,
      gv_itab   TYPE z30920685_u_stud,
      exists TYPE i VALUE 0.   "wenn die MANR schon vorhanden => vorhanden = 1. Wenn nicht=> vorhanden = 0.

gv_wa-manr = mat_nr.
gv_wa-vorname = vname.
gv_wa-nachname = nname.
gv_wa-gebdat = geb_dat.

SELECT * FROM z30920685_u_stud INTO CORRESPONDING FIELDS OF gv_itab WHERE manr = gv_wa-manr.
  IF sy-subrc = 0.
    exists = 1.
  ENDIF.
ENDSELECT.

IF mat_nr IS INITIAL OR vname IS INITIAL OR nname IS INITIAL OR geb_dat IS INITIAL.
  FORMAT COLOR 6.
  WRITE: 'Error, please enter data in all fields!'.
ELSEIF exists = 1.
  FORMAT COLOR 3.
  WRITE: 'The MATNR you entered already exists!'.
ELSE.
  INSERT INTO z30920685_u_stud VALUES gv_wa.
  SELECT * FROM z30920685_u_stud INTO CORRESPONDING FIELDS OF gv_itab.
  ENDSELECT.
  IF sy-subrc = 0.
    WRITE: /, 'New student successfully inserted!'.
  ELSE.
    WRITE: /, 'Error, new student not inserted, try again'.
  ENDIF.
  WRITE: /, 'Number of data entries after insertion:', sy-dbcnt.
ENDIF.
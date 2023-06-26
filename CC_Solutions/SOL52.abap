*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL52
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z30922_6001_SOL52.

PARAMETERS: p_first  TYPE z309226001_stu-firstname,
            p_last TYPE z309226001_stu-lastname,
            p_bday TYPE z309226001_stu-birthday,
            p_sem  TYPE z309226001_stu-semester,
            p_fac TYPE z309226001_stu-faculty.

IF p_first is INITIAL OR p_last is INITIAL OR p_bday is INITIAL OR p_sem is INITIAL OR p_fac is INITIAL.
  MESSAGE 'Please fill out all fields' TYPE 'E'.
ELSE.

  DATA: matnumber TYPE z309226001_stu-matnr.


  CALL FUNCTION 'Z_30922_6001FB_ADDSTU'
    EXPORTING
      ip_first      = p_first
      ip_last     = p_last
      ip_birthday = p_bday
      ip_semester     = p_sem
      ip_faculty    = p_fac
    IMPORTING
      ex_mat          = matnumber
    EXCEPTIONS
      infos_fehler    = 1 "passiert nie wegen message oben
      modify_fehler   = 2
      OTHERS          = 3.

  IF sy-subrc = 1.
    WRITE: 'Data entry incomplete!' COLOR COL_NEGATIVE.
  ELSEIF sy-subrc = 2.
    WRITE: 'Problem when inserting into database!' COLOR COL_NEGATIVE.
  ELSEIF sy-subrc = 3.
    WRITE: 'Ohter error!' COLOR COL_NEGATIVE.
  ELSE.

    WRITE: / 'Student inserted successfully with the data:'.
    WRITE: / 'Matriculation number: ', matnumber, 'Firstname: ', p_first, 'Lastname: ', p_last, 'Birthday: ', p_bday, 'Semester: ', p_sem, 'Fakultät: ', p_fac.

  ENDIF.

ENDIF.
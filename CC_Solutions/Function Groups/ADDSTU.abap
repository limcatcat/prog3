FUNCTION Z_30922_6001FB_ADDSTU. "ist jetzt 065a
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IP_FIRST) TYPE  Z309226001_STU-FIRSTNAME
*"     REFERENCE(IP_LAST) TYPE  Z309226001_STU-LASTNAME
*"     REFERENCE(IP_BIRTHDAY) TYPE  Z309226001_STU-BIRTHDAY
*"     REFERENCE(IP_SEMESTER) TYPE  Z309226001_STU-SEMESTER
*"     REFERENCE(IP_FACULTY) TYPE  Z309226001_STU-FACULTY
*"  EXPORTING
*"     REFERENCE(EX_MAT) TYPE  Z309226001_STU-MATNR
*"  EXCEPTIONS
*"      INFOS_ERROR
*"      MODIFY_ERROR
*"----------------------------------------------------------------------


  IF ip_first is INITIAL OR ip_last is INITIAL OR ip_birthday is INITIAL OR ip_semester is INITIAL OR ip_faculty is INITIAL. "is initial = is null
    RAISE infos_error.
  ELSE.
    DATA: stud_wa TYPE z309226001_stu,
          genma   TYPE z309226001_stu-matnr.

    stud_wa-firstname = ip_first.
    stud_wa-lastname = ip_last.
    stud_wa-birthday = ip_birthday.
    stud_wa-semester = ip_semester.
    stud_wa-faculty = ip_faculty.

    SELECT MAX( matnr ) FROM z309226001_stu INTO @stud_wa-matnr.

    stud_wa-matnr = stud_wa-matnr + 1.
    ex_mat = stud_wa-matnr.

    MODIFY z309226001_stu FROM stud_wa. "check with system variable if it works, otherwise raise exception

    if sy-subrc <> 0.
      raise modify_error.
    endif.

  ENDIF.




ENDFUNCTION.
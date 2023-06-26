*&---------------------------------------------------------------------*
*& Report Z30922_6009_NEW_DYNLIST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6009_new_dynlist.


DATA: gt_itab TYPE TABLE OF z309226009_pers,
      gs_wa   TYPE z309226009_pers,
      gv_sort TYPE i.


TOP-OF-PAGE. "When you use TOP-OF-PAGE, what you WRITE is only shown with START-OF-SELECTION!!!

  WRITE: 'Use F4 to sort the list by PersonID, F5 by Name'.
  ULINE.


START-OF-SELECTION. "This is necessary when you've used TOP-OF-PAGE!!!

  SELECT * FROM z309226009_pers INTO TABLE gt_itab.
  PERFORM display.


AT PF4.
  sy-lsind = 1.
  IF gv_sort = 1.
    SORT gt_itab BY personid ASCENDING.
    gv_sort = 2.

  ELSE.
    SORT gt_itab BY personid DESCENDING.
    gv_sort = 1.

  ENDIF.

  PERFORM display.



AT PF5.
  sy-lsind = 2.
  IF gv_sort = 1.
    SORT gt_itab BY name ASCENDING.
    gv_sort = 2.

  ELSE.
    SORT gt_itab BY name DESCENDING.
    gv_sort = 1.

  ENDIF.

  PERFORM display.


TOP-OF-PAGE DURING LINE-SELECTION.

  IF sy-lsind = 1.
    WRITE 'Sorted by PersonID'.
    ULINE.

  ENDIF.


  IF sy-lsind = 2.
    WRITE 'Sorted by Name'.
    ULINE.

  ENDIF.



**********************************************************************

FORM display.

  LOOP AT gt_itab INTO gs_wa.

    WRITE: /, 1(3) gs_wa-personid, gs_wa-name, gs_wa-family_name, gs_wa-title.

  ENDLOOP.

ENDFORM.
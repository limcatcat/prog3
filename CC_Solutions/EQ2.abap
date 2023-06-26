*&---------------------------------------------------------------------*
*& Report Z30922_6001_EQ2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z30922_6001_EQ2.

**********************************************************************
***Test Exam Example Question 2
**********************************************************************

DATA: count     TYPE i,
      custom_wa TYPE scustom,
      book_wa   TYPE sbook,
      test_id   TYPE sbook-customid.


**Select options not asked in question - optional
SELECT-OPTIONS: custid FOR test_id.

TOP-OF-PAGE.

WRITE: / sy-vline, (15)'Customer ID', sy-vline, (15)'Customer', sy-vline, (15)'Street', sy-vline, (15)'Zip code', sy-vline,
(15)'City', sy-vline, (15)'Booking ID', sy-vline, (15)'Airline', sy-vline, (15)'Flight ID', sy-vline, (15)'Flight Date', sy-vline.

write: /(208) sy-uline.

START-OF-SELECTION.

SELECT id, name, street, postcode, city FROM scustom WHERE id IN @custid ORDER BY id INTO CORRESPONDING FIELDS OF @custom_wa.

  SELECT customid, bookid, carrid, connid, fldate FROM sbook where customid = @custom_wa-id ORDER BY customid INTO CORRESPONDING FIELDS OF @book_wa.


    WRITE: / sy-vline, (15)book_wa-customid, sy-vline, (15)custom_wa-name, sy-vline, (15)custom_wa-street, sy-vline, (15)custom_wa-postcode, sy-vline,
    (15)custom_wa-city, sy-vline, (15)book_wa-bookid, sy-vline, (15)book_wa-carrid, sy-vline, (15)book_wa-connid, sy-vline, (15)book_wa-fldate, sy-vline.


  ENDSELECT.

  count = count + 1.

ENDSELECT.

write: /(208) sy-uline.

WRITE: / sy-vline,'number of customers: ',count, (172)' ',sy-vline.

write: /(208) sy-uline.\\
*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL64
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z30922_6001_SOL64.



"Definiton der Struktur
TYPES: BEGIN OF t_flight,
         carrname TYPE scarr-carrname,
         connid   TYPE spfli-connid,
         cityfrom TYPE spfli-cityfrom,
         cityto   TYPE spfli-cityto,
         belegung TYPE p DECIMALS 2,
         fldate   TYPE sflight-fldate,
         currency TYPE sflight-currency,
         price    TYPE sflight-price,
       END OF t_flight.

"Definition der Typen
DATA: wa_spfli       TYPE spfli,
      wa_sflight     TYPE sflight,
      wa_scarr       TYPE scarr,
      wa_sbook       TYPE sbook,
      wa_scustom     TYPE scustom,
      wa_fluege      TYPE t_flight,
      itab_fluege    TYPE TABLE OF t_flight,
      sortierung(20) TYPE c VALUE 'aufsteigend',
      sort_bool      TYPE i.

"HEADER
TOP-OF-PAGE.
  WRITE:/ ' Interaktives Reporting: Sortieren von Datensätzen'.
  ULINE.  "Unterstreichung des Headers

"Eingabe durch Select - options + Default Werten
  SELECT-OPTIONS:
  s_cfrom FOR wa_spfli-cityfrom NO INTERVALS DEFAULT 'NEW YORK',
  s_cto FOR wa_spfli-cityto NO INTERVALS DEFAULT 'FRANKFURT',
  s_date FOR wa_sflight-fldate.


START-OF-SELECTION.
"Beginn des Programms
"Select - Befehle mit Joins
  SELECT * FROM scarr INTO wa_scarr.
    SELECT * FROM spfli INTO wa_spfli WHERE carrid = wa_scarr-carrid AND cityfrom IN s_cfrom AND cityto IN s_cto.
      SELECT * FROM sflight INTO wa_sflight WHERE carrid = wa_spfli-carrid AND connid = wa_spfli-connid AND fldate IN s_date.

"Befüllung der WA + Berechnung der Belegung
        wa_fluege-belegung = ( wa_sflight-seatsocc / wa_sflight-seatsmax ) * 100.

        wa_fluege-carrname = wa_scarr-carrname.
        wa_fluege-cityfrom = wa_spfli-cityfrom.
        wa_fluege-cityto =  wa_spfli-cityto.
        wa_fluege-connid =  wa_spfli-connid.
        wa_fluege-currency = wa_sflight-currency.
        wa_fluege-fldate = wa_sflight-fldate.
        wa_fluege-price = wa_sflight-price.

"Einfügen in die itab
        APPEND wa_fluege TO itab_fluege.
      ENDSELECT.
    ENDSELECT.
  ENDSELECT.
  PERFORM print.


TOP-OF-PAGE DURING LINE-SELECTION.
  IF sort_bool = 2.
    sortierung = 'aufsteigend'.
  ELSE.
    sortierung = 'absteigend'.
  ENDIF.
  IF sy-lsind = 1.
    WRITE:/ 'Daten nach Preis ', sortierung ,' sortiert!', 'Aktuelle Liste', sy-lsind.
  ELSEIF sy-lsind = 2.
    WRITE:/ 'Daten nach Flugdatum  ', sortierung ,' sortiert!', 'Aktuelle Liste', sy-lsind.
  ELSEIF sy-lsind = 3.
    WRITE:/ 'Daten nach Belegung  ', sortierung ,' sortiert!', 'Aktuelle Liste', sy-lsind.

  ELSEIF sy-lsind = 4.
    WRITE:/'Kundendaten', 'Aktuelle Liste', sy-lsind.
  ENDIF.
  ULINE.

"Taste F4
AT PF4.
  sy-lsind = 1.
  IF sort_bool =  1.
    SORT itab_fluege BY price ASCENDING.
    sort_bool =  2.
  ELSE.
    SORT itab_fluege BY price DESCENDING.
    sort_bool =  1.
  ENDIF.
  PERFORM print. "Ausgabe

"Taste F5
AT PF5.
  sy-lsind = 2.
  IF sort_bool =  1.
    SORT itab_fluege BY fldate ASCENDING.
    sort_bool =  2.
  ELSE.
    SORT itab_fluege BY fldate DESCENDING.
    sort_bool =  1.
  ENDIF.
  PERFORM print. "Ausgabe

"Taste F6
AT PF6.
  sy-lsind = 3.
  IF sort_bool =  1.
    SORT itab_fluege BY belegung ASCENDING.
    sort_bool =  2.
  ELSE.
    SORT itab_fluege BY belegung DESCENDING.
    sort_bool =  1.
  ENDIF.
  PERFORM print. "Ausgabe

"Anzeige füe weitere Details
AT LINE-SELECTION.
  sy-lsind = 4. "LISTE 4
  SELECT * FROM sbook INTO wa_sbook WHERE connid = wa_fluege-connid AND fldate = wa_fluege-fldate.
    SELECT * FROM scustom INTO wa_scustom WHERE id = wa_sbook-customid.
      WRITE:/ wa_scustom-id, wa_scustom-name, wa_scustom-city, wa_scustom-postcode, wa_scustom-street.
    ENDSELECT.
  ENDSELECT.


"Ausgabe über Form, die mit Perform aufgerufen werden kann
FORM print.
  LOOP AT itab_fluege INTO wa_fluege.
    WRITE:/  wa_fluege-carrname, wa_fluege-connid, wa_fluege-cityfrom, wa_fluege-cityto, wa_fluege-fldate,wa_fluege-price, wa_fluege-currency, wa_fluege-belegung.
    IF wa_fluege-belegung >= 80.
      WRITE: '*'.
    ENDIF.
    "Interne Tabell muss erst ausgegeben werden und danach kommt der hide befehl
    "Hide merkt sich alles
    HIDE: wa_fluege. "wa_fluege-connid, wa_fluege-fldate.
  ENDLOOP.
ENDFORM.
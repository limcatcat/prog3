*&---------------------------------------------------------------------*
*& Report Z30922_6001_SOL63
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30922_6001_sol63.


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

"Deklaration der Variablen
DATA: wa_spfli       TYPE spfli,
      wa_sflight     TYPE sflight,
      wa_scarr       TYPE scarr,
      wa_fluege      TYPE t_flight,
      itab_fluege    TYPE TABLE OF t_flight,
      sortierung(20) TYPE c VALUE 'aufsteigend', "Hilfsvariable
      sort_bool      TYPE i.

"Header

TOP-OF-PAGE.
  WRITE:/ 'Interaktives Reporting: F4 --> nach Preis, F5 --> Flugdatum, F6 --> Belegung '.
  ULINE.

  "Default Werte New York und Frankfurt, keine intervalle
  SELECT-OPTIONS:
  s_cfrom FOR wa_spfli-cityfrom NO INTERVALS DEFAULT 'NEW YORK',
  s_cto FOR wa_spfli-cityto NO INTERVALS DEFAULT 'FRANKFURT',
  s_date FOR wa_sflight-fldate.

  "Beginn des eigt. Programmes

START-OF-SELECTION.


  SELECT * FROM scarr INTO wa_scarr.
    SELECT * FROM spfli INTO wa_spfli WHERE carrid = wa_scarr-carrid AND cityfrom IN s_cfrom AND cityto IN s_cto.
      SELECT * FROM sflight INTO wa_sflight WHERE carrid = wa_spfli-carrid AND connid = wa_spfli-connid AND fldate IN s_date.

        "Befüllen der WA + Berechnung der Belegung
        "Berechnung
        wa_fluege-belegung = ( wa_sflight-seatsocc / wa_sflight-seatsmax ) * 100.

        wa_fluege-carrname = wa_scarr-carrname.
        wa_fluege-cityfrom = wa_spfli-cityfrom.
        wa_fluege-cityto =  wa_spfli-cityto.
        wa_fluege-connid =  wa_spfli-connid.
        wa_fluege-currency = wa_sflight-currency.
        wa_fluege-fldate = wa_sflight-fldate.
        wa_fluege-price = wa_sflight-price.

        "Die Befüllung in die itab mit einfügen
        APPEND wa_fluege TO itab_fluege.
      ENDSELECT.
    ENDSELECT.
  ENDSELECT.
  PERFORM print.

  "Überschrift von den Verzweigungslisten (gibt höchstens 20)

TOP-OF-PAGE DURING LINE-SELECTION.

  IF sort_bool = 2.
    sortierung = 'aufsteigend'.
  ELSE.
    sortierung = 'absteigend'.
  ENDIF.

  "Alle drei Fälle der Verwzweigungslisten
  IF sy-lsind = 1. "Verzweigungslisten
    WRITE:/ 'Daten nach Preis ', sortierung ,' sortiert!', 'Aktuelle Liste', sy-lsind.
  ELSEIF sy-lsind = 2.
    WRITE:/ 'Daten nach Flugdatum  ', sortierung ,' sortiert!', 'Aktuelle Liste', sy-lsind.
  ELSEIF sy-lsind = 3.
    WRITE:/ 'Daten nach Belegung  ', sortierung ,' sortiert!', 'Aktuelle Liste', sy-lsind.
  ENDIF.
  ULINE. "Unterstreichung

  "Tastenbelegung: 1=aufsteigend 2 =absteigend
  "Taste F4

AT PF4.
  "Steuerung der lsind
  sy-lsind = 1.
  IF sort_bool =  1.
    SORT itab_fluege BY price ASCENDING. "Aufsteigende Sortierung
    sort_bool =  2. "nach dem Doppelklick soll es absteigend sein
  ELSE.
    SORT itab_fluege BY price DESCENDING."Absteigende sortierung
    sort_bool =  1. "nach dem Doppelklcik wieder aufsteigend
  ENDIF.
  PERFORM print. "Ausgeben

  "Taste F5

AT PF5.
  sy-lsind = 2.
  IF sort_bool =  1.
    SORT itab_fluege BY fldate ASCENDING. "Aufsteigend
    sort_bool =  2.
  ELSE.
    SORT itab_fluege BY fldate DESCENDING. "Absteigend
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
  PERFORM print.  "Ausgabe

  "Ausgabe Form, wie eine Methode, die man bei Perform einsetzt-
FORM print.
  LOOP AT itab_fluege INTO wa_fluege.
    WRITE:/  wa_fluege-carrname, wa_fluege-connid, wa_fluege-cityfrom, wa_fluege-cityto, wa_fluege-fldate,wa_fluege-price, wa_fluege-currency, wa_fluege-belegung.
    IF wa_fluege-belegung >= 80.
      WRITE: '*'.
    ENDIF.
  ENDLOOP.
ENDFORM.
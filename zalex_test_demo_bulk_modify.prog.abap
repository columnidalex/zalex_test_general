*&---------------------------------------------------------------------*
*& Report zalex_test_demo_bulk_modify
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zalex_test_demo_bulk_modify.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
*   clean up the database table.
*   DELETE FROM demo_bulk_modify. " do not empty the table

*   declare itab and wa.
    DATA itab TYPE STANDARD TABLE OF demo_bulk_modify WITH EMPTY KEY.
    DATA wa LIKE LINE OF itab.

*   fill in itab with 10,000 records
    itab = VALUE #( FOR i = 1 THEN i + 1 WHILE i LE 10000 ( k1 = i k2 = i v1 = i + 2 ) ).

*   ABAP bulk modify
*   MODIFY demo_bulk_modify FROM TABLE itab.

*   ABAP single modify
    LOOP AT itab INTO wa.
        MODIFY demo_bulk_modify FROM wa.
    ENDLOOP.

    SELECT *
           FROM demo_bulk_modify
           INTO TABLE @DATA(result).
    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).

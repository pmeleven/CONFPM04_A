*&---------------------------------------------------------------------*
*&  Include  ZCONFPM04_A
*&---------------------------------------------------------------------*

DATA: ls_output TYPE ismnw.
IF afrud_imp-ismne <> 'H'.
  CALL FUNCTION 'UNIT_CONVERSION_SIMPLE'
    EXPORTING
      input                = afrud_imp-ismnw
*     NO_TYPE_CHECK        = 'X'
*     ROUND_SIGN           = ' '
      unit_in              = afrud_imp-ismne
      unit_out             = 'H'
    IMPORTING
*     ADD_CONST            =
*     DECIMALS             =
*     DENOMINATOR          =
*     NUMERATOR            =
      output               = ls_output
    EXCEPTIONS
      conversion_not_found = 1
      division_by_zero     = 2
      input_invalid        = 3
      output_invalid       = 4
      overflow             = 5
      type_invalid         = 6
      units_missing        = 7
      unit_in_not_found    = 8
      unit_out_not_found   = 9
      OTHERS               = 10.
  IF sy-subrc <> 0.
    MESSAGE  'Time entry cant be converted to hours.' TYPE 'E'.
  ENDIF.
ELSE.
  ls_output = afrud_imp-ismnw.
ENDIF.
IF ls_output > 14.
  RAISE exception.
  MESSAGE  'Time Confirmation greater than 24 hours can not be entered.' TYPE 'E'.
ENDIF.

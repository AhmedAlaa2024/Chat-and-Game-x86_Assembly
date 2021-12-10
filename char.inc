;This File Contains Chracter Macros

;=============================================
;              CHARACTER MACROS
;=============================================

;Check if a character is a number (Only Valid for 8-bit input)
;INPUT:     CHAR, LABEL
;OUTPUT:    NONE
;Algorithm:
;IF CHAR IN '0123456789' ==> JMP IS_DIGIT
;ELSE RETURN
ISDIGIT MACRO CHAR, IS_DIGIT
    LOCAL NOT_DIGIT
    CMP CHAR, '0'
    JL NOT_DIGIT

    CMP CHAR, '9'
    JLE IS_DIGIT

    NOT_DIGIT:
ENDM ISDIGIT

;Check if a character is a HEXADECIMAL number (Only Valid for 8-bit input)
;INPUT:     CHAR, LABEL
;OUTPUT:    NONE
;Algorithm:
;IF CHAR IN '0123456789ABCDEFabcdef' ==> JMP IS_HEX
;ELSE RETURN
ISXDIGIT MACRO CHAR, IS_HEX
    LOCAL NOT_HEX
    CMP CHAR, '0'
    JL NOT_HEX

    CMP CHAR, '9'
    JLE IS_HEX

    CMP CHAR, 'A'
    JL NOT_HEX

    CMP CHAR, 'F'
    JLE IS_HEX

    CMP CHAR, 'a'
    JL NOT_HEX

    CMP CHAR, 'f'
    JLE IS_HEX


    NOT_HEX:
ENDM ISXDIGIT

;Check if a character is a Letter (Only Valid for 8-bit input)
;INPUT:     CHAR, LABEL
;OUTPUT:    NONE
;Algorithm:
;IF CHAR IN 'ABCDEFGHIJKLMNOPQRSTUVWXYZ
;     OR IN 'abcdefghijklmnopqrstuvwxyz' ==> JMP IS_ALPHA
;ELSE RETURN
ISALPHA MACRO CHAR, IS_ALPHA
    LOCAL NOT_ALPHA 
    CMP CHAR, 'A'
    JL NOT_ALPHA

    CMP CHAR, 'Z'
    JLE IS_ALPHA

    CMP CHAR, 'a'
    JL NOT_ALPHA

    CMP CHAR, 'z'
    JLE IS_ALPHA

    NOT_ALPHA:
ENDM ISALPHA

;Get integral value of character
;CHAR MUST be in '0123456789'
;ALGORITHM:
;CHAR = CHAR - '0'
TO_INT MACRO CHAR
    SUB CHAR, '0'
ENDM TO_INT

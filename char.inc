;This File Contains Chracter and String Macros

;=============================================
;              CHARACTER MACROS
;=============================================

;=============================================================================
;Check if a character is a number (Only Valid for 8-bit input)
;INPUT:     CHAR, LABEL
;OUTPUT:    NONE
;Algorithm:
;IF ('1' <= CHAR AND CHAR <= '9')
;   GOTO LABEL
;=============================================================================
ISDIGIT MACRO CHAR, IS_DIGIT
    LOCAL NOT_DIGIT
    CMP CHAR, '0'
    JL NOT_DIGIT

    CMP CHAR, '9'
    JLE IS_DIGIT

    NOT_DIGIT:
ENDM ISDIGIT

;=============================================================================
;Check if a character is an uppercase 
;HEXADECIMAL number (Only Valid for 8-bit input)
;INPUT:     CHAR, LABEL
;OUTPUT:    NONE
;Algorithm:
;IF ('1' <= CHAR AND CHAR <= '9') OR ('A' <= CHAR AND CHAR <= 'F') 
;   GOTO LABEL
;=============================================================================
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

    NOT_HEX:
ENDM ISXDIGIT

;=============================================================================
;Check if a character is a letter (Only Valid for 8-bit input)
;INPUT:     CHAR, LABEL
;OUTPUT:    NONE
;Algorithm:
;IF ('A' <= CHAR AND CHAR <= 'Z') OR ('a' <= CHAR AND CHAR <= 'z')
;   GOTO LABEL
;=============================================================================
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

;=============================================================================
;Check if a character is an uppercase letter (Only Valid for 8-bit input)
;INPUT:     CHAR, LABEL
;OUTPUT:    NONE
;Algorithm:
;IF 'A' <= CHAR AND CHAR <= 'Z')
;   GOTO LABEL
;=============================================================================
ISUPPER MACRO CHAR, IS_UPPER
    LOCAL NOT_UPPER 
    CMP CHAR, 'A'
    JL NOT_UPPER

    CMP CHAR, 'Z'
    JLE IS_UPPER

    NOT_UPPER:
ENDM ISUPPER

;=============================================================================
;Check if a character is a lower case letter (Only Valid for 8-bit input)
;INPUT:     CHAR, LABEL
;OUTPUT:    NONE
;Algorithm:
;IF 'a' <= CHAR AND CHAR <= 'z'
;   GOTO LABEL
;=============================================================================
ISLOWER MACRO CHAR, IS_LOWER
    LOCAL NOT_LOWER 
    CMP CHAR, 'a'
    JL NOT_LOWER

    CMP CHAR, 'z'
    JLE IS_LOWER

    NOT_LOWER:
ENDM ISLOWER

;=============================================================================
;Get integral value of character
;CHAR MUST be in '0123456789'
;ALGORITHM:
;CHAR = CHAR - '0'
;=============================================================================
CHAR_TO_INT MACRO CHAR
    SUB CHAR, '0'
ENDM CHAR_TO_INT

;=============================================
;              STRING MACROS
;=============================================

;=============================================================================
;Change each lowercase character in a string to an uppercase character
;INPUT:     String (1-BYTE ARRAY), Null (CHAR)
;OUTPUT:    Modified String
;Algorithm:
;si = 0
;WHILE(String[si] != Null)
;   IF 'a' <= String[si] AND String[SI] <= 'z'
;       String[si] = String[si] - 0x20                                        
;   si = si + 1                                                               
;=============================================================================
TOUPPER MACRO STR, SIZE
    LOCAL TO_UPPER, RETURN, LOOPNEXT, SKIP
    MOV SI, 0
    MOV CX, SIZE

    LOOPNEXT:
    ISLOWER STR[SI], TO_UPPER
    JMP SKIP
    
    TO_UPPER: SUB STR[SI], 20H 
    SKIP:

    INC SI
    LOOP LOOPNEXT

    RETURN:
ENDM TOUPPER

CHARTOUPPER MACRO CHAR
    LOCAL TO_UPPER, RETURN, LOOPNEXT, SKIP
    
    ISLOWER CHAR, TO_UPPER
    JMP RETURN
    
    TO_UPPER: 
    SUB CHAR, 20H 

    RETURN:
ENDM CHARTOUPPER

;========================
;TEST MODULE FOR char.inc
;========================

.MODEL SMALL
.STACK 64
.DATA

;==============================
;       TEST VECTORS
;==============================
LOWER DB 'abcdefghijklmnopqrstuvwxyz'
UPPER DB 'ABCDEFGHIJKLMNOPQRSTYVWXYZ'
NUMBERS DB '123456789'
DB 'ABCEDFabcdef'

RANDOM_NONE_CHARS DB 15,31,32,47,40,39,94,65,125,126,96


TestString DB '   tHiS is 478   Supposed^ ;to Be% in Upper #/*-@!!'
StringLength EQU $ - TestString
NullTerminator DB '$'

;==============================
;       OUTPUT MSGS
;==============================
ISDIGIT_MSG  DB 'ISDIGIT $'
ISXDIGIT_MSG DB 'ISXDIGIT $' 
ISALPHA_MSG  DB 'ISALPHA $' 
ISUPPER_MSG  DB 'ISUPPER $'
ISLOWER_MSG  DB 'ISLOWER $'

FAILED_MSG DB 'Test has FAILED!!',13,10,'$'
SUCCESS_MSG DB 'Test ran successfully',13,10,'$'

.CODE
include char.inc

TEST_ISDIGIT MACRO
    MOV SI, OFFSET NUMBERS
    MOV CX, 9

    CHECK_ISDIGIT1:
    MOV AL, [SI]

    ISDIGIT AL, ISDIGIT_TRUE
    JMP FAILED_ISDIGIT

    ISDIGIT_TRUE:
    INC SI
    LOOP CHECK_ISDIGIT1

    MOV SI, OFFSET RANDOM_NONE_CHARS
    MOV CX, 11

    CHECK_ISDIGIT2:
    MOV AL, [SI]

    ISDIGIT AL, ISDIGIT_TRUE2
    INC SI
    LOOP CHECK_ISDIGIT2
    JMP NXT1
    ISDIGIT_TRUE2:
    JMP FAILED_ISDIGIT  
    NXT1:

    MOV AH, 09H

    MOV DX, OFFSET ISDIGIT_MSG
    INT 21H

    MOV DX, OFFSET SUCCESS_MSG
    INT 21H

    JMP EXIT_ISDIGIT

    FAILED_ISDIGIT:
    MOV AH, 09H

    MOV DX, OFFSET ISDIGIT_MSG
    INT 21H

    MOV DX, OFFSET FAILED_MSG
    INT 21H
    EXIT_ISDIGIT:
ENDM TEST_ISDIGIT

MAIN PROC FAR
    ;Initialize Data Segment
    MOV AX, @DATA
    MOV DS, AX
    ;End initialize
    
    TEST_ISDIGIT
    
    
    TOUPPER TestString, '$'
    
    MOV AH, 09H
    MOV DX, OFFSET TestString
    INT 21H
    
    ;Safely return to OS
    MOV AX, 4C00H
    INT 21H
MAIN ENDP
END MAIN  

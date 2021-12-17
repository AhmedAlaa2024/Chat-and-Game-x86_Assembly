;=============================================================================
;Split a string into word slices
;The seperator character is space ' '
;INPUT:     '$' Terminated String:                      SRC
;OUTPUT:    NULL(ASCII 0) Terminated Array of strings:  DST
;
;Example Usage:
;   SPLIT_STRING used on '  MOV AX,   DI  $'
;   Output:
;       'MOV$AX,$DI$',0
;
;   SPLIT_STRING used on '   $'
;   Output:
;       0
;=============================================================================
SPLIT_STRING MACRO SRC, DST
    LOCAL FIRST_CHAR, MAIN_LOOP, RETURN, SKIP, INSERT
    MOV SI, 0   ;SRC Offset
    MOV DI, 0   ;DST Offset

    ;Search for first occurrence of a char in SRC
    FIRST_CHAR:
    CMP SRC[SI], ' '
    JNE MAIN_LOOP
    INC SI
    JMP FIRST_CHAR

    MAIN_LOOP:
    CMP SRC[SI], '$'
    JE RETURN

    ;Check for space
    CMP SRC[SI], ' '
    ;Non space characted detected
    JNE INSERT
    
    ;'$' Terminate current slice
    MOV DST[DI], '$'
    INC DI
    JMP FIRST_CHAR ;Skip to next occurrence of a non space character
    

    ;Insert Character into DST
    INSERT:
    MOV AL, SRC[SI]
    MOV DST[DI], AL
    INC DI
    
    ;Advance to next iteration
    INC SI
    JMP MAIN_LOOP

    RETURN:
    CMP DI, 0
    JE SKIP

    CMP DST[DI] - 1, '$'
    JE SKIP

    MOV DST[DI], '$'
    INC DI
    SKIP:
    ;Array of strings is terminated by NULL (ASCII 0)
    MOV DST[DI], 0
ENDM SPLIT_STRING1

PARSE_CMD MACRO SRC, CMD_ARR, CMD_ARR_SIZE, CMD_FLAG
    LOCAL MAIN_LOOP, SKIPCMD, FINALLY, CHECK_VALID, RETURN, INVALID, VALID
    MOV DI, 0
    MOV SI, 0
    MOV CMD_FLAG, 0

    MAIN_LOOP:
    ;Reached end of CMD_ARR (No cmd matched)
    CMP DI, CMD_ARR_SIZE
    JE INVALID
    
    ;Check if SRC cmd ended
    CMP SRC[SI], '$'
    ;Check if current cmd also ended
    JE CHECK_VALID

    MOV DL, SRC[SI]
    CMP DL, CMD_ARR[DI]
    ;Cmd mismatch
    JNE SKIPCMD

    INC SI
    INC DI
    JMP MAIN_LOOP

    CHECK_VALID:
    CMP CMD_ARR[DI], '$'
    ;Cmd matched!
    JE VALID
    ;Cmd mismatch
    JMP SKIPCMD

    ;Skip to next cmd in CMD_ARR
    SKIPCMD:
    CMP CMD_ARR[DI], '$'
    JE FINALLY

    INC DI
    JMP SKIPCMD

    FINALLY:
    INC DI
    ;Reset to first char in SRC
    MOV SI, 0
    INC CMD_FLAG
    JMP MAIN_LOOP

    INVALID:
    CALL PARSE_ERROR
    JMP RETURN

    VALID:
    ;TEMPORARY VALID MESSAGE
    ;TODO: IMPLEMENT
    MOV AH, 02
    MOV DL, 'V'
    INT 21H
    RETURN:
ENDM PARSE_CMD


;=============================================================================
;AL = CMD_OPERANDS_ARR[AL]
;==================================================================
GET_CMD_OPERANDS MACRO CMD_OPERANDS_ARR, CMD_FLAG, OP_FLAGS
    MOV BX, OFFSET CMD_OPERANDS_ARR
    MOV AL, CMD_FLAG
    XLAT
    MOV OP_FLAGS, AL
ENDM GET_CMD_OPERANDS

PARSE_OPERANDS MACRO SRC, OP_FLAGS 
    LOCAL MAIN_LOOP, SKIPWORD, FINALLY, RETURN, INVALID

    MOV SI, 0

    ;CHECK IF FIRST OPERAND IS NEEDED
    MOV CL, OP_FLAGS
    ;CL != 0 IF First Operand is needed
    AND CL, 10000000B

    CMP CL, 0
    ;No first operand
    JE SKIPWORD

    ;Has first operand
    

    ;Skip to next word in SRC
    SKIPWORD:
    CMP SRC[SI], '$'
    JE FINALLY

    INC SI
    JMP SKIPWORD

    FINALLY:
    INC SI

    CMP SRC[SI], 0
    JNE INVALID

    INVALID:
    CALL PARSE_ERROR
    JMP RETURN


    RETURN:
ENDM PARSE_CMD


;TEMPORARY ERROR MESSAGE
;TODO: IMPLEMENT
PARSE_ERROR PROC NEAR
    MOV AH, 02
    MOV DL, 'E'
    INT 21H
    RET
PARSE_ERROR ENDP
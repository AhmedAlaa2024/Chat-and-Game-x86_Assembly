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
    LOCAL EXIT, FIRST_CHAR, MAIN_LOOP, RETURN, SKIP, INSERT, SKIP_COMMA_HANDLING
    MOV SI, 0   ;SRC Offset
    MOV DI, 0   ;DST Offset

    CMP SRC[0], ','
    JNE FIRST_CHAR

    CALL PARSE_ERROR
    JMP EXIT

    ;Search for first occurrence of a char in SRC
    FIRST_CHAR:
    CMP SRC[SI], ','
    JNE SKIP_COMMA_HANDLING
    DEC DI
    SKIP_COMMA_HANDLING:
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
    CMP AL, ','
    JNE NOT_COMMA
    MOV DST[DI], '$'
    INC DI
    MOV DST[DI], ','
    INC DI
    MOV DST[DI], '$'
    INC DI
    INC SI
    JMP FIRST_CHAR
    NOT_COMMA:
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
    EXIT:
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

PARSE_OPERANDS MACRO P_DATA, SRC, OP_FLAGS 
    LOCAL MAIN_LOOP, SKIPWORD, FINALLY, RETURN, INVALID

    MOV SI, 0

    SKIPWORD:
    CMP SRC[SI], '$'
    JE FINALLY

    INC SI
    JMP SKIPWORD

    FINALLY:
    INC SI 

    ;CHECK IF FIRST OPERAND IS NEEDED
    MOV CL, OP_FLAGS
    ;CL != 0 IF First Operand is needed
    AND CL, 10000000B

    CMP CL, 0
    ;No first operand
    ;JE SKIPWORD

    ;Has first operand
    
    ;CHECK MEMORY MODE

    MEM_CHK:
    CMP SRC[SI], '['
    JNE REG_CHK

    ;REG INDIRECT CHECK
    INC SI
    ;CX Contain
    MOV CX, OFFSET P_DATA[6]

    MOV BP, WORD PTR SRC[SI]

    CMP BP, WORD PTR BX_STR
    JE REG_INDIRECT_VALID
    ADD CX, 2
    CMP BP, WORD PTR SI_STR
    JE REG_INDIRECT_VALID
    ADD CX, 2
    CMP BP, WORD PTR DI_STR
    JE REG_INDIRECT_VALID
    ADD CX, 2
    CMP BP, WORD PTR BP_STR
    JE REG_INDIRECT_VALID
    


    

    ;DIRECT ADRESSING CHECK
    MOV BH, 0
    MOV BL, SRC[SI]
    
    ;Check if digit
    CMP BL, '0'
    JL INVALID

    CMP BL, '9'
    JLE IS_DIGIT

    ;Check if A-F
    CMP BL, 'A'
    JL INVALID

    CMP BL, 'F'
    JG INVALID
    ;IS HEXCHAR
    SUB BL, 55D ;Get decimal value of hex char
    JMP GET_P_MEM

    IS_DIGIT:
    SUB BL, '0' ;Get decimal value of digit
    
    GET_P_MEM:
    MOV CX, OFFSET P_DATA[BX][16]
    JMP DIRECT_ADDR_VALID

    REG_INDIRECT_VALID:
    INC SI
    DIRECT_ADDR_VALID:
    INC SI

    CMP SRC[SI], ']'
    JNE INVALID

    INC SI

    CMP SRC[SI], '$'
    JNE INVALID

    MOV OP1_LOCATION, CX
    MOV OP1_PROPERTY, 00111000B
    JMP VALID

    REG_CHK:

    IMED_CHK:


    INVALID:
    CALL PARSE_ERROR
    JMP RETURN

    VALID:
    CALL PARSE_VALID

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


PARSE_VALID PROC NEAR
    MOV AH, 02
    MOV DL, 'S'
    INT 21H
    RET
PARSE_VALID ENDP
SPLIT_STRING MACRO SRC, DST
    LOCAL FIRST_CHAR, MAIN_LOOP, RETURN, SKIP, INSERT
    MOV SI, 0
    MOV DI, 0

    FIRST_CHAR:
    CMP SRC[SI], ' '
    JNE MAIN_LOOP
    INC SI
    JMP FIRST_CHAR

    MAIN_LOOP:
    CMP SRC[SI], '$'
    JE RETURN

    ;CHECK WHITESPACE
    CMP SRC[SI], ' '
    JNE INSERT
    
    MOV DST[DI], '$'
    INC DI
    JMP FIRST_CHAR
    

    ;GET CHARACTERS
    INSERT:
    MOV AL, SRC[SI]
    MOV DST[DI], AL
    INC DI
    
    SKIP:
 
    INC SI
    JMP MAIN_LOOP
    ;RETURN
    RETURN:
    MOV DST[DI], '$'
    MOV DST[DI] + 1, '+'
ENDM SPLIT_STRING1

PARSE_CMD MACRO SRC, CMD_ARR, CMD_ARR_SIZE
    LOCAL MAIN_LOOP, SKIPCMD, FINALLY, CHECK_VALID, RETURN, INVALID, VALID
    MOV DI, 0
    MOV SI, 0

    MAIN_LOOP:
    ;Reached end of CMD_ARR (No command matched)
    CMP DI, CMD_ARR_SIZE
    JE INVALID
    
    ;Check if SRC cmd ended
    CMP SRC[SI], '$'
    ;Check if current cmd also ended
    JE CHECK_VALID

    MOV DL, SRC[SI]
    CMP DL, CMD_ARR[DI]
    ;Command mismatch
    JNE SKIPCMD

    INC SI
    INC DI
    JMP MAIN_LOOP

    CHECK_VALID:
    CMP CMD_ARR[DI], '$'
    ;Command matched!
    JE VALID
    ;Command mismatch
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
    JMP MAIN_LOOP

    INVALID:
    CALL PARSE_ERROR
    JMP RETURN

    VALID:
    MOV AH, 02
    MOV DL, 'V'
    INT 21H
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
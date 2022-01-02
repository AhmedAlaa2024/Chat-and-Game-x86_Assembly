;=============================================================================
;Split a string into word slices
;The seperator character is space ' '
;INPUT:     '$' Terminated String:                      CMD_MSG
;OUTPUT:    NULL(ASCII 0) Terminated Array of strings:  SPLIT_DATA
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
SPLIT_STRING PROC NEAR
    MOV SI, 0   ;CMD_MSG Disp
    MOV DI, 0   ;SPLIT_DATA Disp

    CMP CMD_MSG[0], ','
    JNE @@FIRST_CHAR

    CALL PARSE_ERROR
    RET

    ;Search for first occurrence of a char in CMD_MSG
    @@FIRST_CHAR:
    CMP CMD_MSG[SI], ','
    JNE @@SKIP_COMMA_HANDLING
    DEC DI
    @@SKIP_COMMA_HANDLING:
    CMP CMD_MSG[SI], ' '
    JNE @@MAIN_LOOP
    INC SI
    JMP @@FIRST_CHAR

    @@MAIN_LOOP:
    CMP CMD_MSG[SI], '$'
    JE @@RETURN

    ;Check for space
    CMP CMD_MSG[SI], ' '
    ;Non space characted detected
    JNE @@INSERT
    
    ;'$' Terminate current slice
    MOV SPLIT_DATA[DI], '$'
    INC DI
    JMP @@FIRST_CHAR ;Skip to next occurrence of a non space character
    

    ;Insert Character into SPLIT_DATA
    @@INSERT:
    MOV AL, CMD_MSG[SI]
    CMP AL, ','
    JNE @@NOT_COMMA
    MOV SPLIT_DATA[DI], '$'
    INC DI
    MOV SPLIT_DATA[DI], ','
    INC DI
    MOV SPLIT_DATA[DI], '$'
    INC DI
    INC SI
    JMP @@FIRST_CHAR
    @@NOT_COMMA:
    MOV SPLIT_DATA[DI], AL
    INC DI
    
    ;Advance to next iteration
    INC SI
    JMP @@MAIN_LOOP

    @@RETURN:
    CMP DI, 0
    JE @@SKIP

    CMP SPLIT_DATA[DI] - 1, '$'
    JE @@SKIP

    MOV SPLIT_DATA[DI], '$'
    INC DI
    @@SKIP:
    ;Array of strings is terminated by NULL (ASCII 0)
    MOV SPLIT_DATA[DI], 0
    
    RET
SPLIT_STRING ENDP
;=============================================================================
;   Current parse step is invalid event handler
;=============================================================================
PARSE_ERROR PROC NEAR
    MOV PARSE_ERROR_FLAG, 1
    RET
PARSE_ERROR ENDP
;=============================================================================
;   Current parse step is valid event handler
;=============================================================================
PARSE_VALID PROC NEAR
    RET
PARSE_VALID ENDP

;=============================================================================
;Parser subroutine that parses a cmd name
;INPUT:     SI (Current location in Split_data)  
;               
;OUTPUT:    CMD flag (Position in CMD_ARR) as described in PrsrData.inc
;=============================================================================
PARSE_CMD PROC NEAR
    MOV DI, 0
    MOV SI, 0
    MOV CMD_FLAG, 0

    @@MAIN_LOOP:
    ;Reached end of CMD_ARR (No cmd matched)
    CMP DI, CMD_ARR_SIZE
    JE @@INVALID
    
    ;Check if SPLIT_DATA ended
    CMP SPLIT_DATA[SI], '$'
    ;Check if current cmd also ended
    JE @@CHECK_VALID

    MOV DL, SPLIT_DATA[SI]
    CMP DL, CMD_ARR[DI]
    ;Cmd mismatch
    JNE @@SKIPCMD

    INC SI
    INC DI
    JMP @@MAIN_LOOP

    @@CHECK_VALID:
    CMP CMD_ARR[DI], '$'
    ;Cmd matched!
    JE @@VALID
    ;Cmd mismatch
    JMP @@SKIPCMD

    ;Skip to next cmd in CMD_ARR
    @@SKIPCMD:
    CMP CMD_ARR[DI], '$'
    JE @@FINALLY

    INC DI
    JMP @@SKIPCMD

    @@FINALLY:
    INC DI
    ;Reset to first char in SPLIT_DATA
    MOV SI, 0
    INC CMD_FLAG
    JMP @@MAIN_LOOP

    @@INVALID:
    CALL PARSE_ERROR
    RET

    @@VALID:
    CALL PARSE_VALID
    RET
PARSE_CMD ENDP

;=============================================================================
;Parser subroutine that parses a single operand
;INPUT:     SI (Current location in Split_data)  
;               
;OUTPUT:    Operand flag and location
;=============================================================================
PARSE_OPERAND PROC NEAR
    ;CHECK MEMORY MODE
    @@MEM_CHK:
    CMP SPLIT_DATA[SI], '['
    JNE @@REG_CHK

    ;REG INDIRECT CHECK
    INC SI
    ;CX Contain
    MOV CX, DI
    ADD CX, 6

    MOV BP, WORD PTR SPLIT_DATA[SI]

    CMP BP, WORD PTR BX_STR
    JE @@REG_INDIRECT_VALID
    ADD CX, 2
    CMP BP, WORD PTR SI_STR
    JE @@REG_INDIRECT_VALID
    ADD CX, 2
    CMP BP, WORD PTR DI_STR
    JE @@REG_INDIRECT_VALID
    ADD CX, 2
    CMP BP, WORD PTR BP_STR
    JE @@REG_INDIRECT_VALID  

    ;DIRECT ADRESSING CHECK
    MOV BH, 0
    MOV BL, SPLIT_DATA[SI]
    
    ;Check if digit
    CMP BL, '0'
    JL @@INVALIDHEX

    CMP BL, '9'
    JLE @@IS_DIGIT

    ;Check if A-F
    CMP BL, 'A'
    JL @@INVALIDHEX

    CMP BL, 'F'
    JG @@INVALIDHEX

    JMP @@IS_HEXCHAR
    @@INVALIDHEX:
    CALL PARSE_ERROR
    RET

    @@IS_HEXCHAR:
    SUB BL, 55D ;Get decimal value of hex char
    JMP @@GET_P_MEM

    @@IS_DIGIT:
    SUB BL, '0' ;Get decimal value of digit
    
    @@GET_P_MEM:
    MOV CX, DI
    ADD CX, BX
    ADD CX, 16
    JMP @@DIRECT_ADDR_VALID

    @@REG_INDIRECT_VALID:
    INC SI
    MOV BX, CX
    MOV CX, [BX]
    AND CX, 000FH
    ADD CX, 16
    ADD CX, DI
    @@DIRECT_ADDR_VALID:
    INC SI

    CMP SPLIT_DATA[SI], ']'
    JNE @@INVALID_MEM

    INC SI

    CMP SPLIT_DATA[SI], '$'
    JNE @@INVALID_MEM

    MOV BX, DX
    MOV [BX][1], CX
    MOV BYTE PTR [BX], 00111000B
    INC SI
    JMP @@VALID

    @@INVALID_MEM:
    CALL PARSE_ERROR
    RET
    
    @@REG_CHK:
    CMP SPLIT_DATA[SI][2], '$'
    JNE @@IMED_CHK
    MOV BX, 0
    MOV BP, WORD PTR SPLIT_DATA[SI]
    @@REG_CHK_LOOP:
    CMP BX, REG_STR_ARR_SIZE
    JE @@IMED_CHK

    CMP BP, WORD PTR REG_STR_ARR[BX]
    JE @@REG_VALID
    ADD BX, 3
    JMP @@REG_CHK_LOOP

    @@REG_VALID:
    MOV CL, 01000000B ;Set property type
    MOV AL, REG_STR_ARR[BX][2]
    MOV AH, AL
    SHR AH, 3
    AND AH, 00011000B
    OR  CL, AH ;Set property size
    MOV BX, DX
    MOV BYTE PTR [BX], CL
    AND AL, 0FH ;AL now contains p_data location disp
    MOV AH, 0
    MOV CX, AX
    ADD CX, DI
    MOV BX, DX
    MOV WORD PTR [BX][1], CX ;Set OP Location
    ADD SI, 3
    JMP @@VALID


    @@IMED_CHK:
    MOV AX, 0   
    MOV BH, 0
    MOV CL, 0

    ;CHECK IF IMMMEDIATE BEGINS WITH DIGIT
    MOV BL, SPLIT_DATA[SI]
    CMP BL, '0'
    JL @@INVALID

    CMP BL, '9'
    JG @@INVALID

    @@SKIP_LEADING_ZEROS:
    CMP SPLIT_DATA[SI], '$'
    JE @@IMED_CHK_LOOP
    CMP SPLIT_DATA[SI], '0'
    JNE @@IMED_CHK_LOOP
    INC SI
    JMP @@SKIP_LEADING_ZEROS

    @@IMED_CHK_LOOP:
    MOV BL, SPLIT_DATA[SI]
    CMP BL, '$'
    JE @@EXIT_IMMED_LOOP

    CMP CL, 4
    JGE @@INVALID

    ;Check if digit
    CMP BL, '0'
    JL @@INVALID

    CMP BL, '9'
    JLE @@IS_DIGIT_IMMED

    ;Check if A-F
    CMP BL, 'A'
    JL @@INVALID

    CMP BL, 'F'
    JG @@INVALID


    @@IS_HEX_IMMED:
    SUB BL, 55D ;Get decimal value of hex char
    JMP @@CALC_IMMED

    @@IS_DIGIT_IMMED:
    SUB BL, '0' ;Get decimal value of digit

    @@CALC_IMMED:
    SHL AX, 4
    ADD AX, BX

    INC CL
    INC SI
    JMP @@IMED_CHK_LOOP
    @@EXIT_IMMED_LOOP:
    INC SI
    ;AX NOW CONTAINS IMMEDIATE VALUE
    MOV [DI][32], AX
    MOV BP, DI
    ADD BP, 32
    ;BX = OFFSET OP_PROPERTY
    ;BX + 1 = OFFSET OP_LOCATION
    MOV BX, DX
    MOV [BX][1], BP
    
    MOV BYTE PTR [BX], 10010000B
    CMP AX, 0FFH
    JA @@VALID

    MOV BYTE PTR [BX], 10001000B
    JMP @@VALID

    @@INVALID:
    CALL PARSE_ERROR
    RET

    @@VALID:
    CALL PARSE_VALID
    RET
PARSE_OPERAND ENDP
;=============================================================================
;Parser subroutine that parses the (0-2) operands in Split_Data
;INPUT:     CMD Flag (Which command is currently selected)
;           OP Flags (Which operands are supported by this cmd)   
;               
;OUTPUT:    OP 1 and 2 FLAGS and LOCATIONS
;           As described in PrsrData.inc
;=============================================================================
PARSE_CMD_OPERANDS PROC NEAR
    MOV SI, 0
    MOV DI, P_DATA

    @@SKIPWORD:
    CMP SPLIT_DATA[SI], '$'
    JE @@FINALLY

    INC SI
    JMP @@SKIPWORD

    @@FINALLY:
    INC SI

    ;CHECK IF FIRST OPERAND IS NEEDED
    MOV CL, OP_FLAGS
    ;CL != 0 IF First Operand is needed
    AND CL, 10000000B

    CMP CL, 0
    JE @@FINAL_CHECK

    ;Has first operand
    MOV DX, OFFSET OP1_PROPERTY
    CALL PARSE_OPERAND

    ;Check if first operand is valid
    MOV CL, OP_FLAGS
    MOV DL, OP1_PROPERTY
    AND CL, 01110000B ;get supported modes
    AND DL, 11100000B

    SHL CL, 1
    AND CL, DL
    CMP CL, 0 ;If CL == 0 then mode mismatch
    JE @@INVALID 


    ;CHECK IF SECOND OPERAND IS NEEDED
    MOV CL, OP_FLAGS
    ;CL != 0 IF SECOND Operand is needed
    AND CL, 00001000B
    CMP CL, 0
    JNE @@OP2_CHECK

    MOV CL, OP_FLAGS
    AND CL, 00000110B ;CL != 0 if cmd is a shift based cmd
    CMP CL, 0
    JNE @@OP2_CHECK
    
    ;Operand 2 is not needed
    JMP @@FINAL_CHECK

    @@OP2_CHECK:
    ;Check for comma
    CMP WORD PTR SPLIT_DATA[SI], 242CH ;',$'
    JNE @@INVALID
    ADD SI, 2

    ;Has second operand
    MOV DX, OFFSET OP2_PROPERTY
    CALL PARSE_OPERAND 

    ;Check if second operand is valid
    MOV CL, OP_FLAGS
    MOV DL, OP2_PROPERTY
    AND CL, 00000111B ;get supported modes
    AND DL, 11100000B

    SHR DL, 5
    AND CL, DL
    CMP CL, 0 ;If CL == 0 then mode mismatch
    JE @@INVALID 

    MOV CL, OP_FLAGS
    AND CL, 00001111B ;CL != 0 if cmd is a shift based cmd
    CMP CL, 00000110B
    JE @@SHIFT_CMDS_VALIDATION ;Skip regular 2nd operand validation

    ;MEM TO MEM Check
    MOV CL, OP1_PROPERTY
    MOV DL, OP2_PROPERTY
    AND CL, 00100000B ;Get mem mode
    AND DL, 00100000B ;Get mem mode
    AND CL, DL
    CMP CL, 0 ;CL != 0 if both are mem
    JNE @@INVALID

    ;Size Mismatch check
    MOV CL, OP1_PROPERTY
    MOV DL, OP2_PROPERTY
    
    AND DL, 10001000B
    CMP DL, 10001000B
    JNE @@NON_IMMED_SIZE_MISMATCH_CHECK
    JMP @@FINAL_CHECK


    @@NON_IMMED_SIZE_MISMATCH_CHECK:
    MOV CL, OP1_PROPERTY    
    MOV DL, OP2_PROPERTY
    AND CL, 00011000B ;Get sizes
    AND DL, 00011000B ;Get sizes

    AND CL, DL
    CMP CL, 0 ;CL == 0 if size mismatch
    JE @@INVALID
    JMP @@FINAL_CHECK

    @@SHIFT_CMDS_VALIDATION:
    MOV CL, OP2_PROPERTY
    AND CL, 00010000B
    CMP CL, 0
    JNE @@INVALID

    MOV AX, OP2_LOCATION
    SUB AX, 2
    CMP AX, DI
    JE @@FINAL_CHECK

    SUB AX, 30
    CMP AX, DI
    JE @@FINAL_CHECK

    JMP @@INVALID

    @@FINAL_CHECK:
    CMP SPLIT_DATA[SI], 0
    JNE @@INVALID
    RET

    @@INVALID:
    CALL PARSE_ERROR
    RET 
PARSE_CMD_OPERANDS ENDP
;=============================================================================
;Parse an ASM X86 command
;PARSE_ERROR is called whenever a parse step is invalid
;PARSE_VALID is called whenever a parse step is successful
;
;INPUT:     '$' Terminated String:                    CMD_MSG                   
;OUTPUT:    CMD FLAGS
;           OP 1 and 2 FLAGS and LOCATIONS
;           As described in PrsrData.inc
;Example Usage:
;   PARSER used on '  MOV AX,   0ABCD  $'
;   Output:
;       CMD FLag    : MOV CMD flag (1-Byte based on PrsrData defintion order)
;       OP1 Location: OFFSET Player_AX_DATA
;       OP2 Location: OFFFSET Player_Immediate_DATA
;       OP1 PROPERTY: Reg, 16-bits
;       OP2 PROPERTY: Immediate, 16-bits
;=============================================================================
PARSER PROC NEAR    
    MOV PARSE_ERROR_FLAG, 0
    CALL SPLIT_STRING
    TOUPPER SPLIT_DATA, 30

    CALL PARSE_CMD

    ;Get command operands
    MOV BX, OFFSET CMD_OPERANDS_ARR
    MOV AL, CMD_FLAG
    XLAT
    MOV OP_FLAGS, AL

    CALL PARSE_CMD_OPERANDS
    RET
PARSER ENDP

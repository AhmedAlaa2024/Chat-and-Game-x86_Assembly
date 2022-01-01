JUMPS
LOCALS @@

;PUBLIC P_DATA, CMD_MSG, CMD_FLAG, OP_FLAGS, OP1_PROPERTY, OP1_LOCATION, OP2_PROPERTY, OP2_LOCATION, P1_DATA, P1_MEM, P2_DATA, P2_MEM
;EXTRN PARSER:FAR
;EXTRN EXEC_CMD:FAR
;EXTRN FLAGS_LOCATION:WORD

.MODEL SMALL
.STACK 64
.DATA
include BirdData.inc
include GUI_DATA.inc
USERNAME_LENGTH EQU 14
P1_USERNAME_BUFF DB USERNAME_LENGTH
P1_USERNAME_SIZE DB 7
NAME_1 DB 'PLAYER1$'
;NAME_1 DB (USERNAME_LENGTH + 1) DUP('$')

;UNSIGNED 4-DIGIT NUMBER
P1_INITIAL_POINTS DW 56

P2_USERNAME_BUFF DB USERNAME_LENGTH
P2_USERNAME_SIZE DB 7
NAME_2 DB 'PLAYER2$'
;NAME_2 DB (USERNAME_LENGTH + 1) DUP('$')

;UNSIGNED 4-DIGIT NUMBER
P2_INITIAL_POINTS DW 34

P1_FORBIDDEN_CHARATER DB 'D'
P2_FORBIDDEN_CHARATER DB 'F'

CURR_PROCESSOR_FLAG DB 00000001B
CURR_PLAYER_FLAG DB 0
POWER_UP_SELECTED_FLAG DB 0

INCLUDE screens.inc
include p_data.inc
include char.inc
include data.inc

;==================
; PARSER DATA
;==================
SPLIT_DATA DB 34 dup(0)

P_DATA DW ?

CMD_FLAG  DB 0
OP_FLAGS  DB 0

OP1_PROPERTY DB 0
OP1_LOCATION DW 0
OP2_PROPERTY DB 0
OP2_LOCATION DW 0

CMD_BUFF_SIZE EQU 30
CMD_BUFF DB CMD_BUFF_SIZE, 0
CMD_MSG DB 31 dup('$')

PARSE_ERROR_FLAG DB 0
FORBIDDEN_CHAR_ERROR_FLAG DB 0

;=============================================
;         Arithmetic CMDS PROCS               |
;=============================================
EXEC_CMD_ARR LABEL BYTE
ADD_CMD  DW  OFFSET EXEC_ADD_CMD
ADC_CMD  DW  OFFSET EXEC_ADC_CMD
SUB_CMD  DW  OFFSET EXEC_SUB_CMD
SBB_CMD  DW  OFFSET EXEC_SBB_CMD
MUL_CMD  DW  OFFSET EXEC_MUL_CMD
DIV_CMD  DW  OFFSET EXEC_DIV_CMD
IMUL_CMD DW  OFFSET EXEC_IMUL_CMD
IDIV_CMD DW  OFFSET EXEC_IDIV_CMD
INC_CMD  DW  OFFSET EXEC_INC_CMD
DEC_CMD  DW  OFFSET EXEC_DEC_CMD
;=============================================
;         Bitwise CMDS PROCS                  |
;=============================================
XOR_CMD  DW  OFFSET EXEC_XOR_CMD
AND_CMD  DW  OFFSET EXEC_AND_CMD
OR_CMD   DW  OFFSET EXEC_OR_CMD
SHR_CMD  DW  OFFSET EXEC_SHR_CMD
SHL_CMD  DW  OFFSET EXEC_SHL_CMD
SAR_CMD  DW  OFFSET EXEC_SAR_CMD
ROR_CMD  DW  OFFSET EXEC_ROR_CMD
RCL_CMD  DW  OFFSET EXEC_RCL_CMD
RCR_CMD  DW  OFFSET EXEC_RCR_CMD
ROL_CMD  DW  OFFSET EXEC_ROL_CMD
;=============================================
;           Other CMDS PROCS                  |
;=============================================
MOV_CMD  DW  OFFSET EXEC_MOV_CMD
NOP_CMD  DW  OFFSET EXEC_NOP_CMD
CLC_CMD  DW  OFFSET EXEC_CLC_CMD
STC_CMD  DW  OFFSET EXEC_STC_CMD


.CODE

GET_FLAGS PROC NEAR
    MOV BX, P_DATA
    PUSH [BX][34]
    POPF
    RET
GET_FLAGS ENDP

SET_FLAGS PROC NEAR
    PUSHF
    MOV BX, P_DATA
    POP [BX][34] 
    RET
SET_FLAGS ENDP

EXEC_ADD_CMD PROC NEAR
    CMP Cl, 0 
    JNE @@SIZE8  
    MOV DX, WORD PTR [SI]
    CALL GET_FLAGS
    ADD WORD PTR [DI], DX
    JMP @@FINALLY

    @@SIZE8:
    MOV DL, BYTE PTR [SI]
    CALL GET_FLAGS
    ADD BYTE PTR [DI], DL
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_ADD_CMD ENDP

EXEC_ADC_CMD PROC NEAR
    CMP Cl, 0 
    JNE @@SIZE8  
    MOV DX, WORD PTR [SI]
    CALL GET_FLAGS
    ADC WORD PTR [DI], DX
    JMP @@FINALLY

    @@SIZE8:
    MOV DL, BYTE PTR [SI]
    CALL GET_FLAGS
    ADC BYTE PTR [DI], DL
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_ADC_CMD ENDP

EXEC_SUB_CMD PROC NEAR
    CMP Cl, 0 
    JNE @@SIZE8  
    MOV DX, WORD PTR [SI]
    CALL GET_FLAGS
    SUB WORD PTR [DI], DX
    JMP @@FINALLY

    @@SIZE8:
    MOV DL, BYTE PTR [SI]
    CALL GET_FLAGS
    SUB BYTE PTR [DI], DL
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_SUB_CMD ENDP

EXEC_SBB_CMD PROC NEAR
    CMP Cl, 0 
    JNE @@SIZE8  
    MOV DX, WORD PTR [SI]
    CALL GET_FLAGS
    SBB WORD PTR [DI], DX
    JMP @@FINALLY

    @@SIZE8:
    MOV DL, BYTE PTR [SI]
    CALL GET_FLAGS
    SBB BYTE PTR [DI], DL
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_SBB_CMD ENDP

EXEC_MUL_CMD PROC NEAR
    MOV BX, P_DATA
    MOV AX, [BX][0]
    MOV DX, [BX][4]

    CMP Cl, 0 
    JNE @@SIZE8  
    MOV CX, WORD PTR [SI]
    CALL GET_FLAGS
    MUL CX
    JMP @@FINALLY

    @@SIZE8:
    MOV CL, BYTE PTR [SI]
    CALL GET_FLAGS
    MUL CL
    
    @@FINALLY:
    CALL SET_FLAGS
    MOV [BX][0], AX 
    MOV [BX][4], DX
    RET
EXEC_MUL_CMD ENDP

EXEC_IMUL_CMD PROC NEAR
    MOV BX, P_DATA
    MOV AX, [BX][0]
    MOV DX, [BX][4]

    CMP Cl, 0 
    JNE @@SIZE8  
    MOV CX, WORD PTR [SI]
    CALL GET_FLAGS
    IMUL CX
    JMP @@FINALLY

    @@SIZE8:
    MOV CL, BYTE PTR [SI]
    CALL GET_FLAGS
    IMUL CL
    
    @@FINALLY:
    CALL SET_FLAGS
    MOV [BX][0], AX 
    MOV [BX][4], DX
    RET
EXEC_IMUL_CMD ENDP

EXEC_DIV_CMD PROC NEAR
    MOV BX, P_DATA
    MOV AX, [BX][0]
    MOV DX, [BX][4]

    CMP Cl, 0 
    JNE @@SIZE8  
    MOV CX, WORD PTR [SI]
    CALL GET_FLAGS
    DIV CX
    JMP @@FINALLY

    @@SIZE8:
    MOV CL, BYTE PTR [SI]
    CALL GET_FLAGS
    DIV CL
    
    @@FINALLY:
    CALL SET_FLAGS
    MOV [BX][0], AX 
    MOV [BX][4], DX
    RET
EXEC_DIV_CMD ENDP

EXEC_IDIV_CMD PROC NEAR
    MOV BX, P_DATA
    MOV AX, [BX][0]
    MOV DX, [BX][4]

    CMP Cl, 0 
    JNE @@SIZE8  
    MOV CX, WORD PTR [SI]
    CALL GET_FLAGS
    IDIV CX
    JMP @@FINALLY

    @@SIZE8:
    MOV CL, BYTE PTR [SI]
    CALL GET_FLAGS
    IDIV CL
    
    @@FINALLY:
    CALL SET_FLAGS
    MOV [BX][0], AX 
    MOV [BX][4], DX
    RET
EXEC_IDIV_CMD ENDP

EXEC_INC_CMD PROC NEAR
    CMP Cl, 0 
    JNE @@SIZE8  
    CALL GET_FLAGS
    INC WORD PTR [DI]
    JMP @@FINALLY

    @@SIZE8:
    CALL GET_FLAGS
    INC BYTE PTR [DI]
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_INC_CMD ENDP

EXEC_DEC_CMD PROC NEAR
    CMP Cl, 0 
    JNE @@SIZE8  
    CALL GET_FLAGS
    DEC WORD PTR [DI]
    JMP @@FINALLY

    @@SIZE8:
    CALL GET_FLAGS
    DEC BYTE PTR [DI]
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_DEC_CMD ENDP

EXEC_XOR_CMD PROC NEAR
    CMP Cl, 0 
    JNE @@SIZE8  
    MOV DX, WORD PTR [SI]
    CALL GET_FLAGS
    XOR WORD PTR [DI], DX
    JMP @@FINALLY

    @@SIZE8:
    MOV DL, BYTE PTR [SI]
    CALL GET_FLAGS
    XOR BYTE PTR [DI], DL
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_XOR_CMD ENDP

EXEC_AND_CMD PROC NEAR
    CMP Cl, 0 
    JNE @@SIZE8  
    MOV DX, WORD PTR [SI]
    CALL GET_FLAGS
    AND WORD PTR [DI], DX
    JMP @@FINALLY

    @@SIZE8:
    MOV DL, BYTE PTR [SI]
    CALL GET_FLAGS
    AND BYTE PTR [DI], DL
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_AND_CMD ENDP

EXEC_OR_CMD PROC NEAR
    CMP Cl, 0 
    JNE @@SIZE8  
    MOV DX, WORD PTR [SI]
    CALL GET_FLAGS
    OR WORD PTR [DI], DX
    JMP @@FINALLY

    @@SIZE8:
    MOV DL, BYTE PTR [SI]
    CALL GET_FLAGS
    OR BYTE PTR [DI], DL
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_OR_CMD ENDP 

EXEC_SHR_CMD PROC NEAR
    CMP Cl, 0
    MOV CL, BYTE PTR [SI] 
    JNE @@SIZE8    
    CALL GET_FLAGS
    SHR WORD PTR [DI], CL
    JMP @@FINALLY

    @@SIZE8:
    CALL GET_FLAGS
    SHR BYTE PTR [DI], CL
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_SHR_CMD ENDP 

EXEC_SHL_CMD PROC NEAR
    CMP Cl, 0
    MOV CL, BYTE PTR [SI] 
    JNE @@SIZE8    
    CALL GET_FLAGS
    SHL WORD PTR [DI], CL
    JMP @@FINALLY

    @@SIZE8:
    CALL GET_FLAGS
    SHL BYTE PTR [DI], CL
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_SHL_CMD ENDP 

EXEC_SAR_CMD PROC NEAR
    CMP Cl, 0
    MOV CL, BYTE PTR [SI] 
    JNE @@SIZE8    
    CALL GET_FLAGS
    SAR WORD PTR [DI], CL
    JMP @@FINALLY

    @@SIZE8:
    CALL GET_FLAGS
    SAR BYTE PTR [DI], CL
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_SAR_CMD ENDP 

EXEC_ROR_CMD PROC NEAR
    CMP Cl, 0
    MOV CL, BYTE PTR [SI] 
    JNE @@SIZE8    
    CALL GET_FLAGS
    ROR WORD PTR [DI], CL
    JMP @@FINALLY

    @@SIZE8:
    CALL GET_FLAGS
    ROR BYTE PTR [DI], CL
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_ROR_CMD ENDP 

EXEC_RCL_CMD PROC NEAR
    CMP Cl, 0
    MOV CL, BYTE PTR [SI] 
    JNE @@SIZE8    
    CALL GET_FLAGS
    RCL WORD PTR [DI], CL
    JMP @@FINALLY

    @@SIZE8:
    CALL GET_FLAGS
    RCL BYTE PTR [DI], CL
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_RCL_CMD ENDP

EXEC_RCR_CMD PROC NEAR
    CMP Cl, 0
    MOV CL, BYTE PTR [SI] 
    JNE @@SIZE8    
    CALL GET_FLAGS
    RCR WORD PTR [DI], CL
    JMP @@FINALLY

    @@SIZE8:
    CALL GET_FLAGS
    RCR BYTE PTR [DI], CL
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_RCR_CMD ENDP 

EXEC_ROL_CMD PROC NEAR
    CMP Cl, 0
    MOV CL, BYTE PTR [SI] 
    JNE @@SIZE8    
    CALL GET_FLAGS
    ROL WORD PTR [DI], CL
    JMP @@FINALLY

    @@SIZE8:
    CALL GET_FLAGS
    ROL BYTE PTR [DI], CL
    
    @@FINALLY:
    CALL SET_FLAGS
    RET
EXEC_ROL_CMD ENDP  

EXEC_MOV_CMD PROC NEAR
    CMP Cl, 0
    JNE @@SIZE8
   
    MOV DX, WORD PTR [SI]
    MOV WORD PTR [DI], DX
    RET

    @@SIZE8:
    MOV DL, BYTE PTR [SI]
    MOV BYTE PTR [DI], DL
    
    RET
EXEC_MOV_CMD ENDP

EXEC_NOP_CMD PROC NEAR
    NOP
    RET
EXEC_NOP_CMD ENDP

EXEC_CLC_CMD PROC NEAR
    CALL GET_FLAGS
    CLC
    CALL SET_FLAGS
    RET
EXEC_CLC_CMD ENDP

EXEC_STC_CMD PROC NEAR
    CALL GET_FLAGS
    STC
    CALL SET_FLAGS
    RET
EXEC_STC_CMD ENDP

EXEC_CMD PROC NEAR
    ;Initialize Data Segment
    MOV AX, @DATA
    MOV DS, AX
    ;End initialize

    MOV DI, OP1_LOCATION
    MOV SI, OP2_LOCATION

    MOV CL, OP1_PROPERTY
    MOV DL, OP1_PROPERTY
    AND DL, 00100000B   ;Check if memory
    JZ @@NOT_MEMORY
    MOV CL, OP2_PROPERTY   
    @@NOT_MEMORY:
    AND CL, 00001000B


    MOV AH, 0
    MOV AL, CMD_FLAG
    SHL AL, 1       ;Get memory location seperated by Words
    ;AX = CMD memory location displacement

    MOV BX, AX
    MOV AX, WORD PTR EXEC_CMD_ARR[BX] ;AX = EXEC_CMD_ARR[AX]

    ;AX now contains the memory adress of the proper EXEC_CMD PROC
    ;PROC NEAR CALL
    CALL AX

    ;Return from subprogram
    RET
EXEC_CMD ENDP

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

PARSE_ERROR PROC NEAR
    ;MOV AH, 02
    ;MOV DL, 'E'
    ;INT 21H
    MOV PARSE_ERROR_FLAG, 1
    RET
PARSE_ERROR ENDP


PARSE_VALID PROC NEAR
    ;MOV AH, 02
    ;MOV DL, 'V'
    ;INT 21H
    RET
PARSE_VALID ENDP

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
    JG @@VALID

    MOV BYTE PTR [BX], 10001000B
    JMP @@VALID

    @@INVALID:
    CALL PARSE_ERROR
    RET

    @@VALID:
    CALL PARSE_VALID
    RET
PARSE_OPERAND ENDP

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

    ;CMP SPLIT_DATA[SI], 0
    ;JNE @@NOT_END_OF_DATA
    ;CALL PARSE_ERROR
    ;RET
    ;@@NOT_END_OF_DATA:

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

drawPNG macro column,  row,  color,  Y,  X                 ;x,  y,  color...the last two parameters are the dynamic position of the pixel. Assumes that mov ah,  0ch was priorly done.
            mov ch, 0                                                      ;Because all images are db arrays.                                                                             
            mov dh, 0
            mov dl,row
            mov cl,column
            mov al,color
            ;Pixel Loaction
            add dx,Y                                                    ;X and Y correspond to the pixel loction.
            add cx,X
            int 10h
endm drawPNG
savePNG macro column,  row,  color,  Y,  X                 ;x,  y,  color...the last two parameters are the dynamic position of the pixel. Assumes that mov ah,  0ch was priorly done.
            mov AH,0Dh
            mov ch, 0                                                      ;Because all images are db arrays.                                                                             
            mov dh, 0
            mov dl,  row
            mov cl,  column
            ;Pixel Loaction
            add dx,  Y                                                    ;X and Y correspond to the pixel loction.
            add cx,  X
            int 10h
            mov color,al
endm savePNG
DRAW_MOIVNG_OBJECT MACRO img,imgB,imgSize,y,x ;imgB and img are the same width and hight
                local while
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI
                mov bx,  offset img
                mov si, offset imgB
while:
                savePNG [si], [si+1], [si+2],  y,  x
                mov ah, 0ch
                drawPNG [bx], [bx+1], [bx+2],  y,  x
                add bx, 3
                add si, 3
                cmp bx, offset imgSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE while  
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX 
ENDM DRAW_MOIVNG_OBJECT

;===============================================================================      
DRAW_BIRD  MACRO 
        LOCAL NOCHANGE,CHECKDOWN,SHIFT,CHECKSPEED,CHECKEND
        PUSH AX
        PUSH CX
        PUSH DX
        CMP BIRD1_MOVING,0
        JNE CHECKEND
        JMP FAR PTR NOCHANGE
CHECKEND:
        CMP BIRD1_X,300
        JNE CHECKSPEED
        MOV BIRD1_MOVING,0
        MOV GAME_MOVING,0
        call DRAW_BIRDUP_BACKGROUND
        CALL DRAW_BIRDDOWN_BACKGROUND
        call DRAW_PLAYER_BACKGROUND
        mov Bird1_X,600
        cmp BULLET1_MOVING,1
        jne CHECKSPEED
        call DRAW_BULLET_BACKGROUND
CHECKSPEED:
        MOV AX,TIME
        MOV CX,BIRD_SPEED
        DIV CX
        CMP DX,0
        JE SHIFT
        JMP FAR PTR NOCHANGE
SHIFT:
        CMP BIRDWING,1
        JNE CHECKDOWN
        DEC BIRDWING
        call DRAW_BIRDDOWN_BACKGROUND
        SUB BIRD1_X,10
        DRAW_MOIVNG_OBJECT birdup birdupBackGround birdupSize Bird1_Y Bird1_X
        JMP NOCHANGE
CHECKDOWN:
        INC BIRDWING
        call DRAW_BIRDUP_BACKGROUND
        SUB BIRD1_X,10
        DRAW_MOIVNG_OBJECT birddown birddownBackGround birddownSize Bird1_Y Bird1_X
NOCHANGE:
        POP DX
        POP CX
        POP AX
ENDM DRAW_BIRD
;=============================================================================== 
CONSUMEBUFFER MACRO 
        PUSH AX
        mov ah,0;CONSUME BUFFER
        int 16h      
        POP AX
ENDM CONSUMEBUFFER
;========================================================================
;This macro checks the buttons and take a certian action correspondingly
;========================================================================
DRAW_PLAYER MACRO Y , X ,KEY
        LOCAL ISRIGHT,NOCHANGE,DRAW,ISUP,ISDOWN
                CMP KEY,75 ;LEFT
                JNE ISRIGHT
                CONSUMEBUFFER
                CMP X,300
                JBE NOCHANGE
                CALL DRAW_PLAYER_BACKGROUND
                SUB X,10
                JMP DRAW        
        ISRIGHT:
                CMP KEY,77 ;RIGHT
                JNE ISUP
                CONSUMEBUFFER
                CMP X,575
                JAE NOCHANGE
                CALL DRAW_PLAYER_BACKGROUND
                ADD X,10
                JMP DRAW  
        ISUP:
                CMP KEY,72 ;UP
                JNE ISDOWN
                CONSUMEBUFFER
                CMP Y,50
                JBE NOCHANGE
                CALL DRAW_PLAYER_BACKGROUND
                SUB Y,10 
                JMP DRAW 
        ISDOWN:
                CMP KEY,80 ;DOWN
                JNE NOCHANGE
                CONSUMEBUFFER
                CMP Y,300
                JAE NOCHANGE
                CALL DRAW_PLAYER_BACKGROUND
                ADD Y,10 
        DRAW:     
                DRAW_MOIVNG_OBJECT shooter shooterBackground shooterSize P1_Y P1_X      
        NOCHANGE:

ENDM DRAW_PLAYER 
DRAW_BULLET MACRO KEY
        LOCAL NOCHANGE,DRAW,CHECKSPACE,CHECKMOVING,UNHIT,START
        PUSH AX
        PUSH CX
        PUSH DX
        PUSH SI
                CMP KEY,57 ;Space
                JNE CHECKFINISH
                CONSUMEBUFFER
                CMP BULLET1_MOVING,0
                JNE CHECKFINISH
                MOV BULLET1_MOVING,1
                MOV DX,P1_X
                ADD DX,10
                MOV BULLET1_X,DX
                MOV DX,P1_Y
                MOV BULLET1_Y,DX
                SUB BULLET1_Y,20
                DRAW_MOIVNG_OBJECT bullet bulletBackground bulletSize Bullet1_Y Bullet1_X 
        CHECKFINISH:
                CMP BULLET1_Y,20
                JNE CHECKMOVING
                MOV BULLET1_MOVING,0
                CALL DRAW_BULLET_BACKGROUND
                MOV SI,BIRD1_X
                ADD SI,33
                CMP BULLET1_X,SI
                JAE UNHIT
                MOV SI,BULLET1_X
                ADD SI,15
                CMP SI,Bird1_X
                JBE UNHIT
                CALL END_MINI_GAME_P1
                call DRAW_BIRDUP_BACKGROUND
                CALL DRAW_BIRDDOWN_BACKGROUND
                CALL DRAW_PLAYER_BACKGROUND
                MOV BIRD1_MOVING,0
                MOV GAME_MOVING,0
                MOV Bird1_X,600
        UNHIT:
                MOV DX,P1_Y
                MOV BULLET1_Y,DX
                JMP NOCHANGE
        CHECKMOVING:
                CMP BULLET1_MOVING,1
                JNE NOCHANGE
                MOV AX,TIME
                MOV CX,BULLET_SPEED
                DIV CX
                CMP DX,0
                JNE NOCHANGE
                CALL DRAW_BULLET_BACKGROUND
                SUB BULLET1_Y,10
                DRAW_MOIVNG_OBJECT bullet bulletBackground bulletSize Bullet1_Y Bullet1_X      

        NOCHANGE:
        POP SI
        POP DX
        POP CX
        POP AX
ENDM DRAW_BULLET
;===============================================================================
DRAW_BACKGROUND MACRO
        LOCAL OUTER,INNER
        PUSH CX
        PUSH DX
        PUSH BX
        PUSH AX
        MOV DX,0
        MOV AL,0FH
        MOV AH,0CH

        OUTER:
                MOV CX,0
        INNER:
                INT 10h
                INC CX
                CMP CX,640
                JNE INNER
                INC DX
                CMP DX,400
                JNE OUTER

        POP AX
        POP BX
        POP DX
        POP CX
ENDM DRAW_BACKGROUND        
;=================================================
MOVE_CURSOR     MACRO X, Y
        PUSH AX
        PUSH DX
        ;================
        MOV AH,02H
        MOV DL,X
        MOV DH,Y
        INT 10H
        ;================
        POP DX
        POP AX
ENDM    MOVE_CURSOR 
;=================================================

MINI_GAME PROC 
        CMP GAME_MOVING,1
        JE GAMEISMOVING
        CALL GENERATE_RANDOM
        CMP RANDOM0_99,88
        JE GAMENOTMOVING
        RET
GAMENOTMOVING:
        MOV GAME_MOVING,1
        MOV BIRD1_MOVING,1
        DRAW_MOIVNG_OBJECT shooter shooterBackground shooterSize P1_Y P1_X
GAMEISMOVING:
        mov ah,1
        int 16h
        CMP BIRD1_MOVING,0
        JNE CONTINUE_P1
        RET
CONTINUE_P1:
        DRAW_PLAYER P1_Y P1_X AH
        DRAW_BULLET AH
        DRAW_BIRD
        RET
ENDP MINI_GAME

DRAW_PLAYER_BACKGROUND PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
                mov ah, 0ch
                mov bx,  offset shooterBackGround
whileshooterBackGround:
                drawPNG [bx], [bx+1], [bx+2],  P1_Y, P1_X
                add bx, 3
                cmp bx, offset shooterBackGroundSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE whileshooterBackGround
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
        RET
DRAW_PLAYER_BACKGROUND ENDP
DRAW_BULLET_BACKGROUND PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
                mov ah, 0ch
                mov bx,  offset bulletBackGround
whilebulletBackGround:
                drawPNG [bx], [bx+1], [bx+2],  Bullet1_Y, Bullet1_X
                add bx, 3
                cmp bx, offset bulletBackGroundSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE whilebulletBackGround
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
        RET
DRAW_BULLET_BACKGROUND ENDP
DRAW_BIRDUP_BACKGROUND PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
                mov ah, 0ch
                mov bx,  offset birdupBackGround
whilebirdupBackGround:
                drawPNG [bx], [bx+1], [bx+2],  Bird1_Y, Bird1_X
                add bx, 3
                cmp bx, offset birdupBackGroundSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE whilebirdupBackGround
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
        RET
DRAW_BIRDUP_BACKGROUND ENDP
DRAW_BIRDDOWN_BACKGROUND PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
                mov ah, 0ch
                mov bx,  offset birddownBackGround
whilebirddownBackGround:
                drawPNG [bx], [bx+1], [bx+2],  Bird1_Y, Bird1_X
                add bx, 3
                cmp bx, offset birddownBackGroundSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE whilebirddownBackGround
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
        RET
DRAW_BIRDDOWN_BACKGROUND ENDP
GENERATE_RANDOM PROC 
        PUSH AX
        PUSH BX
        PUSH DX
        PUSH CX
        MOV     AH, 00h   ; interrupt to get system timer in CX:DX 
        INT     1AH
        mov     [SEED], dx
        call    CalcNew   ; -> AX is a random number
        xor     dx, dx
        mov     cx, 5    
        div     cx        ; here dx contains the remainder - from 0 to 5
        MOV RANDOM0_4,DX
        call    CalcNew   ; -> AX is a random number
        xor     dx, dx
        mov     cx, 100    
        div     cx        ; here dx contains the remainder - from 0 to 5
        MOV RANDOM0_99,DX
        POP CX
        POP DX
        POP BX
        POP AX
        ret
ENDP GENERATE_RANDOM
; ----------------
; inputs: none  (modifies PRN seed variable)
; clobbers: DX.  returns: AX = next random number
CalcNew PROC 
    mov     ax, 25173          ; LCG Multiplier
    mul     word ptr [SEED]     ; DX:AX = LCG multiplier * seed
    add     ax, 13849          ; Add LCG increment value
    ; Modulo 65536, AX = (multiplier*seed+increment) mod 65536
    mov     [SEED], ax          ; Update seed = return value
    ret
ENDP CalcNew

END_MINI_GAME_P1 PROC
        CMP RANDOM0_4,0
        JNE CHECKRANDOM1
        INC HIT_P1_1
        RET
CHECKRANDOM1:        
        CMP RANDOM0_4,1
        JNE CHECKRANDOM2
        INC HIT_P1_2
        RET
CHECKRANDOM2:        
        CMP RANDOM0_4,2
        JNE CHECKRANDOM3
        INC HIT_P1_3
        RET
CHECKRANDOM3:
        CMP RANDOM0_4,3
        JNE CHECKRANDOM4
        INC HIT_P1_4
        RET
CHECKRANDOM4:
        CMP RANDOM0_4,4
        INC HIT_P1_5
        RET
ENDP END_MINI_GAME_P1

DRAW_BACKGROUND MACRO    COLOR
        LOCAL OUTER,INNER
        PUSH CX
        PUSH DX
        PUSH BX
        PUSH AX
        MOV DX,0
        MOV AL,COLOR
        MOV AH,0CH

        OUTER:
                MOV CX,0
        INNER:
                INT 10h
                INC CX
                CMP CX,800
                JNE INNER
                INC DX
                CMP DX,600
                JNE OUTER

        POP AX
        POP BX
        POP DX
        POP CX
ENDM DRAW_BACKGROUND 
;===================================================================
;EXAMPLE:   DRAW_LINE_V 320, 0, 400, RED -> Draw full vertical line.
DRAW_LINE_V   MACRO X, Y, LENGTH, COLOR
    LOCAL LINE
        ;==========================
        PUSH AX
        PUSH CX
        PUSH DX
        PUSH DI
        ;==========================
        MOV AH,0CH
        MOV AL,COLOR
        MOV CX,X
        MOV DX,Y
        MOV DI,0
        ADD DI,DX
        ADD DI,LENGTH
        LINE:
                INT 10H
                INC DX
                CMP DX,DI
                JNZ LINE
        ;==========================
        POP DI
        POP DX
        POP CX
        POP AX
ENDM    DRAW_LINE_V
;===================================================================
;EXAMPLE:   DRAW_LINE_H 0, 640, 200, GREEN -> Draw full horizontal line.
DRAW_LINE_H   MACRO X, Y, LENGTH, COLOR
        LOCAL LINE
        ;==========================
        PUSH AX
        PUSH CX
        PUSH DX
        PUSH DI
        ;==========================
        MOV AH,0CH
        MOV AL,COLOR
        MOV CX,X
        MOV DX,Y
        ADD DI,CX
        ADD DI,LENGTH
        LINE:
                INT 10H
                INC CX
                CMP CX,DI
                JNZ LINE
        ;==========================
        POP DI
        POP DX
        POP CX
        POP AX
ENDM    DRAW_LINE_H
;===================================================================
MOVE_CURSOR     MACRO X, Y
        PUSH AX
        PUSH DX
        PUSH DI
        ;================
        MOV AH,02H

        MOV DL,X
        MOV DH,Y

        ; MOV DI,X
        ; AND DI,00FFH
        ; MOV DX,DI

        ; MOV DI,Y
        ; AND DI,0FF00H
        ; OR  DX,DI

        INT 10H
        ;================
        POP DI
        POP DX
        POP AX
ENDM    MOVE_CURSOR 
;=================================================
PRINT_STRING    MACRO   X, Y, REG_NAME, COLOR
        LOCAL REPEAT
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DI
        ;================
        LEA DI,REG_NAME

        MOV AH,0EH
        XOR BX,BX       ; PAGE 0
        MOV BL,COLOR

        MOVE_CURSOR X, Y

        MOV CX,0
        MOV CL,'$'
        REPEAT:
                MOV AL,[DI]
                INC DI
                INT 10H
                CMP [DI],CL
                JNZ REPEAT
        ;================
        POP DI
        POP CX
        POP BX
        POP AX
ENDM    PRINT_STRING
;===================================================================
DRAW_BOX   MACRO   X_START, Y_START, LENGTH, WIDTH, COLOR
        LOCAL REPEAT
        ;==========================
        PUSH AX
        PUSH SI
        ;==========================
        MOV SI,Y_START
        MOV AX,Y_START
        ADD AX,WIDTH
        REPEAT:
                DRAW_LINE_H X_START, SI, LENGTH, COLOR
                INC SI
                CMP SI,AX
                JNZ REPEAT
        ;==========================
        POP SI
        POP AX
ENDM    DRAW_BOX
;===================================================================

;===================================================================
PRINT_4_DIGIT_GRAPHICS  MACRO   X, Y, NUMBER, COLOR
        LOCAL REPEAT
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DI
        ;================
        MOV AX, NUMBER
        CALL CONVERT_WORD_TO_STRING
        LEA DI,STR_TEMP

        MOV AH,0EH
        XOR BX,BX       ; PAGE 0
        MOV BL,COLOR

        MOVE_CURSOR X, Y

        MOV CX,4
        REPEAT:
                MOV AL,[DI]
                INC DI
                INT 10H
                LOOP REPEAT
        ;================
        POP DI
        POP CX
        POP BX
        POP AX
ENDM    PRINT_4_DIGIT_GRAPHICS
;===================================================================
DISPLAY_FLAG_VALUE  MACRO   X, Y, FLAG, COLOR
        LOCAL ZERO, EXIT
        PUSH AX
        PUSH BX
        PUSH DX
        ;================
        MOV DL,FLAG

        MOV AH,0EH
        XOR BX,BX       ; PAGE 0
        MOV BL,COLOR

        MOVE_CURSOR X, Y

        CMP DL,0
        JZ ZERO

        MOV AL,'1'
        INT 10H
        JMP EXIT

        ZERO:
                MOV AL,'0'
                INT 10H

        EXIT:
        ;================
        POP DX
        POP BX
        POP AX
ENDM DISPLAY_FLAG_VALUE
;===================================================================
PLAYER_1_UPDATE_REGISTERS_REPRESENTATION    PROC
        PRINT_4_DIGIT_GRAPHICS  60, 7, PLAYER_1_SCORE_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  60, 9, PLAYER_1_AX_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  60, 11, PLAYER_1_BX_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  60, 13, PLAYER_1_CX_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  60, 15, PLAYER_1_DX_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  60, 17, PLAYER_1_DI_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  60, 19, PLAYER_1_SI_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  60, 21, PLAYER_1_BP_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  60, 23, PLAYER_1_SP_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  60, 25, PLAYER_1_TIMER_VALUE, LIGHT_WHITE
        RET
ENDP    PLAYER_1_UPDATE_REGISTERS_REPRESENTATION
;===================================================================
PLAYER_1_UPDATE_MEMORY_REPRESENTATION    PROC
        ;PRINT_4_DIGIT_GRAPHICS  77, 7, PLAYER_1_MEM_0_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  77, 9, PLAYER_1_MEM_1_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  77, 11, PLAYER_1_MEM_2_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  77, 13, PLAYER_1_MEM_3_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  77, 15, PLAYER_1_MEM_4_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  77, 17, PLAYER_1_MEM_5_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  77, 19, PLAYER_1_MEM_6_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  77, 21, PLAYER_1_MEM_7_VALUE, LIGHT_WHITE

        ;PRINT_4_DIGIT_GRAPHICS  93, 7, PLAYER_1_MEM_8_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  93, 9, PLAYER_1_MEM_9_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  93, 11, PLAYER_1_MEM_A_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  93, 13, PLAYER_1_MEM_B_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  93, 15, PLAYER_1_MEM_C_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  93, 17, PLAYER_1_MEM_D_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  93, 19, PLAYER_1_MEM_E_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  93, 21, PLAYER_1_MEM_F_VALUE, LIGHT_WHITE
        RET
ENDP    PLAYER_1_UPDATE_MEMORY_REPRESENTATION
;===================================================================
PLAYER_1_UPDATE_FLAGS_REPRESENTATION    PROC
        DISPLAY_FLAG_VALUE  78, 23, PLAYER_1_C_FLAG_VALUE, BLUE
        DISPLAY_FLAG_VALUE  78, 25, PLAYER_1_Z_FLAG_VALUE, BLUE
        DISPLAY_FLAG_VALUE  94, 23, PLAYER_1_S_FLAG_VALUE, BLUE
        DISPLAY_FLAG_VALUE  94, 25, PLAYER_1_O_FLAG_VALUE, BLUE
        RET
ENDP    PLAYER_1_UPDATE_FLAGS_REPRESENTATION
;===================================================================
DRAW_PLAYER_1 PROC
        ; Draw Power Ups
        DRAW_BOX 407, 500, 325, 45, BLACK

        ; Draw Command Box
        DRAW_BOX 407, 450, 325, 45, BLACK
        PRINT_STRING 53, 29, NAME_1, GREEN
        MOV PLAYER_1_CMD_X_LOCATION, 54
        MOV BL, NAME_1 - 1
        ADD PLAYER_1_CMD_X_LOCATION, BL


        ; Draw Register box
        DRAW_BOX 407, 90, 60, 340, BLACK

        ; Draw Memory and Flags box 1
        DRAW_BOX 540, 90, 60, 340, BLACK

        ; Draw Memory and Flags box 2
        DRAW_BOX 670, 90, 60, 340, BLACK

        MOV CX,8
        MOV BP,160
        MOV SI,0

        PLAYER_1_LINES:
                        MOV AX,3
                        PLAYER_1_THICKNESS_H:
                                                DRAW_LINE_H 407, BP, 320, LIGHT_WHITE
                                                INC BP
                                                DEC AX
                                                JNZ PLAYER_1_THICKNESS_H
                        ADD BP,30
                        LOOP PLAYER_1_LINES

        MOV CX,3
        MOV BP,460
        ; Draw the white borders of register box
        PLAYER_1_THICKNESS_V_1_0:
                                DRAW_LINE_V BP, 90, 340, LIGHT_WHITE
                                INC BP
                                LOOP PLAYER_1_THICKNESS_V_1_0


        MOV CX,3
        MOV BP,590
        ; Draw the white borders of memory box1 - Part I
        PLAYER_1_THICKNESS_V_1_1:
                                DRAW_LINE_V BP, 90, 340, LIGHT_WHITE
                                INC BP
                                LOOP PLAYER_1_THICKNESS_V_1_1

        MOV CX,3
        MOV BP,720
        ; Draw the white borders of memory box1 - Part II
        PLAYER_1_THICKNESS_V_1_2:
                                DRAW_LINE_V BP, 90, 340, LIGHT_WHITE
                                INC BP
                                LOOP PLAYER_1_THICKNESS_V_1_2

        ; Draw score box
        DRAW_LINE_H 407, 135, 320, LIGHT_WHITE
        DRAW_LINE_H 407, 136, 320, LIGHT_WHITE
        DRAW_LINE_H 407, 137, 320, LIGHT_WHITE

        DRAW_LINE_H 407, 87, 60, RED
        DRAW_LINE_H 407, 88, 60, RED
        DRAW_LINE_H 407, 89, 60, RED

        DRAW_LINE_H 407, 132, 60, RED
        DRAW_LINE_H 407, 133, 60, RED
        DRAW_LINE_H 407, 134, 60, RED

        DRAW_LINE_V 405, 87, 48, RED
        DRAW_LINE_V 406, 87, 48, RED
        DRAW_LINE_V 407, 87, 48, RED

        DRAW_LINE_V 527, 87, 48, RED
        DRAW_LINE_V 528, 87, 48, RED
        DRAW_LINE_V 529, 87, 48, RED

        ; Print the registers labels
        PRINT_STRING 52, 7, PLAYER_1_SCORE_LABEL, GREEN
        PRINT_STRING 53, 9, PLAYER_1_AX_REG_LABEL, GREEN
        PRINT_STRING 53, 11, PLAYER_1_BX_REG_LABEL, GREEN
        PRINT_STRING 53, 13, PLAYER_1_CX_REG_LABEL, GREEN
        PRINT_STRING 53, 15, PLAYER_1_DX_REG_LABEL, GREEN
        PRINT_STRING 53, 17, PLAYER_1_DI_REG_LABEL, GREEN
        PRINT_STRING 53, 19, PLAYER_1_SI_REG_LABEL, GREEN
        PRINT_STRING 53, 21, PLAYER_1_BP_REG_LABEL, GREEN
        PRINT_STRING 53, 23, PLAYER_1_SP_REG_LABEL, GREEN
        PRINT_STRING 52, 25, PLAYER_1_TIMER_LABEL, GREEN

        ; Print Memory labels - Part I
        PRINT_STRING 69, 7, PLAYER_1_MEM_0_LABEL, GREEN
        PRINT_STRING 69, 9, PLAYER_1_MEM_1_LABEL, GREEN
        PRINT_STRING 69, 11, PLAYER_1_MEM_2_LABEL, GREEN
        PRINT_STRING 69, 13, PLAYER_1_MEM_3_LABEL, GREEN
        PRINT_STRING 69, 15, PLAYER_1_MEM_4_LABEL, GREEN
        PRINT_STRING 69, 17, PLAYER_1_MEM_5_LABEL, GREEN
        PRINT_STRING 69, 19, PLAYER_1_MEM_6_LABEL, GREEN
        PRINT_STRING 69, 21, PLAYER_1_MEM_7_LABEL, GREEN
        PRINT_STRING 69, 23, PLAYER_1_C_FLAG_LABEL, BLUE
        PRINT_STRING 69, 25, PLAYER_1_Z_FLAG_LABEL, BLUE

        ; Print Memory labels - Part II
        PRINT_STRING 85, 7, PLAYER_1_MEM_8_LABEL, GREEN
        PRINT_STRING 85, 9, PLAYER_1_MEM_9_LABEL, GREEN
        PRINT_STRING 85, 11, PLAYER_1_MEM_A_LABEL, GREEN
        PRINT_STRING 85, 13, PLAYER_1_MEM_B_LABEL, GREEN
        PRINT_STRING 85, 15, PLAYER_1_MEM_C_LABEL, GREEN
        PRINT_STRING 85, 17, PLAYER_1_MEM_D_LABEL, GREEN
        PRINT_STRING 85, 19, PLAYER_1_MEM_E_LABEL, GREEN
        PRINT_STRING 85, 21, PLAYER_1_MEM_F_LABEL, GREEN
        PRINT_STRING 85, 23, PLAYER_1_S_FLAG_LABEL, BLUE
        PRINT_STRING 85, 25, PLAYER_1_O_FLAG_LABEL, BLUE
        
        CALL PLAYER_1_UPDATE_REGISTERS_REPRESENTATION
        CALL PLAYER_1_UPDATE_MEMORY_REPRESENTATION
        CALL PLAYER_1_UPDATE_FLAGS_REPRESENTATION
        
        RET
ENDP    DRAW_PLAYER_1
;===================================================================
PLAYER_2_UPDATE_REGISTERS_REPRESENTATION    PROC
        PRINT_4_DIGIT_GRAPHICS  10, 7, PLAYER_2_SCORE_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  10, 9, PLAYER_2_AX_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  10, 11, PLAYER_2_BX_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  10, 13, PLAYER_2_CX_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  10, 15, PLAYER_2_DX_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  10, 17, PLAYER_2_DI_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  10, 19, PLAYER_2_SI_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  10, 21, PLAYER_2_BP_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  10, 23, PLAYER_2_SP_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  10, 25, PLAYER_2_TIMER_VALUE, LIGHT_WHITE
        RET
ENDP    PLAYER_2_UPDATE_REGISTERS_REPRESENTATION
;===================================================================
PLAYER_2_UPDATE_MEMORY_REPRESENTATION    PROC
        ;PRINT_4_DIGIT_GRAPHICS  27, 7, PLAYER_2_MEM_0_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  27, 9, PLAYER_2_MEM_1_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  27, 11, PLAYER_2_MEM_2_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  27, 13, PLAYER_2_MEM_3_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  27, 15, PLAYER_2_MEM_4_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  27, 17, PLAYER_2_MEM_5_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  27, 19, PLAYER_2_MEM_6_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  27, 21, PLAYER_2_MEM_7_VALUE, LIGHT_WHITE

        ;PRINT_4_DIGIT_GRAPHICS  43, 7, PLAYER_2_MEM_8_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  43, 9, PLAYER_2_MEM_9_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  43, 11, PLAYER_2_MEM_A_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  43, 13, PLAYER_2_MEM_B_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  43, 15, PLAYER_2_MEM_C_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  43, 17, PLAYER_2_MEM_D_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  43, 19, PLAYER_2_MEM_E_VALUE, LIGHT_WHITE
        ;PRINT_4_DIGIT_GRAPHICS  43, 21, PLAYER_2_MEM_F_VALUE, LIGHT_WHITE
        RET
ENDP    PLAYER_2_UPDATE_MEMORY_REPRESENTATION
;===================================================================
PLAYER_2_UPDATE_FLAGS_REPRESENTATION    PROC
        DISPLAY_FLAG_VALUE  28, 23, PLAYER_2_C_FLAG_VALUE, BLUE
        DISPLAY_FLAG_VALUE  28, 25, PLAYER_2_Z_FLAG_VALUE, BLUE
        DISPLAY_FLAG_VALUE  44, 23, PLAYER_2_S_FLAG_VALUE, BLUE
        DISPLAY_FLAG_VALUE  44, 25, PLAYER_2_O_FLAG_VALUE, BLUE
        RET
ENDP    PLAYER_2_UPDATE_FLAGS_REPRESENTATION
;===================================================================
DRAW_PLAYER_2 PROC
        ; Draw Power Ups
        DRAW_BOX 10, 500, 325, 45, BLACK

        ; Draw Command Box
        DRAW_BOX 10, 450, 325, 45, BLACK
        PRINT_STRING 4, 29, NAME_2, GREEN
        MOV PLAYER_2_CMD_X_LOCATION, 5
        MOV BL, NAME_1 - 1
        ADD PLAYER_2_CMD_X_LOCATION, BL

        ; Draw Register box
        DRAW_BOX 10, 90, 60, 340, BLACK

        ; Draw Memory and Flags box 1
        DRAW_BOX 143, 90, 60, 340, BLACK

        ; Draw Memory and Flags box 2
        DRAW_BOX 273, 90, 60, 340, BLACK

        MOV CX,8
        MOV BP,160
        MOV SI,0

        PLAYER_2_LINES:
                        MOV AX,3
                        PLAYER_2_THICKNESS_H:
                                                DRAW_LINE_H 10, BP, 320, LIGHT_WHITE
                                                INC BP
                                                DEC AX
                                                JNZ PLAYER_2_THICKNESS_H
                        ADD BP,30
                        LOOP PLAYER_2_LINES

        MOV CX,3
        MOV BP,63
        ; Draw the white borders of register box
        PLAYER_2_THICKNESS_V_1_0:
                                DRAW_LINE_V BP, 90, 340, LIGHT_WHITE
                                INC BP
                                LOOP PLAYER_2_THICKNESS_V_1_0


        MOV CX,3
        MOV BP,193
        ; Draw the white borders of memory box1 - Part I
        PLAYER_2_THICKNESS_V_1_1:
                                DRAW_LINE_V BP, 90, 340, LIGHT_WHITE
                                INC BP
                                LOOP PLAYER_2_THICKNESS_V_1_1

        MOV CX,3
        MOV BP,323
        ; Draw the white borders of memory box1 - Part II
        PLAYER_2_THICKNESS_V_1_2:
                                DRAW_LINE_V BP, 90, 340, LIGHT_WHITE
                                INC BP
                                LOOP PLAYER_2_THICKNESS_V_1_2

        ; Draw score box
        DRAW_LINE_H 10, 135, 320, LIGHT_WHITE
        DRAW_LINE_H 10, 136, 320, LIGHT_WHITE
        DRAW_LINE_H 10, 137, 320, LIGHT_WHITE

        DRAW_LINE_H 10, 87, 60, RED
        DRAW_LINE_H 10, 88, 60, RED
        DRAW_LINE_H 10, 89, 60, RED

        DRAW_LINE_H 10, 132, 60, RED
        DRAW_LINE_H 10, 133, 60, RED
        DRAW_LINE_H 10, 134, 60, RED

        DRAW_LINE_V 8, 87, 48, RED
        DRAW_LINE_V 9, 87, 48, RED
        DRAW_LINE_V 10, 87, 48, RED

        DRAW_LINE_V 130, 87, 48, RED
        DRAW_LINE_V 131, 87, 48, RED
        DRAW_LINE_V 132, 87, 48, RED

        ; Print the registers labels
        PRINT_STRING 2, 7, PLAYER_2_SCORE_LABEL, GREEN
        PRINT_STRING 3, 9, PLAYER_2_AX_REG_LABEL, GREEN
        PRINT_STRING 3, 11, PLAYER_2_BX_REG_LABEL, GREEN
        PRINT_STRING 3, 13, PLAYER_2_CX_REG_LABEL, GREEN
        PRINT_STRING 3, 15, PLAYER_2_DX_REG_LABEL, GREEN
        PRINT_STRING 3, 17, PLAYER_2_DI_REG_LABEL, GREEN
        PRINT_STRING 3, 19, PLAYER_2_SI_REG_LABEL, GREEN
        PRINT_STRING 3, 21, PLAYER_2_BP_REG_LABEL, GREEN
        PRINT_STRING 3, 23, PLAYER_2_SP_REG_LABEL, GREEN
        PRINT_STRING 2, 25, PLAYER_2_TIMER_LABEL, GREEN

        ; Print Memory labels - Part I
        PRINT_STRING 20, 7, PLAYER_2_MEM_0_LABEL, GREEN
        PRINT_STRING 20, 9, PLAYER_2_MEM_1_LABEL, GREEN
        PRINT_STRING 20, 11, PLAYER_2_MEM_2_LABEL, GREEN
        PRINT_STRING 20, 13, PLAYER_2_MEM_3_LABEL, GREEN
        PRINT_STRING 20, 15, PLAYER_2_MEM_4_LABEL, GREEN
        PRINT_STRING 20, 17, PLAYER_2_MEM_5_LABEL, GREEN
        PRINT_STRING 20, 19, PLAYER_2_MEM_6_LABEL, GREEN
        PRINT_STRING 20, 21, PLAYER_2_MEM_7_LABEL, GREEN
        PRINT_STRING 20, 23, PLAYER_2_C_FLAG_LABEL, BLUE
        PRINT_STRING 20, 25, PLAYER_2_Z_FLAG_LABEL, BLUE

        ; Print Memory labels - Part II
        PRINT_STRING 36, 7, PLAYER_2_MEM_8_LABEL, GREEN
        PRINT_STRING 36, 9, PLAYER_2_MEM_9_LABEL, GREEN
        PRINT_STRING 36, 11, PLAYER_2_MEM_A_LABEL, GREEN
        PRINT_STRING 36, 13, PLAYER_2_MEM_B_LABEL, GREEN
        PRINT_STRING 36, 15, PLAYER_2_MEM_C_LABEL, GREEN
        PRINT_STRING 36, 17, PLAYER_2_MEM_D_LABEL, GREEN
        PRINT_STRING 36, 19, PLAYER_2_MEM_E_LABEL, GREEN
        PRINT_STRING 36, 21, PLAYER_2_MEM_F_LABEL, GREEN
        PRINT_STRING 36, 23, PLAYER_2_S_FLAG_LABEL, BLUE
        PRINT_STRING 36, 25, PLAYER_2_O_FLAG_LABEL, BLUE
        
        CALL PLAYER_2_UPDATE_REGISTERS_REPRESENTATION
        CALL PLAYER_2_UPDATE_MEMORY_REPRESENTATION
        CALL PLAYER_2_UPDATE_FLAGS_REPRESENTATION
        
        RET
ENDP    DRAW_PLAYER_2

EXECUTE_FIRST_POWER_UP PROC NEAR
    TEST POWER_UP_SELECTED_FLAG, 1
    JZ @@EXECUTE
    RET
    @@EXECUTE:
    PUSH AX
    MOV AX, 5
    CALL DESCREASE_CURRENT_PLAYER_SCORE
    MOV POWER_UP_SELECTED_FLAG, 1   
    MOV AL, CURR_PLAYER_FLAG
    TEST AL, 1
    JNZ @@PLAYER_PROCESSOR
    MOV CURR_PROCESSOR_FLAG,00010000B
    JMP @@EXIT
    @@PLAYER_PROCESSOR: 
    MOV CURR_PROCESSOR_FLAG, 00000001B
    @@EXIT:
    POP AX
    RET
EXECUTE_FIRST_POWER_UP ENDP

EXECUTE_SECOND_POWER_UP PROC NEAR
    TEST POWER_UP_SELECTED_FLAG, 1
    JZ @@EXECUTE
    RET
    @@EXECUTE:
    PUSH AX
    MOV AX, 3
    CALL DESCREASE_CURRENT_PLAYER_SCORE
    MOV POWER_UP_SELECTED_FLAG, 1   
    MOV CURR_PROCESSOR_FLAG,00010001B
    POP AX
    RET
EXECUTE_SECOND_POWER_UP ENDP



EXECUTE_CURRENT_COMMAND PROC NEAR
    ;Clear CMD buffer
    MOV BH, 0
    MOV BL, CMD_BUFF[1]
    MOV CMD_MSG[BX], '$'
    MOV CMD_BUFF[1], 0

    ;RESET PLAYER CURSOR LOCATION
    TEST CURR_PLAYER_FLAG, 1 ;ZF = 1 if Player 1
    JNZ @@PLAYER2_CMD_LOC
    MOV PLAYER_1_CMD_X_LOCATION, 54
    MOV BL, NAME_1 - 1
    ADD PLAYER_1_CMD_X_LOCATION, BL 
    JMP @@PLAYER1_CMD_LOC
    @@PLAYER2_CMD_LOC:
    MOV PLAYER_2_CMD_X_LOCATION, 5
    MOV BL, NAME_2 - 1
    ADD PLAYER_2_CMD_X_LOCATION, BL
    @@PLAYER1_CMD_LOC:
       
    MOV FORBIDDEN_CHAR_ERROR_FLAG, 0
    CALL CHECK_FORBIDDEN_CHARACTER
    TEST FORBIDDEN_CHAR_ERROR_FLAG, 1
    JNZ @@SKIP_EXEC

    ;Set player to parse
    TEST CURR_PROCESSOR_FLAG, 00000001B ;ZF = 1 if Player 1
    JZ @@CHECK_SECOND_PROCESSOR
    MOV AX, OFFSET P2_DATA
    MOV P_DATA, AX

    ;Call Parser_P subprogram
    CALL PARSER
    
    TEST PARSE_ERROR_FLAG, 1
    JNZ @@PARSER_ERROR
    ;Call Cmds subprogram
    CALL EXEC_CMD

    @@CHECK_SECOND_PROCESSOR:
    ;Set player to parse
    TEST CURR_PROCESSOR_FLAG, 00010000B ;ZF = 1 if Player 2
    JZ @@SKIP_EXEC
    MOV AX, OFFSET P1_DATA
    MOV P_DATA, AX

    ;Call Parser_P subprogram
    CALL PARSER
    
    TEST PARSE_ERROR_FLAG, 1
    JNZ @@PARSER_ERROR
    ;Call Cmds subprogram
    CALL EXEC_CMD

    JMP @@SKIP_EXEC

    @@PARSER_ERROR:
    MOV AX, 1
    CALL DESCREASE_CURRENT_PLAYER_SCORE
    @@SKIP_EXEC:
    CALL GET_CURR_PLAYER_CMD_X_LOCATION

    MOV CX, 30
    MOV BH, 0
    
    MOVE_CURSOR [SI], 29
    MOV AH, 0EH
    MOV AL, 32
    MOV BL, 0FH
    @@CLEAR_CMD_BOX:
    INT 10H
    LOOP @@CLEAR_CMD_BOX
    MOV POWER_UP_SELECTED_FLAG, 0
    XOR CURR_PLAYER_FLAG, 1
    MOV AL, CURR_PLAYER_FLAG
    TEST AL, 1
    JNZ @@PLAYER_PROCESSOR
    MOV CURR_PROCESSOR_FLAG,00000001B
    RET
    @@PLAYER_PROCESSOR: 
    MOV CURR_PROCESSOR_FLAG, 00010000B
    RET
EXECUTE_CURRENT_COMMAND ENDP
; Subtract ax value from current player score
; Should check for score reaching zero
DESCREASE_CURRENT_PLAYER_SCORE PROC NEAR
    TEST CURR_PLAYER_FLAG, 1 ;ZF = 1 if Player 1
    JNZ @@PLAYER2
    SUB PLAYER_1_SCORE_VALUE ,AX
    JMP @@EXIT
    @@PLAYER2:
    SUB PLAYER_2_SCORE_VALUE ,AX
    @@EXIT:
    RET
DESCREASE_CURRENT_PLAYER_SCORE ENDP
;==========================================
;       Get current player's cmd box
;       X location and store it in SI
;==========================================
GET_CURR_PLAYER_CMD_X_LOCATION PROC NEAR
    TEST CURR_PLAYER_FLAG, 1 ;ZF = 1 if Player 1
    JNZ @@PLAYER2
    MOV SI, OFFSET PLAYER_1_CMD_X_LOCATION
    JMP @@PLAYER1
    @@PLAYER2:
    MOV SI, OFFSET PLAYER_2_CMD_X_LOCATION
    @@PLAYER1:
    RET
ENDP GET_CURR_PLAYER_CMD_X_LOCATION

CHECK_FORBIDDEN_CHARACTER PROC NEAR
    PUSH SI
    PUSH CX
    TOUPPER CMD_MSG , CMD_BUFF_SIZE
    MOV SI, OFFSET CMD_MSG
    
    ;CHECK WHICH PLAYER 
    TEST CURR_PLAYER_FLAG, 1 ;ZF = 1 if Player 1
    JNZ @@PLAYER2
    MOV CH, P1_FORBIDDEN_CHARATER
    JMP @@CONTINUE
    @@PLAYER2:
    MOV CH, P2_FORBIDDEN_CHARATER
    @@CONTINUE:

    @@CHECK_CHAR:
    CMP BYTE PTR[SI], '$'
    JE @@EXIT
    CMP [SI], CH
    JE @@FORBIDDEN_FOUND 
    INC SI 
    JMP @@CHECK_CHAR

    @@FORBIDDEN_FOUND:
    MOV FORBIDDEN_CHAR_ERROR_FLAG,1
    @@EXIT:
    POP CX
    POP SI
    RET
CHECK_FORBIDDEN_CHARACTER ENDP 

WRITE_CMD PROC NEAR
    ;CMP CMD_BUFF[1], CMD_BUFF_SIZE   
    CMP AL, 13
    JNE @@NOT_ENTER
    ; CHECK IF CONTAINING THE FORBIDDEN CHARACTER

    CALL EXECUTE_CURRENT_COMMAND
    RET
    @@NOT_ENTER:
    
    MOV BH, 0
    MOV BL, CMD_BUFF[1]
    MOV CMD_MSG[BX], AL
    INC CMD_BUFF[1]
    
    CALL GET_CURR_PLAYER_CMD_X_LOCATION
    ;Curr PLayer's X location is now in SI

    MOV AH, 02H
    MOV BH, 0
    MOV DL, [SI]
    MOV DH, 29
    INT 10H

    MOV AH, 0EH
    MOV BH, 0
    MOV BL, 0FH
    INT 10H
    INC [SI]
    RET
ENDP WRITE_CMD

HANDLE_BUFFER PROC NEAR
    CMP AH, 75
    JB @@NOT_ARROW
    CMP AH, 80
    JAE @@NOT_ARROW
    ;CALL BIRD MOVE
    RET
    @@NOT_ARROW:
    ;Check if power up key
    @@FIRST_POWER_UP:
    CMP AH, 59 ; F1 SCAN Code
    JNE @@SECOND_POWER_UP
    CALL EXECUTE_FIRST_POWER_UP 
    RET
    @@SECOND_POWER_UP:
    CMP AH, 60 ; F2 SCAN Code
    JNE @@THIRD_POWER_UP
    CALL EXECUTE_SECOND_POWER_UP 
    RET
    @@THIRD_POWER_UP:
    CMP AH, 61 ; F3 SCAN Code
    JNE @@FORTH_POWER_UP
    ; Call Third Power Up 
    RET
    @@FORTH_POWER_UP:
    CMP AH, 62 ; F4 SCAN Code
    JNE @@WRITE_BUFFER_CMD
    ; Call Forth Power Up
    RET
    @@WRITE_BUFFER_CMD: 
    CALL WRITE_CMD
    RET
HANDLE_BUFFER ENDP

CONVERT_WORD_TO_STRING PROC NEAR
        PUSH DX
        PUSH CX
        PUSH DI

        LEA DI,STR_TEMP
        ADD DI,3

        MOV CX,4
        @@REPEAT:
        MOV DL, 0FH
        AND DL, AL
        CMP DL, 10
        JB @@IS_DIGIT
        ADD DL, 55
        JMP @@ADD_TO_STR
        @@IS_DIGIT:
        ADD DL, '0'
        @@ADD_TO_STR:
        MOV [DI], DL
        DEC DI
        SHR AX, 4
        LOOP @@REPEAT
        POP DI
        POP CX
        POP DX
        RET
CONVERT_WORD_TO_STRING ENDP

SET_INITIAL_SCORE PROC NEAR
    MOV AX, P1_INITIAL_POINTS
    CMP P2_INITIAL_POINTS, AX
    JB @@TAKE_P2_POINTS
    MOV PLAYER_1_SCORE_VALUE,AX
    MOV PLAYER_2_SCORE_VALUE,AX
    RET
    @@TAKE_P2_POINTS:
    MOV AX,P2_INITIAL_POINTS
    MOV PLAYER_1_SCORE_VALUE,AX
    MOV PLAYER_2_SCORE_VALUE,AX
    RET
SET_INITIAL_SCORE ENDP

MAIN PROC FAR
    ;Initialize Data Segment
    MOV AX, @DATA
    MOV DS, AX
    ;End initialize

    ;RUN_STRT_SCREEN P1_USERNAME_BUFF, P1_INITIAL_POINTS
    ;RUN_STRT_SCREEN P2_USERNAME_BUFF, P2_INITIAL_POINTS
    call SET_INITIAL_SCORE

    ;SET GRAPHCIS MODE [800x600 - 256 Colors] ~~ [600V x 736H - 256 Colors]
    MOV AX, 4F02H
    MOV BX, 103H
    INT 10H
    ;==================
    ; Draw Screen borders
    DRAW_BACKGROUND LIGHT_WHITE
    DRAW_LINE_V 400, 0, 550, RED
    DRAW_LINE_H 0, 550, 736, RED
    ;==================
    CALL DRAW_PLAYER_1
    CALL DRAW_PLAYER_2
    ;==================
    ;Chat Box
    PRINT_STRING 1,35, NAME_1, RED
    PRINT_STRING 7,35, MESSAGE_1, LIGHT_WHITE

    PRINT_STRING 1,36, NAME_2, RED
    PRINT_STRING 8,36, MESSAGE_2, LIGHT_WHITE
    ;==================
    MOV BP, 0
    UPDATE_TIMER:
    ;Check buffer
    MOV AH, 1
    INT 16h
    JZ SKIP_HANDLE 
    CALL HANDLE_BUFFER
    CONSUMEBUFFER
    SKIP_HANDLE:
    

    MOV DX,BP
    AND DX,0080H
    SHR DX,7
    MOV PLAYER_1_Z_FLAG_VALUE, DL
    MOV PLAYER_1_TIMER_VALUE, BP
    MOV PLAYER_2_Z_FLAG_VALUE, DL
    MOV PLAYER_2_TIMER_VALUE, BP
    CALL PLAYER_1_UPDATE_REGISTERS_REPRESENTATION
    CALL PLAYER_1_UPDATE_FLAGS_REPRESENTATION
    CALL PLAYER_2_UPDATE_REGISTERS_REPRESENTATION
    CALL PLAYER_2_UPDATE_FLAGS_REPRESENTATION

    INC BP


    ;TIMER DELAY 
    ;MOV CX,0FFFFH
    ;DELAY:
    ;LOOP DELAY
    ;CMP BP,0FFFFH
    JMP UPDATE_TIMER    
    ;Safely return to OS
    MOV AX, 4C00H
    INT 21H
MAIN ENDP
END MAIN
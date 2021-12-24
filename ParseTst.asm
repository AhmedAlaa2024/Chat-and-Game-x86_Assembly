;------------------------
;      PARSER      
;------------------------
EXTRN PARSER:FAR
PUBLIC CMD_MSG, OP1_PROPERTY, OP1_LOCATION, OP2_PROPERTY, OP2_LOCATION, P1_DATA, P1_MEM, P2_DATA, P2_MEM


.MODEL SMALL
.STACK 64
.DATA
;========================
;        Parser Data    
;========================
OP1_PROPERTY DB 0
OP1_LOCATION DW 0
OP2_PROPERTY DB 0
OP2_LOCATION DW 0
include p_data.inc

;==================================
CMD_BUFF DB 30, ?
CMD_MSG DB 31 dup('$')

include char.inc

.CODE
DISPLAY_NEWLINE MACRO
    MOV AH, 02H
    
    MOV DL, 13D ;CARIAGE RETURN
    INT 21H

    MOV DL, 10D ;LINEFEED
    INT 21H
ENDM DISPLAY_NEWLINE
;include Parser.inc
MAIN PROC FAR
    ;Initialize Data Segment
    MOV AX, @DATA
    MOV DS, AX
    ;End initialize

    LOOP_INF:
    MOV DX, OFFSET CMD_BUFF
    MOV AH, 0AH
    INT 21H
    MOV BL, CMD_BUFF[1]
    MOV BH, 0
    MOV CMD_MSG[BX], '$'
    DISPLAY_NEWLINE 

    CALL PARSER
    DISPLAY_NEWLINE
    JMP LOOP_INF
    ;===========================
    ;       Test SplitString
    ;===========================
    ;SPLIT_STRING TestString, TestRes
    ;TOUPPER TestRes, 17


    ;===========================
    ;       Test PARSE_CMD
    ;===========================
    ;PARSE_CMD TestRes, CMD_ARR, CMD_ARR_SIZE, CMD_FLAG

    ;GET_CMD_OPERANDS CMD_OPERANDS_ARR, CMD_FLAG, OP_FLAGS
    
    ;PARSE_OPERANDS P1_DATA, TestRes, OP_FLAGS

    ;Safely return to OS
    MOV AX, 4C00H
    INT 21H
MAIN ENDP
END MAIN
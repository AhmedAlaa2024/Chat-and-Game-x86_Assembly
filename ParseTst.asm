;------------------------
;      PARSER      
;------------------------
PUBLIC P_DATA, CMD_MSG, CMD_FLAG, OP_FLAGS, OP1_PROPERTY, OP1_LOCATION, OP2_PROPERTY, OP2_LOCATION, P1_DATA, P1_MEM, P2_DATA, P2_MEM
EXTRN PARSER:FAR
EXTRN EXEC_CMD:FAR
EXTRN FLAGS_LOCATION:WORD


.MODEL SMALL
.STACK 64
.DATA
;========================
;        Parser Data    
;========================
P_DATA DW ?

CMD_FLAG  DB 0
OP_FLAGS  DB 0

OP1_PROPERTY DB 0
OP1_LOCATION DW 0
OP2_PROPERTY DB 0
OP2_LOCATION DW 0

;========================
;        Player Data    
;========================
include p_data.inc

;========================
;        Test Data    
;========================
CMD_BUFF DB 30, ?
CMD_MSG DB 31 dup('$')

.CODE
DISPLAY_NEWLINE MACRO
    MOV AH, 02H
    
    MOV DL, 13D ;CARIAGE RETURN
    INT 21H

    MOV DL, 10D ;LINEFEED
    INT 21H
ENDM DISPLAY_NEWLINE

MAIN PROC FAR
    ;Initialize Data Segment
    MOV AX, @DATA
    MOV DS, AX
    ;End initialize
    MOV AX, OFFSET P2_DATA
    MOV P_DATA, AX

    LOOP_INF:
    MOV DX, OFFSET CMD_BUFF
    MOV AH, 0AH
    INT 21H
    MOV BL, CMD_BUFF[1]
    MOV BH, 0
    MOV CMD_MSG[BX], '$'
    DISPLAY_NEWLINE 

    ;Call Parser_P subprogram
    CALL PARSER
 
    ;Call Cmds subprogram
    CALL EXEC_CMD

    DISPLAY_NEWLINE
    JMP LOOP_INF

    ;Safely return to OS
    MOV AX, 4C00H
    INT 21H
MAIN ENDP
END MAIN
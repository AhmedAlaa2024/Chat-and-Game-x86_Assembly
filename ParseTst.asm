.MODEL SMALL
.STACK 64
.DATA

TestString DB '  IMUL Ax,   F5a$   '
TestRes    DB 17 dup (?)

include data.inc

include char.inc



.CODE
include Parser.inc
MAIN PROC FAR
    ;Initialize Data Segment
    MOV AX, @DATA
    MOV DS, AX
    ;End initialize

    ;===========================
    ;       Test SplitString
    ;===========================
    SPLIT_STRING TestString, TestRes
    TOUPPER TestRes, 17


    ;===========================
    ;       Test PARSE_CMD
    ;===========================
    PARSE_CMD TestRes, CMD_ARR, CMD_ARR_SIZE, CMD_FLAG

    GET_CMD_OPERANDS CMD_OPERANDS_ARR, CMD_FLAG, OP_FLAGS
    

    ;Safely return to OS
    MOV AX, 4C00H
    INT 21H
MAIN ENDP
END MAIN
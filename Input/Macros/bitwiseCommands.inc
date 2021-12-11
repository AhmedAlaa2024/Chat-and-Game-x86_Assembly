;===========================================================================================
; Function: BITWISE_OPERATION_CLASSIFY                                                      |
; TESTED:   FALSE                                                                           |
; Input: <String:MSG> = The Command                                                         |
; Output: <WORD:OP_FLAG> = The flag which carry the command's id or 0xFF for NONE		    |
; Description: Determine which operation is mentioned in the command. Then assign number to |
;			   the OP_FLAG. This number is the order of operation in the project document.	|
;===========================================================================================
BITWISE_OPERATION_CLASSIFY  MACRO MSG,OP_FLAG
 LOCAL SHL_MATCH,SHR_MATCH,SAR_MATCH,ROR_MATCH,RCR_MATCH,ROL_MATCH

    PUSH SI
	PUSH DI
	PUSH CX
   
    MOV OP_FLAG,0FFH ; SET Default that there is no matched operation. (TO AN UNUSED LOCATION)

;=============================================
;  [SHR - SHL - SAR - ROR - RCL - RCR - ROL]  |
;=============================================

    LEA SI,SHR_STR
	LEA DI,MSG
	MOV CX,4

    REPE CMPSB
	JZ SHR_MATCH
    ;
    LEA SI,SHL_STR
	LEA DI,MSG
	MOV CX,4

    REPE CMPSB
	JZ SHL_MATCH
    ;
    LEA SI,SAR_STR
	LEA DI,MSG
	MOV CX,4

    REPE CMPSB
	JZ SAR_MATCH
    ;
    LEA SI,ROR_STR
	LEA DI,MSG
	MOV CX,4

    REPE CMPSB
	JZ ROR_MATCH
    ;
    LEA SI,ROL_STR
	LEA DI,MSG
	MOV CX,4

    REPE CMPSB
	JZ ROL_MATCH
    ;
    LEA SI,RCR_STR
	LEA DI,MSG
	MOV CX,4

    REPE CMPSB
	JZ RCL_MATCH
    ;
    LEA SI,RCR_STR
	LEA DI,MSG
	MOV CX,4

    REPE CMPSB
	JZ RCR_MATCH
    ;
    JMP RETURN

    SHR_MATCH:
                MOV OP_FLAG,13
                JMP RETURN
    SHL_MATCH:
                MOV OP_FLAG,14
                JMP RETURN
    SAR_MATCH:
                MOV OP_FLAG,15
                JMP RETURN
    ROR_MATCH:
                MOV OP_FLAG,16
                JMP RETURN                
    RCL_MATCH:
                MOV OP_FLAG,17
                JMP RETURN    
    RCR_MATCH:
                MOV OP_FLAG,18
                JMP RETURN     
    ROL_MATCH:
                MOV OP_FLAG,19
                JMP RETURN     
    RETURN:

    PUSH CX
	PUSH DI
	PUSH SI
ENDM BITWISE_OPERATION_CLASSIFY   
;MAIN MACRO HERE
; OPERATE MACRO MSG
; PUSH AX
;     DETECT_SRC MSG,AL
;     DETECT_DEST MSG,AH
;     CMP AX,0
;     DETECT_OPERATION MSG AX,AX ; NOT EXACTLY AX BUT THE LOACTION OF THE P1 AX
; POP AX    
; ENDM OPERATE

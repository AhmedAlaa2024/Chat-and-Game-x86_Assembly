;===========================================================================================
; Function: ARITHMETIC_OPERATION_PREPROCESSING                                              |
; TESTED:   FALSE                                                                           |
; Input: <String:MSG> = The Command                                                         |
; Output: <int:OP_CODE> = The code of the operation mentioned in the command,               |
;         <address:SRC> = The address of the source,                                        |
;         <address:DES> = The address of the destination.                                   |
; Description:                                                                              |
;               1. Classify the command, and assign the OP_CODE                             |
;               2. Determine the source, and destination, then assign them to SRC, DES.     |
;===========================================================================================
ARITHMETIC_OPERATION_PREPROCESSING MACRO MSG, OP_CODE, SRC, DES
	_OPERATION_CLASSIFY MSG, OP_CODE
ARITHMETIC_OPERATION_PREPROCESSING ENDM

;===========================================================================================
; Function: _OPERATION_CLASSIFY                                                             |
; TESTED:   TRUE                                                                            |
; Input: <String:MSG> = The Command                                                         |
; Output: <boolean:OP_FLAG> = The flag which carry the command's id or 0xFF for NONE		|
; Description: Determine which operation is mentioned in the command. Then assign number to |
;			   the OP_FLAG. This number is the order of operation in the project document.	|
;===========================================================================================
_OPERATION_CLASSIFY MACRO MSG, OP_FLAG
    LOCAL ADD_MATCH, ADC_MATCH, SUB_MATCH, SBB_MATCH, XOR_MATCH, AND_MATCH, OR_MATCH, RETURN
    
    PUSH SI
	PUSH DI
	PUSH CX

	MOV OP_FLAG,0FFH ; SET Default that there is no matched operation.

	LEA SI,ADD_STR
	LEA DI,MSG
	MOV CX,4

	REPE CMPSB
	JZ ADD_MATCH
	
	LEA SI,ADC_STR
	LEA DI,MSG
	MOV CX,4

	REPE CMPSB
	JZ ADC_MATCH

	LEA SI,SUB_STR
	LEA DI,MSG
	MOV CX,4

	REPE CMPSB
	JZ SUB_MATCH

	LEA SI,SBB_STR
	LEA DI,MSG
	MOV CX,4

	REPE CMPSB
	JZ SBB_MATCH

	LEA SI,XOR_STR
	LEA DI,MSG
	MOV CX,4

	REPE CMPSB
	JZ XOR_MATCH

	LEA SI,AND_STR
	LEA DI,MSG
	MOV CX,4

	REPE CMPSB
	JZ AND_MATCH

	LEA SI,OR_STR
	LEA DI,MSG
	MOV CX,3

	REPE CMPSB
	JZ OR_MATCH

	JMP RETURN

	ADD_MATCH:
				MOV OP_FLAG,0
				JMP RETURN

	ADC_MATCH:
				MOV OP_FLAG,1
				JMP RETURN

	SUB_MATCH:
				MOV OP_FLAG,2
				JMP RETURN

	SBB_MATCH:
				MOV OP_FLAG,3
				JMP RETURN

	XOR_MATCH:
				MOV OP_FLAG,9
				JMP RETURN

	AND_MATCH:
				MOV OP_FLAG,0AH
				JMP RETURN

	OR_MATCH:
				MOV OP_FLAG,0BH
				JMP RETURN

	RETURN:
				POP CX
				POP DI
				POP SI
ENDM _OPERATION_CLASSIFY
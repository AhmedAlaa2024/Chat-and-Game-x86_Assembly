INCLUDE maths.inc
        .MODEL SMALL
        .STACK 64
        .DATA
	;DEFINE YOUR DATA HERE
COMMAND1 DB  'ADD AX,BX'
INCLUDE mathData.inc
        .CODE
MAIN PROC    FAR
	     MOV AX,@DATA
	     MOV DS,AX
             MOV ES,AX
	;================================
	     _OPERATION_CLASSIFY COMMAND1, OP_FLAG
	;================================
	;Safely return to OS
	     MOV AX, 4C00H
	     INT 21H
MAIN ENDP
END MAIN
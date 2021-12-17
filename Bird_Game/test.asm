EXTRN BIRDGAME:NEAR
PUBLIC BIRD_SPEED,BULLET_SPEED,POWERUPSCORE 
        .MODEL SMALL
        .STACK 64 
;==========================================
;                 BIRD DATA               ||
;==========================================
        .DATA
BIRD_SPEED     EQU  1000
BULLET_SPEED   EQU  500
POWERUPSCORE   DB    ?
P1_X DW 0
P1_Y DW 300
;======================================================================================================================================
shooterW equ 25
shooterH equ 25
shooter DB 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31 
 DB 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 98, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 98, 31, 31, 98, 3, 3, 3 
 DB 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 98, 31, 31, 31, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 
 DB 3, 3, 3, 31, 31, 31, 31, 98, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 29, 31, 31, 31, 31, 31, 98, 3, 3, 3, 3, 3, 3 
 DB 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 98, 31, 31, 31, 31, 31, 31, 29, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 30, 31, 31, 31 
 DB 31, 31, 31, 31, 98, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 98, 31, 31, 31, 31, 31, 31, 31, 31, 30, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 
 DB 3, 3, 3, 3, 3, 30, 31, 31, 31, 31, 31, 31, 31, 31, 31, 98, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 98, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31 
 DB 31, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 29, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 29, 31 
 DB 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 98, 3, 3, 3, 3, 3, 3, 3, 3, 3, 98, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 29, 3, 3 
 DB 3, 3, 3, 3, 3, 3, 3, 30, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 98, 3, 3, 3, 3, 3, 3, 3, 98, 31, 31, 31, 31, 31, 31, 31, 31 
 DB 31, 31, 31, 31, 31, 31, 31, 31, 31, 3, 3, 3, 3, 3, 3, 3, 30, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 98, 3, 3, 3, 3, 3 
 DB 98, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 3, 3, 3, 3, 3, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31 
 DB 31, 31, 31, 31, 31, 29, 3, 3, 3, 29, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 98, 3, 98, 31, 31, 31, 31, 31, 31 
 DB 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 29, 3, 30, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31 
 DB 31, 31, 98, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 29, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31 
 DB 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31
        
;======================================================================================================================================
 .CODE
 ;Draw an entire block this is from hossam's notebook
DRAWBLOCK MACRO imgH,imgW,img,X,Y
        LOCAL  ENDING,Start,Drawit
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
            MOV CX,imgW
            ADD CX,X  	;set the width (X) up to image width (based on image resolution)
               MOV DX,Y 
	        ADD DX,imgH 	;set the hieght (Y) up to image height (based on image resolution)
	        mov DI, offset img  ; to iterate over the pixels
	        jmp Start    	;Avoid drawing before the calculations
	Drawit:
	        MOV AH,0Ch   	;set the configuration to writing a pixel
            mov al, [DI]    ; color of the current coordinates
	        MOV BH,00h   	;set the page number
	        INT 10h      	;execute the configuration
	Start: 
	        inc DI
	        DEC Cx       	;  loop iteration in x direction
            CMP CX,X
	        JNE Drawit      ;  check if we can draw c urrent x and y and excape the y iteration
	        MOV CX,imgW
            ADD CX,X  	    ;if loop iteration in y direction, then x should start over so that we sweep the grid
	        DEC DX       	;  loop iteration in y direction
            CMP DX,Y
	        JZ  ENDING   	;  both x and y reached 00 so end program
		    Jmp Drawit

	ENDING:
        
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
ENDM DRAWBLOCK
 
;=========================================================================================================================================       
DRAW_BIRD  MACRO  X, Y
        LOCAL BACK
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX

        MOV CX,X
        MOV DX,Y

        MOV AL,0EH
        MOV AH,0CH

        BACK:
                

        POP DX
        POP CX
        POP BX
        POP AX
ENDM DRAW_BIRD
;=============================================
;TODO: WE SHOULD RECOLOR THE PREVIOUS LOCATION
;=============================================
DRAW_PLAYER MACRO X , Y ,KEY
        LOCAL ISRIGHT,NOCHANGE,DRAW
        CMP KEY,75 ;LEFT
        JNE ISRIGHT
        mov ah,0;CONSUME BUFFER
        int 16h
        SUB X,10
        JMP DRAW        
ISRIGHT:
        CMP KEY,77 ;RIGHT
        JNE NOCHANGE
        mov ah,0;CONSUME BUFFER
        int 16h
        ADD X,10 
DRAW:
        DRAWBLOCK shooterH shooterW shooter P1_X P1_Y      
NOCHANGE:
    
ENDM DRAW_PLAYER 
; DRAW_BULLET MACRO

; DRAW_BULLET ENDM

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

MAIN    PROC    FAR
        MOV AX,@DATA
        MOV DS,AX
        ;SET GRAPHCIS MODE
        MOV AX,4F02h
        MOV BX,100h
        INT 10H
        ;==================
        ;CALL BIRDGAME
        ;==================
        DRAW_BACKGROUND
        DRAWBLOCK shooterH shooterW shooter P1_X P1_Y

        
        ;==================
        ;DRAW_BIRD 50 50
        ;DRAW_PLAYER 0 400

MAINLOOP:
        mov ah,1
        int 16h

        DRAW_PLAYER P1_X P1_Y AH

        JMP MAINLOOP
        ;==================
        RET
MAIN    ENDP
        END      MAIN   

BIRDGAME PROC 
    
    RET
BIRDGAME ENDP
END
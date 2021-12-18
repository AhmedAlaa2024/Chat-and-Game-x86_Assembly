        .MODEL SMALL
        .STACK 64 
;==========================================
;                 BIRD DATA               ||
;==========================================
        .DATA
BIRD_SPEED     EQU  1000
BULLET_SPEED   EQU  500
POWERUPSCORE   DB    ?
P1_X DW 100
P1_Y DW 300
;======================================================================================================================================
;=================================================
BLACK           DB      00H
BLUE            DB      01H
GREEN           DB      02H
CYAN            DB      03H
RED             DB      04H
MAGENTA         DB      05H
BROWN           DB      06H
LIGHT_GREY      DB      07H
DAVE_GRAY       DB      08H
LIGHT_BLUE      DB      09H
LIGHT_GREEN     DB      0AH
LIGHT_CYAN      DB      0BH
LIGHT_RED       DB      0CH
LIGHT_MAGENTA   DB      0DH
LIGHT_YELLOW    DB      0EH
LIGHT_WHITE     DB      0FH
;=================================================
STR_TEMP  DB      ?,?,?,?
;=================================================
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
shooterBackgroundX equ 25
shooterBackgroundY equ 25
shooterBackground DB 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31 
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
;======================================================================================================================================
;this macro draws a moving object and then saves the previous background to a the same dimansion img
;======================================================================================================================================
 ;Draw an entire block this is from hossam's notebook
 ;also saves its background in history
DRAW_MOIVNG_OBJECT MACRO imgH,imgW,img,imgB,X,Y ;imgB and img are the same width and hight
        LOCAL  ENDING,Start,Drawit
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI
        PUSH BX
        PUSH AX
                MOV CX,imgW
                ADD CX,X  	;set the width (X) up to image width (based on image resolution)
                MOV DX,Y 
	        ADD DX,imgH 	;set the hieght (Y) up to image height (based on image resolution)
	        mov DI, offset img  ; to iterate over the pixels
                MOV SI, offset imgB ;the background img to store
                MOV BH,00h   	;set the page number
	        jmp Start    	;Avoid drawing before the calculations
	Drawit:
                ;save before pixel
                MOV AH,0Dh
                INT 10h
                MOV [SI],AL
	        MOV AH,0Ch   	;set the configuration to writing a pixel
                mov al, [DI]    ; color of the current coordinates
	        INT 10h      	;execute the configuration
	Start: 
	        inc DI
                INC SI
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
                POP SI
                POP DI
                POP DX
                POP CX
ENDM DRAW_MOIVNG_OBJECT
;===============================================================================      
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
DRAW_PLAYER MACRO X , Y ,KEY
        LOCAL ISRIGHT,NOCHANGE,DRAW,ISUP,ISDOWN
        CMP KEY,75 ;LEFT
        JNE ISRIGHT
        CONSUMEBUFFER
        CALL DRAW_PLAYER_BACKGROUND
        SUB X,10
        JMP DRAW        
        ISRIGHT:
                CMP KEY,77 ;RIGHT
                JNE ISUP
                CONSUMEBUFFER
                CALL DRAW_PLAYER_BACKGROUND
                ADD X,10
                JMP DRAW  
        ISUP:
                CMP KEY,72 ;UP
                JNE ISDOWN
                CONSUMEBUFFER
                CALL DRAW_PLAYER_BACKGROUND
                SUB Y,10 
                JMP DRAW 
        ISDOWN:
                CMP KEY,80 ;DOWN
                JNE NOCHANGE
                CONSUMEBUFFER
                CALL DRAW_PLAYER_BACKGROUND
                ADD Y,10 
        DRAW:     
                DRAW_MOIVNG_OBJECT shooterH shooterW shooter shooterBackground P1_X P1_Y      
        NOCHANGE:

ENDM DRAW_PLAYER 
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
PRINT_4_DIGIT_GRAPHICS  MACRO   X, Y, NUMBER, COLOR
        LOCAL REPEAT
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DI
        ;================
        CONVERT_4_DIGITS_TO_STRING NUMBER, STR_TEMP
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
CONVERT_4_DIGITS_TO_STRING    MACRO   NUMBER, STRING_PTR
        LOCAL REPEAT
        PUSH AX
        PUSH BX
        PUSH DX
        PUSH DI
        ;================
        MOV AX,NUMBER

        LEA DI,STRING_PTR
        ADD DI,3

        MOV CX,4
        REPEAT:
                MOV DX,0

                MOV BX,10
                DIV BX

                ADD DX,'0'

                MOV [DI],DL
                DEC DI
                LOOP REPEAT
        ;================
        POP DI
        POP DX
        POP BX
        POP AX
ENDM    CONVERT_4_DIGITS_TO_STRING
;=================================================
MAIN    PROC    FAR
        MOV AX,@DATA
        MOV DS,AX
        ;==================
        ;SET GRAPHCIS MODE
        MOV AX,4F02h
        MOV BX,100h
        INT 10H
        ;==================
        DRAW_BACKGROUND
        DRAW_MOIVNG_OBJECT shooterH shooterW shooter shooterBackground P1_X P1_Y
        PRINT_4_DIGIT_GRAPHICS 5, 0, CX, RED
        ;==================
MAINLOOP:
        mov ah,1
        int 16h
        DRAW_PLAYER P1_X P1_Y AH
        JMP MAINLOOP
        ;==================
        RET
MAIN    ENDP
;======================================================================================================================================
; Draw the previos background of the shooter
;======================================================================================================================================
DRAW_PLAYER_BACKGROUND PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
                MOV CX,shooterW
                ADD CX,P1_X  	;set the width (X) up to image width (based on image resolution)
                MOV DX,P1_Y 
	        ADD DX,shooterH 	;set the hieght (Y) up to image height (based on image resolution)
	        mov DI, offset shooterBackground  ; to iterate over the pixels
                MOV BH,00h   	;set the page number
	        jmp STARTING    	;Avoid drawing before the calculations
	DRAWING:
	        MOV AH,0Ch   	;set the configuration to writing a pixel
                mov al, [DI]    ; color of the current coordinates
	        INT 10h      	;execute the configuration
	STARTING: 
	        inc DI
	        DEC Cx       	;  loop iteration in x direction
                CMP CX,P1_X
	        JNE DRAWING      ;  check if we can draw c urrent x and y and excape the y iteration
	        MOV CX,shooterW
                ADD CX,P1_X  	    ;if loop iteration in y direction, then x should start over so that we sweep the grid
	        DEC DX       	;  loop iteration in y direction
                CMP DX,P1_Y
	        JZ  STOP   	;  both x and y reached 00 so end program
		Jmp DRAWING

	STOP:       
                POP AX
                POP BX
                POP DI
                POP DX
                POP CX
                RET
DRAW_PLAYER_BACKGROUND ENDP
END      MAIN
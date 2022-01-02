JUMPS
LOCALS @@

.MODEL SMALL
.STACK 64
.DATA
include BirdData.inc
include GUI_DATA.inc
USERNAME_LENGTH EQU 14
P1_USERNAME_BUFF DB USERNAME_LENGTH
P1_USERNAME_SIZE DB 0
;NAME_1 DB 'PLAYER1$'
NAME_1 DB (USERNAME_LENGTH + 1) DUP('$')

;UNSIGNED 4-DIGIT NUMBER
P1_INITIAL_POINTS DW 100

P2_USERNAME_BUFF DB USERNAME_LENGTH
P2_USERNAME_SIZE DB 0
;NAME_2 DB 'PLAYER2$'
NAME_2 DB (USERNAME_LENGTH + 1) DUP('$')

;UNSIGNED 4-DIGIT NUMBER
P2_INITIAL_POINTS DW 80

;==================================
;           GAME STATE
;==================================
P1_FORBIDDEN_CHAR_MSG DB 'Forbidden Char : '
P1_FORBIDDEN_CHARACTER DB 'Z'
DB '$'
P2_FORBIDDEN_CHAR_MSG DB 'Forbidden Char : '
P2_FORBIDDEN_CHARACTER DB 'Y'
DB '$'

PROCESSOR_MSG DB 'PROCESSOR : '
PROCESSOR_CHARACTER DB '0'
DB '$'

CURR_PROCESSOR_FLAG DB 00000001B
CURR_PLAYER_FLAG DB 0

POWER_UP_SELECTED_FLAG DB 0

P1_CLEARED_ALL_RESGISTERS DB 0
P2_CLEARED_ALL_RESGISTERS DB 0

P1_CHANGED_FORBIDDEN_CHAR DB 0
P2_CHANGED_FORBIDDEN_CHAR DB 0

;LEVEL 2 POWER UP -F6
P1_CHANGED_ALL_RESGISTERS DB 0
P2_CHANGED_ALL_RESGISTERS DB 0
REGISTER_VALUE_FOUND_FLAG DW 0 ;P1_AX-P1_CX-000000.P2_AX-P2_BX-000000 RANGED-> AX,CX,DX,BX,SI,DI,BP,SP

PARSE_ERROR_FLAG DB 0
FORBIDDEN_CHAR_ERROR_FLAG DB 0
GAME_LEVEL DB 0

;Main screen and selection screen data
INCLUDE SCREENS.inc
;Player data
INCLUDE P_DATA.inc
;Character macros
INCLUDE CHAR.inc
;Parser data
INCLUDE PRSRDATA.inc
;Command execution data
INCLUDE EXECDATA.INC

CMD_BUFF_SIZE EQU 30
CMD_BUFF DB CMD_BUFF_SIZE, 0
CMD_MSG DB 31 dup('$')

.CODE
;Include parser subprogram
INCLUDE PARSER.INC
;Execute commands subprogram
INCLUDE CMD_PROC.INC
;GUI Commands
INCLUDE GUI.INC


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
DRAW_BIRD1  MACRO 
        LOCAL NOCHANGE,CHECKDOWN,SHIFT,CHECKSPEED,CHECKEND,CHECKBULLET2
        PUSH AX
        PUSH CX
        PUSH DX
        CMP BIRD_MOVING,0
        JNE CHECKEND
        JMP FAR PTR NOCHANGE
CHECKEND:
        CMP BIRD1_X,410
        JNE CHECKSPEED
        MOV BIRD_MOVING,0
        CALL MINI_GAME_MOVING
        call DRAW_BIRDUP1_BACKGROUND
        CALL DRAW_BIRDDOWN1_BACKGROUND
        call DRAW_PLAYER1_BACKGROUND
        call DRAW_BIRDUP2_BACKGROUND
        CALL DRAW_BIRDDOWN2_BACKGROUND
        call DRAW_PLAYER2_BACKGROUND
        mov Bird1_X,760
        mov Bird2_X,360
        cmp BULLET1_MOVING,1
        jne CHECKBULLET2
        call DRAW_BULLET1_BACKGROUND
        MOV BULLET1_MOVING,0
CHECKBULLET2:
        cmp BULLET2_MOVING,1
        jne CHECKSPEED
        call DRAW_BULLET2_BACKGROUND
        MOV BULLET2_MOVING,0
CHECKSPEED:
        MOV AX,TIME
        MOV CX,BIRD_SPEED
        DIV CX
        CMP DX,0
        JE SHIFT
        JMP FAR PTR NOCHANGE
SHIFT:
        CMP BIRDWING1,1
        JNE CHECKDOWN
        DEC BIRDWING1
        call DRAW_BIRDDOWN1_BACKGROUND
        SUB BIRD1_X,10
        DRAW_MOIVNG_OBJECT birdup birdupBackGround birdupSize Bird1_Y Bird1_X
        JMP NOCHANGE
CHECKDOWN:
        INC BIRDWING1
        call DRAW_BIRDUP1_BACKGROUND
        SUB BIRD1_X,10
        DRAW_MOIVNG_OBJECT birddown birddownBackGround birddownSize Bird1_Y Bird1_X
NOCHANGE:
        POP DX
        POP CX
        POP AX
ENDM DRAW_BIRD1
DRAW_BIRD2  MACRO 
        LOCAL NOCHANGE,CHECKDOWN,SHIFT,CHECKSPEED,CHECKEND,CHECKBULLET2
        PUSH AX
        PUSH CX
        PUSH DX
        CMP BIRD_MOVING,0
        JNE CHECKEND
        JMP FAR PTR NOCHANGE
CHECKEND:
        CMP BIRD2_X,10
        JNE CHECKSPEED
        MOV BIRD_MOVING,0
        CALL MINI_GAME_MOVING
        call DRAW_BIRDUP2_BACKGROUND
        CALL DRAW_BIRDDOWN2_BACKGROUND
        call DRAW_PLAYER2_BACKGROUND
        mov Bird2_X,360
        mov Bird1_X,760
        cmp BULLET1_MOVING,1
        jne CHECKBULLET2
        call DRAW_BULLET1_BACKGROUND
        MOV BULLET1_MOVING,0
CHECKBULLET2:
        cmp BULLET2_MOVING,1
        jne CHECKSPEED
        call DRAW_BULLET2_BACKGROUND
        MOV BULLET2_MOVING,0
CHECKSPEED:
        MOV AX,TIME
        MOV CX,BIRD_SPEED
        DIV CX
        CMP DX,0
        JE SHIFT
        JMP FAR PTR NOCHANGE
SHIFT:
        CMP BIRDWING2,1
        JNE CHECKDOWN
        DEC BIRDWING2
        call DRAW_BIRDDOWN2_BACKGROUND
        SUB BIRD2_X,10
        DRAW_MOIVNG_OBJECT birdup birdupBackGround birdupSize Bird2_Y Bird2_X
        JMP NOCHANGE
CHECKDOWN:
        INC BIRDWING2
        call DRAW_BIRDUP2_BACKGROUND
        SUB BIRD2_X,10
        DRAW_MOIVNG_OBJECT birddown birddownBackGround birddownSize Bird2_Y Bird2_X
NOCHANGE:
        POP DX
        POP CX
        POP AX
ENDM DRAW_BIRD2
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
DRAW_PLAYER1 MACRO Y , X ,KEY
        LOCAL ISRIGHT,NOCHANGE,DRAW,ISUP,ISDOWN
                CMP KEY,75 ;LEFT
                JNE ISRIGHT
                ;CONSUMEBUFFER
                CMP X,400
                JBE NOCHANGE
                CALL DRAW_PLAYER1_BACKGROUND
                SUB X,10
                JMP DRAW        
        ISRIGHT:
                CMP KEY,77 ;RIGHT
                JNE ISUP
                ;CONSUMEBUFFER
                CMP X,770
                JAE NOCHANGE
                CALL DRAW_PLAYER1_BACKGROUND
                ADD X,10
                JMP DRAW  
        ISUP:
                CMP KEY,72 ;UP
                JNE ISDOWN
                ;CONSUMEBUFFER
                CMP Y,50
                JBE NOCHANGE
                CALL DRAW_PLAYER1_BACKGROUND
                SUB Y,10 
                JMP DRAW 
        ISDOWN:
                CMP KEY,80 ;DOWN
                JNE NOCHANGE
                ;CONSUMEBUFFER
                CMP Y,300
                JAE NOCHANGE
                CALL DRAW_PLAYER1_BACKGROUND
                ADD Y,10 
        DRAW:     
                DRAW_MOIVNG_OBJECT shooter shooter1Background shooterSize P1_Y P1_X      
        NOCHANGE:

ENDM DRAW_PLAYER1 
DRAW_PLAYER2 MACRO Y , X ,KEY
        LOCAL ISRIGHT,NOCHANGE,DRAW,ISUP,ISDOWN
                CMP KEY,30 ;LEFT
                JNE ISRIGHT
                ;CONSUMEBUFFER
                CMP X,0
                JBE NOCHANGE
                CALL DRAW_PLAYER2_BACKGROUND
                SUB X,10
                JMP DRAW        
        ISRIGHT:
                CMP KEY,32 ;RIGHT
                JNE ISUP
                ;CONSUMEBUFFER
                CMP X,375
                JAE NOCHANGE
                CALL DRAW_PLAYER2_BACKGROUND
                ADD X,10
                JMP DRAW  
        ISUP:
                CMP KEY,17 ;UP
                JNE ISDOWN
                ;CONSUMEBUFFER
                CMP Y,50
                JBE NOCHANGE
                CALL DRAW_PLAYER2_BACKGROUND
                SUB Y,10 
                JMP DRAW 
        ISDOWN:
                CMP KEY,31 ;DOWN
                JNE NOCHANGE
                ;CONSUMEBUFFER
                CMP Y,300
                JAE NOCHANGE
                CALL DRAW_PLAYER2_BACKGROUND
                ADD Y,10 
        DRAW:     
                DRAW_MOIVNG_OBJECT shooter shooter2Background shooterSize P2_Y P2_X      
        NOCHANGE:

ENDM DRAW_PLAYER2
DRAW_BULLET1 MACRO KEY
        LOCAL NOCHANGE,CHECKFINISH,CHECKSPACE,CHECKMOVING,UNHIT
        PUSH AX
        PUSH CX
        PUSH DX
        PUSH SI
                CMP KEY,57 ;Space
                JNE CHECKFINISH
                ;CONSUMEBUFFER
                CMP BULLET1_MOVING,0
                JNE CHECKFINISH
                MOV BULLET1_MOVING,1
                MOV DX,P1_X
                ADD DX,5
                MOV BULLET1_X,DX
                MOV DX,P1_Y
                MOV BULLET1_Y,DX
                SUB BULLET1_Y,20
                DRAW_MOIVNG_OBJECT bullet bullet1Background bulletSize Bullet1_Y Bullet1_X 
        CHECKFINISH:
                CMP BULLET1_Y,20
                JNE CHECKMOVING
                MOV BULLET1_MOVING,0
                CALL DRAW_BULLET1_BACKGROUND
                MOV SI,BIRD1_X
                ADD SI,33
                CMP BULLET1_X,SI
                JAE UNHIT
                MOV SI,BULLET1_X
                ADD SI,15
                CMP SI,Bird1_X
                JBE UNHIT
                CALL END_MINI_GAME_P1
                call DRAW_BIRDUP1_BACKGROUND
                CALL DRAW_BIRDDOWN1_BACKGROUND
                call DRAW_BIRDUP2_BACKGROUND
                CALL DRAW_BIRDDOWN2_BACKGROUND
                CALL DRAW_PLAYER1_BACKGROUND
                CALL DRAW_PLAYER2_BACKGROUND
                MOV BIRD_MOVING,0
                CALL MINI_GAME_MOVING
                MOV Bird1_X,760
                MOV Bird2_X,360
                cmp BULLET2_MOVING,1
                jne UNHIT
                call DRAW_BULLET2_BACKGROUND
                MOV BULLET2_MOVING,0
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
                CALL DRAW_BULLET1_BACKGROUND
                SUB BULLET1_Y,10
                DRAW_MOIVNG_OBJECT bullet bullet1Background bulletSize Bullet1_Y Bullet1_X      

        NOCHANGE:
        POP SI
        POP DX
        POP CX
        POP AX
ENDM DRAW_BULLET1
DRAW_BULLET2 MACRO KEY
        LOCAL NOCHANGE,CHECKFINISH,CHECKSPACE,CHECKMOVING,UNHIT,CHECKBULLETMOVING
        PUSH AX
        PUSH CX
        PUSH DX
        PUSH SI
                CMP KEY,28 ;P
                JNE CHECKFINISH
                ;CONSUMEBUFFER
                CMP BULLET2_MOVING,0
                JNE CHECKFINISH
                MOV BULLET2_MOVING,1
                MOV DX,P2_X
                ADD DX,5
                MOV BULLET2_X,DX
                MOV DX,P2_Y
                MOV BULLET2_Y,DX
                SUB BULLET2_Y,20
                DRAW_MOIVNG_OBJECT bullet bullet2Background bulletSize Bullet2_Y Bullet2_X 
        CHECKFINISH:
                CMP BULLET2_Y,20
                JNE CHECKMOVING
                MOV BULLET2_MOVING,0
                CALL DRAW_BULLET2_BACKGROUND
                MOV SI,BIRD2_X
                ADD SI,33
                CMP BULLET2_X,SI
                JAE UNHIT
                MOV SI,BULLET2_X
                ADD SI,15
                CMP SI,Bird2_X
                JBE UNHIT
                CALL END_MINI_GAME_P2
                call DRAW_BIRDUP2_BACKGROUND
                CALL DRAW_BIRDDOWN2_BACKGROUND
                call DRAW_BIRDUP1_BACKGROUND
                CALL DRAW_BIRDDOWN1_BACKGROUND
                CALL DRAW_PLAYER2_BACKGROUND
                CALL DRAW_PLAYER1_BACKGROUND
                MOV BIRD_MOVING,0
                CALL MINI_GAME_MOVING
                MOV Bird2_X,360
                MOV Bird1_X,760
                cmp BULLET1_MOVING,1
                jne UNHIT
                call DRAW_BULLET1_BACKGROUND
                MOV BULLET1_MOVING,0
        UNHIT:
                MOV DX,P2_Y
                MOV BULLET2_Y,DX
                JMP NOCHANGE
        CHECKMOVING:
                CMP BULLET2_MOVING,1
                JNE NOCHANGE
                MOV AX,TIME
                MOV CX,BULLET_SPEED
                DIV CX
                CMP DX,0
                JNE NOCHANGE
                CALL DRAW_BULLET2_BACKGROUND
                SUB BULLET2_Y,10
                DRAW_MOIVNG_OBJECT bullet bullet2Background bulletSize Bullet2_Y Bullet2_X      

        NOCHANGE:
        POP SI
        POP DX
        POP CX
        POP AX
ENDM DRAW_BULLET2
;===============================================================================
;===================================================================
; The Bird game proc
;===================================================================
MINI_GAME PROC
        CMP GAME_MOVING,1
        JE GAMEISMOVING
        CALL GENERATE_RANDOM
        CMP RANDOM0_99,88
        JE GAMENOTMOVING
        RET
GAMENOTMOVING:
        MOV GAME_MOVING,1
        CALL DRAW_TARGET
        MOV BIRD_MOVING,1
        MOV BIRD_MOVING,1
        DRAW_MOIVNG_OBJECT shooter shooter1Background shooterSize P1_Y P1_X
        DRAW_MOIVNG_OBJECT shooter shooter2Background shooterSize P2_Y P2_X

GAMEISMOVING:
        mov ah,1
        int 16h
        JZ @@BUFF_EMPTY
        MOV AH, 0 ;CONSUME BUFFER
        INT 16h
@@BUFF_EMPTY:
        CMP BIRD_MOVING,0
        JE CONTINUE_P2
CONTINUE_P1:
        DRAW_PLAYER1 P1_Y P1_X AH
        DRAW_BULLET1 AH
        DRAW_BIRD1
CONTINUE_P2:
        CMP BIRD_MOVING,0
        JE SKIPPING
        DRAW_PLAYER2 P2_Y P2_X AH
        DRAW_BULLET2 AH
        DRAW_BIRD2
SKIPPING:    
        RET
ENDP MINI_GAME
;===================================================================
; END_MINI_GAME AND TARGET
;===================================================================
END_MINI_GAME_P1 PROC
        MOV BL, CURR_PLAYER_FLAG
        MOV CURR_PLAYER_FLAG, 0
        CMP RANDOM0_4,0
        JNE CHECK1RANDOM1
        INC HIT_P1_1
        MOV AX, 1
        JMP @@RETURN
CHECK1RANDOM1:        
        CMP RANDOM0_4,1
        JNE CHECK1RANDOM2
        INC HIT_P1_2
        MOV AX, 2
        JMP @@RETURN
CHECK1RANDOM2:        
        CMP RANDOM0_4,2
        JNE CHECK1RANDOM3
        INC HIT_P1_3
        MOV AX, 3
        JMP @@RETURN
CHECK1RANDOM3:
        CMP RANDOM0_4,3
        JNE CHECK1RANDOM4
        INC HIT_P1_4
        MOV AX, 4
        JMP @@RETURN
CHECK1RANDOM4:
        CMP RANDOM0_4,4
        INC HIT_P1_5
        MOV AX, 5
        @@RETURN:
        NEG AX
        CALL DESCREASE_CURRENT_PLAYER_SCORE
        MOV CURR_PLAYER_FLAG, BL
        RET
ENDP END_MINI_GAME_P1
END_MINI_GAME_P2 PROC
        MOV BL, CURR_PLAYER_FLAG
        MOV CURR_PLAYER_FLAG, 1
        CMP RANDOM0_4,0
        JNE @@CHECK2RANDOM1
        INC HIT_P2_1
        MOV AX, 1
        JMP @@RETURN
@@CHECK2RANDOM1:        
        CMP RANDOM0_4,1
        JNE @@CHECK2RANDOM2
        INC HIT_P2_2
        MOV AX, 2
        JMP @@RETURN
@@CHECK2RANDOM2:        
        CMP RANDOM0_4,2
        JNE @@CHECK2RANDOM3
        INC HIT_P2_3
        MOV AX, 3
        JMP @@RETURN
@@CHECK2RANDOM3:
        CMP RANDOM0_4,3
        JNE @@CHECK2RANDOM4
        INC HIT_P2_4
        MOV AX, 4
        JMP @@RETURN
@@CHECK2RANDOM4:
        CMP RANDOM0_4,4
        INC HIT_P2_5
        MOV AX, 5
        @@RETURN:
        NEG AX
        CALL DESCREASE_CURRENT_PLAYER_SCORE
        MOV CURR_PLAYER_FLAG, BL
        RET
ENDP END_MINI_GAME_P2 
SET_TAREGT_X PROC
        CMP RANDOM0_4,0
        JNE @@CHECK2RANDOM1
        MOV HIT_X,31
        RET
@@CHECK2RANDOM1:        
        CMP RANDOM0_4,1
        JNE @@CHECK2RANDOM2
        MOV HIT_X,111
        RET
@@CHECK2RANDOM2:        
        CMP RANDOM0_4,2
        JNE @@CHECK2RANDOM3
        MOV HIT_X,191
        RET
@@CHECK2RANDOM3:
        CMP RANDOM0_4,3
        JNE @@CHECK2RANDOM4
        MOV HIT_X,271
        RET
@@CHECK2RANDOM4:
        CMP RANDOM0_4,4
        MOV HIT_X,351
        RET
ENDP SET_TAREGT_X        
;======================================================================================================================================
; Draw the previos background of the shooter
;======================================================================================================================================
DRAW_PLAYER1_BACKGROUND PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
                mov ah, 0ch
                mov bx,  offset shooter1BackGround
whileshooter1BackGround:
                drawPNG [bx], [bx+1], [bx+2],  P1_Y, P1_X
                add bx, 3
                cmp bx, offset shooter1BackGroundSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE whileshooter1BackGround
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
        RET
DRAW_PLAYER1_BACKGROUND ENDP
DRAW_PLAYER2_BACKGROUND PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
                mov ah, 0ch
                mov bx,  offset shooter2BackGround
whileshooter2BackGround:
                drawPNG [bx], [bx+1], [bx+2],  P2_Y, P2_X
                add bx, 3
                cmp bx, offset shooter2BackGroundSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE whileshooter2BackGround
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
        RET
DRAW_PLAYER2_BACKGROUND ENDP
DRAW_BULLET1_BACKGROUND PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
                mov ah, 0ch
                mov bx,  offset bullet1BackGround
whilebullet1BackGround:
                drawPNG [bx], [bx+1], [bx+2],  Bullet1_Y, Bullet1_X
                add bx, 3
                cmp bx, offset bullet1BackGroundSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE whilebullet1BackGround
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
        RET
DRAW_BULLET1_BACKGROUND ENDP
DRAW_BULLET2_BACKGROUND PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
                mov ah, 0ch
                mov bx,  offset bullet2BackGround
whilebullet2BackGround:
                drawPNG [bx], [bx+1], [bx+2],  Bullet2_Y, Bullet2_X
                add bx, 3
                cmp bx, offset bullet2BackGroundSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE whilebullet2BackGround
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
        RET
DRAW_BULLET2_BACKGROUND ENDP
DRAW_BIRDUP1_BACKGROUND PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
                mov ah, 0ch
                mov bx,  offset birdupBackGround
whilebirdup1BackGround:
                drawPNG [bx], [bx+1], [bx+2],  Bird1_Y, Bird1_X
                add bx, 3
                cmp bx, offset birdupBackGroundSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE whilebirdup1BackGround
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
        RET
DRAW_BIRDUP1_BACKGROUND ENDP
DRAW_BIRDDOWN1_BACKGROUND PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
                mov ah, 0ch
                mov bx,  offset birddownBackGround
whilebirddown1BackGround:
                drawPNG [bx], [bx+1], [bx+2],  Bird1_Y, Bird1_X
                add bx, 3
                cmp bx, offset birddownBackGroundSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE whilebirddown1BackGround
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
        RET
DRAW_BIRDDOWN1_BACKGROUND ENDP
DRAW_BIRDUP2_BACKGROUND PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
                mov ah, 0ch
                mov bx,  offset birdupBackGround
whilebirdup2BackGround:
                drawPNG [bx], [bx+1], [bx+2],  Bird2_Y, Bird2_X
                add bx, 3
                cmp bx, offset birdupBackGroundSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE whilebirdup2BackGround
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
        RET
DRAW_BIRDUP2_BACKGROUND ENDP
DRAW_BIRDDOWN2_BACKGROUND PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
                mov ah, 0ch
                mov bx,  offset birddownBackGround
whilebirddown2BackGround:
                drawPNG [bx], [bx+1], [bx+2],  Bird2_Y, Bird2_X
                add bx, 3
                cmp bx, offset birddownBackGroundSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE whilebirddown2BackGround
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
        RET
DRAW_BIRDDOWN2_BACKGROUND ENDP
DRAW_TARGET PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX
        PUSH SI
                CALL SET_TAREGT_X
                MOV SI,HIT_X
                ADD SI,400
                mov ah, 0ch
                mov bx,  offset target
@@target:
                drawPNG [bx], [bx+1], [bx+2], HIT_Y, HIT_X 
                drawPNG [bx], [bx+1], [bx+2], HIT_Y, SI
                add bx, 3
                cmp bx, offset targetSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE @@target
        POP SI
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
        RET
DRAW_TARGET ENDP
DRAW_TARGET_BACKGROUND PROC NEAR
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH BX
        PUSH AX

                mov ah, 0ch
                mov bx,  offset targetBackGround
@@target:
                ;BOX 1
                drawPNG [bx], [bx+1], [bx+2], HIT_Y, 31
                drawPNG [bx], [bx+1], [bx+2], HIT_Y, 111
                drawPNG [bx], [bx+1], [bx+2], HIT_Y, 191
                drawPNG [bx], [bx+1], [bx+2], HIT_Y, 271
                drawPNG [bx], [bx+1], [bx+2], HIT_Y, 351
                ;BOX 2
                drawPNG [bx], [bx+1], [bx+2], HIT_Y, 431
                drawPNG [bx], [bx+1], [bx+2], HIT_Y, 511
                drawPNG [bx], [bx+1], [bx+2], HIT_Y, 591
                drawPNG [bx], [bx+1], [bx+2], HIT_Y, 671
                drawPNG [bx], [bx+1], [bx+2], HIT_Y, 751
                add bx, 3
                cmp bx, offset targetBackGroundSize                                       ;Time to end the loop whenever the offset is outside the image.
                JNE @@target
        POP AX
        POP BX
        POP DI
        POP DX
        POP CX
        RET
DRAW_TARGET_BACKGROUND ENDP
MINI_GAME_MOVING PROC
        CMP BIRD_MOVING,0
        JE @@NEXT
        RET
@@NEXT:
        CMP BIRD_MOVING,0
        JE @@STOP
        RET
@@STOP:
        MOV GAME_MOVING,0
        CALL DRAW_TARGET_BACKGROUND
        RET
MINI_GAME_MOVING ENDP
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
        mov     cx, 250    
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

UPDATE_FORBIDDEN_CHARACTER_REPRESENTATION PROC NEAR
    TEST GAME_LEVEL , 1
    JNZ @@EXIT
    PRINT_STRING 51, 4, P1_FORBIDDEN_CHAR_MSG, RED
    PRINT_STRING 1, 4, P2_FORBIDDEN_CHAR_MSG, RED
    @@EXIT:
    RET
UPDATE_FORBIDDEN_CHARACTER_REPRESENTATION ENDP

UPDATE_CURRENT_PROCESSOR_REPRESENTATION PROC NEAR
    CALL SET_PROCCESSOR_MSG
    PRINT_STRING 13, 3, PROCESSOR_CHARACTER, LIGHT_YELLOW
    RET
UPDATE_CURRENT_PROCESSOR_REPRESENTATION ENDP 

CAN_USE_POWER_UP MACRO NO, COST
    LOCAL @@PLAYER_2,  @@EXIT_M
    TEST CURR_PLAYER_FLAG, 1 ;ZF = 1 if Player 1
    JNZ @@PLAYER_2
    CMP PLAYER_1_SCORE_VALUE, COST
    JBE NO
    JMP @@EXIT_M
    @@PLAYER_2:
    CMP PLAYER_2_SCORE_VALUE, COST
    JBE NO
    @@EXIT_M:
ENDM CAN_USE_POWER_UP     

EXECUTE_FIRST_POWER_UP PROC NEAR
    TEST GAME_LEVEL, 1
    JNZ @@LEVEL_2
    TEST POWER_UP_SELECTED_FLAG, 1
    JZ @@LEVEL_1
    RET
    @@LEVEL_2:
    TEST CURR_PROCESSOR_FLAG, 00000001B
    JNZ @@TOGGLE_2
    MOV CURR_PROCESSOR_FLAG, 00000001B
    RET
    @@TOGGLE_2:
    MOV CURR_PROCESSOR_FLAG, 00010000B
    RET
    @@LEVEL_1:
    PUSH AX
    ;CAN_USE_POWER_UP @@EXIT, 5 
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
    ;CAN_USE_POWER_UP @@EXIT, 3 
    MOV AX, 3
    CALL DESCREASE_CURRENT_PLAYER_SCORE
    MOV POWER_UP_SELECTED_FLAG, 1   
    MOV CURR_PROCESSOR_FLAG,00010001B
    @@EXIT:
    POP AX
    RET
EXECUTE_SECOND_POWER_UP ENDP

EXECUTE_FIFTH_POWER_UP PROC NEAR
    PUSH AX
    TEST POWER_UP_SELECTED_FLAG, 1
    JZ @@EXECUTE
    RET
    @@EXECUTE:    
    TEST CURR_PLAYER_FLAG, 1 ;ZF = 1 if Player 1
    JNZ @@PLAYER2
    TEST P1_CLEARED_ALL_RESGISTERS, 1
    JNZ @@EXIT
    MOV P1_CLEARED_ALL_RESGISTERS, 1
    JMP @@CLEAR_ALL
    @@PLAYER2:
    TEST P2_CLEARED_ALL_RESGISTERS, 1
    JNZ @@EXIT
    MOV P2_CLEARED_ALL_RESGISTERS, 1
    @@CLEAR_ALL:
    ;CAN_USE_POWER_UP @@EXIT, 30 
    MOV AX, 30
    CALL DESCREASE_CURRENT_PLAYER_SCORE
    MOV AX, 0
    MOV PLAYER_1_AX_VALUE, AX
    MOV PLAYER_1_BX_VALUE, AX
    MOV PLAYER_1_CX_VALUE, AX
    MOV PLAYER_1_DX_VALUE, AX
    MOV PLAYER_1_SI_VALUE, AX
    MOV PLAYER_1_DI_VALUE, AX
    MOV PLAYER_1_BP_VALUE, AX
    MOV PLAYER_1_SP_VALUE, AX
    MOV PLAYER_2_AX_VALUE, AX
    MOV PLAYER_2_BX_VALUE, AX
    MOV PLAYER_2_CX_VALUE, AX
    MOV PLAYER_2_DX_VALUE, AX
    MOV PLAYER_2_SI_VALUE, AX
    MOV PLAYER_2_DI_VALUE, AX
    MOV PLAYER_2_BP_VALUE, AX
    MOV PLAYER_2_SP_VALUE, AX
    @@EXIT:  
    POP AX
    RET
EXECUTE_FIFTH_POWER_UP ENDP
EXECUTE_THIRD_POWER_UP PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    ;CAN_USE_POWER_UP @@LEAVE, 8 
    MOV BL, CMD_BUFF[1]
    CMP BL,1
    JNE @@EXIT 
    TEST POWER_UP_SELECTED_FLAG, 1
    JZ @@EXECUTE
    JMP @@LEAVE
    @@EXECUTE:
    TEST CURR_PLAYER_FLAG, 1 ;ZF = 1 if Player 1
    JNZ @@PLAYER2
    TEST P1_CHANGED_FORBIDDEN_CHAR, 1
    JNZ @@EXIT
    MOV P1_CHANGED_FORBIDDEN_CHAR, 1
    JMP @@CHANGE
    @@PLAYER2:
    TEST P2_CHANGED_FORBIDDEN_CHAR, 1
    JNZ @@EXIT
    MOV P2_CHANGED_FORBIDDEN_CHAR, 1
    @@CHANGE:
    MOV BH, 0       
    MOV BL, CMD_BUFF[1]
    DEC BX
    MOV Al, CMD_MSG[BX]
    
    ISDIGIT AL, @@VALID_ALPHANUMBERIC
    ISALPHA AL, @@VALID_ALPHANUMBERIC
    JMP @@REST

    @@VALID_ALPHANUMBERIC: 
    CHARTOUPPER Al

    TEST CURR_PLAYER_FLAG, 1 ;ZF = 1 if Player 1
    JNZ @@PLAYER2_E
    MOV P2_FORBIDDEN_CHARACTER, AL
    JMP @@REST
    @@PLAYER2_E:
    MOV P1_FORBIDDEN_CHARACTER, AL
    
    MOV AX, 8
    CALL DESCREASE_CURRENT_PLAYER_SCORE

    @@REST:
    ;RESET PLAYER CURSOR LOCATION
    TEST CURR_PLAYER_FLAG, 1 ;ZF = 1 if Player 1
    JNZ @@PLAYER2_CMD_LOC
    MOV PLAYER_1_CMD_X_LOCATION, 54
    MOV BL, P1_USERNAME_SIZE
    ADD PLAYER_1_CMD_X_LOCATION, BL 
    JMP @@CONTNIUE
    @@PLAYER2_CMD_LOC:
    MOV PLAYER_2_CMD_X_LOCATION, 5
    MOV BL, P2_USERNAME_SIZE
    ADD PLAYER_2_CMD_X_LOCATION, BL 
    @@CONTNIUE:    

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

    @@EXIT:
    CALL UPDATE_FORBIDDEN_CHARACTER_REPRESENTATION
    @@LEAVE:
    POP SI
    POP CX 
    POP BX  
    POP AX
    RET
EXECUTE_THIRD_POWER_UP ENDP
EXECUTE_SIXTH_POWER_UP PROC NEAR
        PUSH AX
        PUSH BX
        PUSH SI
        PUSH DI
        TEST GAME_LEVEL,1
        JZ @@RETURN
        MOV BL, CMD_BUFF[1]
        CMP BL,9 ;ABCD ABCD = 9 CHARS        
        JNE @@RETURN
        TEST POWER_UP_SELECTED_FLAG, 1
        JZ @@EXECUTE
        JMP @@RETURN
        @@EXECUTE:

        TEST CURR_PLAYER_FLAG, 1 ;ZF = 1 if Player 1
        JNZ @@PLAYER2
        TEST P1_CHANGED_ALL_RESGISTERS, 1
        JNZ @@RETURN
        MOV P1_CHANGED_ALL_RESGISTERS, 1
        JMP @@CHANGE
        @@PLAYER2:
        TEST P2_CHANGED_ALL_RESGISTERS, 1
        JNZ @@RETURN
        MOV P2_CHANGED_ALL_RESGISTERS, 1
        @@CHANGE:

        ;SPLIT AND EXCEUTE
        CALL SPLIT_STRING 
        TOUPPER SPLIT_DATA, 30

        MOV SI,0
        MOV BX, 0       
        @@FIRST_VAL:        
        MOV Al, SPLIT_DATA[BX]
        ISXDIGIT AL, @@CONTINUE1
        JMP @@REST
        @@CONTINUE1:
        ISDIGIT AL,@@DIGIT_1
        SUB AL,55D
        JMP @@END1
        @@DIGIT_1:
        SUB AL,'0'
        @@END1:
        SHL SI,4
        MOV AH,0
        ADD SI,AX
        INC BX
        CMP BX,4
        JNE @@FIRST_VAL

        MOV BX,5
        MOV DI,0    
        @@SECOND_VAL:        
        MOV Al, SPLIT_DATA[BX]
        ISXDIGIT AL, @@CONTINUE2
        JMP @@REST
        @@CONTINUE2:
        ISDIGIT AL,@@DIGIT_2
        SUB AL,55D
        JMP @@END2
        @@DIGIT_2:
        SUB AL,'0'
        @@END2:
        SHL DI,4
        MOV AH,0
        ADD DI,AX
        INC BX
        CMP BX,9
        JNE @@SECOND_VAL
        ;HERE MEANS ALL GOOD SHOULD EXCEUCTE AND EARSE BUFFER
        ; MOV PLAYER_1_SI_VALUE,SI
        ; MOV PLAYER_1_DI_VALUE,DI

        ; CHECK_REGISTERS_VALUES DI
        ; CMP REGISTER_VALUE_FOUND_FLAG,0
        ; JE @@REST
        ;JMP @@REST
        XCHG SI,DI
        CALL CHECK_REGISTERS_VALUES
        XCHG SI,DI
        ;REGISTER_VALUE_FOUND_FLAG NOW HAS ALL THE REGS WITH THE PREVOIUS VALUE TO BE CHANGED
        MOV AX,1000000000000000B
        ;P1 CHECK
        MOV CX,8
        LEA BX,P1_DATA
        @@P1_CHECK:
        TEST REGISTER_VALUE_FOUND_FLAG,AX
        JZ @@NEXT1
        MOV [BX],DI
        @@NEXT1:
        SHR AX,1
        ADD BX,2
        LOOP @@P1_CHECK

        ;P2 CHECK
        MOV CX,8
        LEA BX,P2_DATA
        @@P2_CHECK:
        TEST REGISTER_VALUE_FOUND_FLAG,AX
        JZ @@NEXT2
        MOV [BX],DI
        @@NEXT2:
        SHR AX,1
        ADD BX,2
        LOOP @@P2_CHECK

        MOV AX, 50
        CALL DESCREASE_CURRENT_PLAYER_SCORE
        JMP @@REST


        @@REST:
        ;RESET PLAYER CURSOR LOCATION
        TEST CURR_PLAYER_FLAG, 1 ;ZF = 1 if Player 1
        JNZ @@PLAYER2_CMD_LOC
        MOV PLAYER_1_CMD_X_LOCATION, 54
        MOV BL, P1_USERNAME_SIZE
        ADD PLAYER_1_CMD_X_LOCATION, BL 
        JMP @@CONTNIUE
        @@PLAYER2_CMD_LOC:
        MOV PLAYER_2_CMD_X_LOCATION, 5
        MOV BL, P2_USERNAME_SIZE
        ADD PLAYER_2_CMD_X_LOCATION, BL 
        @@CONTNIUE:    

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


@@RETURN:
        POP DI
        POP SI
        POP BX
        POP AX
        RET
ENDP EXECUTE_SIXTH_POWER_UP
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
    MOV BL, P1_USERNAME_SIZE
    ADD PLAYER_1_CMD_X_LOCATION, BL 
    JMP @@PLAYER1_CMD_LOC
    @@PLAYER2_CMD_LOC:
    MOV PLAYER_2_CMD_X_LOCATION, 5
    MOV BL, P2_USERNAME_SIZE
    ADD PLAYER_2_CMD_X_LOCATION, BL
    @@PLAYER1_CMD_LOC:
       
    

    ;Set player to parse
    TEST CURR_PROCESSOR_FLAG, 00000001B ;ZF = 1 if Player 1
    JZ @@CHECK_SECOND_PROCESSOR
    MOV AX, OFFSET P2_DATA
    MOV P_DATA, AX

    ;Call Parser_P subprogram
    CALL PARSER
    
    TEST PARSE_ERROR_FLAG, 1
    JNZ @@PARSER_ERROR

    MOV FORBIDDEN_CHAR_ERROR_FLAG, 0
    CALL CHECK_FORBIDDEN_CHARACTER
    TEST FORBIDDEN_CHAR_ERROR_FLAG, 1
    JNZ @@SKIP_EXEC
    
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

    MOV FORBIDDEN_CHAR_ERROR_FLAG, 0
    CALL CHECK_FORBIDDEN_CHARACTER
    TEST FORBIDDEN_CHAR_ERROR_FLAG, 1
    JNZ @@SKIP_EXEC

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

;=============================================
; Subtract AX value from current player score
;   Should check for score reaching zero
;=============================================
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
;=============================================
;       Get current player's cmd box
;       x location and store it in SI
;=============================================
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
    MOV CH, P1_FORBIDDEN_CHARACTER
    JMP @@CONTINUE
    @@PLAYER2:
    MOV CH, P2_FORBIDDEN_CHARACTER
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
    CMP AL, 13
    JNE @@NOT_ENTER

    CALL EXECUTE_CURRENT_COMMAND
    RET
    @@NOT_ENTER:
    ; Max size reached ?
    CMP AL, 08H   ;BACKSPACE
    JNE @@NOT_BACKSPACE
    CMP CMD_BUFF[1], 0
    JE @@BUFF_EMPTY
    
    CALL GET_CURR_PLAYER_CMD_X_LOCATION

    MOV AH, 02H
    MOV BH, 0
    MOV DL, [SI]
    MOV DH, 29
    INT 10H

    MOV AH, 0EH
    MOV BH, 0
    MOV BL, 0FH

    MOV AL, 08H ;BACKSPACE
    INT 10H
    MOV AL, 20H ;SPACE
    INT 10H 
    MOV AL, 08H ;BACKSPACE
    INT 10H

    DEC CMD_BUFF[1]
    DEC BYTE PTR [SI]
    @@BUFF_EMPTY:
    RET
    @@NOT_BACKSPACE:
    CMP CMD_BUFF[1], CMD_BUFF_SIZE
    JNE @@BUFF_NOT_FULL
    RET
    @@BUFF_NOT_FULL:
    
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
    INC BYTE PTR [SI]
    RET
ENDP WRITE_CMD

HANDLE_BUFFER PROC NEAR
    CMP AH, 75
    JB @@NOT_ARROW
    CMP AH, 80
    JAE @@NOT_ARROW
    JMP @@RETURN
    @@NOT_ARROW:
    ;Check if power up key
    @@FIRST_POWER_UP:
    CMP AH, 59 ; F1 SCAN Code
    JNE @@SECOND_POWER_UP
    CAN_USE_POWER_UP @@RETURN, 5
    CALL EXECUTE_FIRST_POWER_UP 
    JMP @@RETURN
    @@SECOND_POWER_UP:
    CMP AH, 60 ; F2 SCAN Code
    JNE @@THIRD_POWER_UP
    CAN_USE_POWER_UP @@RETURN, 3
    CALL EXECUTE_SECOND_POWER_UP 
    JMP @@RETURN
    @@THIRD_POWER_UP:
    CMP AH, 61 ; F3 SCAN Code
    JNE @@FORTH_POWER_UP
    CAN_USE_POWER_UP @@RETURN, 8
    CALL EXECUTE_THIRD_POWER_UP 
    JMP @@RETURN
    @@FORTH_POWER_UP:
    CMP AH, 62 ; F4 SCAN Code
    JNE @@FIFTH_POWER_UP
    ; Call Forth Power Up 
    JMP @@RETURN
    @@FIFTH_POWER_UP:
    CMP AH, 63 ; F5 SCAN Code
    JNE @@SIXTH_POWER_UP
    CAN_USE_POWER_UP @@RETURN, 30
    CALL EXECUTE_FIFTH_POWER_UP
    JMP @@RETURN
    @@SIXTH_POWER_UP:
    CMP AH, 64 ; F5 SCAN Code
    JNE @@WRITE_BUFFER_CMD
    CAN_USE_POWER_UP @@RETURN, 50
    CALL EXECUTE_SIXTH_POWER_UP
    JMP @@RETURN
    @@WRITE_BUFFER_CMD: 
    CALL WRITE_CMD
    @@RETURN:
    CONSUMEBUFFER
    RET
HANDLE_BUFFER ENDP
;===========================================================================================
; Function: CONVERT_WORD_TO_STRING                                                          |
; TESTED:   TRUE                                                                            |
; Input:                                                                                    |
;                <INT:NUMBER> = The number which is needed to be converted                  |
; Output: <Action> = Conversion from 4-digit number to string                               |
;                    This will be saved in STR_TEMP(SIZE : 4)                               |
; Description:                                                                              |
;              Convert the number digit by digit to char by char and put it in the variable |
;===========================================================================================
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

SET_PROCCESSOR_MSG PROC NEAR
    TEST CURR_PROCESSOR_FLAG, 00000001B
    JZ @@PLAYER2ONLY
    TEST CURR_PROCESSOR_FLAG, 00010000B
    JNZ @@PLAYER1AND2
    MOV PROCESSOR_CHARACTER, '0'
    RET
    @@PLAYER2ONLY:
    MOV PROCESSOR_CHARACTER, '1'    
    RET
    @@PLAYER1AND2:
    MOV PROCESSOR_CHARACTER, '2'    
    RET
SET_PROCCESSOR_MSG ENDP

DID_SOMEONE_WIN MACRO GAME_ENDED
    CMP PLAYER_1_SCORE_VALUE , 0
    JBE GAME_ENDED
    CMP PLAYER_2_SCORE_VALUE , 0
    JBE GAME_ENDED
ENDM DID_SOMEONE_WIN


CHECK_REGISTERS_VALUES PROC NEAR
        PUSH AX
        PUSH CX
        PUSH BX
        PUSH SI

        MOV REGISTER_VALUE_FOUND_FLAG,0
        MOV AX,1000000000000000B
        ;P1 CHECK
        MOV CX,8
        LEA BX,P1_DATA
        @@P1_CHECK:
        MOV SI,[BX]
        CMP DI,SI
        JNE @@NEXT1
        OR REGISTER_VALUE_FOUND_FLAG,AX
        @@NEXT1:
        SHR AX,1
        ADD BX,2
        LOOP @@P1_CHECK

        ;P2 CHECK
        MOV CX,8
        LEA BX,P2_DATA
        @@P2_CHECK:
        MOV SI,[BX]
        CMP DI,SI
        JNE @@NEXT2
        OR REGISTER_VALUE_FOUND_FLAG,AX
        @@NEXT2:
        SHR AX,1
        ADD BX,2
        LOOP @@P2_CHECK

        POP SI
        POP BX
        POP CX
        POP AX
        RET
CHECK_REGISTERS_VALUES ENDP
MAIN PROC FAR
    ;Initialize Data Segment
    MOV AX, @DATA
    MOV DS, AX
    ;End initialize

    RUN_STRT_SCREEN P1_USERNAME_BUFF, P1_INITIAL_POINTS
    RUN_STRT_SCREEN P2_USERNAME_BUFF, P2_INITIAL_POINTS
    GET_FORBIDDEN_CHAR P2_FORBIDDEN_CHARACTER
    GET_FORBIDDEN_CHAR P1_FORBIDDEN_CHARACTER
    SELECT_GAME_LEVEL_SCREEN GAME_LEVEL

    CALL SET_INITIAL_SCORE

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
    CALL DRAW_TARGET_BACKGROUND
    CALL UPDATE_FORBIDDEN_CHARACTER_REPRESENTATION
    ;==================
    ;Chat Box
    PRINT_STRING 1, 35, NAME_1, RED
    MOV DL, 2
    ADD DL, P1_USERNAME_SIZE
    PRINT_STRING DL, 35, MESSAGE_1, LIGHT_WHITE

    PRINT_STRING 1, 36, NAME_2, RED
    MOV DL, 2
    ADD DL, P2_USERNAME_SIZE
    PRINT_STRING DL, 36, MESSAGE_2, LIGHT_WHITE
    ;==================
    PRINT_STRING 1, 3, PROCESSOR_MSG, LIGHT_YELLOW

;     MOV PLAYER_1_BX_VALUE,0123   
;     MOV DI,0123
;     CHECK_REGISTERS_VALUES DI
;     MOV DI,REGISTER_VALUE_FOUND_FLAG
;     MOV PLAYER_1_CX_VALUE,DI    

    ;=================
    MOV BP, 0
    UPDATE_TIMER:
    ;Check buffer
    MOV AH, 1
    INT 16h
    JZ SKIP_HANDLE 
    CALL HANDLE_BUFFER
    SKIP_HANDLE:
    

    MOV DX,BP
    AND DX,0080H
    SHR DX,7
    MOV PLAYER_1_Z_FLAG_VALUE, DL
    MOV PLAYER_1_TIMER_VALUE, BP
    MOV PLAYER_2_Z_FLAG_VALUE, DL
    MOV PLAYER_2_TIMER_VALUE, BP
    
    CALL PLAYER_1_UPDATE_REGISTERS_REPRESENTATION
    CALL PLAYER_1_UPDATE_MEMORY_REPRESENTATION
    CALL PLAYER_1_UPDATE_FLAGS_REPRESENTATION
    CALL PLAYER_1_UPDATE_BIRD_SCORE

    CALL PLAYER_2_UPDATE_REGISTERS_REPRESENTATION
    CALL PLAYER_2_UPDATE_MEMORY_REPRESENTATION
    CALL PLAYER_2_UPDATE_FLAGS_REPRESENTATION
    CALL PLAYER_2_UPDATE_BIRD_SCORE

    CALL UPDATE_CURRENT_PROCESSOR_REPRESENTATION
    INC BP

    @@MINI_GAME:
    call MINI_GAME    
    INC TIME
    cmp GAME_MOVING, 1
    je @@MINI_GAME

    ;TIMER DELAY 
    ;MOV CX,0FFFFH
    ;DELAY:
    ;LOOP DELAY
    ;CMP BP,0FFFFH
    DID_SOMEONE_WIN @@GAME_ENDED
    JMP UPDATE_TIMER
    @@GAME_ENDED:
    CMP PLAYER_1_SCORE_VALUE , 0
    SHOW_GAME_ENDED_SCRREN NAME_2
    JMP @@SAFE_RETURN
    CMP PLAYER_2_SCORE_VALUE , 0
    SHOW_GAME_ENDED_SCRREN NAME_1
    @@SAFE_RETURN:
    ;Safely return to OS
    MOV AX, 4C00H
    INT 21H
MAIN ENDP
END MAIN
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
;===================================================================
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
        PRINT_4_DIGIT_GRAPHICS  77, 7, PLAYER_1_MEM_0_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  77, 9, PLAYER_1_MEM_1_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  77, 11, PLAYER_1_MEM_2_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  77, 13, PLAYER_1_MEM_3_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  77, 15, PLAYER_1_MEM_4_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  77, 17, PLAYER_1_MEM_5_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  77, 19, PLAYER_1_MEM_6_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  77, 21, PLAYER_1_MEM_7_VALUE, LIGHT_WHITE

        PRINT_4_DIGIT_GRAPHICS  93, 7, PLAYER_1_MEM_8_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  93, 9, PLAYER_1_MEM_9_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  93, 11, PLAYER_1_MEM_A_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  93, 13, PLAYER_1_MEM_B_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  93, 15, PLAYER_1_MEM_C_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  93, 17, PLAYER_1_MEM_D_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  93, 19, PLAYER_1_MEM_E_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  93, 21, PLAYER_1_MEM_F_VALUE, LIGHT_WHITE
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
        PRINT_4_DIGIT_GRAPHICS  27, 7, PLAYER_2_MEM_0_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  27, 9, PLAYER_2_MEM_1_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  27, 11, PLAYER_2_MEM_2_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  27, 13, PLAYER_2_MEM_3_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  27, 15, PLAYER_2_MEM_4_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  27, 17, PLAYER_2_MEM_5_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  27, 19, PLAYER_2_MEM_6_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  27, 21, PLAYER_2_MEM_7_VALUE, LIGHT_WHITE

        PRINT_4_DIGIT_GRAPHICS  43, 7, PLAYER_2_MEM_8_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  43, 9, PLAYER_2_MEM_9_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  43, 11, PLAYER_2_MEM_A_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  43, 13, PLAYER_2_MEM_B_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  43, 15, PLAYER_2_MEM_C_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  43, 17, PLAYER_2_MEM_D_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  43, 19, PLAYER_2_MEM_E_VALUE, LIGHT_WHITE
        PRINT_4_DIGIT_GRAPHICS  43, 21, PLAYER_2_MEM_F_VALUE, LIGHT_WHITE
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
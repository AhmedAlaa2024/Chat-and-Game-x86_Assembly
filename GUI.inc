;===========================================================================================
; Function: DRAW_BACKGROUND                                                                 |
; TESTED:   TRUE                                                                            |
; Input: <INT:COLOR> = The color needed to draw the background by.                          |
; Output: <Action> = The screen will be filled by the choiced color                         |
; Description:                                                                              |
;               Cover the screen by the selected color                                      |
;===========================================================================================
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
;===========================================================================================
; Function: DRAW_LINE_V                                                                     |
; TESTED:   TRUE                                                                            |
; Input:                                                                                    |
;                <INT:X> = The X-cordinate of the start point                               |
;                <INT:Y> = The Y-cordinate of the start point                               |
;                <INT:LENGTH> = The length of the vertical line                             |
;                <INT:COLOR> = The color needed to draw the background by.                  |
; Output: <Action> = Draw vetical line                                                      |
; Description:                                                                              |
;               Draw a vertical line from the start point with specified length             |
; EXAMPLE:   DRAW_LINE_V 320, 0, 400, RED -> Draw full vertical line.                       |
;===========================================================================================
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
;===========================================================================================
; Function: DRAW_LINE_H                                                                     |
; TESTED:   TRUE                                                                            |
; Input:                                                                                    |
;                <INT:X> = The X-cordinate of the start point                               |
;                <INT:Y> = The Y-cordinate of the start point                               |
;                <INT:LENGTH> = The length of the horizontal line                           |
;                <INT:COLOR> = The color needed to draw the background by.                  |
; Output: <Action> = Draw horizontal line                                                   |
; Description:                                                                              |
;               Draw a horizontal line from the start point with specified length           |
;               ;EXAMPLE:   DRAW_LINE_H 0, 640, 200, GREEN -> Draw full horizontal line.    |              
;===========================================================================================
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
        MOV DI,0
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
;===========================================================================================
; Function: MOVE_CURSOR                                                                     |
; TESTED:   TRUE                                                                            |
; Input:                                                                                    |
;                <INT:X> = The X-cordinate of the required position                         |
;                <INT:Y> = The Y-cordinate of the required position                         |
; Output: <Action> = Move the cursor to (r,c) = (x,y)                                       |
; Description:                                                                              |
;               Move the cursor to (r,c) = (x,y)                                            |
;===========================================================================================
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
;===========================================================================================
; Function: PRINT_STRING                                                                    |
; TESTED:   TRUE                                                                            |
; Input:                                                                                    |
;                <INT:X> = The X-cordinate of the start point                               |
;                <INT:Y> = The Y-cordinate of the start point                               |
;                <STRING:STR> = The string that will be printed                             |
;                <INT:COLOR> = The color needed to draw the string by                       |
; Output: <Action> = Print string at (x,y)                                                  |
; Description:                                                                              |
;               1. Move the cursor to the required position                                 |
;               2. Print the string character by character until '$'                        |
;===========================================================================================
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
;===========================================================================================
; Function: DRAW_BOX                                                                        |
; TESTED:   TRUE                                                                            |
; Input:                                                                                    |
;                <INT:X_START> = The X-cordinate of the top left corner of the box          |
;                <INT:Y_START> = The Y-cordinate of the top left corner of the box          |
;                <INT:LENGTH> = The length of the box (along x-axis)                        |
;                <INT:WIDTH> = The width of the box (along y-axis)                          |
;                <INT:COLOR> = The color needed to the background of the box by.            |
; Output: <Action> = Draw a box with color from (x,y)                                       |
; Description:                                                                              |
;               1. Move the cursor to (x,y)                                                 |
;               2. Draw 2 horizontal lines with seperated space = width                     |
;               3. Draw 2 Vertical lines with seperated space = length                      |
;                                                                                           |
;                 _____________________LENGTH___________________________                    |
;                |                                                      |                   |                                   
;                |                                                      |                   |                                   
;              WIDTH                                                   WIDTH                |                                      
;                |                                                      |                   |                                   
;                |                                                      |                   |                                   
;                |_____________________LENGTH___________________________|                   |
;===========================================================================================
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

;===========================================================================================
; Function: PRINT_4_DIGIT_GRAPHICS                                                          |
; TESTED:   TRUE                                                                            |
; Input:                                                                                    |
;                <INT:X> = The X-cordinate of the start point                               |
;                <INT:Y> = The Y-cordinate of the start point                               |
;                <INT:NUMBER> = The number which is needed to be converted                  |
;                <INT:COLOR> = The color needed to draw the string by                       |
; Output: <Action> = Conversion from 4-digit number to string, then print it at (x,y)       |
; Description:                                                                              |
;               1. Convert the number digit by digit to char by char                        |
;                  and put it in the variable.                                              |
;               2. Print the content of that variable.                                      |
;===========================================================================================
PRINT_4_DIGIT_GRAPHICS  MACRO   X, Y, NUMBER, COLOR
        LOCAL REPEAT
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DI
        ;================
        MOV AX, NUMBER
        CALL CONVERT_WORD_TO_STRING
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
ENDM PRINT_4_DIGIT_GRAPHICS
;===========================================================================================
; Function: PRINT_1_DIGIT_GRAPHICS                                                          |
; TESTED:   TRUE                                                                            |
; Input:                                                                                    |
;                <INT:X> = The X-cordinate of the start point                               |
;                <INT:Y> = The Y-cordinate of the start point                               |
;                <INT:COLOR> = The color needed to draw the flag value by                   |
;                <INT:NUMBER> = The number which is needed to be printed                    |
; Output: <Action> = Print the number (1-digit) at (x,y)                                    |
; Description:                                                                              |
;                  Print the number (1-digit) at (x,y)                                      |
;===========================================================================================
PRINT_1_DIGIT_GRAPHICS  MACRO   X, Y, COLOR, NUMBER
        PUSH AX
        PUSH BX
        PUSH DX
        ;================
        MOV AL, NUMBER
        XOR BX,BX       ; PAGE 0
        MOV BL,COLOR

        MOVE_CURSOR X, Y

        ADD AL,'0'

        MOV AH,0EH
        INT 10H
        ;================
        POP DX
        POP BX
        POP AX
ENDM    PRINT_1_DIGIT_GRAPHICS
;===================================================================
PRINT_NUM_TO_GRAPHICS PROC NEAR
    PUSH CX
    PUSH SI
    ADD SI, CX
    DEC SI

    MOV BH, 0
    MOV AH, 02H
    ;Move cursor to DL, DH
    INT 10H

    MOV AH, 0EH   
    @@REPEAT:
        MOV AL, [SI]
        AND AL, 0F0H
        SHR AL, 4
        CMP AL, 10
        JB @@IS_DIGIT_2
        ADD AL, 55
        JMP @@PrintHigherNibble
        @@IS_DIGIT_2:
        ADD AL, '0'
        @@PrintHigherNibble:
        INT 10H

        MOV AL, [SI]
        AND AL, 00FH
        CMP AL, 10
        JB @@IS_DIGIT_1
        ADD AL, 55
        JMP @@PrintLowerNibble
        @@IS_DIGIT_1:
        ADD AL, '0'
        @@PrintLowerNibble:
        INT 10H
   
        DEC SI
    LOOP @@REPEAT
    POP SI
    POP CX
    RET
PRINT_NUM_TO_GRAPHICS ENDP
;===========================================================================================
; Function: DISPLAY_FLAG_VALUE                                                              |
; TESTED:   TRUE                                                                            |
; Input:                                                                                    |
;                <INT:X> = The X-cordinate of the start point                               |
;                <INT:Y> = The Y-cordinate of the start point                               |
;                <INT:FLAG> = The flag value which is needed to be printed                  |
;                <INT:COLOR> = The color needed to draw the flag value by                   |
; Output: <Action> = Print the flag (0 or 1) at (x,y)                                       |
; Description:                                                                              |
;                  if (flag == 0)                                                           |
;                       printf("0");                                                        |
;                  else                                                                     |
;                       printf("1");                                                        |
;===========================================================================================
DISPLAY_FLAG_VALUE  MACRO   X, Y, FLAG, COLOR
        LOCAL ZERO, EXIT
        PUSH AX
        PUSH BX
        PUSH BP
        ;================
        MOV BP, FLAG

        MOV AH,0EH
        XOR BX,BX       ; PAGE 0
        MOV BL,COLOR

        MOVE_CURSOR X, Y

        CMP BP,0
        JE ZERO

        MOV AL,'1'
        INT 10H
        JMP EXIT

        ZERO:
                MOV AL,'0'
                INT 10H

        EXIT:
        ;================
        POP BP
        POP BX
        POP AX
ENDM DISPLAY_FLAG_VALUE
;===========================================================================================
; Function: PLAYER_1_UPDATE_REGISTERS_REPRESENTATION                                        |
; Type: Procedure                                                                           |
; TESTED:   TRUE                                                                            |
; Input:    NONE                                                                            |
; Output: <Action> = Reload the registers of player 1 with the new data                     |
; Description:                                                                              |
;                  Reload the registers of player 1 with the new data                       |
;===========================================================================================
PLAYER_1_UPDATE_REGISTERS_REPRESENTATION PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI

        MOV BL, LIGHT_WHITE ;Set color
        MOV DL, 60          ;Set X
        MOV DH, 7           ;Set Y
        MOV CX, 2           ;Print two bytes
    
        MOV SI, OFFSET PLAYER_1_SCORE_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 9
        MOV SI, OFFSET PLAYER_1_AX_VALUE
        CALL PRINT_NUM_TO_GRAPHICS
        
        MOV DH, 11
        MOV SI, OFFSET PLAYER_1_BX_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 13
        MOV SI, OFFSET PLAYER_1_CX_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 15
        MOV SI, OFFSET PLAYER_1_DX_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 17
        MOV SI, OFFSET PLAYER_1_DI_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 19
        MOV SI, OFFSET PLAYER_1_SI_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 21
        MOV SI, OFFSET PLAYER_1_BP_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 23
        MOV SI, OFFSET PLAYER_1_SP_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 25
        MOV SI, OFFSET PLAYER_1_TIMER_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        POP SI
        POP DX
        POP CX
        POP BX
        POP AX 
        RET
PLAYER_1_UPDATE_REGISTERS_REPRESENTATION ENDP    
;===========================================================================================
; Function: PLAYER_1_UPDATE_MEMORY_REPRESENTATION                                           |
; Type: Procedure                                                                           |
; TESTED:   TRUE                                                                            |
; Input:    NONE                                                                            |
; Output: <Action> = Reload the memory of the player 1 with the new data                    |
; Description:                                                                              |
;                  Reload the memory of the player 1 with the new data                      |
;===========================================================================================
PLAYER_1_UPDATE_MEMORY_REPRESENTATION    PROC
        PUSH BP
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI

        MOV BL, LIGHT_WHITE ;Set color
        MOV DL, 77          ;Set X
        MOV DH, 7           ;Set Y
        MOV CX, 1           ;Print one byte

        MOV SI, OFFSET PLAYER_1_MEM_0_VALUE
        MOV BP, 8           ;Loop counter
        @@COL1:
            CALL PRINT_NUM_TO_GRAPHICS 
            INC SI
            ADD DH, 2
            DEC BP
        JNZ @@COL1

        MOV DL, 93
        MOV DH, 7
        MOV SI, OFFSET PLAYER_1_MEM_8_VALUE
        MOV BP, 8           ;Loop counter
        @@COL2:
            CALL PRINT_NUM_TO_GRAPHICS 
            INC SI
            ADD DH, 2
            DEC BP
        JNZ @@COL2
        
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        POP BP
        RET
ENDP    PLAYER_1_UPDATE_MEMORY_REPRESENTATION
;===========================================================================================
; Function: PLAYER_1_UPDATE_FLAGS_REPRESENTATION                                            |
; Type: Procedure                                                                           |
; TESTED:   TRUE                                                                            |
; Input:    NONE                                                                            |
; Output: <Action> = Reload the flags of the player 1 with the new data                     |
; Description:                                                                              |
;                  Reload the flags of the player 1 with the new data                       |
;===========================================================================================
PLAYER_1_UPDATE_FLAGS_REPRESENTATION    PROC
        MOV BX, 0000000000000001B ;CF
        AND BX, P1_FLAGS 
        DISPLAY_FLAG_VALUE  78, 23, BX, BLUE

        MOV BX, 0000000001000000B ;ZF
        AND BX, P1_FLAGS 
        DISPLAY_FLAG_VALUE  78, 25, BX, BLUE

        MOV BX, 0000000010000000B ;SF
        AND BX, P1_FLAGS 
        DISPLAY_FLAG_VALUE  94, 23, BX, BLUE

        MOV BX, 0000100000000000B ;OF
        AND BX, P1_FLAGS 
        DISPLAY_FLAG_VALUE  94, 25, BX, BLUE
        RET
ENDP    PLAYER_1_UPDATE_FLAGS_REPRESENTATION
;===========================================================================================
; Function: PLAYER_1_UPDATE_BIRD_SCORE                                                      |
; Type: Procedure                                                                           |
; TESTED:   TRUE                                                                            |
; Input:    NONE                                                                            |
; Output: <Action> = Reload the bird scores of the player 1 with the new data               |
; Description:                                                                              |
;                  Reload the bird scores of the player 1 with the new data                 |
;===========================================================================================
PLAYER_1_UPDATE_BIRD_SCORE      PROC
        PRINT_1_DIGIT_GRAPHICS 55+0, 32, BLUE, HIT_P1_1
        PRINT_1_DIGIT_GRAPHICS 55+10, 32, GREEN, HIT_P1_2
        PRINT_1_DIGIT_GRAPHICS 55+20, 32, LIGHT_YELLOW, HIT_P1_3
        PRINT_1_DIGIT_GRAPHICS 55+30, 32, RED, HIT_P1_4
        PRINT_1_DIGIT_GRAPHICS 55+40, 32, LIGHT_WHITE, HIT_P1_5
        RET
ENDP    PLAYER_1_UPDATE_BIRD_SCORE
;===========================================================================================
; Function: DRAW_PLAYER_1                                                                   |
; Type: Procedure                                                                           |
; TESTED:   TRUE                                                                            |
; Input:    NONE                                                                            |
; Output: <Action> = Draw all the body of player 1 (Regs + flags + memory + bird scores     |
;                       + commands)                                                         |
; Description:                                                                              |
;                  Draw all the body of player 1 (Regs + flags + memory + bird scores       |
;                       + commands)                                                         |
;===========================================================================================
DRAW_PLAYER_1 PROC
        ; Draw Power Ups
        DRAW_BOX 407, 500, 325, 45, BLACK

        ; Draw Command Box
        DRAW_BOX 407, 450, 325, 45, BLACK
        PRINT_STRING 53, 29, NAME_1, GREEN
        MOV PLAYER_1_CMD_X_LOCATION, 54
        MOV BL, P1_USERNAME_SIZE
        ADD PLAYER_1_CMD_X_LOCATION, BL


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
;===========================================================================================
; Function: PLAYER_2_UPDATE_REGISTERS_REPRESENTATION                                        |
; Type: Procedure                                                                           |
; TESTED:   TRUE                                                                            |
; Input:    NONE                                                                            |
; Output: <Action> = Reload the registers of player 2 with the new data                     |
; Description:                                                                              |
;                  Reload the registers of player 2 with the new data                       |
;===========================================================================================
PLAYER_2_UPDATE_REGISTERS_REPRESENTATION    PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI

        MOV BL, LIGHT_WHITE ;Set color
        MOV DL, 10          ;Set X
        MOV DH, 7           ;Set Y
        MOV CX, 2           ;Print two bytes
    
        MOV SI, OFFSET PLAYER_2_SCORE_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 9
        MOV SI, OFFSET PLAYER_2_AX_VALUE
        CALL PRINT_NUM_TO_GRAPHICS
        
        MOV DH, 11
        MOV SI, OFFSET PLAYER_2_BX_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 13
        MOV SI, OFFSET PLAYER_2_CX_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 15
        MOV SI, OFFSET PLAYER_2_DX_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 17
        MOV SI, OFFSET PLAYER_2_DI_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 19
        MOV SI, OFFSET PLAYER_2_SI_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 21
        MOV SI, OFFSET PLAYER_2_BP_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 23
        MOV SI, OFFSET PLAYER_2_SP_VALUE
        CALL PRINT_NUM_TO_GRAPHICS

        MOV DH, 25
        MOV SI, OFFSET PLAYER_2_TIMER_VALUE
        CALL PRINT_NUM_TO_GRAPHICS
        
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
ENDP    PLAYER_2_UPDATE_REGISTERS_REPRESENTATION
;===========================================================================================
; Function: PLAYER_2_UPDATE_MEMORY_REPRESENTATION                                           |
; Type: Procedure                                                                           |
; TESTED:   TRUE                                                                            |
; Input:    NONE                                                                            |
; Output: <Action> = Reload the memory of the player 2 with the new data                    |
; Description:                                                                              |
;                  Reload the memory of the player 2 with the new data                      |
;===========================================================================================
PLAYER_2_UPDATE_MEMORY_REPRESENTATION    PROC
        PUSH BP
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI

        MOV BL, LIGHT_WHITE ;Set color
        MOV DL, 28          ;Set X
        MOV DH, 7           ;Set Y
        MOV CX, 1           ;Print one byte

        MOV SI, OFFSET PLAYER_2_MEM_0_VALUE
        MOV BP, 8           ;Loop counter
        @@COL1:
            CALL PRINT_NUM_TO_GRAPHICS 
            INC SI
            ADD DH, 2
            DEC BP
        JNZ @@COL1

        MOV DL, 44
        MOV DH, 7
        MOV SI, OFFSET PLAYER_2_MEM_8_VALUE
        MOV BP, 8           ;Loop counter
        @@COL2:
            CALL PRINT_NUM_TO_GRAPHICS 
            INC SI
            ADD DH, 2
            DEC BP
        JNZ @@COL2

        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        POP BP
        RET
ENDP    PLAYER_2_UPDATE_MEMORY_REPRESENTATION
;===========================================================================================
; Function: PLAYER_2_UPDATE_FLAGS_REPRESENTATION                                            |
; Type: Procedure                                                                           |
; TESTED:   TRUE                                                                            |
; Input:    NONE                                                                            |
; Output: <Action> = Reload the flags of the player 2 with the new data                     |
; Description:                                                                              |
;                  Reload the flags of the player 2 with the new data                       |
;===========================================================================================
PLAYER_2_UPDATE_FLAGS_REPRESENTATION    PROC
        MOV BX, 0000000000000001B ;CF
        AND BX, P2_FLAGS 
        DISPLAY_FLAG_VALUE  28, 23, BX, BLUE

        MOV BX, 0000000001000000B ;ZF
        AND BX, P2_FLAGS 
        DISPLAY_FLAG_VALUE  28, 25, BX, BLUE

        MOV BX, 0000000010000000B ;SF
        AND BX, P2_FLAGS 
        DISPLAY_FLAG_VALUE  44, 23, BX, BLUE

        MOV BX, 0000100000000000B ;OF
        AND BX, P2_FLAGS 
        DISPLAY_FLAG_VALUE  44, 25, BX, BLUE
        RET
ENDP    PLAYER_2_UPDATE_FLAGS_REPRESENTATION
;===========================================================================================
; Function: PLAYER_2_UPDATE_BIRD_SCORE                                                      |
; Type: Procedure                                                                           |
; TESTED:   TRUE                                                                            |
; Input:    NONE                                                                            |
; Output: <Action> = Reload the bird scores of the player 2 with the new data               |
; Description:                                                                              |
;                  Reload the bird scores of the player 2 with the new data                 |
;===========================================================================================
PLAYER_2_UPDATE_BIRD_SCORE      PROC
        PRINT_1_DIGIT_GRAPHICS 5+0, 32, BLUE, HIT_P2_1
        PRINT_1_DIGIT_GRAPHICS 5+10, 32, GREEN, HIT_P2_2
        PRINT_1_DIGIT_GRAPHICS 5+20, 32, LIGHT_YELLOW, HIT_P2_3
        PRINT_1_DIGIT_GRAPHICS 5+30, 32, RED, HIT_P2_4
        PRINT_1_DIGIT_GRAPHICS 5+40, 32, LIGHT_WHITE, HIT_P2_5
        RET
ENDP    PLAYER_2_UPDATE_BIRD_SCORE
;===========================================================================================
; Function: DRAW_PLAYER_2                                                                   |
; Type: Procedure                                                                           |
; TESTED:   TRUE                                                                            |
; Input:    NONE                                                                            |
; Output: <Action> = Draw all the body of player 2 (Regs + flags + memory + bird scores     |
;                       + commands)                                                         |
; Description:                                                                              |
;                  Draw all the body of player 2 (Regs + flags + memory + bird scores       |
;                       + commands)                                                         |
;===========================================================================================
DRAW_PLAYER_2 PROC
        ; Draw Power Ups
        DRAW_BOX 10, 500, 325, 45, BLACK

        ; Draw Command Box
        DRAW_BOX 10, 450, 325, 45, BLACK
        PRINT_STRING 4, 29, NAME_2, GREEN
        MOV PLAYER_2_CMD_X_LOCATION, 5
        MOV BL, P2_USERNAME_SIZE
        ADD PLAYER_2_CMD_X_LOCATION, BL

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
DRAW_PLAYER_2 ENDP    

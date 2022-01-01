        .MODEL SMALL
        .STACK 64
        .DATA
        ;DEFINE YOUR DATA HERE
;===========================================
STR_TEMP              DB      ?,?,?,?
;===========================================
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
;===========================================
PLAYER_1_SCORE_LABEL           DB      'Score', '$'
PLAYER_1_AX_REG_LABEL          DB      'AX', '$'
PLAYER_1_BX_REG_LABEL          DB      'BX', '$'
PLAYER_1_CX_REG_LABEL          DB      'CX', '$'
PLAYER_1_DX_REG_LABEL          DB      'DX', '$'
PLAYER_1_DI_REG_LABEL          DB      'DI', '$'
PLAYER_1_SI_REG_LABEL          DB      'SI', '$'
PLAYER_1_BP_REG_LABEL          DB      'BP', '$'
PLAYER_1_SP_REG_LABEL          DB      'SP', '$'
PLAYER_1_TIMER_LABEL           DB      'TIME', '$'
;===========================================
PLAYER_1_MEM_0_LABEL           DB       '0x0', '$'
PLAYER_1_MEM_1_LABEL           DB       '0x1', '$'
PLAYER_1_MEM_2_LABEL           DB       '0x2', '$'
PLAYER_1_MEM_3_LABEL           DB       '0x3', '$'
PLAYER_1_MEM_4_LABEL           DB       '0x4', '$'
PLAYER_1_MEM_5_LABEL           DB       '0x5', '$'
PLAYER_1_MEM_6_LABEL           DB       '0x6', '$'
PLAYER_1_MEM_7_LABEL           DB       '0x7', '$'
PLAYER_1_MEM_8_LABEL           DB       '0x8', '$'
PLAYER_1_MEM_9_LABEL           DB       '0x9', '$'
PLAYER_1_MEM_A_LABEL           DB       '0xA', '$'
PLAYER_1_MEM_B_LABEL           DB       '0xB', '$'
PLAYER_1_MEM_C_LABEL           DB       '0xC', '$'
PLAYER_1_MEM_D_LABEL           DB       '0xD', '$'
PLAYER_1_MEM_E_LABEL           DB       '0xE', '$'
PLAYER_1_MEM_F_LABEL           DB       '0xF', '$'
;===========================================
PLAYER_1_C_FLAG_LABEL          DB       'CF: ', '$'
PLAYER_1_Z_FLAG_LABEL          DB       'ZF: ', '$'
PLAYER_1_S_FLAG_LABEL          DB       'SF: ', '$'
PLAYER_1_O_FLAG_LABEL          DB       'OF: ', '$'
;===========================================
NAME_1                DB      'Alaa: ', '$'
MESSAGE_1             DB      ' Have the project been finished?', '$'
NAME_2                DB      'Kamal: ', '$'
MESSAGE_2             DB      'Yeah! We did it, Alaa!!!', '$'
;===========================================
PLAYER_1_SCORE_VALUE           DW      0000
PLAYER_1_AX_VALUE              DW      0000
PLAYER_1_BX_VALUE              DW      0000
PLAYER_1_CX_VALUE              DW      0000
PLAYER_1_DX_VALUE              DW      0000
PLAYER_1_DI_VALUE              DW      0000
PLAYER_1_SI_VALUE              DW      0000
PLAYER_1_BP_VALUE              DW      0000
PLAYER_1_SP_VALUE              DW      0000
PLAYER_1_TIMER_VALUE           DW      0000
;===========================================
PLAYER_1_MEM_0_VALUE           DW       0000
PLAYER_1_MEM_1_VALUE           DW       0000
PLAYER_1_MEM_2_VALUE           DW       0000
PLAYER_1_MEM_3_VALUE           DW       0000
PLAYER_1_MEM_4_VALUE           DW       0000
PLAYER_1_MEM_5_VALUE           DW       0000
PLAYER_1_MEM_6_VALUE           DW       0000
PLAYER_1_MEM_7_VALUE           DW       0000
PLAYER_1_MEM_8_VALUE           DW       0000
PLAYER_1_MEM_9_VALUE           DW       0000
PLAYER_1_MEM_A_VALUE           DW       0000
PLAYER_1_MEM_B_VALUE           DW       0000
PLAYER_1_MEM_C_VALUE           DW       0000
PLAYER_1_MEM_D_VALUE           DW       0000
PLAYER_1_MEM_E_VALUE           DW       0000
PLAYER_1_MEM_F_VALUE           DW       0000
;===========================================
PLAYER_1_C_FLAG_VALUE          DB       0
PLAYER_1_Z_FLAG_VALUE          DB       1
PLAYER_1_S_FLAG_VALUE          DB       1
PLAYER_1_O_FLAG_VALUE          DB       0
;===========================================
PLAYER_2_SCORE_LABEL           DB      'Score', '$'
PLAYER_2_AX_REG_LABEL          DB      'AX', '$'
PLAYER_2_BX_REG_LABEL          DB      'BX', '$'
PLAYER_2_CX_REG_LABEL          DB      'CX', '$'
PLAYER_2_DX_REG_LABEL          DB      'DX', '$'
PLAYER_2_DI_REG_LABEL          DB      'DI', '$'
PLAYER_2_SI_REG_LABEL          DB      'SI', '$'
PLAYER_2_BP_REG_LABEL          DB      'BP', '$'
PLAYER_2_SP_REG_LABEL          DB      'SP', '$'
PLAYER_2_TIMER_LABEL           DB      'TIME', '$'
;===========================================
PLAYER_2_MEM_0_LABEL           DB       '0x0', '$'
PLAYER_2_MEM_1_LABEL           DB       '0x1', '$'
PLAYER_2_MEM_2_LABEL           DB       '0x2', '$'
PLAYER_2_MEM_3_LABEL           DB       '0x3', '$'
PLAYER_2_MEM_4_LABEL           DB       '0x4', '$'
PLAYER_2_MEM_5_LABEL           DB       '0x5', '$'
PLAYER_2_MEM_6_LABEL           DB       '0x6', '$'
PLAYER_2_MEM_7_LABEL           DB       '0x7', '$'
PLAYER_2_MEM_8_LABEL           DB       '0x8', '$'
PLAYER_2_MEM_9_LABEL           DB       '0x9', '$'
PLAYER_2_MEM_A_LABEL           DB       '0xA', '$'
PLAYER_2_MEM_B_LABEL           DB       '0xB', '$'
PLAYER_2_MEM_C_LABEL           DB       '0xC', '$'
PLAYER_2_MEM_D_LABEL           DB       '0xD', '$'
PLAYER_2_MEM_E_LABEL           DB       '0xE', '$'
PLAYER_2_MEM_F_LABEL           DB       '0xF', '$'
;===========================================
PLAYER_2_C_FLAG_LABEL          DB       'CF: ', '$'
PLAYER_2_Z_FLAG_LABEL          DB       'ZF: ', '$'
PLAYER_2_S_FLAG_LABEL          DB       'SF: ', '$'
PLAYER_2_O_FLAG_LABEL          DB       'OF: ', '$'
;===========================================
PLAYER_2_SCORE_VALUE           DW      0000
PLAYER_2_AX_VALUE              DW      0000
PLAYER_2_BX_VALUE              DW      0000
PLAYER_2_CX_VALUE              DW      0000
PLAYER_2_DX_VALUE              DW      0000
PLAYER_2_DI_VALUE              DW      0000
PLAYER_2_SI_VALUE              DW      0000
PLAYER_2_BP_VALUE              DW      0000
PLAYER_2_SP_VALUE              DW      0000
PLAYER_2_TIMER_VALUE           DW      0000
;===========================================
PLAYER_2_MEM_0_VALUE           DW       0000
PLAYER_2_MEM_1_VALUE           DW       0000
PLAYER_2_MEM_2_VALUE           DW       0000
PLAYER_2_MEM_3_VALUE           DW       0000
PLAYER_2_MEM_4_VALUE           DW       0000
PLAYER_2_MEM_5_VALUE           DW       0000
PLAYER_2_MEM_6_VALUE           DW       0000
PLAYER_2_MEM_7_VALUE           DW       0000
PLAYER_2_MEM_8_VALUE           DW       0000
PLAYER_2_MEM_9_VALUE           DW       0000
PLAYER_2_MEM_A_VALUE           DW       0000
PLAYER_2_MEM_B_VALUE           DW       0000
PLAYER_2_MEM_C_VALUE           DW       0000
PLAYER_2_MEM_D_VALUE           DW       0000
PLAYER_2_MEM_E_VALUE           DW       0000
PLAYER_2_MEM_F_VALUE           DW       0000
;===========================================
PLAYER_2_C_FLAG_VALUE          DB       0
PLAYER_2_Z_FLAG_VALUE          DB       1
PLAYER_2_S_FLAG_VALUE          DB       1
PLAYER_2_O_FLAG_VALUE          DB       0
;===========================================
        .CODE
;===================================================================
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
;===================================================================
MAIN    PROC    FAR
        MOV AX,@DATA
        MOV DS,AX
        ;==================
        ;SET GRAPHCIS MODE [800x600 - 256 Colors] ~~ [600V x 736H - 256 Colors]
        MOV AX,4F02H
        MOV BX,103H
        INT 10H
        ;==================
        ; Draw Screen borders
        DRAW_BACKGROUND LIGHT_WHITE
        DRAW_LINE_V 400, 0, 550, RED
        DRAW_LINE_H 0, 550, 736, RED
        ;==================
        CALL DRAW_PLAYER_1
        CALL DRAW_PLAYER_2
        ;==================
        ;Chat Box
        PRINT_STRING 1,35, NAME_1, RED
        PRINT_STRING 7,35, MESSAGE_1, LIGHT_WHITE

        PRINT_STRING 1,36, NAME_2, RED
        PRINT_STRING 8,36, MESSAGE_2, LIGHT_WHITE
        ;==================
        MOV BP,0
        UPDATE_TIMER:
                        MOV DX,BP
                        AND DX,0080H
                        SHR DX,7
                        MOV PLAYER_1_Z_FLAG_VALUE,DL
                        MOV PLAYER_1_TIMER_VALUE,BP
                        MOV PLAYER_2_Z_FLAG_VALUE,DL
                        MOV PLAYER_2_TIMER_VALUE,BP
                        CALL PLAYER_1_UPDATE_REGISTERS_REPRESENTATION
                        CALL PLAYER_1_UPDATE_FLAGS_REPRESENTATION
                        CALL PLAYER_2_UPDATE_REGISTERS_REPRESENTATION
                        CALL PLAYER_2_UPDATE_FLAGS_REPRESENTATION
                        INC BP
                        MOV CX,0FFFFH
                        DELAY:
                                LOOP DELAY
                        CMP BP,0FFFFH
                        JNZ UPDATE_TIMER
MAIN    ENDP
        END     MAIN
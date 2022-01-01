        LOCALS @@
        .MODEL SMALL
        .STACK 64
        .DATA
        ;DEFINE YOUR DATA HERE
;===========================================
STR_TEMP        DB      ?,?,?,?
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
PLAYER_2_C_FLAG_VALUE          DW       0
PLAYER_2_Z_FLAG_VALUE          DW       1
PLAYER_2_S_FLAG_VALUE          DW       1
PLAYER_2_O_FLAG_VALUE          DW       0
;===========================================
X_START                        DW       0000
Y_START                        DW       0000
L                              DW       0000
W                              DW       0000
COLOR                          DB       00
NUMBER                         DW       0000
STRING_PTR                     DB       ?,?,?,?              
;===========================================
        .CODE
;===================================================================
SET_SHARED_RESOURCES    PROC    ; AX, BX, CX, DX, DI, SI, BP
        MOV X_START,AX
        MOV Y_START,BX
        MOV L,CX
        MOV W,DX
        MOV AX,DI
        MOV COLOR,AL
        MOV NUMBER,SI
        MOV AX,BP
        MOV STRING_PTR,AL
        RET
ENDP    SET_SHARED_RESOURCES
;===================================================================
SET_REGS        MACRO   PRAM1, PRAM2, PRAM3, PRAM4, PRAM5, PRAM6, PRAM7
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI
        PUSH BP
        ;==========================
        MOV AX, PRAM1
        MOV BX, PRAM2
        MOV CX, PRAM3
        MOV DX, PRAM4
        MOV DI, WORD PTR PRAM5
        AND DI, 00FFH
        MOV SI, PRAM6
        MOV BP, WORD PTR PRAM7
        AND BP, 00FFH
        CALL SET_SHARED_RESOURCES
        ;==========================
        POP BP
        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
ENDM    SET_REGS
;===================================================================
CLEAR_SHARED_RESOURCES    PROC    ; AX, BX, CX, DX, DI, SI, BP
        SET_REGS 0, 0, 0, 0, 0, 0, 0
        RET
ENDP    CLEAR_SHARED_RESOURCES
;===================================================================
DRAW_BACKGROUND PROC    ; COLOR
        LOCAL OUTER,INNER
        PUSH CX
        PUSH DX
        PUSH BX
        PUSH AX
        ;==========================
        MOV DX,0
        MOV AL,COLOR
        MOV AH,0CH

        @@OUTER:
                MOV CX,0
        @@INNER:
                INT 10h
                INC CX
                CMP CX,800
                JNE @@INNER
                INC DX
                CMP DX,600
                JNE @@OUTER
        ;==========================
        CALL CLEAR_SHARED_RESOURCES
        POP AX
        POP BX
        POP DX
        POP CX
        RET
ENDP DRAW_BACKGROUND 
;===================================================================
;EXAMPLE:   DRAW_LINE_V 320, 0, 400, RED -> Draw full vertical line.
DRAW_LINE_V   PROC ; X, Y, L, COLOR
        PUSH AX
        PUSH CX
        PUSH DX
        PUSH DI
        ;==========================
        MOV AH,0CH
        MOV AL,COLOR
        MOV CX,X_START
        MOV DX,Y_START
        MOV DI,0
        ADD DI,DX
        ADD DI,L
        @@LINE:
                INT 10H
                INC DX
                CMP DX,DI
                JNZ @@LINE
        ;==========================
        CALL CLEAR_SHARED_RESOURCES
        POP DI
        POP DX
        POP CX
        POP AX
        RET
ENDP    DRAW_LINE_V
;===================================================================
;EXAMPLE:   DRAW_LINE_H 0, 640, 200, GREEN -> Draw full horizontal line.
DRAW_LINE_H   PROC ; X, Y, L, COLOR
        PUSH AX
        PUSH CX
        PUSH DX
        PUSH DI
        ;==========================
        MOV AH,0CH
        MOV AL,COLOR
        MOV CX,X_START
        MOV DX,Y_START
        ADD DI,CX
        ADD DI,L
        @@LINE:
                INT 10H
                INC CX
                CMP CX,DI
                JNZ @@LINE
        ;==========================
        CALL CLEAR_SHARED_RESOURCES
        POP DI
        POP DX
        POP CX
        POP AX
        RET
ENDP    DRAW_LINE_H
;===================================================================
MOVE_CURSOR     PROC ; X, Y
        PUSH AX
        PUSH DX
        PUSH DI
        ;================
        MOV AH,02H

        MOV DL,BYTE PTR X_START
        MOV DH,BYTE PTR Y_START

        INT 10H
        ;================
        CALL CLEAR_SHARED_RESOURCES
        POP DI
        POP DX
        POP AX
        RET
ENDP    MOVE_CURSOR 
;=================================================
PRINT_STRING    PROC   ; X, Y, STR, COLOR
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DI
        ;================
        LEA DI,STR_TEMP

        MOV AH,0EH
        XOR BX,BX       ; PAGE 0
        MOV BL,COLOR
        SET_REGS X_START, Y_START, 0, 0, 0, 0, 0
        CALL MOVE_CURSOR ; X, Y

        MOV CX,0
        MOV CL,'$'
        @@REPEAT:
                MOV AL,[DI]
                INC DI
                INT 10H
                CMP [DI],CL
                JNZ @@REPEAT
        ;================
        CALL CLEAR_SHARED_RESOURCES
        POP DI
        POP CX
        POP BX
        POP AX
        RET
ENDP    PRINT_STRING
;===================================================================
DRAW_BOX   PROC   ; X_START, Y_START, L, W, COLOR
        PUSH AX
        PUSH SI
        ;==========================
        MOV SI,Y_START
        MOV AX,Y_START
        ADD AX,W
        @@REPEAT:
                SET_REGS X_START, SI, L, 0, COLOR, 0, 0
                CALL DRAW_LINE_H ; X_START, SI, L, COLOR
                INC SI
                CMP SI,AX
                JNZ @@REPEAT
        ;==========================
        CALL CLEAR_SHARED_RESOURCES
        POP SI
        POP AX
        RET
ENDP    DRAW_BOX
;===================================================================
CONVERT_4_DIGITS_TO_STRING    PROC   ; NUMBER, STRING_PTR
        PUSH AX
        PUSH BX
        PUSH DX
        PUSH DI
        ;================
        MOV AX,NUMBER

        LEA DI,STRING_PTR
        ADD DI,3

        MOV CX,4
        @@REPEAT:
                MOV DX,0

                MOV BX,10
                DIV BX

                ADD DX,'0'

                MOV [DI],DL
                DEC DI
                LOOP @@REPEAT
        ;================
        CALL CLEAR_SHARED_RESOURCES
        POP DI
        POP DX
        POP BX
        POP AX
        RET
ENDP    CONVERT_4_DIGITS_TO_STRING
;===================================================================
PRINT_4_DIGIT_GRAPHICS  PROC   ; X, Y, NUMBER, COLOR
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DI
        ;================
        SET_REGS 0, 0, 0, 0, 0, NUMBER, STR_TEMP
        CALL CONVERT_4_DIGITS_TO_STRING ; NUMBER, STR_TEMP
        LEA DI,STR_TEMP

        MOV AH,0EH
        XOR BX,BX       ; PAGE 0
        MOV BL,COLOR

        SET_REGS X_START, Y_START, 0, 0, 0, 0, 0
        CALL MOVE_CURSOR ; X, Y

        MOV CX,4
        @@REPEAT:
                MOV AL,[DI]
                INC DI
                INT 10H
                LOOP @@REPEAT
        ;================
        CALL CLEAR_SHARED_RESOURCES
        POP DI
        POP CX
        POP BX
        POP AX
        RET
ENDP    PRINT_4_DIGIT_GRAPHICS
;===================================================================
DISPLAY_FLAG_VALUE  PROC   ; X, Y, FLAG, COLOR
        PUSH AX
        PUSH BX
        PUSH DX
        ;================
        MOV DX,NUMBER
        AND DX,00FFH

        MOV AH,0EH
        XOR BX,BX       ; PAGE 0
        MOV BL,COLOR

        SET_REGS X_START, Y_START, 0, 0, 0, 0, 0
        CALL MOVE_CURSOR ; X, Y

        CMP DL,0
        JZ @@ZERO

        MOV AL,'1'
        INT 10H
        JMP @@EXIT

        @@ZERO:
                MOV AL,'0'
                INT 10H

        @@EXIT:
        ;================
        CALL CLEAR_SHARED_RESOURCES
        POP DX
        POP BX
        POP AX
        RET
ENDP DISPLAY_FLAG_VALUE
;===================================================================
PLAYER_1_UPDATE_REGISTERS_REPRESENTATION    PROC
        SET_REGS 60, 7, 0, 0, LIGHT_WHITE, PLAYER_1_SCORE_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 60, 7, PLAYER_1_SCORE_VALUE, LIGHT_WHITE

        SET_REGS 60, 9, 0, 0, LIGHT_WHITE, PLAYER_1_AX_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 60, 9, PLAYER_1_AX_VALUE, LIGHT_WHITE

        SET_REGS 60, 11, 0, 0, LIGHT_WHITE, PLAYER_1_BX_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 60, 11, PLAYER_1_BX_VALUE, LIGHT_WHITE

        SET_REGS 60, 13, 0, 0, LIGHT_WHITE, PLAYER_1_CX_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 60, 13, PLAYER_1_CX_VALUE, LIGHT_WHITE

        SET_REGS 60, 15, 0, 0, LIGHT_WHITE, PLAYER_1_DX_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 60, 15, PLAYER_1_DX_VALUE, LIGHT_WHITE

        SET_REGS 60, 17, 0, 0, LIGHT_WHITE, PLAYER_1_DI_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 60, 17, PLAYER_1_DI_VALUE, LIGHT_WHITE

        SET_REGS 60, 19, 0, 0, LIGHT_WHITE, PLAYER_1_SI_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 60, 19, PLAYER_1_SI_VALUE, LIGHT_WHITE

        SET_REGS 60, 21, 0, 0, LIGHT_WHITE, PLAYER_1_BP_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 60, 21, PLAYER_1_BP_VALUE, LIGHT_WHITE

        SET_REGS 60, 23, 0, 0, LIGHT_WHITE, PLAYER_1_SP_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 60, 23, PLAYER_1_SP_VALUE, LIGHT_WHITE

        SET_REGS 60, 25, 0, 0, LIGHT_WHITE, PLAYER_1_TIMER_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 60, 25, PLAYER_1_TIMER_VALUE, LIGHT_WHITE
        ;================
        CALL CLEAR_SHARED_RESOURCES
        RET
ENDP    PLAYER_1_UPDATE_REGISTERS_REPRESENTATION
;===================================================================
PLAYER_1_UPDATE_MEMORY_REPRESENTATION    PROC
        SET_REGS 77, 7, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_0_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 77, 7, PLAYER_1_MEM_0_VALUE, LIGHT_WHITE

        SET_REGS 77, 9, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_1_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 77, 9, PLAYER_1_MEM_1_VALUE, LIGHT_WHITE

        SET_REGS 77, 11, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_2_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 77, 11, PLAYER_1_MEM_2_VALUE, LIGHT_WHITE

        SET_REGS 77, 13, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_3_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 77, 13, PLAYER_1_MEM_3_VALUE, LIGHT_WHITE

        SET_REGS 77, 15, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_4_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 77, 15, PLAYER_1_MEM_4_VALUE, LIGHT_WHITE

        SET_REGS 77, 17, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_5_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 77, 17, PLAYER_1_MEM_5_VALUE, LIGHT_WHITE

        SET_REGS 77, 19, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_6_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 77, 19, PLAYER_1_MEM_6_VALUE, LIGHT_WHITE

        SET_REGS 77, 21, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_7_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 77, 21, PLAYER_1_MEM_7_VALUE, LIGHT_WHITE

        SET_REGS 93, 7, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_8_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 93, 7, PLAYER_1_MEM_8_VALUE, LIGHT_WHITE

        SET_REGS 93, 9, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_9_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 93, 9, PLAYER_1_MEM_9_VALUE, LIGHT_WHITE

        SET_REGS 93, 11, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_A_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 93, 11, PLAYER_1_MEM_A_VALUE, LIGHT_WHITE

        SET_REGS 93, 13, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_B_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 93, 13, PLAYER_1_MEM_B_VALUE, LIGHT_WHITE

        SET_REGS 93, 15, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_C_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 93, 15, PLAYER_1_MEM_C_VALUE, LIGHT_WHITE

        SET_REGS 93, 17, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_D_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 93, 17, PLAYER_1_MEM_D_VALUE, LIGHT_WHITE

        SET_REGS 93, 19, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_E_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 93, 19, PLAYER_1_MEM_E_VALUE, LIGHT_WHITE

        SET_REGS 93, 21, 0, 0, LIGHT_WHITE, PLAYER_1_MEM_F_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 93, 21, PLAYER_1_MEM_F_VALUE, LIGHT_WHITE
        ;================
        CALL CLEAR_SHARED_RESOURCES
        RET
ENDP    PLAYER_1_UPDATE_MEMORY_REPRESENTATION
;===================================================================
PLAYER_1_UPDATE_FLAGS_REPRESENTATION    PROC
        ;SET_REGS 78, 23, 0, 0, BLUE, PLAYER_1_C_FLAG_VALUE, 0
        CALL DISPLAY_FLAG_VALUE  ; 78, 23, PLAYER_1_C_FLAG_VALUE, BLUE

        ;SET_REGS 78, 25, 0, 0, BLUE, PLAYER_1_Z_FLAG_VALUE, 0
        CALL DISPLAY_FLAG_VALUE  ; 78, 25, PLAYER_1_Z_FLAG_VALUE, BLUE

        ;SET_REGS 94, 23, 0, 0, BLUE, PLAYER_1_S_FLAG_VALUE, 0
        CALL DISPLAY_FLAG_VALUE  ; 94, 23, PLAYER_1_S_FLAG_VALUE, BLUE

        ;SET_REGS 94, 25, 0, 0, BLUE, PLAYER_1_O_FLAG_VALUE, 0
        CALL DISPLAY_FLAG_VALUE  ; 94, 25, PLAYER_1_O_FLAG_VALUE, BLUE
        ;================
        CALL CLEAR_SHARED_RESOURCES
        RET
ENDP    PLAYER_1_UPDATE_FLAGS_REPRESENTATION
;===================================================================
DRAW_PLAYER_1 PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI
        PUSH BP
        ; Draw Power Ups
        SET_REGS 407, 500, 325, 45, BLACK, 0, 0
        CALL DRAW_BOX ; 407, 500, 325, 45, BLACK

        ; Draw Command Box
        SET_REGS 407, 450, 325, 45, BLACK, 0, 0
        CALL DRAW_BOX ; 407, 450, 325, 45, BLACK

        SET_REGS 53, 29, 0, 0, GREEN, 0, NAME_1
        CALL PRINT_STRING ; 53, 29, NAME_1, GREEN

        ; Draw Register box
        SET_REGS 407, 90, 60, 340, BLACK, 0, 0
        CALL DRAW_BOX ; 407, 90, 60, 340, BLACK

        ; Draw Memory and Flags box 1
        SET_REGS 540, 90, 60, 340, BLACK, 0, 0
        CALL DRAW_BOX ; 540, 90, 60, 340, BLACK

        ; Draw Memory and Flags box 2
        SET_REGS 670, 90, 60, 340, BLACK, 0, 0
        CALL DRAW_BOX ; 670, 90, 60, 340, BLACK

        MOV CX,8
        MOV BP,160
        MOV SI,0

        @@PLAYER_1_LINES:
                        MOV AX,3
                        @@PLAYER_1_THICKNESS_H:
                                                SET_REGS 407, BP, 320, 0, LIGHT_WHITE, 0, 0
                                                CALL DRAW_LINE_H ; 407, BP, 320, LIGHT_WHITE
                                                INC BP
                                                DEC AX
                                                JNZ @@PLAYER_1_THICKNESS_H
                        ADD BP,30
                        LOOP @@PLAYER_1_LINES

        MOV CX,3
        MOV BP,460
        ; Draw the white borders of register box
        @@PLAYER_1_THICKNESS_V_1_0:
                                SET_REGS BP, 90, 0, 340, LIGHT_WHITE, 0, 0
                                CALL DRAW_LINE_V ; BP, 90, 340, LIGHT_WHITE
                                INC BP
                                LOOP @@PLAYER_1_THICKNESS_V_1_0


        MOV CX,3
        MOV BP,590
        ; Draw the white borders of memory box1 - Part I
        @@PLAYER_1_THICKNESS_V_1_1:
                                SET_REGS BP, 90, 0, 340, LIGHT_WHITE, 0, 0
                                CALL DRAW_LINE_V ; BP, 90, 340, LIGHT_WHITE
                                INC BP
                                LOOP @@PLAYER_1_THICKNESS_V_1_1

        MOV CX,3
        MOV BP,720
        ; Draw the white borders of memory box1 - Part II
        @@PLAYER_1_THICKNESS_V_1_2:
                                SET_REGS BP, 90, 0, 340, LIGHT_WHITE, 0, 0
                                CALL DRAW_LINE_V ; BP, 90, 340, LIGHT_WHITE
                                INC BP
                                LOOP @@PLAYER_1_THICKNESS_V_1_2

        ; Draw score box
        SET_REGS 407, 135, 320, 0, LIGHT_WHITE, 0, 0
        CALL DRAW_LINE_H ; 407, 135, 320, LIGHT_WHITE

        SET_REGS 407, 136, 320, 0, LIGHT_WHITE, 0, 0
        CALL DRAW_LINE_H ; 407, 136, 320, LIGHT_WHITE

        SET_REGS 407, 137, 320, 0, LIGHT_WHITE, 0, 0
        CALL DRAW_LINE_H ; 407, 137, 320, LIGHT_WHITE

        SET_REGS 407, 87, 60, 0, RED, 0, 0
        CALL DRAW_LINE_H ; 407, 87, 60, RED

        SET_REGS 407, 88, 60, 0, RED, 0, 0
        CALL DRAW_LINE_H ; 407, 88, 60, RED

        SET_REGS 407, 89, 60, 0, RED, 0, 0
        CALL DRAW_LINE_H ; 407, 89, 60, RED

        SET_REGS 407, 132, 60, 0, RED, 0, 0
        CALL DRAW_LINE_H ; 407, 132, 60, RED

        SET_REGS 407, 133, 60, 0, RED, 0, 0
        CALL DRAW_LINE_H ; 407, 133, 60, RED

        SET_REGS 407, 134, 60, 0, RED, 0, 0
        CALL DRAW_LINE_H ; 407, 134, 60, RED

        SET_REGS 405, 87, 0, 48, RED, 0, 0
        CALL DRAW_LINE_V ; 405, 87, 48, RED

        SET_REGS 406, 87, 0, 48, RED, 0, 0
        CALL DRAW_LINE_V ; 406, 87, 48, RED

        SET_REGS 407, 87, 0, 48, RED, 0, 0
        CALL DRAW_LINE_V ; 407, 87, 48, RED

        SET_REGS 527, 87, 0, 48, RED, 0, 0
        CALL DRAW_LINE_V ; 527, 87, 48, RED

        SET_REGS 528, 87, 0, 48, RED, 0, 0
        CALL DRAW_LINE_V ; 528, 87, 48, RED

        SET_REGS 529, 87, 0, 48, RED, 0, 0
        CALL DRAW_LINE_V ; 529, 87, 48, RED

        ; Print the registers labels
        SET_REGS 52, 7, 0, 0, GREEN, 0, PLAYER_1_SCORE_LABEL
        CALL PRINT_STRING ; 52, 7, PLAYER_1_SCORE_LABEL, GREEN

        SET_REGS 53, 9, 0, 0, GREEN, 0, PLAYER_1_AX_REG_LABEL
        CALL PRINT_STRING ; 53, 9, PLAYER_1_AX_REG_LABEL, GREEN

        SET_REGS 53, 11, 0, 0, GREEN, 0, PLAYER_1_BX_REG_LABEL
        CALL PRINT_STRING ; 53, 11, PLAYER_1_BX_REG_LABEL, GREEN

        SET_REGS 53, 13, 0, 0, GREEN, 0, PLAYER_1_CX_REG_LABEL
        CALL PRINT_STRING ; 53, 13, PLAYER_1_CX_REG_LABEL, GREEN

        SET_REGS 53, 15, 0, 0, GREEN, 0, PLAYER_1_DX_REG_LABEL
        CALL PRINT_STRING ; 53, 15, PLAYER_1_DX_REG_LABEL, GREEN

        SET_REGS 53, 17, 0, 0, GREEN, 0, PLAYER_1_DI_REG_LABEL
        CALL PRINT_STRING ; 53, 17, PLAYER_1_DI_REG_LABEL, GREEN

        SET_REGS 53, 19, 0, 0, GREEN, 0, PLAYER_1_SI_REG_LABEL
        CALL PRINT_STRING ; 53, 19, PLAYER_1_SI_REG_LABEL, GREEN

        SET_REGS 53, 21, 0, 0, GREEN, 0, PLAYER_1_BP_REG_LABEL
        CALL PRINT_STRING ; 53, 21, PLAYER_1_BP_REG_LABEL, GREEN

        SET_REGS 53, 23, 0, 0, GREEN, 0, PLAYER_1_SP_REG_LABEL
        CALL PRINT_STRING ; 53, 23, PLAYER_1_SP_REG_LABEL, GREEN

        SET_REGS 52, 25, 0, 0, GREEN, 0, PLAYER_1_TIMER_LABEL
        CALL PRINT_STRING ; 52, 25, PLAYER_1_TIMER_LABEL, GREEN

        ; Print Memory labels - Part I
        SET_REGS 69, 7, 0, 0, GREEN, 0, PLAYER_1_MEM_0_LABEL
        CALL PRINT_STRING ; 69, 7, PLAYER_1_MEM_0_LABEL, GREEN

        SET_REGS 69, 9, 0, 0, GREEN, 0, PLAYER_1_MEM_1_LABEL
        CALL PRINT_STRING ; 69, 9, PLAYER_1_MEM_1_LABEL, GREEN

        SET_REGS 69, 11, 0, 0, GREEN, 0, PLAYER_1_MEM_2_LABEL
        CALL PRINT_STRING ; 69, 11, PLAYER_1_MEM_2_LABEL, GREEN

        SET_REGS 69, 13, 0, 0, GREEN, 0, PLAYER_1_MEM_3_LABEL
        CALL PRINT_STRING ; 69, 13, PLAYER_1_MEM_3_LABEL, GREEN

        SET_REGS 69, 15, 0, 0, GREEN, 0, PLAYER_1_MEM_4_LABEL
        CALL PRINT_STRING ; 69, 15, PLAYER_1_MEM_4_LABEL, GREEN

        SET_REGS 69, 17, 0, 0, GREEN, 0, PLAYER_1_MEM_5_LABEL
        CALL PRINT_STRING ; 69, 17, PLAYER_1_MEM_5_LABEL, GREEN

        SET_REGS 69, 19, 0, 0, GREEN, 0, PLAYER_1_MEM_6_LABEL
        CALL PRINT_STRING ; 69, 19, PLAYER_1_MEM_6_LABEL, GREEN

        SET_REGS 69, 21, 0, 0, GREEN, 0, PLAYER_1_MEM_7_LABEL
        CALL PRINT_STRING ; 69, 21, PLAYER_1_MEM_7_LABEL, GREEN

        SET_REGS 69, 23, 0, 0, BLUE, 0, PLAYER_1_C_FLAG_LABEL
        CALL PRINT_STRING ; 69, 23, PLAYER_1_C_FLAG_LABEL, BLUE

        SET_REGS 69, 25, 0, 0, BLUE, 0, PLAYER_1_Z_FLAG_LABEL
        CALL PRINT_STRING ; 69, 25, PLAYER_1_Z_FLAG_LABEL, BLUE

        ; Print Memory labels - Part II
        SET_REGS 85, 7, 0, 0, GREEN, 0, PLAYER_1_MEM_0_LABEL
        CALL PRINT_STRING ; 85, 7, PLAYER_1_MEM_8_LABEL, GREEN

        SET_REGS 85, 9, 0, 0, GREEN, 0, PLAYER_1_MEM_0_LABEL
        CALL PRINT_STRING ; 85, 9, PLAYER_1_MEM_9_LABEL, GREEN

        SET_REGS 85, 11, 0, 0, GREEN, 0, PLAYER_1_MEM_0_LABEL
        CALL PRINT_STRING ; 85, 11, PLAYER_1_MEM_A_LABEL, GREEN

        SET_REGS 85, 13, 0, 0, GREEN, 0, PLAYER_1_MEM_0_LABEL
        CALL PRINT_STRING ; 85, 13, PLAYER_1_MEM_B_LABEL, GREEN

        SET_REGS 85, 15, 0, 0, GREEN, 0, PLAYER_1_MEM_0_LABEL
        CALL PRINT_STRING ; 85, 15, PLAYER_1_MEM_C_LABEL, GREEN

        SET_REGS 85, 17, 0, 0, GREEN, 0, PLAYER_1_MEM_0_LABEL
        CALL PRINT_STRING ; 85, 17, PLAYER_1_MEM_D_LABEL, GREEN

        SET_REGS 85, 19, 0, 0, GREEN, 0, PLAYER_1_MEM_0_LABEL
        CALL PRINT_STRING ; 85, 19, PLAYER_1_MEM_E_LABEL, GREEN

        SET_REGS 85, 21, 0, 0, GREEN, 0, PLAYER_1_MEM_0_LABEL
        CALL PRINT_STRING ; 85, 21, PLAYER_1_MEM_F_LABEL, GREEN

        SET_REGS 85, 23, 0, 0, BLUE, 0, PLAYER_1_MEM_0_LABEL
        CALL PRINT_STRING ; 85, 23, PLAYER_1_S_FLAG_LABEL, BLUE

        SET_REGS 85, 25, 0, 0, BLUE, 0, PLAYER_1_MEM_0_LABEL
        CALL PRINT_STRING ; 85, 25, PLAYER_1_O_FLAG_LABEL, BLUE
        
        CALL PLAYER_1_UPDATE_REGISTERS_REPRESENTATION
        CALL PLAYER_1_UPDATE_MEMORY_REPRESENTATION
        CALL PLAYER_1_UPDATE_FLAGS_REPRESENTATION
        ;================
        CALL CLEAR_SHARED_RESOURCES
        POP BP
        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
ENDP    DRAW_PLAYER_1
;===================================================================
PLAYER_2_UPDATE_REGISTERS_REPRESENTATION    PROC
        SET_REGS 10, 7, 0, 0, LIGHT_WHITE, PLAYER_2_SCORE_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 10, 7, PLAYER_2_SCORE_VALUE, LIGHT_WHITE

        SET_REGS 10, 9, 0, 0, LIGHT_WHITE, PLAYER_2_AX_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 10, 9, PLAYER_2_AX_VALUE, LIGHT_WHITE

        SET_REGS 10, 11, 0, 0, LIGHT_WHITE, PLAYER_2_BX_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 10, 11, PLAYER_2_BX_VALUE, LIGHT_WHITE

        SET_REGS 10, 13, 0, 0, LIGHT_WHITE, PLAYER_2_CX_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 10, 13, PLAYER_2_CX_VALUE, LIGHT_WHITE

        SET_REGS 10, 15, 0, 0, LIGHT_WHITE, PLAYER_2_DX_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 10, 15, PLAYER_2_DX_VALUE, LIGHT_WHITE

        SET_REGS 10, 17, 0, 0, LIGHT_WHITE, PLAYER_2_DI_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 10, 17, PLAYER_2_DI_VALUE, LIGHT_WHITE

        SET_REGS 10, 19, 0, 0, LIGHT_WHITE, PLAYER_2_SI_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 10, 19, PLAYER_2_SI_VALUE, LIGHT_WHITE

        SET_REGS 10, 21, 0, 0, LIGHT_WHITE, PLAYER_2_BP_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 10, 21, PLAYER_2_BP_VALUE, LIGHT_WHITE

        SET_REGS 10, 23, 0, 0, LIGHT_WHITE, PLAYER_2_SP_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 10, 23, PLAYER_2_SP_VALUE, LIGHT_WHITE

        SET_REGS 10, 25, 0, 0, LIGHT_WHITE, PLAYER_2_TIMER_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 10, 25, PLAYER_2_TIMER_VALUE, LIGHT_WHITE
        ;================
        CALL CLEAR_SHARED_RESOURCES
        RET
ENDP    PLAYER_2_UPDATE_REGISTERS_REPRESENTATION
;===================================================================
PLAYER_2_UPDATE_MEMORY_REPRESENTATION    PROC
        SET_REGS 27, 7, 0, 0, LIGHT_WHITE, PLAYER_2_MEM_0_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 27, 7, PLAYER_2_MEM_0_VALUE, LIGHT_WHITE

        SET_REGS 27, 9, 0, 0, LIGHT_WHITE, PLAYER_2_MEM_1_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 27, 9, PLAYER_2_MEM_1_VALUE, LIGHT_WHITE

        SET_REGS 27, 11, 0, 0, LIGHT_WHITE, PLAYER_2_MEM_2_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 27, 11, PLAYER_2_MEM_2_VALUE, LIGHT_WHITE

        SET_REGS 27, 13, 0, 0, LIGHT_WHITE, PLAYER_2_MEM_3_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 27, 13, PLAYER_2_MEM_3_VALUE, LIGHT_WHITE

        SET_REGS 27, 15, 0, 0, LIGHT_WHITE, PLAYER_2_MEM_4_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 27, 15, PLAYER_2_MEM_4_VALUE, LIGHT_WHITE

        SET_REGS 27, 17, 0, 0, LIGHT_WHITE, PLAYER_2_SCORE_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 27, 17, PLAYER_2_MEM_5_VALUE, LIGHT_WHITE

        SET_REGS 27, 19, 0, 0, LIGHT_WHITE, PLAYER_2_SCORE_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 27, 19, PLAYER_2_MEM_6_VALUE, LIGHT_WHITE

        SET_REGS 27, 21, 0, 0, LIGHT_WHITE, PLAYER_2_SCORE_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 27, 21, PLAYER_2_MEM_7_VALUE, LIGHT_WHITE

        SET_REGS 43, 7, 0, 0, LIGHT_WHITE, PLAYER_2_SCORE_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 43, 7, PLAYER_2_MEM_8_VALUE, LIGHT_WHITE

        SET_REGS 43, 9, 0, 0, LIGHT_WHITE, PLAYER_2_SCORE_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 43, 9, PLAYER_2_MEM_9_VALUE, LIGHT_WHITE

        SET_REGS 43, 11, 0, 0, LIGHT_WHITE, PLAYER_2_SCORE_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 43, 11, PLAYER_2_MEM_A_VALUE, LIGHT_WHITE

        SET_REGS 43, 13, 0, 0, LIGHT_WHITE, PLAYER_2_SCORE_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 43, 13, PLAYER_2_MEM_B_VALUE, LIGHT_WHITE

        SET_REGS 43, 15, 0, 0, LIGHT_WHITE, PLAYER_2_SCORE_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 43, 15, PLAYER_2_MEM_C_VALUE, LIGHT_WHITE

        SET_REGS 43, 17, 0, 0, LIGHT_WHITE, PLAYER_2_SCORE_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 43, 17, PLAYER_2_MEM_D_VALUE, LIGHT_WHITE

        SET_REGS 43, 19, 0, 0, LIGHT_WHITE, PLAYER_2_SCORE_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 43, 19, PLAYER_2_MEM_E_VALUE, LIGHT_WHITE

        SET_REGS 43, 21, 0, 0, LIGHT_WHITE, PLAYER_2_SCORE_VALUE, 0
        CALL PRINT_4_DIGIT_GRAPHICS  ; 43, 21, PLAYER_2_MEM_F_VALUE, LIGHT_WHITE
        ;================
        CALL CLEAR_SHARED_RESOURCES
        RET
ENDP    PLAYER_2_UPDATE_MEMORY_REPRESENTATION
;===================================================================
PLAYER_2_UPDATE_FLAGS_REPRESENTATION    PROC
        CALL DISPLAY_FLAG_VALUE  ; 28, 23, PLAYER_2_C_FLAG_VALUE, BLUE
        CALL DISPLAY_FLAG_VALUE  ; 28, 25, PLAYER_2_Z_FLAG_VALUE, BLUE
        CALL DISPLAY_FLAG_VALUE  ; 44, 23, PLAYER_2_S_FLAG_VALUE, BLUE
        CALL DISPLAY_FLAG_VALUE  ; 44, 25, PLAYER_2_O_FLAG_VALUE, BLUE
        ;================
        CALL CLEAR_SHARED_RESOURCES
        RET
ENDP    PLAYER_2_UPDATE_FLAGS_REPRESENTATION
;===================================================================
DRAW_PLAYER_2 PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI
        PUSH BP
        ; Draw Power Ups
        SET_REGS 10, 500, 325, 45, BLACK, 0, 0
        CALL DRAW_BOX ; 10, 500, 325, 45, BLACK

        ; Draw Command Box
        SET_REGS 10, 450, 325, 45, BLACK, 0, 0
        CALL DRAW_BOX ; 10, 450, 325, 45, BLACK
        SET_REGS 4, 49, 0, 0, GREEN, 0, NAME_2
        CALL PRINT_STRING ; 4, 29, NAME_2, GREEN

        ; Draw Register box
        SET_REGS 10, 90, 60, 340, BLACK, 0, 0
        CALL DRAW_BOX ; 10, 90, 60, 340, BLACK

        ; Draw Memory and Flags box 1
        SET_REGS 143, 90, 60, 340, BLACK, 0, 0
        CALL DRAW_BOX ; 143, 90, 60, 340, BLACK

        ; Draw Memory and Flags box 2
        SET_REGS 273, 90, 60, 340, BLACK, 0, 0
        CALL DRAW_BOX ; 273, 90, 60, 340, BLACK

        MOV CX,8
        MOV BP,160
        MOV SI,0

        @@PLAYER_2_LINES:
                        MOV AX,3
                        @@PLAYER_2_THICKNESS_H:
                                                SET_REGS 10, BP, 320, 0, LIGHT_WHITE, 0, 0
                                                CALL DRAW_LINE_H ; 10, BP, 320, LIGHT_WHITE
                                                INC BP
                                                DEC AX
                                                JNZ @@PLAYER_2_THICKNESS_H
                        ADD BP,30
                        LOOP @@PLAYER_2_LINES

        MOV CX,3
        MOV BP,63
        ; Draw the white borders of register box
        @@PLAYER_2_THICKNESS_V_1_0:
                                SET_REGS BP, 90, 0, 340, LIGHT_WHITE, 0, 0
                                CALL DRAW_LINE_V ; BP, 90, 340, LIGHT_WHITE
                                INC BP
                                LOOP @@PLAYER_2_THICKNESS_V_1_0


        MOV CX,3
        MOV BP,193
        ; Draw the white borders of memory box1 - Part I
        @@PLAYER_2_THICKNESS_V_1_1:
                                SET_REGS BP, 90, 0, 340, LIGHT_WHITE, 0, 0
                                CALL DRAW_LINE_V ; BP, 90, 340, LIGHT_WHITE
                                INC BP
                                LOOP @@PLAYER_2_THICKNESS_V_1_1

        MOV CX,3
        MOV BP,323
        ; Draw the white borders of memory box1 - Part II
        @@PLAYER_2_THICKNESS_V_1_2:
                                SET_REGS BP, 90, 0, 340, LIGHT_WHITE, 0, 0
                                CALL DRAW_LINE_V ; BP, 90, 340, LIGHT_WHITE
                                INC BP
                                LOOP @@PLAYER_2_THICKNESS_V_1_2

        ; Draw score box
        SET_REGS 10, 135, 320, 0, LIGHT_WHITE, 0, 0
        CALL DRAW_LINE_H ; 10, 135, 320, LIGHT_WHITE

        SET_REGS 10, 136, 320, 0, LIGHT_WHITE, 0, 0
        CALL DRAW_LINE_H ; 10, 136, 320, LIGHT_WHITE

        SET_REGS 10, 137, 320, 0, LIGHT_WHITE, 0, 0
        CALL DRAW_LINE_H ; 10, 137, 320, LIGHT_WHITE


        SET_REGS 10, 87, 60, 0, RED, 0, 0
        CALL DRAW_LINE_H ; 10, 87, 60, RED

        SET_REGS 10, 88, 60, 0, RED, 0, 0
        CALL DRAW_LINE_H ; 10, 88, 60, RED

        SET_REGS 10, 89, 60, 0, RED, 0, 0
        CALL DRAW_LINE_H ; 10, 89, 60, RED


        SET_REGS 10, 132, 60, 0, RED, 0, 0
        CALL DRAW_LINE_H ; 10, 132, 60, RED

        SET_REGS 10, 133, 60, 0, RED, 0, 0
        CALL DRAW_LINE_H ; 10, 133, 60, RED

        SET_REGS 10, 134, 60, 0, RED, 0, 0
        CALL DRAW_LINE_H ; 10, 134, 60, RED


        SET_REGS 8, 87, 0, 48, RED, 0, 0
        CALL DRAW_LINE_V ; 8, 87, 48, RED

        SET_REGS 9, 87, 0, 48, RED, 0, 0
        CALL DRAW_LINE_V ; 9, 87, 48, RED

        SET_REGS 10, 87, 0, 48, RED, 0, 0
        CALL DRAW_LINE_V ; 10, 87, 48, RED


        SET_REGS 130, 87, 0, 48, RED, 0, 0
        CALL DRAW_LINE_V ; 130, 87, 48, RED

        SET_REGS 131, 87, 0, 48, RED, 0, 0
        CALL DRAW_LINE_V ; 131, 87, 48, RED

        SET_REGS 132, 87, 0, 48, RED, 0, 0
        CALL DRAW_LINE_V ; 132, 87, 48, RED


        ; Print the registers labels
        SET_REGS 2, 7, 0, 0, GREEN, 0, PLAYER_2_SCORE_LABEL
        CALL PRINT_STRING ; 2, 7, PLAYER_2_SCORE_LABEL, GREEN

        SET_REGS 3, 9, 0, 0, GREEN, 0, PLAYER_2_AX_REG_LABEL
        CALL PRINT_STRING ; 3, 9, PLAYER_2_AX_REG_LABEL, GREEN

        SET_REGS 3, 11, 0, 0, GREEN, 0, PLAYER_2_BX_REG_LABEL
        CALL PRINT_STRING ; 3, 11, PLAYER_2_BX_REG_LABEL, GREEN

        SET_REGS 3, 13, 0, 0, GREEN, 0, PLAYER_2_CX_REG_LABEL
        CALL PRINT_STRING ; 3, 13, PLAYER_2_CX_REG_LABEL, GREEN

        SET_REGS 3, 15, 0, 0, GREEN, 0, PLAYER_2_DX_REG_LABEL
        CALL PRINT_STRING ; 3, 15, PLAYER_2_DX_REG_LABEL, GREEN

        SET_REGS 3, 17, 0, 0, GREEN, 0, PLAYER_2_DI_REG_LABEL
        CALL PRINT_STRING ; 3, 17, PLAYER_2_DI_REG_LABEL, GREEN

        SET_REGS 3, 19, 0, 0, GREEN, 0, PLAYER_2_SI_REG_LABEL
        CALL PRINT_STRING ; 3, 19, PLAYER_2_SI_REG_LABEL, GREEN

        SET_REGS 3, 21, 0, 0, GREEN, 0, PLAYER_2_BP_REG_LABEL
        CALL PRINT_STRING ; 3, 21, PLAYER_2_BP_REG_LABEL, GREEN

        SET_REGS 3, 23, 0, 0, GREEN, 0, PLAYER_2_SP_REG_LABEL
        CALL PRINT_STRING ; 3, 23, PLAYER_2_SP_REG_LABEL, GREEN

        SET_REGS 2, 25, 0, 0, GREEN, 0, PLAYER_2_TIMER_LABEL
        CALL PRINT_STRING ; 2, 25, PLAYER_2_TIMER_LABEL, GREEN

        ; Print Memory labels - Part I
        SET_REGS 20, 7, 0, 0, GREEN, 0, PLAYER_2_MEM_0_LABEL
        CALL PRINT_STRING ; 20, 7, PLAYER_2_MEM_0_LABEL, GREEN

        SET_REGS 20, 9, 0, 0, GREEN, 0, PLAYER_2_MEM_1_LABEL
        CALL PRINT_STRING ; 20, 9, PLAYER_2_MEM_1_LABEL, GREEN

        SET_REGS 20, 11, 0, 0, GREEN, 0, PLAYER_2_MEM_2_LABEL
        CALL PRINT_STRING ; 20, 11, PLAYER_2_MEM_2_LABEL, GREEN

        SET_REGS 20, 13, 0, 0, GREEN, 0, PLAYER_2_MEM_3_LABEL
        CALL PRINT_STRING ; 20, 13, PLAYER_2_MEM_3_LABEL, GREEN

        SET_REGS 20, 15, 0, 0, GREEN, 0, PLAYER_2_MEM_4_LABEL
        CALL PRINT_STRING ; 20, 15, PLAYER_2_MEM_4_LABEL, GREEN

        SET_REGS 20, 17, 0, 0, GREEN, 0, PLAYER_2_MEM_5_LABEL
        CALL PRINT_STRING ; 20, 17, PLAYER_2_MEM_5_LABEL, GREEN

        SET_REGS 20, 19, 0, 0, GREEN, 0, PLAYER_2_MEM_6_LABEL
        CALL PRINT_STRING ; 20, 19, PLAYER_2_MEM_6_LABEL, GREEN

        SET_REGS 20, 21, 0, 0, GREEN, 0, PLAYER_2_MEM_7_LABEL
        CALL PRINT_STRING ; 20, 21, PLAYER_2_MEM_7_LABEL, GREEN
        
        SET_REGS 20, 23, 0, 0, BLUE, 0, PLAYER_2_C_FLAG_LABEL
        CALL PRINT_STRING ; 20, 23, PLAYER_2_C_FLAG_LABEL, BLUE

        SET_REGS 20, 25, 0, 0, BLUE, 0, PLAYER_2_Z_FLAG_LABEL
        CALL PRINT_STRING ; 20, 25, PLAYER_2_Z_FLAG_LABEL, BLUE

        ; Print Memory labels - Part II
        SET_REGS 36, 7, 0, 0, GREEN, 0, PLAYER_2_MEM_8_LABEL
        CALL PRINT_STRING ; 36, 7, PLAYER_2_MEM_8_LABEL, GREEN

        SET_REGS 36, 9, 0, 0, GREEN, 0, PLAYER_2_MEM_9_LABEL
        CALL PRINT_STRING ; 36, 9, PLAYER_2_MEM_9_LABEL, GREEN

        SET_REGS 36, 11, 0, 0, GREEN, 0, PLAYER_2_MEM_A_LABEL
        CALL PRINT_STRING ; 36, 11, PLAYER_2_MEM_A_LABEL, GREEN

        SET_REGS 36, 13, 0, 0, GREEN, 0, PLAYER_2_MEM_B_LABEL
        CALL PRINT_STRING ; 36, 13, PLAYER_2_MEM_B_LABEL, GREEN

        SET_REGS 36, 15, 0, 0, GREEN, 0, PLAYER_2_MEM_C_LABEL
        CALL PRINT_STRING ; 36, 15, PLAYER_2_MEM_C_LABEL, GREEN

        SET_REGS 36, 17, 0, 0, GREEN, 0, PLAYER_2_MEM_D_LABEL
        CALL PRINT_STRING ; 36, 17, PLAYER_2_MEM_D_LABEL, GREEN

        SET_REGS 36, 19, 0, 0, GREEN, 0, PLAYER_2_MEM_E_LABEL
        CALL PRINT_STRING ; 36, 19, PLAYER_2_MEM_E_LABEL, GREEN

        SET_REGS 36, 21, 0, 0, GREEN, 0, PLAYER_2_MEM_F_LABEL
        CALL PRINT_STRING ; 36, 21, PLAYER_2_MEM_F_LABEL, GREEN

        SET_REGS 36, 23, 0, 0, BLUE, 0, PLAYER_2_S_FLAG_LABEL
        CALL PRINT_STRING ; 36, 23, PLAYER_2_S_FLAG_LABEL, BLUE

        SET_REGS 36, 25, 0, 0, BLUE, 0, PLAYER_2_O_FLAG_LABEL
        CALL PRINT_STRING ; 36, 25, PLAYER_2_O_FLAG_LABEL, BLUE
        
        CALL PLAYER_2_UPDATE_REGISTERS_REPRESENTATION
        CALL PLAYER_2_UPDATE_MEMORY_REPRESENTATION
        CALL PLAYER_2_UPDATE_FLAGS_REPRESENTATION
        ;================
        CALL CLEAR_SHARED_RESOURCES
        POP BP
        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
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
        SET_REGS 0, 0, 0, 0, LIGHT_WHITE, 0, 0
        CALL DRAW_BACKGROUND ;LIGHT_WHITE

        SET_REGS 400, 0, 0, 550, RED, 0, 0
        CALL DRAW_LINE_V ; 400, 0, 550, RED

        SET_REGS 0, 550, 736, 0, RED, 0, 0
        CALL DRAW_LINE_H ; 0, 550, 736, RED
        ;==================
        CALL DRAW_PLAYER_1
        CALL DRAW_PLAYER_2
        ;==================
        ;Chat Box
        SET_REGS 1, 35, 0, 0, RED, 0, NAME_1
        CALL PRINT_STRING ; 1,35, NAME_1, RED

        SET_REGS 7, 35, 0, 0, LIGHT_WHITE, 0, MESSAGE_1
        CALL PRINT_STRING ; 7,35, MESSAGE_1, LIGHT_WHITE


        SET_REGS 1, 36, 0, 0, RED, 0, NAME_2
        CALL PRINT_STRING ; 1,36, NAME_2, RED

        SET_REGS 8, 36, 0, 0, LIGHT_WHITE, 0, MESSAGE_2
        CALL PRINT_STRING ; 8,36, MESSAGE_2, LIGHT_WHITE
        ;==================
        MOV BP,0
        @@UPDATE_TIMER:
                        MOV DX,BP
                        AND DX,0080H
                        SHR DX,7
                        CALL PLAYER_1_UPDATE_REGISTERS_REPRESENTATION
                        CALL PLAYER_1_UPDATE_FLAGS_REPRESENTATION
                        CALL PLAYER_2_UPDATE_REGISTERS_REPRESENTATION
                        CALL PLAYER_2_UPDATE_FLAGS_REPRESENTATION
                        INC BP
                        MOV CX,0FFFFH
                        @@DELAY:
                                LOOP @@DELAY
                        CMP BP,0FFFFH
                        JNZ @@UPDATE_TIMER
MAIN    ENDP
        END     MAIN
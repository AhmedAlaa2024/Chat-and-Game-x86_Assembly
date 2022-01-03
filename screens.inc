;=============================================
;              Screen MACROS
;=============================================

;=============================================================================
;Sets the video mode (3: TEXT MODE, 13: Graphics mode) 
;PARAMATER:     mode (1 Byte)
;REGISTERS CHANGED: AH  AL
;=============================================================================
SET_VIDEO MACRO
    PUSH AX
    PUSH BX
    MOV AX,4F02H
    MOV BX,103H
    INT 10H
    POP BX
    POP AX
ENDM SET_VIDEO

;=============================================================================
;GET a CHAR from STDIN (WITHOUT ECHO)
;OUTPUT:    AL (CHAR)
;REGISTERS CHANGED: AH  AL
;=============================================================================
GET_CHAR MACRO
    MOV AH, 08
    INT 21H
ENDM GET_CHAR

;=============================================================================
;Display a CHAR to STDOUT 
;PARAMATER:     CHAR
;REGISTERS CHANGED: AH  DL
;=============================================================================
DISPLAY_CHAR MACRO CHAR
    MOV DL, CHAR
    MOV AH, 02
    INT 21H
ENDM DISPLAY_CHAR

;=============================================================================
;Display a $ terminated string to STDOUT 
;PARAMATER:     MSG (1st byte of message)
;REGISTERS CHANGED: AH  DX
;=============================================================================
DISPLAY_MSG MACRO MSG
    MOV DX, OFFSET MSG
    MOV AH, 09
    INT 21H
ENDM DISPLAY_MSG

;=============================================================================
;Displays a new line in STDOUT
;REGISTERS CHANGED: AH  DL
;=============================================================================
DISPLAY_NEWLINE MACRO
    MOV AH, 02H
    
    MOV DL, 13D ;CARIAGE RETURN
    INT 21H

    MOV DL, 10D ;LINEFEED
    INT 21H
ENDM DISPLAY_NEWLINE

;=============================================================================
;Removes Current Character in STDOUT
;REGISTERS CHANGED: AH  DL
;=============================================================================
DISPLAY_BACKSPACE MACRO
    MOV AH, 02H

    MOV DL, 08H ;BACKSPACE
    INT 21H

    MOV DL, 20H ;SPACE
    INT 21H 

    MOV DL, 08H ;BACKSPACE
    INT 21H
ENDM DISPLAY_BACKSPACE

;=============================================
;              Start Screen
;=============================================

;=============================================================================
;Gets Username from STDIN (With ECHO)
;First character must be a letter
;Min size = 1, Max size = Buff[0]
;Supports backspace
;Carriage return to confirm username
;PARAMETERS:  USERNAME BUFFER (0: MaxSize, 1: CurrSize, >1: Username String)
;=============================================================================
GET_USERNAME MACRO USERNAME
    LOCAL GETFIRST, GETNEXT, DONEFIRST, BACKSPACE, RETURN
    MOV BX, 0000H       ;Current Input Size
    MOV CH, USERNAME[0] ;CH == Max Input Size

    GETFIRST:
    GET_CHAR
    ISALPHA AL, DONEFIRST  
    JMP GETFIRST

    DONEFIRST:
    DISPLAY_CHAR AL
    MOV USERNAME[BX][2], AL
    INC BL
    GETNEXT:
    GET_CHAR

    CMP AL, 09D   ;Ignore TAB
    JE GETNEXT 

    CMP AL, 13D   ;CARRIAGE RETURN
    JE RETURN

    CMP AL, 08H   ;BACKSPACE
    JE BACKSPACE

    CMP BL, CH   ;Max Size Reached
    JE GETNEXT 

    DISPLAY_CHAR AL
    MOV USERNAME[BX][2], AL ;Save current character to username buffer
    INC BL
    JMP GETNEXT

    BACKSPACE:
    DISPLAY_BACKSPACE
    DEC BL
    MOV USERNAME[BX][2], '$'
    CMP BL, 0
    JE GETFIRST
    JMP GETNEXT

    RETURN:
    MOV USERNAME[1], BL
ENDM GET_USERNAME

GET_ONE_CHAR MACRO CHAR
    LOCAL GETFIRST, GETNEXT, DONEFIRST, BACKSPACE, RETURN

    GETFIRST:
    GET_CHAR
    ISALPHA AL, DONEFIRST
    ISDIGIT AL, DONEFIRST
    JMP GETFIRST

    DONEFIRST:
    DISPLAY_CHAR AL
    CHARTOUPPER AL
    MOV CHAR, AL
ENDM GET_ONE_CHAR

GET_ONE_OR_TWO MACRO LEVEL
    LOCAL GETFIRST, GETNEXT, DONEFIRST, BACKSPACE, RETURN

    GETFIRST:
    GET_CHAR
    CMP AL, '1'
    JE  DONEFIRST
    CMP AL, '2'
    JE  DONEFIRST
    JMP GETFIRST

    DONEFIRST:
    DISPLAY_CHAR AL
    SUB AL , '1'
    MOV LEVEL, AL
ENDM GET_ONE_OR_TWO
;=============================================================================
;Gets suggested from STDIN (With ECHO)
;No trailing zeros allowed
;Min size = 1, Max size = 9999
;Supports backspace
;Carriage return to confirm
;PARAMETERS:  POINTS (2-Bytes)
;=============================================================================
GET_POINTS MACRO POINTS
    LOCAL GETFIRST, GETNEXT, VALID, DONEFIRST, BACKSPACE, RETURN
    ;The number is stored in BX
    MOV BX, 0
    MOV CX, 0400H ;CL = 0 (current size), CH = 4 (Max Size)
    MOV SI, 10    ;Used in MUL, DIV

    GETFIRST:
    GET_CHAR
    ;No trailing zeros
    CMP AL, '0'  
    JE GETFIRST

    ISDIGIT AL, DONEFIRST
    JMP GETFIRST
    
    DONEFIRST:
    DISPLAY_CHAR AL
    CHAR_TO_INT AL
    MOV BL, AL
    INC CL
    GETNEXT:
    GET_CHAR
    CMP AL, 13D   ;CARRIAGE RETURN
    JE RETURN

    CMP AL, 08H   ;BACKSPACE
    JE BACKSPACE

    CMP CL, CH   ;Max Size Reached
    JE GETNEXT 

    ISDIGIT AL, VALID
    JMP GETNEXT
    VALID:
    DISPLAY_CHAR AL
    CHAR_TO_INT AL

    ;DECIMAL SHIFT LEFT WITH AL
    MOV AH, 0
    XCHG AX, BX
    MUL SI
    ADD BX, AX

    INC CL
    JMP GETNEXT

    BACKSPACE:
    DISPLAY_BACKSPACE
    ;DECIMAL SHIFT RIGHT
    MOV DX, 0  ;Ensure Word to Word Division
    MOV AX, BX
    DIV SI     ;AX = AX / 10
    MOV BX, AX

    DEC CL
    CMP CL, 0
    JE GETFIRST
    JMP GETNEXT

    RETURN:
    MOV POINTS, BX
ENDM GET_POINTS

RUN_STRT_SCREEN MACRO USERNAME, POINTS
    LOCAL GET_AGAIN

    SET_VIDEO TEXT_MODE
    DISPLAY_MSG STRT_NAME_PROMPT
    GET_USERNAME USERNAME
    DISPLAY_NEWLINE

    DISPLAY_MSG STRT_POINT_PROMPT
    GET_POINTS POINTS
    DISPLAY_NEWLINE

    DISPLAY_MSG STRT_PRESS_ENTER_PROMPT
    GET_AGAIN:
    GET_CHAR
    CMP AL, 13D ;Carriage return
    JNE GET_AGAIN
ENDM RUN_STRT_SCREEN

SELECT_GAME_LEVEL_SCREEN MACRO LEVEL 
    LOCAL GET_AGAIN

    SET_VIDEO
    DISPLAY_MSG GAME_LEVEL_PROMPT
    GET_ONE_OR_TWO LEVEL
    DISPLAY_NEWLINE

    DISPLAY_MSG STRT_PRESS_ENTER_PROMPT
    GET_AGAIN:
    GET_CHAR
    CMP AL, 13D ;Carriage return
    JNE GET_AGAIN
ENDM SELECT_GAME_LEVEL_SCREEN

GET_FORBIDDEN_CHAR MACRO CHAR
    LOCAL GET_AGAIN

    SET_VIDEO
    DISPLAY_MSG FORBIDDEN_CHAR_PROMPT
    GET_ONE_CHAR CHAR
    DISPLAY_NEWLINE

    DISPLAY_MSG STRT_PRESS_ENTER_PROMPT
    GET_AGAIN:
    GET_CHAR
    CMP AL, 13D ;Carriage return
    JNE GET_AGAIN
ENDM GET_FORBIDDEN_CHAR

SHOW_GAME_ENDED_SCRREN MACRO PLAYER_NAME
    LOCAL GET_AGAIN
    SET_VIDEO
    DISPLAY_MSG GAME_ENDED_PROMPT
    DISPLAY_MSG PLAYER_NAME
    DISPLAY_NEWLINE
    DISPLAY_MSG STRT_PRESS_ENTER_PROMPT
    GET_AGAIN:
    GET_CHAR
    CMP AL, 13D ;Carriage return
    JNE GET_AGAIN
ENDM SHOW_GAME_ENDED_SCRREN

IS_SECRET_KEY MACRO   NUMBER, ADDRESS
        PUSH AX
        MOV AX,NUMBER
        CMP AX,105EH
        JZ ADDRESS
        POP AX
ENDM    IS_SECRET_KEY
;=============================================================================
PLAYER_1_INITIALIZE_REG  PROC
        PUSH AX
        PUSH CX
        MOV TEMP_REG_VALUE,0
        MOV CX,0
        @@REPEAT:
                    GET_CHAR
                    CMP AL,08H
                    JZ @@BACKSPACE
                    CMP AL,13
                    JZ @@ENTER

                    CHARTOUPPER AL

                    ISXDIGIT AL, @@CONVERT
                    JMP @@REPEAT

                    @@CONVERT:
                                DISPLAY_CHAR AL
                                ISDIGIT AL,@@DECIMAL
                                JMP @@HEX

                                @@DECIMAL:
                                            SUB AL,'0'
                                            JMP @@CONTINUE
                                
                                @@HEX:
                                        SUB AL,55D
                                        JMP @@CONTINUE

                    @@CONTINUE:
                                PUSH AX
                                MOV AX,TEMP_REG_VALUE
                                SHL AX,4
                                MOV TEMP_REG_VALUE,AX
                                POP AX
                                MOV AH,0
                                ADD TEMP_REG_VALUE,AX

                                INC CX
                                CMP CX,4
                                JNZ @@REPEAT
                                JMP @@ENTER

        @@BACKSPACE:
                    CMP CX,0
                    JZ @@REPEAT

                    DISPLAY_BACKSPACE
                    DEC CX
                    JMP @@REPEAT

        @@SECRET_KEY:
                        @@DELETE:
                                    DISPLAY_BACKSPACE
                                    LOOP @@DELETE
                        MOV TEMP_REG_VALUE,0
                        JMP @@REPEAT
        @@ENTER:
                IS_SECRET_KEY TEMP_REG_VALUE,@@SECRET_KEY

                DISPLAY_NEWLINE

                CMP CURRENT_REG,0
                JZ @@_AX

                CMP CURRENT_REG,1
                JZ @@_BX

                CMP CURRENT_REG,2
                JZ @@_CX

                CMP CURRENT_REG,3
                JZ @@_DX

                CMP CURRENT_REG,4
                JZ @@_DI

                CMP CURRENT_REG,5
                JZ @@_SI

                CMP CURRENT_REG,6
                JZ @@_BP

                CMP CURRENT_REG,7
                JZ @@_SP

                JMP @@EXIT

                @@_AX:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_1_AX_VALUE,AX
                        JMP @@EXIT
                @@_BX:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_1_BX_VALUE,AX
                        JMP @@EXIT
                @@_CX:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_1_CX_VALUE,AX
                        JMP @@EXIT
                @@_DX:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_1_DX_VALUE,AX
                        JMP @@EXIT
                @@_DI:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_1_DI_VALUE,AX
                        JMP @@EXIT
                @@_SI:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_1_SI_VALUE,AX
                        JMP @@EXIT
                @@_BP:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_1_BP_VALUE,AX
                        JMP @@EXIT
                @@_SP:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_1_SP_VALUE,AX
                        JMP @@EXIT

                @@EXIT:
                POP CX
                POP AX
        RET
ENDP    PLAYER_1_INITIALIZE_REG
;==============================================================
PLAYER_2_INITIALIZE_REG  PROC
        PUSH AX
        PUSH CX
        MOV TEMP_REG_VALUE,0
        MOV CX,0
        @@REPEAT:
                    GET_CHAR
                    CMP AL,08H
                    JZ @@BACKSPACE
                    CMP AL,13
                    JZ @@ENTER

                    CHARTOUPPER AL
                    
                    ISXDIGIT AL, @@CONVERT
                    JMP @@REPEAT

                    @@CONVERT:
                                DISPLAY_CHAR AL
                                ISDIGIT AL,@@DECIMAL
                                JMP @@HEX

                                @@DECIMAL:
                                            SUB AL,'0'
                                            JMP @@CONTINUE
                                
                                @@HEX:
                                        SUB AL,55D
                                        JMP @@CONTINUE

                    @@CONTINUE:
                                PUSH AX
                                MOV AX,TEMP_REG_VALUE
                                SHL AX,4
                                MOV TEMP_REG_VALUE,AX
                                POP AX
                                MOV AH,0
                                ADD TEMP_REG_VALUE,AX

                                INC CX
                                CMP CX,4
                                JNZ @@REPEAT
                                JMP @@ENTER

        @@BACKSPACE:
                    CMP CX,0
                    JZ @@REPEAT

                    DISPLAY_BACKSPACE
                    DEC CX
                    JMP @@REPEAT

        @@SECRET_KEY:
                        @@DELETE:
                                    DISPLAY_BACKSPACE
                                    LOOP @@DELETE
                        MOV TEMP_REG_VALUE,0
                        JMP @@REPEAT
        @@ENTER:
                IS_SECRET_KEY TEMP_REG_VALUE,@@SECRET_KEY

                DISPLAY_NEWLINE
                CMP CURRENT_REG,0
                JZ @@_AX

                CMP CURRENT_REG,1
                JZ @@_BX

                CMP CURRENT_REG,2
                JZ @@_CX

                CMP CURRENT_REG,3
                JZ @@_DX

                CMP CURRENT_REG,4
                JZ @@_DI

                CMP CURRENT_REG,5
                JZ @@_SI

                CMP CURRENT_REG,6
                JZ @@_BP

                CMP CURRENT_REG,7
                JZ @@_SP

                JMP @@EXIT

                @@_AX:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_2_AX_VALUE,AX
                        JMP @@EXIT
                @@_BX:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_2_BX_VALUE,AX
                        JMP @@EXIT
                @@_CX:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_2_CX_VALUE,AX
                        JMP @@EXIT
                @@_DX:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_2_DX_VALUE,AX
                        JMP @@EXIT
                @@_DI:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_2_DI_VALUE,AX
                        JMP @@EXIT
                @@_SI:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_2_SI_VALUE,AX
                        JMP @@EXIT
                @@_BP:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_2_BP_VALUE,AX
                        JMP @@EXIT
                @@_SP:
                        MOV AX,TEMP_REG_VALUE
                        MOV PLAYER_2_SP_VALUE,AX
                        JMP @@EXIT

                @@EXIT:
                POP CX
                POP AX
        RET
ENDP    PLAYER_2_INITIALIZE_REG
;==============================================================
PLAYER_1_RUN_INITIALIZATION_SCREEN   PROC
        SET_VIDEO TEXT_MODE

        DISPLAY_MSG STRT_AX_PROMPT
        MOV CURRENT_REG,0
        CALL PLAYER_1_INITIALIZE_REG
        
        DISPLAY_MSG STRT_BX_PROMPT
        MOV CURRENT_REG,1
        CALL PLAYER_1_INITIALIZE_REG

        DISPLAY_MSG STRT_CX_PROMPT
        MOV CURRENT_REG,2
        CALL PLAYER_1_INITIALIZE_REG

        DISPLAY_MSG STRT_DX_PROMPT
        MOV CURRENT_REG,3
        CALL PLAYER_1_INITIALIZE_REG

        DISPLAY_MSG STRT_DI_PROMPT
        MOV CURRENT_REG,4
        CALL PLAYER_1_INITIALIZE_REG

        DISPLAY_MSG STRT_SI_PROMPT
        MOV CURRENT_REG,5
        CALL PLAYER_1_INITIALIZE_REG

        DISPLAY_MSG STRT_BP_PROMPT
        MOV CURRENT_REG,6
        CALL PLAYER_1_INITIALIZE_REG

        DISPLAY_MSG STRT_SP_PROMPT
        MOV CURRENT_REG,7
        CALL PLAYER_1_INITIALIZE_REG

        RET
ENDP    PLAYER_1_RUN_INITIALIZATION_SCREEN
;==============================================================
PLAYER_2_RUN_INITIALIZATION_SCREEN   PROC
        SET_VIDEO TEXT_MODE

        DISPLAY_MSG STRT_AX_PROMPT
        MOV CURRENT_REG,0
        CALL PLAYER_2_INITIALIZE_REG
        
        DISPLAY_MSG STRT_BX_PROMPT
        MOV CURRENT_REG,1
        CALL PLAYER_2_INITIALIZE_REG

        DISPLAY_MSG STRT_CX_PROMPT
        MOV CURRENT_REG,2
        CALL PLAYER_2_INITIALIZE_REG

        DISPLAY_MSG STRT_DX_PROMPT
        MOV CURRENT_REG,3
        CALL PLAYER_2_INITIALIZE_REG

        DISPLAY_MSG STRT_DI_PROMPT
        MOV CURRENT_REG,4
        CALL PLAYER_2_INITIALIZE_REG

        DISPLAY_MSG STRT_SI_PROMPT
        MOV CURRENT_REG,5
        CALL PLAYER_2_INITIALIZE_REG

        DISPLAY_MSG STRT_BP_PROMPT
        MOV CURRENT_REG,6
        CALL PLAYER_2_INITIALIZE_REG

        DISPLAY_MSG STRT_SP_PROMPT
        MOV CURRENT_REG,7
        CALL PLAYER_2_INITIALIZE_REG

        RET
ENDP    PLAYER_2_RUN_INITIALIZATION_SCREEN
;==============================================================
;=============================================
;              Screen MACROS
;=============================================

;=============================================================================
;Sets the video mode (3: TEXT MODE, 13: Graphics mode) 
;PARAMATER:     mode (1 Byte)
;REGISTERS CHANGED: AH  AL
;=============================================================================
SET_VIDEO MACRO
    MOV AX,4F02H
    MOV BX,103H
    INT 10H
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

    SET_VIDEO
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
RUN_MAIN_SCREEN PROC NEAR
    SET_VIDEO

    MOV BH, 0

    ;MOVE CURSOR
    MOV AH, 02
    MOV DH, 10 
    MOV DL, 30
    INT 10H

    MOV AH, 09H
    MOV DX, OFFSET MAIN_SCREEN_MSG1
    INT 21H

    MOV AH, 02
    MOV DH, 15 
    MOV DL, 30
    INT 10H

    MOV AH, 09H
    MOV DX, OFFSET MAIN_SCREEN_MSG2
    INT 21H

    MOV AH, 02
    MOV DH, 20
    MOV DL, 30
    INT 10H

    MOV AH, 09H
    MOV DX, OFFSET MAIN_SCREEN_MSG3
    INT 21H

    MOV AH, 02
    MOV DH, 30
    MOV DL, 0
    INT 10H

    MOV AH, 09H
    MOV DX, OFFSET SCREEN_SPLITTER
    INT 21H

    RET
RUN_MAIN_SCREEN ENDP

RUN_NEW_GAME_SCRREN PROC NEAR
    SET_VIDEO

    MOV BH, 0

    ;MOVE CURSOR
    MOV AH, 02
    MOV DH, 15
    MOV DL, 30
    INT 10H

    MOV AH, 09H
    MOV DX, OFFSET NEW_GAME_SCREEN_MSG
    INT 21H

    RET
RUN_NEW_GAME_SCRREN ENDP

SHOW_NEW_GAME_SCRREN_NOTIFICATIONS MACRO 
    LOCAL LEVEL_ONE,END,LOOP1,LOOP2
    PUSH AX
    PUSH DX
    PUSH CX

    MOV DH, 31

    CMP GAME_LEVEL, 0
    JE LEVEL_ONE
    
    MOV AH, 02
    MOV DL, 0
    INT 10H

    MOV AH, 09H
    MOV CX, DX
    MOV DX, OFFSET NEW_GAME_SCREEN_LEVEL_TWO
    INT 21H
    MOV DX, CX
    INC DH
    
    JMP END

    LEVEL_ONE:
    MOV AH, 02
    MOV DL, 0
    INT 10H
    
    MOV AH, 09H
    MOV CX, DX
    MOV DX, OFFSET NEW_GAME_SCREEN_LEVEL_ONE
    INT 21H
    MOV DX, CX
    INC DH

    END:
    MOV CX, 0FFFFH
    LOOP1: 
       MOV DX, 50
       LOOP2: DEC DX
              JNZ LOOP2
    LOOP LOOP1
    POP CX
    POP DX
    POP AX
ENDM SHOW_NEW_GAME_SCRREN_NOTIFICATIONS

DISPLAY_OTHER_PLAYER_NAME PROC NEAR
    PUSH DX
    PUSH BX
    PUSH AX

    MOV BH,0
    MOV AH,3
    INT 10H
    MOV AH, 09H
    MOV DX, OFFSET NAME_2
    INT 21H

    POP AX
    POP BX
    POP DX
    RET
DISPLAY_OTHER_PLAYER_NAME ENDP

DISPLAY_CURRRENT_PLAYER_NAME PROC NEAR
    PUSH DX
    PUSH BX
    PUSH AX

    MOV BH,0
    MOV AH,3
    INT 10H
    MOV AH, 09H
    MOV DX, OFFSET NAME_1
    INT 21H

    POP AX
    POP BX
    POP DX
    RET
DISPLAY_CURRRENT_PLAYER_NAME ENDP

SHOW_MAIN_SCRREN_NOTIFICATIONS MACRO Flag
    LOCAL CLEAR_AREA, WELCOME_NOTIFICATION,GAME_SENT,CHAT_SENT,CHAT_REVEIVED,GAME_REVEIVED,END
    PUSH AX
    PUSH DX
    PUSH CX

    MOV DH,31
    MOV CX,5
    CLEAR_AREA:
    MOV AH, 02
    MOV DL, 0
    INT 10H
    MOV AH, 09H
    PUSH DX
    MOV DX, OFFSET SCREEN_ERASER
    INT 21H
    POP DX
    INC DH
    LOOP CLEAR_AREA


    MOV DH, 31

    TEST Flag, 00000001B
    JZ WELCOME_NOTIFICATION
    
    MOV AH, 02
    MOV DL, 0
    INT 10H

    MOV AH, 09H
    MOV CX, DX
    MOV DX, OFFSET MAIN_SCRREN_REVEIVING_OTHER_PLAYER_NAME_MSG
    INT 21H
    MOV DX, CX
    INC DH
    
    WELCOME_NOTIFICATION:
    TEST Flag, 00000010B
    JZ CHAT_SENT
    MOV AH, 02
    MOV DL, 0
    INT 10H
    
    MOV AH, 09H
    MOV CX, DX
    MOV DX, OFFSET MAIN_SCRREN__PLAYER_JOINED
    INT 21H
    MOV DX, CX
    CALL DISPLAY_OTHER_PLAYER_NAME
    INC DH

    CHAT_SENT:
    TEST Flag, 00000100B
    JZ GAME_SENT
    MOV AH, 02
    MOV DL, 0
    INT 10H

    MOV AH, 09H
    MOV CX, DX
    MOV DX, OFFSET MAIN_SCREEN_NOTIFICATION_CHAT_SENT
    INT 21H
    MOV DX, CX
    CALL DISPLAY_OTHER_PLAYER_NAME
    INC DH

    GAME_SENT:
    TEST Flag, 00001000B
    JZ CHAT_REVEIVED
    MOV AH, 02
    MOV DL, 0
    INT 10H

    MOV AH, 09H
    MOV CX, DX
    MOV DX, OFFSET MAIN_SCREEN_NOTIFICATION_GAME_SENT
    INT 21H
    MOV Dx,CX
    CALL DISPLAY_OTHER_PLAYER_NAME
    INC DH
    
    CHAT_REVEIVED:
    TEST Flag, 00010000B
    JZ GAME_REVEIVED
    MOV AH, 02
    MOV DL, 0
    INT 10H

    MOV AH, 09H
    MOV CX, DX
    MOV DX, OFFSET MAIN_SCREEN_NOTIFICATION_CHAT_RECEIVED
    INT 21H
    MOV DX, CX
    CALL DISPLAY_OTHER_PLAYER_NAME
    INC DH
    
    GAME_REVEIVED:
    TEST Flag, 00100000B
    JZ END
    MOV AH, 02
    MOV DL, 0
    INT 10H

    MOV AH, 09H
    MOV CX, DX
    MOV DX, OFFSET MAIN_SCREEN_NOTIFICATION_GAME_RECEIVED
    INT 21H
    MOV DX,CX
    CALL DISPLAY_OTHER_PLAYER_NAME
    INC DH

    END:
    POP CX
    POP DX
    POP AX
ENDM SHOW_MAIN_SCRREN_NOTIFICATIONS

SHOW_FINAL_SCORE_SCREEN MACRO
    SET_VIDEO

    MOV BH, 0
    
    ;MOVE CURSOR
    MOV AH, 02
    MOV DH, 15
    MOV DL, 10
    INT 10H

    CALL DISPLAY_CURRRENT_PLAYER_NAME
    
    ADD DL, P1_USERNAME_SIZE

    MOV AH, 09H
    MOV CX, DX
    MOV DX, OFFSET FINAL_SCORE_MSG
    INT 21H
    
    MOV AH, 3
    INT 10h
    

    PRINT_4_DIGIT_GRAPHICS DL, DH, PLAYER_1_SCORE_VALUE, LIGHT_WHITE


    MOV BH, 0
    
    ;MOVE CURSOR
    MOV AH, 02
    MOV DH, 20
    MOV DL, 10
    INT 10H

    CALL DISPLAY_OTHER_PLAYER_NAME
    
    ADD DL, P2_USERNAME_SIZE

    MOV AH, 09H
    MOV CX, DX
    MOV DX, OFFSET FINAL_SCORE_MSG
    INT 21H
    
    MOV AH, 3
    INT 10h
    

    PRINT_4_DIGIT_GRAPHICS DL, DH, PLAYER_2_SCORE_VALUE, LIGHT_WHITE

    MOV CX, 0FFFFH
    LOOP1: 
       MOV DX, 50
       LOOP2: DEC DX
              JNZ LOOP2
    LOOP LOOP1

    RET
ENDM SHOW_FINAL_SCORE_SCREEN 

SCROLL_UP PROC 
    PUSH AX
    MOV AH, 6
    MOV AL, 1
    MOV BH, 7
    MOV CH, 1
    MOV CL, 0
    MOV DH, 11
    MOV DL, 79
    INT 10H
    MOV AH, 03
    MOV BH, 0
    INT 10H
    DEC DH

    MOV AH, 2
    INT 10H
    POP AX
    RET
SCROLL_UP ENDP 

SCROLL_DOWN PROC 
    PUSH AX
    MOV AH, 6
    MOV AL, 1
    MOV BH, 7
    MOV CH, 14
    MOV CL, 0
    MOV DH, 22
    MOV DL, 79
    INT 10H
    MOV AH, 03
    MOV BH, 0
    INT 10H

    POP AX
    RET
SCROLL_DOWN ENDP 

SEND_MSG PROC NEAR
    MOV SEND_VALUE, CHATSEND
    CALL SEND_CHAR

    MOV CX, BP
    INC CX
    MOV SI, OFFSET out_msg
    
    @@SEND_LOOP:
    MOV RECIEVE_VALUE, 0
    CALL RECIEVE_CHAR
    CMP RECIEVE_VALUE, CHATRECIEVE
    JNE @@SEND_LOOP

    MOV DL, [SI]
    MOV SEND_VALUE, DL
    CALL SEND_CHAR
    INC SI
    LOOP @@SEND_LOOP

    RET
SEND_MSG ENDP

RECIEVE_MSG PROC NEAR
    ;Get cursor
    MOV AH, 03
    INT 10H
    MOV loc_up, DH
    MOV loc_up[1], DL

    MOV DI, OFFSET read_msg
    MOV SEND_VALUE, CHATRECIEVE
    
    @@RECIEVE_LOOP:
    CALL SEND_CHAR
    @@RECIEVE:
    MOV RECIEVE_VALUE, 0
    CALL RECIEVE_CHAR
    CMP RECIEVE_VALUE, 0
    JE @@RECIEVE
    MOV DL, RECIEVE_VALUE
    MOV [DI], DL
    INC DI
    CMP DL, '$'
    JNE @@RECIEVE_LOOP
    ;Set down cursor
    CMP loc_down, 23
    JB @@SKIP_SCROLL
    CALL SCROLL_DOWN
    DEC loc_down
    @@SKIP_SCROLL: 

    MOV BH, 0
    MOV AH, 02 
    MOV DH, loc_down
    MOV DL, 0
    INT 10H

    INC loc_down

    MOV DX, OFFSET read_msg
    MOV AH, 09
    INT 21H

    ;Set cursor back
    MOV BH, 0
    MOV AH, 02 
    MOV DH, loc_up
    MOV DL, loc_up[1]
    INT 10H
    RET
RECIEVE_MSG ENDP

RUN_CHATTING_SCREEN PROC NEAR
        PUSH SI
        PUSH DI
@@BEGIN:
        ;Set Text Mode
        MOV AX,03h
        MOV BX, 0H
        INT 10H

        ;Move Cursor 0,0
        MOV BH, 0
        MOV AH, 02H
        MOV DL, 0
        MOV DH, 0
        INT 10H

        ;Print String
        MOV DX, OFFSET NAME_1
        MOV AH, 9
        INT 21H

        ;Move Cursor 0,13
        MOV AH, 02H
        MOV DL, 0
        MOV DH, 13
        INT 10H

        MOV DX, OFFSET NAME_2
        MOV AH, 9
        INT 21H

        ;Move Cursor 0,12
        MOV AH, 02H
        MOV DL, 0
        MOV DH, 12
        INT 10H

        MOV DX, OFFSET SPLIT_SCREEN
        MOV AH, 9
        INT 21H

        ;Move Cursor 0,23
        MOV AH, 02H
        MOV DL, 0
        MOV DH, 23
        INT 10H

        MOV DX, OFFSET SPLIT_SCREEN
        MOV AH, 9
        INT 21H

        ;Move Cursor 0,24
        MOV AH, 02H
        MOV DL, 0
        MOV DH, 24
        INT 10H

        MOV AH, 9
        MOV DX, OFFSET CHATTING_NOTIFICATION_1  
        INT 21H

        MOV DX, OFFSET NAME_2 
        INT 21H

        MOV DX, OFFSET CHATTING_NOTIFICATION_2 
        INT 21H

        ;Move Cursor 0,1
        MOV AH, 02H
        MOV DL, 0
        MOV DH, 1
        INT 10H

        LEA SI, out_msg
        LEA DI, read_msg
@@CHATTING_LOOP:
@@CHECK_BUFFER:
        MOV AH, 1
        INT 16H
        JZ @@CHECK_SERIAL
        MOV AH, 0
        INT 16H
        CMP AH, 61 ;F3 SCAN Code
        JE @@EXIT
        MOV BP, SI
        SUB BP, OFFSET out_msg
        ;BP Contains current msg size
        ;AL Contains current character
        CMP AL, 13D ;Enter
        JNE @@NOT_ENTER
        ;Check if msg is already empty
        CMP BP, 0
        JE @@CHECK_SERIAL
        DISPLAY_NEWLINE
        MOV [SI], '$'
        ;Check for scrolling
        INC loc_up
        CMP loc_up, 12
        JB @@SKIP_SCROLLING_UP
        CALL SCROLL_UP
        DEC loc_up
        @@SKIP_SCROLLING_UP:
        CALL SEND_MSG

        ;Cleanup msg
        MOV SI, OFFSET out_msg
        MOV [SI], '$'
        JMP @@CHECK_SERIAL

        @@NOT_ENTER:     
        CMP AL, 08D ;Backspace
        JNE @@NOT_BACKSPACE
        ;Check if msg is already empty
        CMP BP, 0
        JE @@CHECK_SERIAL
        ;Perform backspace    
        MOV [SI], '$'
        DEC SI
        DISPLAY_BACKSPACE
        JMP @@CHECK_SERIAL
        @@NOT_BACKSPACE:
        ;Check if msg size limit reached
        CMP BP, 79
        JE @@CHECK_SERIAL

        ;Add character to buffer
        MOV [SI], AL
        INC SI

        ;Display character
        MOV DL, AL
        MOV AH, 02
        INT 21H      
@@CHECK_SERIAL:
        MOV RECIEVE_VALUE, 0
        CALL RECIEVE_CHAR
        CMP RECIEVE_VALUE, 0
        JE @@CHATTING_LOOP ;No char recieved
        CMP RECIEVE_VALUE, CHATEXIT ;Check if other player exited
        JE @@RETURN
        CALL RECIEVE_MSG
        JMP @@CHATTING_LOOP
@@EXIT:
        MOV SEND_VALUE, CHATEXIT ;Send other player exit notice
        CALL SEND_CHAR
@@RETURN:
        MOV loc_down, 14
        POP DI
        POP SI
RET
RUN_CHATTING_SCREEN ENDP 
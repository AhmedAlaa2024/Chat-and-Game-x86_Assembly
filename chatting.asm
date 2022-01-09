;================================
;DATA
;================================
read_msg db 81 dup('$')
out_msg db 81 dup('$')
SPLIT_SCREEN DB 80 DUP ('='), '$'
CHATTING_NOTIFICATION_1 DB '-To End Chatting with ','$'
CHATTING_NOTIFICATION_2 DB ' press F3', '$'
val db ?
loc_up db 1, 0
loc_down db 14, 0

CHATSEND EQU 130
CHATRECIEVE EQU 131
CHATEXIT EQU 132
;================================
;CODE
;================================
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
        CMP AH, 61 ;F3 SCAN Code
        JE @@EXIT
        MOV AH, 0
        INT 16H
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
        POP DI
        POP SI
RET
RUN_CHATTING_SCREEN ENDP 
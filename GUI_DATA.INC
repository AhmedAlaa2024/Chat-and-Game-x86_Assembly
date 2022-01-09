;Screen Data
MAIN_SCREEN_MSG1 DB 'To start chatting press F1$'
MAIN_SCREEN_MSG2 DB 'To start the game press F2$'
MAIN_SCREEN_MSG3 DB 'To end the program press ESC$'
NEW_GAME_SCREEN_MSG DB 'Please WAit .......... $'
FINAL_SCORE_MSG DB ' Has Score Of = $'
NEW_GAME_SCREEN_LEVEL_ONE DB 'The Game Level Was Chosen To Be 1 $'
NEW_GAME_SCREEN_LEVEL_TWO DB 'The Game Level Was Chosen To Be 2 $'
STRT_NAME_PROMPT DB 'Please enter your name: (Must start with a letter)',13,10,'$'
STRT_POINT_PROMPT DB 'Enter your suggested initial points: (4-Digit max)',13,10,'$'
FORBIDDEN_CHAR_PROMPT DB 'Enter your forbidden char: (1 Character Max)',13,10,'$'
GAME_LEVEL_PROMPT DB 'Enter your game level: (1 or 2 Only)',13,10,'$'
GAME_ENDED_PROMPT DB 'Game Ended And The Winner Is : ','$'
STRT_PRESS_ENTER_PROMPT DB 'Press Enter key to continue','$'

TEMP_REG_VALUE  DW  0000
CURRENT_REG DB  0

STRT_AX_PROMPT DB  'Enter your suggested initial Register value for AX: (4-Digit max)',13,10,'$'
STRT_BX_PROMPT DB  'Enter your suggested initial Register value for BX: (4-Digit max)',13,10,'$'
STRT_CX_PROMPT DB  'Enter your suggested initial Register value for CX: (4-Digit max)',13,10,'$'
STRT_DX_PROMPT DB  'Enter your suggested initial Register value for DX: (4-Digit max)',13,10,'$'
STRT_DI_PROMPT DB  'Enter your suggested initial Register value for DI: (4-Digit max)',13,10,'$'
STRT_SI_PROMPT DB  'Enter your suggested initial Register value for SI: (4-Digit max)',13,10,'$'
STRT_BP_PROMPT DB  'Enter your suggested initial Register value for BP: (4-Digit max)',13,10,'$'
STRT_SP_PROMPT DB  'Enter your suggested initial Register value for SP: (4-Digit max)',13,10,'$'
;STRT_REG_PROMPT DB  [STRT_AX_PROMPT], [STRT_BX_PROMPT], [STRT_CX_PROMPT], [STRT_DX_PROMPT], [STRT_DI_PROMPT], [STRT_SI_PROMPT], [STRT_BP_PROMPT], [STRT_SP_PROMPT]

SCREEN_SPLITTER DB 100 dup('='), '$'
SCREEN_ERASER DB 100 dup(' '), '$'
MAIN_SCRREN_REVEIVING_OTHER_PLAYER_NAME_MSG DB 'WAITING FOR OTHER PLAYER TO JOIN THE PARTY, PLEASE WAIT...',13,10,'$'
MAIN_SCRREN__PLAYER_JOINED DB 'ANOTHER PLAYER JOINED THE GAME WITH USERNAME : $'
MAIN_SCREEN_NOTIFICATION_CHAT_SENT DB 'You Sent A chat Request To $'
MAIN_SCREEN_NOTIFICATION_GAME_SENT DB 'You Sent A Game Request To $'
MAIN_SCREEN_NOTIFICATION_CHAT_RECEIVED DB 'You Received A Chat Request From $'
MAIN_SCREEN_NOTIFICATION_GAME_RECEIVED DB 'You Received A Game Request From $'
;===========================================
STR_TEMP              DB      ?,?,?,?,'$'
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
MESSAGE_1             DB      'Have the project been finished?', '$'
MESSAGE_2             DB      'Yeah! We did it, Alaa!!!', '$'
;===========================================
PLAYER_1_SCORE_VALUE           DW      0000
PLAYER_1_TIMER_VALUE           DW      0000
;===========================================
PLAYER_1_C_FLAG_VALUE          DB       0
PLAYER_1_Z_FLAG_VALUE          DB       1
PLAYER_1_S_FLAG_VALUE          DB       1
PLAYER_1_O_FLAG_VALUE          DB       0
;===========================================
PLAYER_1_CMD_X_LOCATION        DB       ?
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
PLAYER_2_TIMER_VALUE           DW      0000
;===========================================
PLAYER_2_C_FLAG_VALUE          DB       0
PLAYER_2_Z_FLAG_VALUE          DB       1
PLAYER_2_S_FLAG_VALUE          DB       1
PLAYER_2_O_FLAG_VALUE          DB       0
;===========================================
PLAYER_2_CMD_X_LOCATION        DB       ?
;===========================================
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
        .MODEL SMALL
        .STACK 64 
;==========================================
;                 BIRD DATA               ||
;==========================================
        .DATA
TIME DW 0
BIRD_SPEED     EQU  10000
BULLET_SPEED   EQU  5000
POWERUPSCORE   DB    ?
BULLET1_MOVING DB 0
BIRD1_MOVING DB 0
BIRDWING DB 0 ;0 for down 1 for up
P1_X DW 0
P1_Y DW 300
BULLET1_X DW 200
BULLET1_Y DW 200
BIRD1_X DW 600
BIRD1_Y DW 0
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
shooter db 11,0,107,12,0,107,13,0,107,11,1,107,12,1,107,13,1,107,10,2,107,11,2,106,12,2,107,13,2,107,14,2,107,10,3,106,11,3,107,12,3,107,13,3,107,14,3,107,9,4,107,10,4,106,11,4,107,12,4,107,13,4,107,14,4,107,15,4,107,9,5,106,10,5,106,11,5,107,12,5,107,13,5,107,14,5,107,15,5,107
db 8,6,107,9,6,106,10,6,107,11,6,107,12,6,107,13,6,107,14,6,107,15,6,107,16,6,108,8,7,106,9,7,107,10,7,107,11,7,107,12,7,107,13,7,107,14,7,107,15,7,107,16,7,108,7,8,107,8,8,106,9,8,107,10,8,107,11,8,107,12,8,107,13,8,107,14,8,107,15,8,107,16,8,108,17,8,108,7,9,107
db 8,9,107,9,9,107,10,9,107,11,9,107,12,9,107,13,9,107,14,9,107,15,9,108,16,9,108,17,9,108,6,10,107,7,10,106,8,10,107,9,10,107,10,10,107,11,10,107,12,10,107,13,10,107,14,10,107,15,10,108,16,10,108,17,10,108,18,10,108,6,11,107,7,11,107,8,11,107,9,11,107,10,11,107,11,11,107,12,11,107
db 13,11,107,14,11,107,15,11,108,16,11,108,17,11,108,18,11,108,6,12,106,7,12,107,8,12,107,9,12,107,10,12,107,11,12,107,12,12,107,13,12,107,14,12,108,15,12,108,16,12,108,17,12,108,18,12,108,5,13,107,6,13,107,7,13,107,8,13,107,9,13,107,10,13,107,11,13,107,12,13,107,13,13,108,14,13,108,15,13,108
db 16,13,108,17,13,108,18,13,108,19,13,108,5,14,106,6,14,107,7,14,107,8,14,107,9,14,107,10,14,107,11,14,107,12,14,107,13,14,108,14,14,108,15,14,108,16,14,108,17,14,108,18,14,108,19,14,108,4,15,108,5,15,106,6,15,107,7,15,107,8,15,107,9,15,107,10,15,107,11,15,107,12,15,108,13,15,108,14,15,108
db 15,15,108,16,15,108,17,15,108,18,15,108,19,15,108,20,15,108,4,16,106,5,16,106,6,16,107,7,16,107,8,16,107,9,16,107,10,16,107,11,16,107,12,16,108,13,16,108,14,16,108,15,16,108,16,16,108,17,16,108,18,16,108,19,16,108,20,16,108,3,17,107,4,17,106,5,17,107,6,17,107,7,17,107,8,17,107,9,17,107
db 10,17,107,11,17,107,12,17,108,13,17,108,14,17,108,15,17,108,16,17,108,17,17,108,18,17,108,19,17,108,20,17,108,21,17,108,3,18,106,4,18,107,5,18,107,6,18,107,7,18,107,8,18,107,9,18,107,10,18,107,11,18,108,12,18,108,13,18,108,14,18,108,15,18,108,16,18,108,17,18,108,18,18,108,19,18,108,20,18,108
db 21,18,108,2,19,107,3,19,107,4,19,107,5,19,107,6,19,107,7,19,107,8,19,107,9,19,107,10,19,107,11,19,108,12,19,108,13,19,108,14,19,108,15,19,108,16,19,108,17,19,108,18,19,108,19,19,108,20,19,108,21,19,108,22,19,108,2,20,106,3,20,107,4,20,107,5,20,107,6,20,107,7,20,107,8,20,107,9,20,107
db 10,20,108,11,20,108,12,20,108,13,20,108,14,20,108,15,20,108,16,20,108,17,20,108,18,20,108,19,20,108,20,20,108,21,20,108,22,20,108,1,21,107,2,21,107,3,21,107,4,21,107,5,21,107,6,21,107,7,21,107,8,21,107,9,21,107,10,21,108,11,21,108,12,21,108,13,21,108,14,21,108,15,21,108,16,21,108,17,21,108
db 18,21,108,19,21,108,20,21,108,21,21,108,22,21,108,23,21,108,1,22,106,2,22,107,3,22,107,4,22,107,5,22,107,6,22,107,7,22,107,8,22,107,9,22,107,10,22,108,11,22,108,12,22,108,13,22,108,14,22,108,15,22,108,16,22,108,17,22,108,18,22,108,19,22,108,20,22,108,21,22,108,22,22,108,23,22,108,0,23,107
db 1,23,107,2,23,107,3,23,107,4,23,107,5,23,107,6,23,107,7,23,107,8,23,107,9,23,107,10,23,108,11,23,108,12,23,108,13,23,108,14,23,108,15,23,108,16,23,108,17,23,108,18,23,108,19,23,108,20,23,108,21,23,108,22,23,108,23,23,108,24,23,108,0,24,106,1,24,107,2,24,107,3,24,107,4,24,107,5,24,107
db 6,24,107,7,24,107,8,24,107,9,24,107,10,24,108,11,24,108,12,24,108,13,24,108,14,24,108,15,24,108,16,24,108,17,24,108,18,24,108,19,24,108,20,24,108,21,24,108,22,24,108,23,24,108,24,24,108
shooterSize dw 25 
shooterBackGround db 11,0,107,12,0,107,13,0,107,11,1,107,12,1,107,13,1,107,10,2,107,11,2,106,12,2,107,13,2,107,14,2,107,10,3,106,11,3,107,12,3,107,13,3,107,14,3,107,9,4,107,10,4,106,11,4,107,12,4,107,13,4,107,14,4,107,15,4,107,9,5,106,10,5,106,11,5,107,12,5,107,13,5,107,14,5,107,15,5,107
db 8,6,107,9,6,106,10,6,107,11,6,107,12,6,107,13,6,107,14,6,107,15,6,107,16,6,108,8,7,106,9,7,107,10,7,107,11,7,107,12,7,107,13,7,107,14,7,107,15,7,107,16,7,108,7,8,107,8,8,106,9,8,107,10,8,107,11,8,107,12,8,107,13,8,107,14,8,107,15,8,107,16,8,108,17,8,108,7,9,107
db 8,9,107,9,9,107,10,9,107,11,9,107,12,9,107,13,9,107,14,9,107,15,9,108,16,9,108,17,9,108,6,10,107,7,10,106,8,10,107,9,10,107,10,10,107,11,10,107,12,10,107,13,10,107,14,10,107,15,10,108,16,10,108,17,10,108,18,10,108,6,11,107,7,11,107,8,11,107,9,11,107,10,11,107,11,11,107,12,11,107
db 13,11,107,14,11,107,15,11,108,16,11,108,17,11,108,18,11,108,6,12,106,7,12,107,8,12,107,9,12,107,10,12,107,11,12,107,12,12,107,13,12,107,14,12,108,15,12,108,16,12,108,17,12,108,18,12,108,5,13,107,6,13,107,7,13,107,8,13,107,9,13,107,10,13,107,11,13,107,12,13,107,13,13,108,14,13,108,15,13,108
db 16,13,108,17,13,108,18,13,108,19,13,108,5,14,106,6,14,107,7,14,107,8,14,107,9,14,107,10,14,107,11,14,107,12,14,107,13,14,108,14,14,108,15,14,108,16,14,108,17,14,108,18,14,108,19,14,108,4,15,108,5,15,106,6,15,107,7,15,107,8,15,107,9,15,107,10,15,107,11,15,107,12,15,108,13,15,108,14,15,108
db 15,15,108,16,15,108,17,15,108,18,15,108,19,15,108,20,15,108,4,16,106,5,16,106,6,16,107,7,16,107,8,16,107,9,16,107,10,16,107,11,16,107,12,16,108,13,16,108,14,16,108,15,16,108,16,16,108,17,16,108,18,16,108,19,16,108,20,16,108,3,17,107,4,17,106,5,17,107,6,17,107,7,17,107,8,17,107,9,17,107
db 10,17,107,11,17,107,12,17,108,13,17,108,14,17,108,15,17,108,16,17,108,17,17,108,18,17,108,19,17,108,20,17,108,21,17,108,3,18,106,4,18,107,5,18,107,6,18,107,7,18,107,8,18,107,9,18,107,10,18,107,11,18,108,12,18,108,13,18,108,14,18,108,15,18,108,16,18,108,17,18,108,18,18,108,19,18,108,20,18,108
db 21,18,108,2,19,107,3,19,107,4,19,107,5,19,107,6,19,107,7,19,107,8,19,107,9,19,107,10,19,107,11,19,108,12,19,108,13,19,108,14,19,108,15,19,108,16,19,108,17,19,108,18,19,108,19,19,108,20,19,108,21,19,108,22,19,108,2,20,106,3,20,107,4,20,107,5,20,107,6,20,107,7,20,107,8,20,107,9,20,107
db 10,20,108,11,20,108,12,20,108,13,20,108,14,20,108,15,20,108,16,20,108,17,20,108,18,20,108,19,20,108,20,20,108,21,20,108,22,20,108,1,21,107,2,21,107,3,21,107,4,21,107,5,21,107,6,21,107,7,21,107,8,21,107,9,21,107,10,21,108,11,21,108,12,21,108,13,21,108,14,21,108,15,21,108,16,21,108,17,21,108
db 18,21,108,19,21,108,20,21,108,21,21,108,22,21,108,23,21,108,1,22,106,2,22,107,3,22,107,4,22,107,5,22,107,6,22,107,7,22,107,8,22,107,9,22,107,10,22,108,11,22,108,12,22,108,13,22,108,14,22,108,15,22,108,16,22,108,17,22,108,18,22,108,19,22,108,20,22,108,21,22,108,22,22,108,23,22,108,0,23,107
db 1,23,107,2,23,107,3,23,107,4,23,107,5,23,107,6,23,107,7,23,107,8,23,107,9,23,107,10,23,108,11,23,108,12,23,108,13,23,108,14,23,108,15,23,108,16,23,108,17,23,108,18,23,108,19,23,108,20,23,108,21,23,108,22,23,108,23,23,108,24,23,108,0,24,106,1,24,107,2,24,107,3,24,107,4,24,107,5,24,107
db 6,24,107,7,24,107,8,24,107,9,24,107,10,24,108,11,24,108,12,24,108,13,24,108,14,24,108,15,24,108,16,24,108,17,24,108,18,24,108,19,24,108,20,24,108,21,24,108,22,24,108,23,24,108,24,24,108
shooterBackGroundSize dw 25   
Bullet db 5,0,113,6,0,113,7,0,113,8,0,113,9,0,113,3,1,113,4,1,113,5,1,113,6,1,113,7,1,113,8,1,113,9,1,113,10,1,41,11,1,41,2,2,113,3,2,113,4,2,113,5,2,113,6,2,113,7,2,113,8,2,113,9,2,113,10,2,41,11,2,41,12,2,41,1,3,113,2,3,113,3,3,113,4,3,113,5,3,185
db 6,3,113,7,3,113,8,3,113,9,3,41,10,3,41,11,3,41,12,3,41,13,3,41,1,4,113,2,4,113,3,4,113,4,4,113,5,4,113,6,4,113,7,4,113,8,4,113,9,4,41,10,4,41,11,4,41,12,4,41,13,4,41,0,5,113,1,5,113,2,5,113,3,5,113,4,5,113,5,5,113,6,5,185,7,5,113,8,5,41
db 9,5,41,10,5,41,11,5,41,12,5,41,13,5,41,14,5,41,0,6,113,1,6,113,2,6,113,3,6,113,4,6,113,5,6,113,6,6,113,7,6,41,8,6,41,9,6,41,10,6,41,11,6,41,12,6,41,13,6,41,14,6,41,0,7,113,1,7,113,2,7,113,3,7,113,4,7,113,5,7,113,6,7,113,7,7,41,8,7,41
db 9,7,41,10,7,41,11,7,41,12,7,41,13,7,41,14,7,41,0,8,113,1,8,113,2,8,113,3,8,113,4,8,113,5,8,113,6,8,41,7,8,41,8,8,41,9,8,41,10,8,41,11,8,41,12,8,41,13,8,41,14,8,41,0,9,113,1,9,113,2,9,113,3,9,113,4,9,113,5,9,113,6,9,41,7,9,41,8,9,41
db 9,9,41,10,9,41,11,9,41,12,9,41,13,9,41,14,9,41,1,10,113,2,10,113,3,10,41,4,10,113,5,10,113,6,10,41,7,10,41,8,10,41,9,10,41,10,10,41,11,10,41,12,10,41,13,10,41,1,11,113,2,11,113,3,11,113,4,11,113,5,11,113,6,11,41,7,11,41,8,11,41,9,11,41,10,11,41,11,11,41
db 12,11,41,13,11,41,2,12,113,3,12,113,4,12,113,5,12,41,6,12,41,7,12,41,8,12,41,9,12,41,10,12,41,11,12,41,12,12,41,3,13,113,4,13,113,5,13,41,6,13,41,7,13,41,8,13,41,9,13,41,10,13,41,11,13,41,5,14,41,6,14,41,7,14,41,8,14,41,9,14,41
bulletSize dw 15    
bulletBackGround db 5,0,113,6,0,113,7,0,113,8,0,113,9,0,113,3,1,113,4,1,113,5,1,113,6,1,113,7,1,113,8,1,113,9,1,113,10,1,41,11,1,41,2,2,113,3,2,113,4,2,113,5,2,113,6,2,113,7,2,113,8,2,113,9,2,113,10,2,41,11,2,41,12,2,41,1,3,113,2,3,113,3,3,113,4,3,113,5,3,185
db 6,3,113,7,3,113,8,3,113,9,3,41,10,3,41,11,3,41,12,3,41,13,3,41,1,4,113,2,4,113,3,4,113,4,4,113,5,4,113,6,4,113,7,4,113,8,4,113,9,4,41,10,4,41,11,4,41,12,4,41,13,4,41,0,5,113,1,5,113,2,5,113,3,5,113,4,5,113,5,5,113,6,5,185,7,5,113,8,5,41
db 9,5,41,10,5,41,11,5,41,12,5,41,13,5,41,14,5,41,0,6,113,1,6,113,2,6,113,3,6,113,4,6,113,5,6,113,6,6,113,7,6,41,8,6,41,9,6,41,10,6,41,11,6,41,12,6,41,13,6,41,14,6,41,0,7,113,1,7,113,2,7,113,3,7,113,4,7,113,5,7,113,6,7,113,7,7,41,8,7,41
db 9,7,41,10,7,41,11,7,41,12,7,41,13,7,41,14,7,41,0,8,113,1,8,113,2,8,113,3,8,113,4,8,113,5,8,113,6,8,41,7,8,41,8,8,41,9,8,41,10,8,41,11,8,41,12,8,41,13,8,41,14,8,41,0,9,113,1,9,113,2,9,113,3,9,113,4,9,113,5,9,113,6,9,41,7,9,41,8,9,41
db 9,9,41,10,9,41,11,9,41,12,9,41,13,9,41,14,9,41,1,10,113,2,10,113,3,10,41,4,10,113,5,10,113,6,10,41,7,10,41,8,10,41,9,10,41,10,10,41,11,10,41,12,10,41,13,10,41,1,11,113,2,11,113,3,11,113,4,11,113,5,11,113,6,11,41,7,11,41,8,11,41,9,11,41,10,11,41,11,11,41
db 12,11,41,13,11,41,2,12,113,3,12,113,4,12,113,5,12,41,6,12,41,7,12,41,8,12,41,9,12,41,10,12,41,11,12,41,12,12,41,3,13,113,4,13,113,5,13,41,6,13,41,7,13,41,8,13,41,9,13,41,10,13,41,11,13,41,5,14,41,6,14,41,7,14,41,8,14,41,9,14,41
bulletBackGroundSize dw 15     
birddown db 6,0,16,7,0,16,8,0,16,9,0,16,10,0,16,11,0,16,12,0,16,13,0,16,14,0,16,6,1,16,7,1,16,8,1,16,9,1,16,10,1,16,11,1,16,12,1,16,13,1,16,14,1,16,4,2,16,5,2,16,6,2,150,7,2,150,8,2,151,9,2,151,10,2,151,11,2,151,12,2,151,13,2,151,14,2,151,15,2,16
db 16,2,16,17,2,16,18,2,16,19,2,16,20,2,16,25,2,16,26,2,16,27,2,16,28,2,16,29,2,16,30,2,16,4,3,16,5,3,16,6,3,150,7,3,150,8,3,150,9,3,150,10,3,150,11,3,150,12,3,150,13,3,150,14,3,150,15,3,16,16,3,16,17,3,16,18,3,16,19,3,16,20,3,16,25,3,16,26,3,16
db 27,3,16,28,3,16,29,3,16,30,3,16,2,4,16,3,4,16,4,4,43,5,4,43,6,4,14,7,4,14,8,4,16,9,4,16,10,4,150,11,4,150,12,4,150,13,4,150,14,4,150,15,4,150,16,4,150,17,4,151,18,4,151,19,4,151,20,4,151,21,4,16,22,4,16,23,4,128,24,4,128,25,4,150,26,4,150,27,4,150
db 28,4,150,29,4,150,30,4,150,31,4,16,32,4,16,2,5,16,3,5,16,4,5,43,5,5,43,6,5,14,7,5,14,8,5,16,9,5,16,10,5,150,11,5,150,12,5,150,13,5,150,14,5,150,15,5,150,16,5,150,17,5,150,18,5,151,19,5,151,20,5,151,21,5,16,22,5,16,23,5,128,24,5,128,25,5,150,26,5,150
db 27,5,150,28,5,150,29,5,150,30,5,150,31,5,16,32,5,16,0,6,16,1,6,16,2,6,43,3,6,43,4,6,14,5,6,14,6,6,14,7,6,14,8,6,150,9,6,150,10,6,150,11,6,150,12,6,150,13,6,150,14,6,150,15,6,150,16,6,150,17,6,150,18,6,150,19,6,151,20,6,151,21,6,151,22,6,151,23,6,16
db 24,6,16,25,6,16,26,6,16,27,6,150,28,6,150,29,6,16,30,6,16,0,7,16,1,7,16,2,7,43,3,7,43,4,7,14,5,7,14,6,7,14,7,7,14,8,7,150,9,7,150,10,7,150,11,7,150,12,7,150,13,7,150,14,7,150,15,7,150,16,7,150,17,7,150,18,7,150,19,7,151,20,7,151,21,7,151,22,7,151
db 23,7,16,24,7,16,25,7,16,26,7,16,27,7,150,28,7,150,29,7,16,30,7,16,2,8,16,3,8,16,4,8,16,5,8,16,6,8,16,7,8,16,8,8,150,9,8,150,10,8,150,11,8,128,12,8,16,13,8,16,14,8,150,15,8,150,16,8,150,17,8,150,18,8,150,19,8,150,20,8,150,21,8,151,22,8,151,23,8,151
db 24,8,151,25,8,151,26,8,150,27,8,16,28,8,16,2,9,16,3,9,16,4,9,16,5,9,16,6,9,16,7,9,16,8,9,150,9,9,150,10,9,150,11,9,128,12,9,16,13,9,16,14,9,150,15,9,150,16,9,150,17,9,150,18,9,150,19,9,150,20,9,150,21,9,150,22,9,151,23,9,151,24,9,151,25,9,151,26,9,151
db 27,9,16,28,9,16,6,10,16,7,10,16,8,10,150,9,10,150,10,10,150,11,10,151,12,10,128,13,10,128,14,10,16,15,10,16,16,10,16,17,10,16,18,10,150,19,10,150,20,10,150,21,10,150,22,10,151,23,10,151,24,10,151,25,10,151,26,10,151,27,10,151,28,10,151,29,10,16,30,10,16,6,11,16,7,11,16,8,11,150
db 9,11,150,10,11,150,11,11,150,12,11,151,13,11,128,14,11,16,15,11,16,16,11,16,17,11,16,18,11,150,19,11,150,20,11,150,21,11,150,22,11,150,23,11,151,24,11,151,25,11,151,26,11,151,27,11,151,28,11,151,29,11,16,30,11,16,8,12,16,9,12,16,10,12,16,11,12,16,12,12,16,13,12,128,14,12,128,15,12,128
db 16,12,128,17,12,128,18,12,16,19,12,16,20,12,150,21,12,150,22,12,150,23,12,150,24,12,151,25,12,151,26,12,151,27,12,151,28,12,151,29,12,16,30,12,16,8,13,16,9,13,16,10,13,16,11,13,16,12,13,16,13,13,150,14,13,151,15,13,151,16,13,128,17,13,128,18,13,16,19,13,16,20,13,150,21,13,150,22,13,150
db 23,13,150,24,13,150,25,13,150,26,13,151,27,13,151,28,13,151,29,13,16,30,13,16,13,14,16,14,14,16,15,14,16,16,14,16,17,14,16,18,14,16,19,14,16,20,14,16,21,14,16,22,14,16,23,14,150,24,14,150,25,14,150,26,14,151,27,14,151,28,14,151,29,14,16,30,14,16,13,15,16,14,15,16,15,15,16,16,15,16
db 17,15,16,18,15,16,19,15,16,20,15,16,21,15,16,22,15,16,23,15,150,24,15,150,25,15,150,26,15,151,27,15,151,28,15,151,29,15,16,30,15,16,21,16,16,22,16,16,23,16,150,24,16,150,25,16,150,26,16,150,27,16,151,28,16,151,29,16,16,30,16,16,21,17,16,22,17,16,23,17,150,24,17,150,25,17,150,26,17,150
db 27,17,150,28,17,151,29,17,16,30,17,16,21,18,16,22,18,16,23,18,150,24,18,150,25,18,150,26,18,150,27,18,150,28,18,151,29,18,16,30,18,16,23,19,16,24,19,16,25,19,150,26,19,150,27,19,150,28,19,150,29,19,16,30,19,16,23,20,16,24,20,16,25,20,16,26,20,16,27,20,16,28,20,16,25,21,16,26,21,16
db 27,21,16,28,21,16
birddownSize dw 22 
birddownBackGround db 6,0,15,7,0,15,8,0,15,9,0,15,10,0,15,11,0,15,12,0,15,13,0,15,14,0,15,6,1,15,7,1,15,8,1,15,9,1,15,10,1,15,11,1,15,12,1,15,13,1,15,14,1,15,4,2,15,5,2,15,6,2,15,7,2,15,8,2,15,9,2,15,10,2,15,11,2,15,12,2,15,13,2,15,14,2,15,15,2,15
db 16,2,15,17,2,15,18,2,15,19,2,15,20,2,15,25,2,15,26,2,15,27,2,15,28,2,15,29,2,15,30,2,15,4,3,15,5,3,15,6,3,15,7,3,15,8,3,15,9,3,15,10,3,15,11,3,15,12,3,15,13,3,15,14,3,15,15,3,15,16,3,15,17,3,15,18,3,15,19,3,15,20,3,15,25,3,15,26,3,15
db 27,3,15,28,3,15,29,3,15,30,3,15,2,4,15,3,4,15,4,4,15,5,4,15,6,4,15,7,4,15,8,4,15,9,4,15,10,4,15,11,4,15,12,4,15,13,4,15,14,4,15,15,4,15,16,4,15,17,4,15,18,4,15,19,4,15,20,4,15,21,4,15,22,4,15,23,4,15,24,4,15,25,4,15,26,4,15,27,4,15
db 28,4,15,29,4,15,30,4,15,31,4,15,32,4,15,2,5,15,3,5,15,4,5,15,5,5,15,6,5,15,7,5,15,8,5,15,9,5,15,10,5,15,11,5,15,12,5,15,13,5,15,14,5,15,15,5,15,16,5,15,17,5,15,18,5,15,19,5,15,20,5,15,21,5,15,22,5,15,23,5,15,24,5,15,25,5,15,26,5,15
db 27,5,15,28,5,15,29,5,15,30,5,15,31,5,15,32,5,15,0,6,15,1,6,15,2,6,15,3,6,15,4,6,15,5,6,15,6,6,15,7,6,15,8,6,15,9,6,15,10,6,15,11,6,15,12,6,15,13,6,15,14,6,15,15,6,15,16,6,15,17,6,15,18,6,15,19,6,15,20,6,15,21,6,15,22,6,15,23,6,15
db 24,6,15,25,6,15,26,6,15,27,6,15,28,6,15,29,6,15,30,6,15,0,7,15,1,7,15,2,7,15,3,7,15,4,7,15,5,7,15,6,7,15,7,7,15,8,7,15,9,7,15,10,7,15,11,7,15,12,7,15,13,7,15,14,7,15,15,7,15,16,7,15,17,7,15,18,7,15,19,7,15,20,7,15,21,7,15,22,7,15
db 23,7,15,24,7,15,25,7,15,26,7,15,27,7,15,28,7,15,29,7,15,30,7,15,2,8,15,3,8,15,4,8,15,5,8,15,6,8,15,7,8,15,8,8,15,9,8,15,10,8,15,11,8,15,12,8,15,13,8,15,14,8,15,15,8,15,16,8,15,17,8,15,18,8,15,19,8,15,20,8,15,21,8,15,22,8,15,23,8,15
db 24,8,15,25,8,15,26,8,15,27,8,15,28,8,15,2,9,15,3,9,15,4,9,15,5,9,15,6,9,15,7,9,15,8,9,15,9,9,15,10,9,15,11,9,15,12,9,15,13,9,15,14,9,15,15,9,15,16,9,15,17,9,15,18,9,15,19,9,15,20,9,15,21,9,15,22,9,15,23,9,15,24,9,15,25,9,15,26,9,15
db 27,9,15,28,9,15,6,10,15,7,10,15,8,10,15,9,10,15,10,10,15,11,10,15,12,10,15,13,10,15,14,10,15,15,10,15,16,10,15,17,10,15,18,10,15,19,10,15,20,10,15,21,10,15,22,10,15,23,10,15,24,10,15,25,10,15,26,10,15,27,10,15,28,10,15,29,10,15,30,10,15,6,11,15,7,11,15,8,11,15
db 9,11,15,10,11,15,11,11,15,12,11,15,13,11,15,14,11,15,15,11,15,16,11,15,17,11,15,18,11,15,19,11,15,20,11,15,21,11,15,22,11,15,23,11,15,24,11,15,25,11,15,26,11,15,27,11,15,28,11,15,29,11,15,30,11,15,8,12,15,9,12,15,10,12,15,11,12,15,12,12,15,13,12,15,14,12,15,15,12,15
db 16,12,15,17,12,15,18,12,15,19,12,15,20,12,15,21,12,15,22,12,15,23,12,15,24,12,15,25,12,15,26,12,15,27,12,15,28,12,15,29,12,15,30,12,15,8,13,15,9,13,15,10,13,15,11,13,15,12,13,15,13,13,15,14,13,15,15,13,15,16,13,15,17,13,15,18,13,15,19,13,15,20,13,15,21,13,15,22,13,15
db 23,13,15,24,13,15,25,13,15,26,13,15,27,13,15,28,13,15,29,13,15,30,13,15,13,14,15,14,14,15,15,14,15,16,14,15,17,14,15,18,14,15,19,14,15,20,14,15,21,14,15,22,14,15,23,14,15,24,14,15,25,14,15,26,14,15,27,14,15,28,14,15,29,14,15,30,14,15,13,15,15,14,15,15,15,15,15,16,15,15
db 17,15,15,18,15,15,19,15,15,20,15,15,21,15,15,22,15,15,23,15,15,24,15,15,25,15,15,26,15,15,27,15,15,28,15,15,29,15,15,30,15,15,21,16,15,22,16,15,23,16,15,24,16,15,25,16,15,26,16,15,27,16,15,28,16,15,29,16,15,30,16,15,21,17,15,22,17,15,23,17,15,24,17,15,25,17,15,26,17,15
db 27,17,15,28,17,15,29,17,15,30,17,15,21,18,15,22,18,15,23,18,15,24,18,15,25,18,15,26,18,15,27,18,15,28,18,15,29,18,15,30,18,15,23,19,15,24,19,15,25,19,15,26,19,15,27,19,15,28,19,15,29,19,15,30,19,15,23,20,15,24,20,15,25,20,15,26,20,15,27,20,15,28,20,15,25,21,15,26,21,15
db 27,21,15,28,21,15
birddownBackGroundSize dw 22  
 birdup db 23,0,16,24,0,16,25,0,16,26,0,16,27,0,16,28,0,16,29,0,16,30,0,16,23,1,16,24,1,16,25,1,16,26,1,16,27,1,16,28,1,16,29,1,16,30,1,16,19,2,16,20,2,16,21,2,16,22,2,16,23,2,128,24,2,128,25,2,128,26,2,128,27,2,128,28,2,128,29,2,128,30,2,128,31,2,16,32,2,16
db 19,3,16,20,3,16,21,3,16,22,3,16,23,3,128,24,3,151,25,3,151,26,3,151,27,3,151,28,3,151,29,3,151,30,3,151,31,3,16,32,3,16,6,4,16,7,4,16,8,4,16,9,4,16,10,4,16,11,4,16,12,4,16,13,4,16,14,4,16,17,4,16,18,4,16,19,4,128,20,4,128,21,4,128,22,4,128,23,4,151
db 24,4,151,25,4,151,26,4,151,27,4,151,28,4,151,29,4,151,30,4,151,31,4,16,32,4,16,6,5,16,7,5,16,8,5,16,9,5,16,10,5,16,11,5,16,12,5,16,13,5,16,14,5,16,17,5,16,18,5,16,19,5,128,20,5,128,21,5,128,22,5,151,23,5,151,24,5,151,25,5,151,26,5,150,27,5,150,28,5,150
db 29,5,150,30,5,150,31,5,16,32,5,16,4,6,16,5,6,16,6,6,128,7,6,128,8,6,128,9,6,128,10,6,128,11,6,128,12,6,128,13,6,128,14,6,128,15,6,16,16,6,16,17,6,128,18,6,128,19,6,128,20,6,151,21,6,151,22,6,151,23,6,151,24,6,151,25,6,151,26,6,150,27,6,150,28,6,150,29,6,16
db 30,6,16,4,7,16,5,7,16,6,7,128,7,7,151,8,7,151,9,7,151,10,7,151,11,7,151,12,7,151,13,7,151,14,7,128,15,7,16,16,7,16,17,7,128,18,7,151,19,7,151,20,7,151,21,7,151,22,7,151,23,7,151,24,7,150,25,7,150,26,7,150,27,7,150,28,7,150,29,7,16,30,7,16,2,8,16,3,8,16
db 4,8,43,5,8,43,6,8,14,7,8,14,8,8,16,9,8,16,10,8,150,11,8,150,12,8,150,13,8,151,14,8,151,15,8,128,16,8,128,17,8,128,18,8,151,19,8,151,20,8,151,21,8,151,22,8,151,23,8,150,24,8,150,25,8,16,26,8,16,27,8,16,28,8,16,2,9,16,3,9,16,4,9,43,5,9,43,6,9,14
db 7,9,14,8,9,16,9,9,16,10,9,150,11,9,150,12,9,150,13,9,150,14,9,151,15,9,151,16,9,151,17,9,151,18,9,151,19,9,151,20,9,151,21,9,151,22,9,150,23,9,150,24,9,150,25,9,16,26,9,16,27,9,16,28,9,16,0,10,16,1,10,16,2,10,43,3,10,43,4,10,14,5,10,14,6,10,14,7,10,14
db 8,10,150,9,10,150,10,10,150,11,10,150,12,10,150,13,10,150,14,10,150,15,10,151,16,10,151,17,10,151,18,10,151,19,10,151,20,10,150,21,10,150,22,10,150,23,10,16,24,10,16,25,10,151,26,10,151,27,10,151,28,10,151,29,10,16,30,10,16,0,11,16,1,11,16,2,11,43,3,11,43,4,11,14,5,11,14,6,11,14
db 7,11,14,8,11,150,9,11,150,10,11,150,11,11,150,12,11,150,13,11,150,14,11,150,15,11,150,16,11,150,17,11,150,18,11,150,19,11,150,20,11,150,21,11,150,22,11,150,23,11,16,24,11,16,25,11,151,26,11,151,27,11,150,28,11,150,29,11,16,30,11,16,2,12,16,3,12,16,4,12,16,5,12,16,6,12,16,7,12,16
db 8,12,151,9,12,151,10,12,150,11,12,150,12,12,150,13,12,150,14,12,150,15,12,150,16,12,150,17,12,150,18,12,150,19,12,16,20,12,16,21,12,16,22,12,16,23,12,151,24,12,151,25,12,151,26,12,150,27,12,150,28,12,150,29,12,16,30,12,16,2,13,16,3,13,16,4,13,16,5,13,16,6,13,16,7,13,16,8,13,128
db 9,13,151,10,13,150,11,13,150,12,13,150,13,13,150,14,13,150,15,13,150,16,13,150,17,13,150,18,13,150,19,13,16,20,13,16,21,13,16,22,13,16,23,13,151,24,13,151,25,13,150,26,13,150,27,13,150,28,13,150,29,13,16,30,13,16,6,14,16,7,14,16,8,14,128,9,14,151,10,14,151,11,14,150,12,14,150,13,14,150
db 14,14,150,15,14,150,16,14,150,17,14,150,18,14,150,19,14,151,20,14,151,21,14,151,22,14,151,23,14,150,24,14,150,25,14,150,26,14,150,27,14,16,28,14,16,6,15,16,7,15,16,8,15,128,9,15,128,10,15,128,11,15,151,12,15,151,13,15,151,14,15,150,15,15,150,16,15,150,17,15,150,18,15,150,19,15,150,20,15,150
db 21,15,150,22,15,150,23,15,150,24,15,150,25,15,150,26,15,150,27,15,16,28,15,16,8,16,16,9,16,16,10,16,16,11,16,16,12,16,16,13,16,151,14,16,151,15,16,150,16,16,150,17,16,150,18,16,150,19,16,150,20,16,150,21,16,150,22,16,150,23,16,16,24,16,16,25,16,16,26,16,16,8,17,16,9,17,16,10,17,16
db 11,17,16,12,17,16,13,17,151,14,17,151,15,17,151,16,17,151,17,17,150,18,17,150,19,17,150,20,17,150,21,17,150,22,17,150,23,17,16,24,17,16,25,17,16,26,17,16,13,18,16,14,18,16,15,18,16,16,18,16,17,18,16,18,18,16,19,18,16,20,18,16,21,18,16,22,18,16,13,19,16,14,19,16,15,19,16,16,19,16
db 17,19,16,18,19,16,19,19,16,20,19,16,21,19,16,22,19,16
birdupSize dw 20 
birdupBackGround db 23,0,15,24,0,15,25,0,15,26,0,15,27,0,15,28,0,15,29,0,15,30,0,15,23,1,15,24,1,15,25,1,15,26,1,15,27,1,15,28,1,15,29,1,15,30,1,15,19,2,15,20,2,15,21,2,15,22,2,15,23,2,15,24,2,15,25,2,15,26,2,15,27,2,15,28,2,15,29,2,15,30,2,15,31,2,15,32,2,15
db 19,3,15,20,3,15,21,3,15,22,3,15,23,3,15,24,3,15,25,3,15,26,3,15,27,3,15,28,3,15,29,3,15,30,3,15,31,3,15,32,3,15,6,4,15,7,4,15,8,4,15,9,4,15,10,4,15,11,4,15,12,4,15,13,4,15,14,4,15,17,4,15,18,4,15,19,4,15,20,4,15,21,4,15,22,4,15,23,4,15
db 24,4,15,25,4,15,26,4,15,27,4,15,28,4,15,29,4,15,30,4,15,31,4,15,32,4,15,6,5,15,7,5,15,8,5,15,9,5,15,10,5,15,11,5,15,12,5,15,13,5,15,14,5,15,17,5,15,18,5,15,19,5,15,20,5,15,21,5,15,22,5,15,23,5,15,24,5,15,25,5,15,26,5,15,27,5,15,28,5,15
db 29,5,15,30,5,15,31,5,15,32,5,15,4,6,15,5,6,15,6,6,15,7,6,15,8,6,15,9,6,15,10,6,15,11,6,15,12,6,15,13,6,15,14,6,15,15,6,15,16,6,15,17,6,15,18,6,15,19,6,15,20,6,15,21,6,15,22,6,15,23,6,15,24,6,15,25,6,15,26,6,15,27,6,15,28,6,15,29,6,15
db 30,6,15,4,7,15,5,7,15,6,7,15,7,7,15,8,7,15,9,7,15,10,7,15,11,7,15,12,7,15,13,7,15,14,7,15,15,7,15,16,7,15,17,7,15,18,7,15,19,7,15,20,7,15,21,7,15,22,7,15,23,7,15,24,7,15,25,7,15,26,7,15,27,7,15,28,7,15,29,7,15,30,7,15,2,8,15,3,8,15
db 4,8,15,5,8,15,6,8,15,7,8,15,8,8,15,9,8,15,10,8,15,11,8,15,12,8,15,13,8,15,14,8,15,15,8,15,16,8,15,17,8,15,18,8,15,19,8,15,20,8,15,21,8,15,22,8,15,23,8,15,24,8,15,25,8,15,26,8,15,27,8,15,28,8,15,2,9,15,3,9,15,4,9,15,5,9,15,6,9,15
db 7,9,15,8,9,15,9,9,15,10,9,15,11,9,15,12,9,15,13,9,15,14,9,15,15,9,15,16,9,15,17,9,15,18,9,15,19,9,15,20,9,15,21,9,15,22,9,15,23,9,15,24,9,15,25,9,15,26,9,15,27,9,15,28,9,15,0,10,15,1,10,15,2,10,15,3,10,15,4,10,15,5,10,15,6,10,15,7,10,15
db 8,10,15,9,10,15,10,10,15,11,10,15,12,10,15,13,10,15,14,10,15,15,10,15,16,10,15,17,10,15,18,10,15,19,10,15,20,10,15,21,10,15,22,10,15,23,10,15,24,10,15,25,10,15,26,10,15,27,10,15,28,10,15,29,10,15,30,10,15,0,11,15,1,11,15,2,11,15,3,11,15,4,11,15,5,11,15,6,11,15
db 7,11,15,8,11,15,9,11,15,10,11,15,11,11,15,12,11,15,13,11,15,14,11,15,15,11,15,16,11,15,17,11,15,18,11,15,19,11,15,20,11,15,21,11,15,22,11,15,23,11,15,24,11,15,25,11,15,26,11,15,27,11,15,28,11,15,29,11,15,30,11,15,2,12,15,3,12,15,4,12,15,5,12,15,6,12,15,7,12,15
db 8,12,15,9,12,15,10,12,15,11,12,15,12,12,15,13,12,15,14,12,15,15,12,15,16,12,15,17,12,15,18,12,15,19,12,15,20,12,15,21,12,15,22,12,15,23,12,15,24,12,15,25,12,15,26,12,15,27,12,15,28,12,15,29,12,15,30,12,15,2,13,15,3,13,15,4,13,15,5,13,15,6,13,15,7,13,15,8,13,15
db 9,13,15,10,13,15,11,13,15,12,13,15,13,13,15,14,13,15,15,13,15,16,13,15,17,13,15,18,13,15,19,13,15,20,13,15,21,13,15,22,13,15,23,13,15,24,13,15,25,13,15,26,13,15,27,13,15,28,13,15,29,13,15,30,13,15,6,14,15,7,14,15,8,14,15,9,14,15,10,14,15,11,14,15,12,14,15,13,14,15
db 14,14,15,15,14,15,16,14,15,17,14,15,18,14,15,19,14,15,20,14,15,21,14,15,22,14,15,23,14,15,24,14,15,25,14,15,26,14,15,27,14,15,28,14,15,6,15,15,7,15,15,8,15,15,9,15,15,10,15,15,11,15,15,12,15,15,13,15,15,14,15,15,15,15,15,16,15,15,17,15,15,18,15,15,19,15,15,20,15,15
db 21,15,15,22,15,15,23,15,15,24,15,15,25,15,15,26,15,15,27,15,15,28,15,15,8,16,15,9,16,15,10,16,15,11,16,15,12,16,15,13,16,15,14,16,15,15,16,15,16,16,15,17,16,15,18,16,15,19,16,15,20,16,15,21,16,15,22,16,15,23,16,15,24,16,15,25,16,15,26,16,15,8,17,15,9,17,15,10,17,15
db 11,17,15,12,17,15,13,17,15,14,17,15,15,17,15,16,17,15,17,17,15,18,17,15,19,17,15,20,17,15,21,17,15,22,17,15,23,17,15,24,17,15,25,17,15,26,17,15,13,18,15,14,18,15,15,18,15,16,18,15,17,18,15,18,18,15,19,18,15,20,18,15,21,18,15,22,18,15,13,19,15,14,19,15,15,19,15,16,19,15
db 17,19,15,18,19,15,19,19,15,20,19,15,21,19,15,22,19,15
birdupBackGroundSize dw 20 
;======================================================================================================================================
 .CODE
;======================================================================================================================================
;this macro draws a moving object and then saves the previous background to a the same dimansion img
;======================================================================================================================================

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
        LOCAL NOCHANGE,CHECKDOWN,SHIFT,CHECKSPEED
        PUSH AX
        PUSH CX
        PUSH DX
        CMP BIRD1_X,0
        JNE CHECKSPEED
        call DRAW_BIRDUP_BACKGROUND
        MOV BIRD1_X,600
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
                DRAW_MOIVNG_OBJECT shooter shooterBackground shooterSize P1_Y P1_X      
        NOCHANGE:

ENDM DRAW_PLAYER 
DRAW_BULLET MACRO KEY
        LOCAL NOCHANGE,DRAW,CHECKSPACE,CHECKMOVING
        PUSH AX
        PUSH CX
        PUSH DX
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
                CMP BULLET1_Y,10
                JNE CHECKMOVING
                MOV BULLET1_MOVING,0
                CALL DRAW_BULLET_BACKGROUND
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
        DRAW_MOIVNG_OBJECT shooter shooterBackground shooterSize P1_Y P1_X
        PRINT_4_DIGIT_GRAPHICS 22, 10, CX, RED


        ;==================
MAINLOOP:
        mov ah,1
        int 16h
        INC TIME
        CMP TIME,0FFFFh
        JNE  Continue
        MOV TIME,0
Continue:
        DRAW_PLAYER P1_Y P1_X AH
        DRAW_BULLET AH
        DRAW_BIRD
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
END      MAIN
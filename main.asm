.MODEL SMALL
.STACK 64
.DATA
;========================
;        P1 DATA        
;========================
USERNAME_LENGTH EQU 15
P1_USERNAME_BUFF DB USERNAME_LENGTH
P1_USERNAME_SIZE DB 0
P1_USERNAME DB (USERNAME_LENGTH + 1) DUP('$')

;UNSIGNED 4-DIGIT NUMBER
P1_INITIAL_POINTS DW ?              
;========================
;        GFX DATA        
;========================
;------------------------
;      START SCREEN      
;------------------------
INCLUDE screens.inc

.CODE
MAIN PROC FAR
    ;Initialize Data Segment
    MOV AX, @DATA
    MOV DS, AX
    ;End initialize

    RUN_STRT_SCREEN P1_USERNAME_BUFF, P1_INITIAL_POINTS
    
    ;Safely return to OS
    MOV AX, 4C00H
    INT 21H
MAIN ENDP
END MAIN
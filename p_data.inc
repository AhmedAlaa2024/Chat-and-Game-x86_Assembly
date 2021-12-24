;=============================================
;              LOCAL-PLAYER DATA              |
;=============================================
P1_DATA LABEL BYTE
P1_AX LABEL WORD
P1_AL DB 0
P1_AH DB 0

P1_CX LABEL WORD
P1_CL DB 0
P1_CH DB 0

P1_DX LABEL WORD
P1_DL DB 0
P1_DH DB 0

P1_BX LABEL WORD
P1_BL DB 0
P1_BH DB 0

P1_SI DW 0
P1_DI DW 0
P1_BP DW 0
P1_SP DW 0

P1_MEM DB 16 dup(0)

P1_IMMED DW 0
;=============================================
;             NETWORK-PLAYER DATA             |
;=============================================
P2_DATA LABEL BYTE
P2_AX LABEL WORD
P2_AL DB 0
P2_AH DB 0

P2_CX LABEL WORD
P2_CL DB 0
P2_CH DB 0

P2_DX LABEL WORD
P2_DL DB 0
P2_DH DB 0

P2_BX LABEL WORD
P2_BL DB 0
P2_BH DB 0

P2_SI DW 0
P2_DI DW 0
P2_BP DW 0
P2_SP DW 0

P2_MEM DB 16 dup(0)

P2_IMMED DW 0
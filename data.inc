CMD_ARR LABEL BYTE
;=============================================
;         Arithmatic Operations Strings       |
;=============================================
ADD_STR  DB  'ADD$'
ADC_STR  DB  'ADC$'
SUB_STR  DB  'SUB$'
SBB_STR  DB  'SBB$'
MUL_STR  DB  'MUL$'
DIV_STR  DB  'DIV$'
IMUL_STR DB  'IMUL$'
IDIV_STR DB  'IDIV$'
INC_STR  DB  'INC$'
DEC_STR  DB  'DEC$'
;=============================================
;         Bitwise Operations Strings          |
;=============================================
XOR_STR  DB  'XOR$'
AND_STR  DB  'AND$'
OR_STR   DB  'OR$'
SHR_STR  DB  'SHR$'
SHL_STR  DB  'SHL$'
SAR_STR  DB  'SAR$'
ROR_STR  DB  'ROR$'
RCL_STR  DB  'RCL$'
RCR_STR  DB  'RCR$'
ROL_STR  DB  'ROL$'
;=============================================
;           Other Operations Strings          |
;=============================================
MOV_STR  DB  'MOV$'
NOP_STR  DB  'NOP$'
CLC_STR  DB  'CLC$'
STC_STR  DB  'STC$'

CMD_ARR_SIZE EQU $ - CMD_ARR



CMD_OPERANDS_ARR LABEL BYTE
;=============================================
;Each commmand has one byte which contains
;flags that determines the properties
;of its operands:
;
;Byte: b7-0
;
;b7: Whether the command has a first operand
;b6: first operand supports immediate
;b5: first operand supports register
;b4: first operand supports memory
;b3: Whether the command has a second operand
;b2-0: Same flags as first operand
;=============================================
;=============================================
;         Arithmatic Operands Strings         |
;=============================================
ADD_OPS  DB  10111111B
ADC_OPS  DB  10111111B
SUB_OPS  DB  10111111B
SBB_OPS  DB  10111111B
MUL_OPS  DB  10110000B
DIV_OPS  DB  10110000B
IMUL_OPS DB  10110000B
IDIV_OPS DB  10110000B
INC_OPS  DB  10110000B
DEC_OPS  DB  10110000B
;=============================================
;         Bitwise Operands Strings            |
;=============================================
XOR_OPS  DB  10111111B
AND_OPS  DB  10111111B
OR_OPS   DB  10111111B
SHR_OPS  DB  10110101B
SHL_OPS  DB  10110101B
SAR_OPS  DB  10110101B
ROR_OPS  DB  10110101B
RCL_OPS  DB  10110101B
RCR_OPS  DB  10110101B
ROL_OPS  DB  10110101B
;=============================================
;           Other Operands Strings            |
;=============================================
MOV_OPS  DB  10111111B
NOP_OPS  DB  00000000B
CLC_OPS  DB  00000000B
STC_OPS  DB  00000000B

CMD_OPERANDS_SIZE EQU $ - CMD_OPERANDS_ARR
;=============================================
;              REGISTERS STRINGS              |
;=============================================
REG_STR_ARR LABEL BYTE
AX_STR DB 'AX'
AL_STR DB 'AL'
AH_STR DB 'AH'
BX_STR DB 'BX'
BL_STR DB 'BL'
BH_STR DB 'BH'
CX_STR DB 'CX'
CL_STR DB 'CL'
CH_STR DB 'CH'
DX_STR DB 'DX'
DL_STR DB 'DL'
DH_STR DB 'DH'
SI_STR DB 'SI'
DI_STR DB 'DI'
BP_STR DB 'BP'
SP_STR DB 'SP'
REG_STR_ARR_SIZE EQU $ - REG_STR_ARR
;=============================================
;             Miscellaneous Data              |
;=============================================
CMD_FLAG  DB 0
OP_FLAGS  DB 0
OP1_PROPERTY DB ?
OP1_LOCATION DW ?
OP2_PROPERTY DB ?
OP2_LOCATION DW ?

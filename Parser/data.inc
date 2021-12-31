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
SHR_OPS  DB  10110110B
SHL_OPS  DB  10110110B
SAR_OPS  DB  10110110B
ROR_OPS  DB  10110110B
RCL_OPS  DB  10110110B
RCR_OPS  DB  10110110B
ROL_OPS  DB  10110110B
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
;Each additional byte represents the size     |
;and the offset of its memory location in     |
;p_data                                       |
;=============================================
REG_STR_ARR LABEL BYTE
AX_STR DB 'AX', 10000000B 
AL_STR DB 'AL', 01000000B
AH_STR DB 'AH', 01000001B
CX_STR DB 'CX', 10000010B
CL_STR DB 'CL', 01000010B
CH_STR DB 'CH', 01000011B
DX_STR DB 'DX', 10000100B
DL_STR DB 'DL', 01000100B
DH_STR DB 'DH', 01000101B
BX_STR DB 'BX', 10000110B
BL_STR DB 'BL', 01000110B
BH_STR DB 'BH', 01000111B
SI_STR DB 'SI', 10001000B
DI_STR DB 'DI', 10001010B
BP_STR DB 'BP', 10001100B
SP_STR DB 'SP', 10001110B 
REG_STR_ARR_SIZE EQU $ - REG_STR_ARR
;=============================================
;             Miscellaneous Data              |
;=============================================

;=============================================
;Each Operand has one byte which contains
;flags that determines its properties
;Note that memory can be treated as both
;16 and 8 bits
;
;Byte: b7-0
;
;b7: The operand is immediate
;b6: The operand is register
;b5: The operand is memory
;b4: The operand is 16-bits
;b3: The operand is 8-bits
;b2-0: Unused
;=============================================


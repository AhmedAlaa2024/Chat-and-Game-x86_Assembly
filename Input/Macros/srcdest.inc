;===========================================================================================
; Function: DETECT_SRC                                                                      |
; TESTED:   FALSE                                                                           |
; Input: <String:MSG> = The Command starting from the src                                   |
; Output: <address:SRC> = The address of the source,                                        |
; Description:                                                                              |
;               1. Detect the source then assign it to SRC as a memory location.            |
;===========================================================================================
DETECT_SRC MACRO MSG,SRC

ENDM DETECT_SRC
;===========================================================================================
; Function: DETECT_DEST                                                                     |
; TESTED:   FALSE                                                                           |
; Input: <String:MSG> = The Command starting from the DEST                                  |
; Output: <address:SRC> = The address of the source,                                        |
; Description:                                                                              |
;               1. Detect the destnation then assign it to DEST as a memory location.       |
;===========================================================================================
DETECT_DEST MACRO MSG,DEST
;check for the ',' dont forget    
ENDM DETECT_DEST
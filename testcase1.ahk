#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
MsgBox,TestCase1 Script is running 
Time := 2000
Tab::
Send,
(
kamal
)
sleep, Time
Send,
(

4321

)
sleep, Time
Send,
(

Kotp

)
sleep, Time
Send,
(

5162

)
sleep, Time
Send,
(

c
)
sleep, Time
Send,
(

4
)
sleep, Time
Send,
(

1

)
sleep, 2500
Send,
(
mov ax,123
)
sleep, Time
Send,
(

sub ax,1
)
sleep, Time
Send,
(

XOR AX, 4
)
sleep, Time
Send,
(

add SP,0abc
)
sleep, Time
Send,
(

add sp,ax
)
sleep, Time
Send,
(

mov bx,0ffff
)
sleep, Time
Send,
(

mov bx,0fbef
)
sleep, Time
Send,
(

mul bl
)
sleep, Time
Send,{Enter}
Send, {F2}
Send,
(
mov [a],0ffbe
)
sleep, Time
Send,
(

mov [a],[b]
)
sleep, Time
Send,
(

adc [f],0bca1
)
sleep,Time
Send,{Enter}
sleep, 1000
Send, {F5}
sleep, Time
Send,
(
adc AX,0105e
)
sleep,Time
Send,{Enter}
sleep,Time
Send,
(
adc AX,0105E
)
sleep,Time
Send,{Enter}
Send, {F1}
Send,
(
XOR AX,AX
)
sleep,Time
Send,
(

OR AX, 0105E
)
sleep,Time
Send,{Enter}
return
Esc::ExitApp  ; Exit script with Escape key
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
MsgBox,TestCase2 Script is running 
Time := 2000
Tab::
Send,
(
Player1
)
sleep, Time
Send,
(

9999

)
sleep, Time
Send,
(

Player2

)
sleep, Time
Send,
(

60

)
sleep, Time
Send,
(

a
)
sleep, Time
Send,
(

b
)
sleep, Time
Send,
(

2

)
sleep, Time
send,
(
1

)
sleep, 20
send,
(
2

)
sleep, 20
send,
(
3

)
sleep, 20
send,
(
4

)
sleep, 20
send,
(
5

)
sleep, 20
send,
(
6

)
sleep, 20
send,
(
7

)
sleep, 20
send,
(
8

)
sleep, 20
send,
(
9

)
sleep, 20
send,
(
a123
)
sleep, 20
send,
(
b0b

)
sleep, 20
send,
(
cac

)
sleep, 20
send,
(
dab

)
sleep, 20
send,
(
e34

)
sleep, 20
send,
(
f5

)
sleep, 20
send,
(
0

)
sleep, 2500
Send, {F1}
Send,
(
ADD ax, 0A122
)
sleep, Time
Send,
(

sub SP, 5EE5
)
sleep, Time
Send,
(

d
)
sleep, Time
Send, {F3}
Send,
(
add SP,0abd
)
sleep, Time
Send,
(

MOV DI,123
)
sleep, Time
Send,
(

mov bx,0ffff
)
sleep, Time
Send,
(

A123 0DAB
)
sleep, Time
Send, {F6}
sleep, Time
Send,
(
NOP
)
sleep, Time
Send,{Enter}
Send,
(
A123 FFFF
)
sleep, Time
Send, {F6}
sleep, 2500
Send,
(
move ax, 105e
)
sleep, Time
Send,{Enter}
return
Esc::ExitApp  ; Exit script with Escape key
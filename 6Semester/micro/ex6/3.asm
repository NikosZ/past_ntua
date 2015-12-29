
.include "m16def.inc"
.DEF temp=r21
.DEF zero=r22
.DEF temp2=r19
.org 0
clr temp
clr zero
out DDRD,temp
ser temp
out PORTD,temp ; pull up C port
out DDRB,temp ; porta enable for output
Start:
clr temp
ldi temp,1
out PORTB,temp
Input:
in temp2,PIND ;take SW input
cpi temp2,3 ; first action
breq F1
cpi temp2,5 ;second action etc
breq F2
cpi temp2,6
breq F3
cpi temp2,9
breq F4
cpi temp2,10
breq F5
cpi temp2,12
breq Start ;reset
cpi temp2,7
breq Start
cpi temp2,11
breq Start
cpi temp2,14
breq Start
cpi temp2,15
breq Start
jmp Input ;do it again

F1:
lsl temp
out PORTB,temp ;rotate leds
jmp Input
F2:
lsr temp
out PORTB,temp ;rotate leds
jmp Input
F3:
lsl temp
lsl temp ; rotate 2 times left
out PORTB,temp
jmp Input
F4:
lsr temp
lsr temp ;ratate 2 times right
out PORTB,temp
jmp Input
F5:
ldi temp,3 ; leds 0-1
out PORTB,temp
jmp Input

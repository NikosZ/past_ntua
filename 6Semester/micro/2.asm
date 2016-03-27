.include "m16def.inc"
.DEF temp=r21
.DEF x0=r22
.DEF x1=r20
.DEF temp2=r19
.org 0
clr temp
out DDRC,temp
ser temp
out PORTC,temp ; pull up C port
out DDRA,temp ; porta enable for output

in temp,PINC ; take input
ldi temp2,12 ; AB
and temp2,temp
cpi temp2,12 
breq Set_x0
ldi temp2,112 ;CD`E`
and temp2,temp
cpi temp2,16 
breq Set_x0
jmp X1
Set_x0:
ldi x0,1
X1:
ldi temp2,60 ; mask ABC`D
and temp2,temp
cpi temp2,44 
breq Set_x1
ldi temp2,224 ; mask D`EF`
and temp2,temp
cpi temp2,128
breq Set_x1
jmp X_2
Set_x1:
ldi x1,1
X_2:
clr temp2
add temp2,x1 ; add the numbers
add temp2,x2
sbrc temp2,2 ; check if the number is 2
dec temp2
lsl temp2
lsl temp2 ; rotate bits
lsl x1 ; now it is in the correct place
add temp2,x1
add temp2,x0 ; output ready
out PORTA,temp2



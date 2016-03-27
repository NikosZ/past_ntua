.include "m16def.inc"
.DEF temp=r21
.DEF counter=r22
.org 0
clr temp
out DDRD,temp
ser temp
out PORTD,temp ; pull up D port
out DDRB,temp ; portb enable


checkleds:
in temp,PIND ; get input
sbrc temp,7 ; check if msb of input is 1
jmp normal
jmp reverse

normal:
ldi temp,0b1111111
out PORTB,temp
ldi counter,50 ;0,5 sec
loop1: 
rcall Delay10
subi counter,1
BREQ loop1 ; until is zero
clr temp ;close leds
out PORTB,temp
ldi counter,150 ; timer new
loop2:
rcall Delay10
subi counter,1
BREQ loop2
jmp checkleds

reverse:
clr temp ;close leds,not needed, case of hardware failure
out PORTB,temp
ldi counter,50 ;0,5 sec
loop1: 
rcall Delay10
subi counter,1
BREQ loop1 ; until is zero
ldi temp,0b1111111 ; light leds
out PORTB,temp
ldi counter,150 ; timer new
loop2:
rcall Delay10
subi counter,1
BREQ loop2
clr temp
out PORTB,temp ; close leds
jmp checkleds


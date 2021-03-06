IN 10H
MVI B,00H

LINE0:
MVI A,FEH ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H ;KODIKOS  INSTR STEP
JZ LEDINST
CPI 05H ; code FETCH PC
JZ LEDPC

LINE1:
MVI A,FDH ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H
;KODIKOS  RUN
JZ LEDRUN
CPI 05H
; code FETCH register
JZ LEDREG
CPI 03H ; fetch address
JZ LEDADR

LINE2:
MVI A,FBH ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H ;KODIKOS  0
JZ LED0
CPI 05H ; code store/incr
JZ LEDINCR
CPI 03H  ; INCR
JZ LEDINST

LINE3:
MVI A,F7H ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H ;KODIKOS 1
JZ LED1
CPI 05H ; code 2
JZ LED2
CPI 03H ; code 3
JZ LED3

LINE4:
MVI A,EFH ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H  ;KODIKOS 4
JZ LED4
CPI 05H ; code 5
JZ LED5
CPI 03H ; code 6
JZ LED6

LINE5:
MVI A,DFH ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H  ;KODIKOS 7
JZ LED7
CPI 05H  ; code 8
JZ LED8
CPI 03H  ; code 9
JZ LED9

LINE6:
MVI A,BFH ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H ;KODIKOS A
JZ LEDA
CPI 05H ; code B
JZ LEDB
CPI 03H ; code C
JZ LEDC

LINE7:
MVI A,7FH ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H  ;KODIKOS D
JZ LEDD
CPI 05H ; code E
JZ LEDE
CPI 03H ; code F
JZ LEDF



LED0:
MVI A,30H 
STA 2800H ; second digit
MVI A,C0H ; 0 code
STA 3800H ; this code is the same for all 0-F , i will just cp it

MVI A,10H
STA 2800H ;first digit
MVI A,C0H ; zero
STA 3800H
JMP RR ;reset digits


LED1:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,F9H ; one
STA 3800H
JMP RR ;reset digits

LED2:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,A4H ; two
STA 3800H
JMP RR ;reset digits

LED3:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,B0H ; three
STA 3800H
JMP RR ;reset digits

LED4:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,99H ; zero
STA 3800H
JMP RR ;reset digits

LED5:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,92H ; five
STA 3800H
JMP RR ;reset digits

LED6:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,82H ; six
STA 3800H
JMP RR ;reset digits

LED7:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,F8H ; seven
STA 3800H
JMP RR ;reset digits

LED8:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,80H ; eight
STA 3800H
JMP RR ;reset digits

LED9:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,98H ; nine
STA 3800H
JMP RR ;reset digits

LEDA:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,88H ; A
STA 3800H
JMP RR ;reset digits

LEDB:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,83H ; b
STA 3800H
JMP RR ;reset digits

LEDC:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,A3H ; c
STA 3800H
JMP RR ;reset digits

LEDD:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,A1H ; d
STA 3800H
JMP RR ;reset digits

LEDE:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,86H ; e
STA 3800H
JMP RR ;reset digits

LEDF:
MVI A,30H 
STA 2800H 
MVI A,C0H 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,8EH ; f
STA 3800H
JMP RR ;reset digits


LEDINST:
MVI A,30H 
STA 2800H 
MVI A,80H ;eight 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,82H ; 6
STA 3800H
JMP RR ;reset digits

LEDPC:
MVI A,30H 
STA 2800H 
MVI A,80H ;eight 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,92H ; 5
STA 3800H
JMP RR ;reset digits

LEDRUN:
MVI A,30H 
STA 2800H 
MVI A,80H ;eight 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,99H ; 4
STA 3800H
JMP RR ;reset digits

LEDREG:
MVI A,30H 
STA 2800H 
MVI A,80H ;eight 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,C0H ; 0
STA 3800H
JMP RR ;reset digits

LEDADR:
MVI A,30H 
STA 2800H 
MVI A,80H ;eight 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,A4H ; 2
STA 3800H
JMP RR ;reset digits

LEDINCR:
MVI A,30H 
STA 2800H 
MVI A,80H ;eight 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,B0H ; 3
STA 3800H
JMP RR ;reset digits

LEDDECR:
MVI A,30H 
STA 2800H 
MVI A,80H ;eight 
STA 3800H 

MVI A,10H
STA 2800H ;first digit
MVI A,F9H ; 1
STA 3800H
JMP RR ;reset digits

RR:
MVI A,FFH
STA 3800H
JMP LINE0

RST 1
END



IN 10H
MVI A,0DH
SIM
EI
JMP WAIT1
INTR_ROUTINE:
LXI B,03E8H ;1 s
DI ; close iderrupts
MVI A,00H ; Light all the led 
STA 3000H
MVI C,3CH ; reset counter
EI ;open iderrupts
JMP WAIT2



WAIT1:
JMP WAIT1

WAIT2:
DCR C ; -1 second
JZ CLOSE
LXI H,0B04H ; place to store the numbers
CALL DELB
MOV A,C
JMP BCD1 ; BCD form of the number
KAT1:
ANI 0FH ;first 4 bytes to store
MOV M,A
MOV A,C
JMP BCD
KAT:
ANI F0H ;mask 4-MSB bits
RRC
RRC
RRC
RRC ; next 4 bits , the dozens
INX H
MOV M,A
LXI D,0B00H
;RST 1
CALL STDM
CALL DCD
JMP WAIT2

BCD:
PUSH D
;PUSH C
MVI E,00H ; dozens
MVI D,00H ; 0-9
FIND:  
CPI 0AH ; 10 to find how many dozens
JC LAST
INR E ; +1 dozen

SUI 0AH
JMP FIND
LAST:
 ; A haze the other number in 0-4 bits.
MOV D,A ;
MOV A,E ; 
RLC
RLC
RLC
RLC 
ADD D ; now it has its BCD form
;POP C
POP D
JMP KAT

BCD1:
PUSH D
;PUSH C
MVI E,00H ; dozens
MVI D,00H ; 0-9
FIND2:  
CPI 0AH ; 10 to find how many dozens
JC LAST2
INR E ; +1 dozen

SUI 0AH
JMP FIND2
LAST2:
 ; A haze the other number in 0-4 bits.
MOV D,A ;
MOV A,E ; 
RLC
RLC
RLC
RLC 
ADD D ; now it has its BCD form
;POP C
POP D
JMP KAT1

CLOSE:
MVI A,FFH
STA 3000H ; close leds
;POP PSW
;RET

JMP WAIT1
END


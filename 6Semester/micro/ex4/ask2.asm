IN 10H
MVI C,F0H ; some numbers for testing
MVI B,09H ;
MVI A,0DH ;mask interupts
SIM
EI
JMP WAIT
INTR_ROUTINE:
DI ;disable interapts
CALL KIND
MOV H,A ; store input
CALL KIND
MOV L,A ; again
MOV A,L ;
STA 0B10H ; first digit for segment
MOV A,H ;
STA 0B11H ;
;RST 1
LXI D,0B10H ;
PUSH H
CALL STDM
CALL DCD ; let the segment light
POP H
MOV A,H ;
;RST 1
ANI 0FH
RLC
RLC
RLC
RLC  
ADD L ; now A has the number that the segment display has
;RST 1
CMP B ; is A< = K1
JZ FIRSTLED 
JC FIRSTLED
CMP C ; A < =K2
JZ SECONDLED
JC SECONDLED
MVI A,04H ;ELSE
CMA 
STA 3000H
JMP ENDI
SECONDLED:
MVI A,02H ; 
CMA ; second led
STA 3000H

JMP ENDI
FIRSTLED:
MVI A,01H 
CMA
STA 3000H 
ENDI:
EI ;enable interupts
RET

WAIT:
JMP WAIT

END

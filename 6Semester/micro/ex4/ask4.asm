LXI H,FIRST
SHLD 0035H
MVI A,0DH 
MVI C,20H ;COUNTER 
MVI H,00H 
MVI L,00H  ; prosthesi diplis akrivias
SIM ;mask for interupts
EI; ENABLE INTERUPTS
WAIT:
JMP WAIT

FIRST: 
DI ;stop interupts
PUSH H
LXI H,SECOND ; for the next RST 5.5
SHLD 002DH
IN PORT_IN ; input
ANI 0FH ;mask number in case of rubbish
MOV B,A ; save value to B
POP H
EI ; enable inderupts 
RET

SECOND :
DI ; same
PUSH H
LXI H,FIRST ; for the next interupt
SHLD 002DH
IN PORT_IN
RLC
RLC
RLC
RLC ;rotete to MSB
ANI F0H ; mask in case
ADD B ; now we have the number
POP H ; now we have the sum till now
MVI D,00H ;
MOV E,A ; 
DAD D ; now we add the new value
DCR C ; -1 to counter
JZ ENDI
EI
RET



ENDI: ;find MEAN VALUE
DAD H
DAD H ; 4 thesis aristera , prepei alli mia thesi
MOV A,L 
RLC ; now the carry has the MSB bit of L
MOV A,H 
RAL ; now the MSB of L is the LSB of H
 ; Now H has the result 
END

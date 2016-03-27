LOOP1:
LDA 2000H
MVI B,00H;midenisma
MVI D,08H;if A is zero (8 loops)
LOOP2:
DCR D
JZ LOOP1Z
RRC; rotate to find the first 1
JC LEDON
MOV C,A
MOV A,B
RLC;rotate because you wont light this led
ORI 01H; dont light first led
MOV B,A
MOV A,C
JMP LOOP2
LOOP1Z:
MVI A,00H ;if a is zero
CMA
STA 3000H
JMP LOOP1
LEDON:
MOV A,B ;put B to a to See which led to light
STA 3000H
JMP LOOP1

RST 1
END

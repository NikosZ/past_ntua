IN 10H
LOOP1:
CALL KIND ; read keyboard
MOV B,A ;save
CPI 00H
JZ LIGHT ; if it is zero dont light anything
MVI A,00H
ORI 01H ; put the first 1 to find which led will light
LOOP2:
DCR B
JZ LIGHT
RLC ;while not zero push left the bit
JMP LOOP2

LIGHT:
CMA
STA 3000H 
JMP LOOP1


RST 1
END

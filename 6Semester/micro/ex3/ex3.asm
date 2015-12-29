IN 10H
MVI B,00H
LINE0:
MVI A,FEH ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H
MVI C,86H ;KODIKOS  INSTR STEP
JZ LED
CPI 05H
MVI C,85H ; code FETCH PC
JZ LED

LINE1:
MVI A,FDH ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H
MVI C,84H ;KODIKOS  RUN
JZ LED
CPI 05H
MVI C,80H ; code FETCH register
JZ LED
CPI 03H
MVI C,82H ; fetch address
JZ LED

LINE2:
MVI A,FBH ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H
MVI C,00H ;KODIKOS  0
JZ LED
CPI 05H
MVI C,83H ; code store/incr
JZ LED
CPI 03H
MVI C,86H ; INCR
JZ LED

LINE3:
MVI A,F7H ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H
MVI C,01H ;KODIKOS 1
JZ LED
CPI 05H
MVI C,02H ; code 2
JZ LED
CPI 03H
MVI C,03H ; code 3
JZ LED

LINE4:
MVI A,EFH ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H
MVI C,04H ;KODIKOS 4
JZ LED
CPI 05H
MVI C,05H ; code 5
JZ LED
CPI 03H
MVI C,06H ; code 6
JZ LED

LINE5:
MVI A,DFH ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H
MVI C,07H ;KODIKOS 7
JZ LED
CPI 05H
MVI C,08H ; code 8
JZ LED
CPI 03H
MVI C,09H ; code 9
JZ LED

LINE6:
MVI A,BFH ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H
MVI C,0AH ;KODIKOS A
JZ LED
CPI 05H
MVI C,0BH ; code B
JZ LED
CPI 03H
MVI C,0CH ; code C
JZ LED

LINE7:
MVI A,7FH ;epilogi grammis
STA 2800H
LDA 1800H ;diabasma stilis
ANI 07H ;mask number
CPI 06H
MVI C,0DH ;KODIKOS D
JZ LED
CPI 05H
MVI C,0EH ; code E
JZ LED
CPI 03H
MVI C,0FH ; code F
JZ LED
MVI C,00H

LED:
LXI H,0B04H
MOV A,C ;fere minima ston A
ANI 0FH ;first 4 bytes to store
MOV M,A
MOV A,C
ANI F0H
INX H
MOV M,A
LXI D,0B00H
CALL STDM
CALL DCD
MOV B,C
JMP LINE0
RST 1
END

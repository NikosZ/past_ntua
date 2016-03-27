
MVI B,64H ; 1/10s
CHECK1:
LDA 2000H
RLC
JNC CHECK2 ; is MSB off?
JMP CHECK1


CHECK2:
CALL DELB
MOV A,D
CPI 01H ;miose TA S , an einai on to flag
JC CHECK2\_M
CHECK2C:
LDA 2000H
RLC
JC CHECK3 ; is MSB on?
JMP CHECK1

CHECK2_M:
DCR C ; miosi kathisterisis
JZ CLOSE2

CHECK3:
CALL DELB
MOV A,D
CPI 01H ;miose TA S , an einai on to flag
JC CHECK3_M
CHECK3C:
LDA 2000H
RLC
JC NEWLIGHT ; is MSB off?
JMP CHECK1

CHECK3\_M:
DCR C ; miosi kathisterisis
JZ CLOSE3

CLOSE2:
MVI D,00H ; midenismos flag
MVI A,FFH
STA 3000H
;fotakia
JMP CHECK2C

CLOSE3:
MVI D,00H ; midenismos flag
MVI A,FFH
STA 3000H
;fotakia
JMP CHECK3C

NEWLIGHT:
MVI C,C8H ;20s / 1/10
MVI D,01H ;flag variable
MVI A,7FH
STA 3000H
LIGHT:
DCR C ; diakritiki ikanotita
JZ CLOSE
CALL DELB
JMP CHECK1 ; elenxos gia tixon ananeosi
CHOICE:
MOV A,D
CPI 01H
JC CHECK1 ; den einai anixto kanena fos
JMP LIGHT ; sinexisi tis kathsiterisis twn 20s

CLOSE:
MVI D,00H ; midenismos flag
MVI A,FFH
STA 3000H
JMP CHECK1
RST 1
HLT
END

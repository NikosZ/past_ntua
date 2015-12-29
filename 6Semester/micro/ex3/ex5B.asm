MVI B,00H
READY:
RIM  ;receive bit
RLC ; check if is 1
JNC READY

YES:
MVI A,FFH ; sent 1 
SIM
RIM
RLC 
JZ REC ; receive data
JMP YES
REC:
IN DATA ; get data
STAX H ; save data to memory
INX H ; next cell
ICR B
JC ENDA
EI ; next data
JMP READY
ENDA:
END

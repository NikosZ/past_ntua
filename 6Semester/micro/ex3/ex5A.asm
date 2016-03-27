MVI B,00H ;counter for bytes

READY:
MVI A,FFH; ; we want to sent 1 so A= 11XXXXXX
SIM ; sent bit
RIM  ;receive bit
RLC ; check if is 1
JNC READY

YES:
; we sent nothing so , the other feveice will receive the 0 bit
LDAX H
OUT DATA
INX H
ICR B
JC ENDA ; if B=256 ->C=1 B=0
WAIT:
RIM ; wait for 0 bit
RLC 
JNC READY ;byte was sent ,go for the next
JMP WAIT ; wait to complete the transfer
ENDA:
END

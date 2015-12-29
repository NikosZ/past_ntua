DATA_SEG SEGMENT ; for store min max
FIS DW 0;
SEC DW 11111111b ;max number 
DW 11111111b
DATA_SEG ENDS
main:
ASSUME DS:DATA_SEG
mov si,0 ; lets say that the data mem of the number is in zero.
mov bx,0  
mov cx,5
mov dl,0
loopa:
mov ax,[si]    ; si is used for the data in mem
push ax
push bx
mov bx,OFFSET FIS     ; take prev max
cmp ax,bx
jg change        ; check if it is greater to change val
min:
mov bx,OFFSET SEC         
cmp ax,bx
jg rest
MOV OFFSET SEC,ax    ;update min
rest:
pop bx
pop ax
test ax,1  ; test if it is even
jz  even 
jmp notev:
even:
add bx,ax
inc dl 
notev:
inc si
inc si ; 2 times because we have 16 bit vals

loop loopa                   
mov ax,bx
mov bx,dx 
xor dx,dx ; zero dx
div bx   ;akereo meros

; there we can put exit, or something else, i will leave it empty

change:
MOV OFFSET FIS,ax
jmp min
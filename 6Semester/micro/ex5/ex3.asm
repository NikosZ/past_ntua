PRINT_HEX PROC NEAR   
    PUSHF 
    PUSH bx
    CMP BL,9
    JG ADDK
    ADD BL,30H ; 0 Char
    JMP ADDK2
ADDK:
ADD BL,37H       ; CHARACTER A= 10
ADDK2:  
    PUSH dx
    PUSH ax
    MOV DL,BL
    MOV AH,2
    INT 21H
    POP ax
    POP dx
    POP bx
    POPF
    RET
PRINT_HEX ENDP         
                   
                   
PRINT_OCT PROC NEAR   
    PUSHF 
    PUSH BX
    PUSH AX   
    push dx
    mov al,bl
    mov ah,3
    RCL BL,2 
    and bl,ah    ; take first 2 bits (actually 2 MSBs and mask)
    
    mov dl,bl ; time to print
    add dl,30H ;char 0 
    mov ah,2
    int 21H
    push cx
    mov cx,2
    loopa1:
    mov bl,al ; time for the rest of the number  3 bits per octal number
    rcl bl,5 
    mov ah,3
    and bl,ah
    mov dl,bl
    add dl,30H
    mov ah,2
    int 21H
    loop loopa1
    POP CX
    POP DX
    POP AX
    POP BX
    POPF
    RET
PRINT_OCT ENDP         

PRINT_BIN PROC NEAR  
    PUSHF 
    PUSH BX
    PUSH AX   
    push dx
    push cx
    mov cx,8
    loopa:
     rcl bl ,1 ; one bit per time
    mov ah,1
    and bl,ah
    mov dl,bl
    add dl,30H ; go to number 0 + offset of number (o or 1)
    mov ah,2H
    int 21H
    loop loopa
    POP CX
    POP DX
    POP AX
    POP BX
    POPF
    RET
PRINT_BIN ENDP         
MACRO PRINT CHAR
    PUSH DX
    PUSH AX
    MOV DL,CHAR
    MOV AH,2
    INT 21H
    POP AX
    POP DX
ENDM
READ MACRO 
    mov ah,8
    int 21h
ENDM
READ_DEC PROC NEAR
    pushf
    notnumber:
    READ
    cmp al,30h   ; check if it is a digit
    jl notnumber                        
    cmp al,39h
    jg notnumber
    sub al,30h 
    popf
    
READ_DEC ENDP
START:
    call READ_DEC ; read until a digits
    mov dx,0
    mov ah,0
    mov bl,10
    mul bl
    mov cl,al
    call READ_DEC
    mov ah,0
    add cl,al ; now i have the number
    mov bl,al
    call PRINT_HEX
    PRINT '='
    call PRINT_OCT
    PRINT '='
    call PRINT_BIN
    PRINT 0AH
    PRINT 0DH ; new line


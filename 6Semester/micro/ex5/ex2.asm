

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
MACRO PRINT CHAR           ; book code
    PUSH dx
    PUSH ax
    MOV DL,CHAR
    MOV AH,2
    INT 21H
    POP ax
    POP dx
ENDM
READ MACRO 
    mov ah,8
    int 21h
ENDM
READ_2D PROC NEAR 
    PUSH ax
    push dx
    push bx
    call READ_DEC ; read until a digits
    mov dx,0
    mov ah,0
    mov bl,10
    mul bl
    mov cl,al
    INC di     ; next place to store
    call READ_DEC
    mov ah,0
    add cl,al ;  
    pop bx
    pop dx
    pop ax
READ_2D ENDP         
PRINT_STR MACRO STRING 
    push dx
    push ax
    mov dx, OFFSET STRING
    mov ah,9
    int 21h
    pop ax
    pop dx
ENDM
STORE MACRO
    MOV di,al
    ENDM
READ_DEC PROC NEAR
    pushf
    notnumber:
    READ
    cmp al,30h   ; check if it is a digit
    jl notnumber                        
    cmp al,39h
    jg notnumber
    mov ah,0
    mov di,ax      ;store in data as ascii code
    sub al,30h 
    popf
    
READ_DEC ENDP
DATA_SEG SEGMENT
    FIRST DB  "x="
    XVAL1 DW '0'  
    DW '0'
    DB " y="
    YVAL1 DW '0'
    DW '0'
    DB 0AH,0DH,'$'  ; NEW LINE
    PRINTSUB DB "x+y=$"
    PRINTMINUS DB "x-y=-$"  
    PRINTMINUS2 DB "x-y=-$" 
    NEWL DB 0AH,0DH,'$'  ; NEW LINE
                                    
DATA_SEG ENDS
CODE_SEG SEGMENT 
    ASSUME CS:CODE_SEG,DS:DATA_SEG
    MAIN PROC FAR
       mov di, OFFSET XVAL1
      call READ_2D
       mov bl,cl
       mov di, OFFSET YVAL1
      call READ_2D
       PRINT_STR FIRST ; print the input
       push bx ;store value
       add bl, cl ; now we have   the sum   
       PRINT_STR PRINTSUB
       call PRINT_HEX 
       pop bx
       cmp bl,cl
       jg printno
       PRINT_STR PRINTMINUS
       sub cl,bl
       mov bl,cl
      
       jmp end1 
       printno:
       PRINT_STR PRINTMINUS2
        sub bl,cl 
        end1:
         call PRINT_HEX
         PRINT_STR NEWL
   CODE_SEG ENDS
    END MAIN
        
       

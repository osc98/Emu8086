.model small

.data
    msg1 db 13,10, "INGRESE UNA CADENA EN FORMATO NUMÉRICO Y EN EL RANGO (1-300) :$"
    msg2 db 13,10, "INGRESE UNA CADENA EN FORMATO NUMÉRICO Y EN EL RANGO (1-300) :$"
    msg3 db 13,10, "LA SUMA DE AMBOS NÚMEROS ES :$"
    msg4 db 13,10, "ERROR : LA CADENA NO ESTÁ EN EL FORMATO SOLICITADO. PROCESO ABORTADO.$"
    var1U db ?
    var2U db ?
    var1D db ?
    var2D db ?
    var1C db ?
    var2C db ?
    u db ?
    d db ?
    c db ? 
    salto db 13, 10, "$";salto de linea
.code
.startup
;//////////////////////////////////////
    mov ax,@DATA
    mov ds,ax
    ;pedimos el primer numero
    mov ah,09h ;
    lea dx,msg1
    int 21h 
    ;leemos hasta 3 caracteres
    ;Guardar la centena de la varible 1

    guardar_V1C:   ;etiqueta imprimir       
    mov ah,01h  ;petcion para leer un caracter
    int 21h     ;interrupcion de sistema
    sub al,30h  ;substraer 30h
    mov var1C,al ;guardamos la poscion en variable 
    cmp var1C,0Ah
    ja error
    je error
    jb guardar_V1D
      
    guardar_V1D:   ;etiqueta imprimir        
    mov ah,01h  ;petcion para leer un caracter
    int 21h     ;interrupcion de sistema
    sub al,30h
    mov var1D,al ;guardamos la poscion en variable 
    cmp var1D,0Ah
    ja error
    je error
    jb guardar_V1U
          
    guardar_V1U:   ;etiqueta imprimir       
    mov ah,01h  ;petcion para leer un caracter
    int 21h     ;interrupcion de sistema
    sub al,30h  ;restar 30h para ascii
    mov var1U,al ;guardamos la poscion en variable 
    cmp var1U,0Ah
    ja error
    je error
    jb validar1
    
    validar1: ;
    cmp var1C,3
    ja error
    jb pedir_Segundo
    je error
;//////////////////////////////////////    
     ;pedimos el segundo numero
pedir_Segundo: 
    mov ah,09h ;
    lea dx,msg2
    int 21h 
    ;leemos hasta 3 caracteres
    ;Guardar la unidad de la varible 2

     guardar_V2C:   ;etiqueta imprimir       
     mov ah,01h  ;petcion para leer un caracter
     int 21h     ;interrupcion de sistema
     sub al,30h
     mov var2C,al ;guardamos la poscion en variable 
     cmp var2C,0Ah
     ja error
     je error
     jb guardar_V2D
    
     guardar_V2D:   ;etiqueta imprimir       
     
     mov ah,01h  ;petcion para leer un caracter
     int 21h     ;interrupcion de sistema
     sub al,30h
     mov var2D,al ;guardamos la poscion en variable 
     cmp var2D,0Ah
     ja error
     je error
     jb guardar_V2U
          
     guardar_V2U:   ;etiqueta imprimir       
     mov ah,01h  ;petcion para leer un caracter
     int 21h     ;interrupcion de sistema
     sub al,30h 
     mov var2U,al ;guardamos la poscion en variable     
     cmp var2U,0Ah
     ja error
     je error
     jb salto_linea 
    
;//////////////////////////////////////
    salto_linea:    
    mov ah, 09  ;muestra el caracter en pantalla 
    mov dx, offset salto ;direccion absoluta 
    lea dx, salto        ;mostramos en pantalla
    int 21h 
;//////////////////////////////////////         
 
validar2:    
    cmp var2C,4
    ja error
    jb validar3
    je error
validar3:
    jmp sumar_Unidades
error:
    mov ah,09 
    lea dx,msg4
    int 21h
    jmp salir
 
sumar_Unidades:
     mov al,var1U
     add al,var2U
     add al,30h
     mov u,al
     cmp u,'9'
     ja sumar_Uni_Dec
     je sumar_Decenas 
     jb sumar_Decenas 
     
sumar_Uni_Dec:
     sub u,0ah
     mov al,u
     push ax
     mov al,var1D
     add al,var2D
     add al,30h 
     add al,1
     mov d,al
     cmp d,'9'
     ja sumar_Dec_Cen
     je sumar_Centenas
     jb sumar_Centenas

sumar_Decenas:
     push ax
     mov al,var1D
     add al,var2D
     add al,30h
     mov d,al
     cmp d,'9'
     ja sumar_Dec_Cen
     je sumar_Centenas
     jb sumar_Centenas   

sumar_Dec_Cen:
    sub d,0ah 
    mov al,d
    push ax
     mov al,var1C
     add al,var2C
     add al,30h 
     add al,1
     mov c,al
     push ax
     mov cx,3
     jmp imprimir
     
sumar_Centenas:
    push ax
    mov al,var1C
    add al,var2C
    add al,30h
    mov c,al
    push ax
    mov cx,3
    jmp imprimir
     
imprimir:   ;etiqueta imprimir
    mov ah,09
    lea dx,msg3
    pop ax    ;saca el dato de la cima de la pila      
    mov ah,02h;establecemos la posicion del cursor
    mov dl,al ;pasamos  ah a dl 
    int 21h   ;interrupcion de bio
    loop imprimir ;regresamos a la etiqueta imprimir
      
    salir:
      mov ah,04ch ;finaliza el programa
      int 21h

end
.model small

.data   ;seccion con nuestras variables
    msg1 db 13,10, "INGRESE El DIVIDENDO DE DOS DIGITOS:$"
    msg2 db 13,10, "INGRESE EL DIVISOR DE UN DIGITO (2,4,8) es exacto dieferente varia el resultado :$"
    msg3 db 13,10, "El RESULTADO ES:$"
    msg4 db 13,10, "ERROR : LA CADENA NO ESTA EN EL FORMATO SOLICITADO. PROCESO ABORTADO.$"
    var1Ub db 00000000b
    var1Db db 00000000b
    var2Ub db 00000000b
    var2Db db 00000000b
    var1D db ?
    var2D db ?
    var1U db ?
    var2U db ?
    resultadoBinario db ?
    binBase db ?
    diez db 0Ah    ;divisor de base numérica
    d db ? 
    u db ?
    salto db 13, 10, "$"    ;salto de linea
.code
.startup
;//////////////////////////////////////
    mov ax,@DATA
    mov ds,ax
    ;pedimos el primer numero
    mov ah,09h ;
    lea dx,msg1
    int 21h
                       
    guardar_V1D:    ;Guardamos las centenas en una variable        
    mov ah,01h      ;petcion para leer un caracter
    int 21h         ;interrupcion de sistema
    sub al,30h      ;restar 30h para convertir a ascii
    mov var1D,al    ;guardamos la poscion en variable 
    cmp var1D,0Ah   ;validamos que se ingrese valores menores a'10' en ascii
    ja error        ;si es mayor vamos a error
    je error        ;si es igual vamos a error
    jb guardar_V1U  ;si es menor pasamos a guardar las unidades
          
guardar_V1U:    ;etiqueta imprimir           

binarioDecimal: 
    mov ah,var1Db
    add var1Db,00001010b
    dec al
    cmp al,0
    ja binarioDecimal    
    mov ah,01h      ;petcion para leer un caracter
    int 21h         ;interrupcion de sistema
    sub al,30h      ;restar 30h para convertir a ascii
    mov var1U,al    ;guardamos la poscion en variable
     
    cmp var1U,0Ah   ;validamos que se ingrese valores menores a'10' en asci
    ja error        ;si es mayor vamos a error
    je error        ;si es igual vamos a error
    jb guardar_V     ;si es menor pasamos a validar 

guardar_V:    ;etiqueta imprimir           
binarioDecimal2: 
    mov ah,var1Ub
    add var1Ub,00000001b
    dec al
    cmp al,0
    ja binarioDecimal2
    mov bl, var1Db
    cmp var1Db,00h
    je  sumDUb0
    ja  sumDUbN
    
sumDUb0:
    mov ah,var1Db
    add var1Ub,ah
    mov resultadoBinario,ah
    jmp salto_linea
sumDUbN:
    mov ah,var1Db
    add var1Ub,ah
    mov resultadoBinario,ah
;//////////////////////////////////////////
salto_linea:    
    mov ah, 09      ;muestra el caracter en pantalla 
    mov dx, offset salto ;direccion absoluta 
    lea dx, salto    ;mostramos en pantalla
    int 21h 
;/////////////////////////////
;SEGUNDO FACTOR
segundo_factor:    
    mov ah,09h ;
    lea dx,msg2
    int 21h
                       
guardar_V2D:        ;Guardamos las centenas en una variable        
    mov ah,01h      ;petcion para leer un caracter
    int 21h         ;interrupcion de sistema
    sub al,30h      ;restar 30h para convertir a ascii
    mov var2D,al    ;guardamos la poscion en variable 
    cmp var2D,01h   ;validamos que se ingrese valores menores a'10' en ascii
    ja  it2        ;si es mayor vamos a error
    jb  error        ;si es menor vamos a error
it2:
    mov bh,var1Ub
    mov binBase,bh
    cmp var2D,02h
    ja  it4
    jb  error
    je it2fin
    
it4:
    cmp var2D,04h
    ja  it8
    jb  it3 
    je it4fin
it8:
    shr resultadoBinario,01b
    cmp var2D,08h
    ja  it9
    jb  it5
    je it8fin
    
it3:
    shr var1Ub,1
    mov ah,var1Ub
    mov resultadoBinario,ah
    sub resultadoBinario,01h
    cmp var2D,03h
    je resultado
it5:
    shr var1Ub,2
    mov ah,var1Ub
    mov resultadoBinario,ah
    sub resultadoBinario,01h
    cmp var2D,05h
    ja  it6
    je resultado
it6:
    sub resultadoBinario,01h
    cmp var2D,06h
    ja  it7
    je resultado
it7:
    sub resultadoBinario,01h
    cmp var2D,07h
    je resultado
it9:
    shr var1Ub,3
    mov ah,var1Ub
    mov resultadoBinario,01h
    sub resultadoBinario,bh
    cmp var2D,09h
    je resultado
    ja  error
it2fin:
    shr var1Ub,1
    mov ah,var1Ub
    mov resultadoBinario,ah
    jmp resultado
it4fin:
    shr var1Ub,2
    mov ah,var1Ub
    mov resultadoBinario,ah
    jmp resultado 
it8fin:
    shr var1Ub,3
    mov ah,var1Ub
    mov resultadoBinario,ah
    jmp resultado      

;///////////////////////////////////////
error:              ;etiqueta error
    mov ah,09       ;funcion para imprimir una cadena
    lea dx,msg4     ;imprimimos la variable msg4
    int 21h         ;interrupcion de bios
    jmp salir       ;finalizamos el programa
    
    
resultado:
;//////////////////////////////////////////
salto_linea2:    
    mov ah, 09      ;muestra el caracter en pantalla 
    mov dx, offset salto ;direccion absoluta 
    lea dx, salto    ;mostramos en pantalla
    int 21h
    mov ah, 09      ;muestra el caracter en pantalla 
    mov dx, offset msg3 ;direccion absoluta 
    lea dx, msg3    ;mostramos en pantalla
    int 21h 
;/////////////////////////////
    mov al,resultadoBinario
    cbw
    mov bl,diez
    idiv bl 
    MOV d, al
    MOV u, AH
    MOV DX, 0000H
    ADD d, 30H
    ADD u, 30H
    ADD DL, OFFSET d
    
    MOV AH, 09H ;DESPLIEGA EL RESULTADO EN PANTALLA
    INT 21H
    
    
;//////////////////////////////////////
    ;Seccion salir      
salir:
    mov ah,04ch   ;finaliza el programa
    int 21h
;/////////////////////////////////////
end
.model small
.data   ;seccion con nuestras variables
    msg0 db 13,10,"* PARA MULTIPLICAR, / PARA DIVIDIR $"
    msg1 db 13,10, "INGRESE El PRIMER FACTOR DE DOS DIGITOS:$"
    msg2 db 13,10, "INGRESE EL SEGUNDO FACTOR DE UN DIGITO :$"
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
;//////////////////////////////////////////////
;Variables para division
    msg5 db 13,10, "INGRESE El DIVIDENDO DE DOS DIGITOS:$"
    msg6 db 13,10, "INGRESE EL DIVISOR DE UN DIGITO (2,4,8) es exacto dieferente varia el resultado :$"
    msg7 db 13,10, "El RESULTADO ES:$"
    msg8 db 13,10, "ERROR : LA CADENA NO ESTA EN EL FORMATO SOLICITADO. PROCESO ABORTADO.$"
    var1Ub_D db 00000000b
    var1Db_D db 00000000b
    var2Db_D db 00000000b
    var1D_D db ?
    var2D_D db ?
    var1U_D db ?
    binBase_D db ?
.code
.startup
;//////////////////////////////////////
    mov ax,@DATA
    mov ds,ax
;ELECCION DE DIVIDIR O MULTIPLICAR    
    mov ah,09h ;    ;imprimir cadena
    lea dx,msg0     ;mostramos la cadenas msg1
    int 21h         ;interrupcion de bios
    mov ah,01h      ;petcion para leer un caracter
    int 21h         ;interrupcion de sistema
    cmp al, 02Ah    ;si ingresa '*'
    je MULTIPLICACION ;ir a multiplicacion
    cmp al,02Fh     ;comparar con '/'
    je DIVISION     ;si es igual ir dividir
    jb error        ;menor
    ja error        ;mayor
    
;-------------------    MULTIPLICACION  ---------------------------------
    
MULTIPLICACION:    
    ;leemos las decenas
    mov ah,09h ;    ;imprimir cadena
    lea dx,msg1     ;mostramos la cadenas msg1
    int 21h         ;interrupcion de bios                      
    guardar_V1D:    ;Guardamos las centenas en una variable        
    mov ah,01h      ;petcion para leer un caracter
    int 21h         ;interrupcion de sistema
    sub al,30h      ;restar 30h para convertir a ascii
    mov var1D,al    ;guardamos la poscion en variable 
    cmp var1D,0Ah   ;validamos que se ingrese valores menores a'10' en ascii
    ja error        ;si es mayor vamos a error
    je error        ;si es igual vamos a error
    jb guardar_V1U  ;si es menor pasamos a guardar las unidades
;//////////////////////////////////////                              
guardar_V1U:        ;bloque guardar decenas         
 binarioDecimal:    ;convertimos las decenas a binario
    mov ah,var1Db   ;pasamos el valor de las decenas al registo ah
    add var1Db,00001010b ;sumamos 10 en binario por cada decena 
    dec al          ;decrementamos el registro al en 1
    cmp al,0        ;comparamos al con 0, si no repetimos sumar 10 en binario
    ja binarioDecimal;si es mayor a 0 regresamos a la etiqueta binarioDecimal    
;//////////////////////////////////////
;leemos las unidades    
    mov ah,01h      ;petcion para leer un caracter
    int 21h         ;interrupcion de sistema
    sub al,30h      ;restar 30h para convertir a ascii
    mov var1U,al    ;guardamos la poscion en variable  
    cmp var1U,0Ah   ;validamos que se ingrese valores menores a'10' en asci
    ja error        ;si es mayor vamos a error
    je error        ;si es igual vamos a error
    jb guardar_V    ;si es menor pasamos a validar 

guardar_V:    ;Bloque de codigo para convertir dec a bin 

binarioDecimal2:    ;Empezamos con los decimales 
    mov ah,var1Ub   ;Para las unidades
    add var1Ub,00000001b ;sumamos 1 en binario
    dec al          ;restamos 1 al registro al
    cmp al,0        ;si al no es 0, repetimos sumar 1 en binario
    ja binarioDecimal2  ;cuando sale del ciclo pasamos a las decimas
    mov bl, var1Db  ;guardamos el valor de las decimas en el registro bl
    mov ah,var1Db   ;guardamos en la variable de las unidades el registro ah
    add var1Ub,ah   ;sumamos las decenas y unidades en binario
    mov resultadoBinario,ah ;guardamos el resultado en un variable
;//////////////////////////////////////////
salto_linea:    
    mov ah, 09      ;muestra el caracter en pantalla 
    mov dx, offset salto ;direccion absoluta 
    lea dx, salto    ;mostramos en pantalla
    int 21h 
;/////////////////////////////
;SEGUNDO FACTOR
segundo_factor:     ;bloque para el segundo factor
    mov ah,09h ;    ;imprimir cadena
    lea dx,msg2     ;cadena msg2
    int 21h         ;interrupcion de bios
    
    mov ah,01h      ;petcion para leer un caracter
    int 21h         ;interrupcion de sistema
    sub al,30h      ;restar 30h para convertir a ascii
    mov var2D,al    ;guardamos la poscion en variable 
    cmp var2D,01h   ;validamos que se ingrese valores menores a'10' en ascii
    ja  it2        ;si es mayor vamos a error
    jb  error        ;si es menor vamos a error

it2:                ;iteracion 2
    mov bh,var1Ub   ;guardamos en bh nuestro binario
    mov binBase,bh  ;guardamos en binbase el binario dividendo
    cmp var2D,02h   ;comparamos el divisor 
    ja  it4         ;mayor
    jb  error       ;menor
    je it2fin       ;igual
    
it4:                ;iteracion 3
    cmp var2D,04h   ;comparamos el divisor
    ja  it8         ;mayor
    jb  it3         ;menor
    je it4fin       ;igual
    
it8:                ;iteracion 4
    cmp var2D,08h   ;compara el divisor
    ja  it9         ;mayor
    jb  it5         ;menor
    je it8fin       ;igual
    
it3:                ;iteracion 5
    shl var1Ub,1    ;desplazamiento a la derecha
    mov ah,var1Ub   ;pasamos var1Ub al registro ah
    mov resultadoBinario,ah ;guardamos lo del registro ah en la variable
    add resultadoBinario,bh;substraemos 1 al resultado
    cmp var2D,03h   ;comparamos el divisor 
    je resultado    ;si es igual vamos al resultado
   
it5:                ;iteracion 6
    shl var1Ub,2    ;desplazamiento a la derecha
    mov ah,var1Ub   ;pasamos var1Ub al registro ah
    mov resultadoBinario,ah;guardamos lo del registro ah en la variable
    add resultadoBinario,bh;substraemos 1 al resultado
    cmp var2D,05h   ;comparamos el divisor
    ja  it6         ;mayor
    je resultado    ;igual
    
it6:                ;iteracion 7
    add resultadoBinario,bh;substraemos 1 al resultado
    cmp var2D,06h   ;comparamos el divisor
    ja  it7         ;mayor
    je resultado    ;igual
    
it7:                ;iteracion 8
    add resultadoBinario,bh;agregamos 1 al resultado
    cmp var2D,07h   ;comparamos el divisor
    je resultado    ;igual
    
it9:                ;iteracion 9
    shr var1Ub,3    ;desplazamiento a la derecha
    mov ah,var1Ub   ;pasamos var1Ub al registro ah
    mov resultadoBinario,ah;guardamos lo del registro ah en la variable
    add resultadoBinario,bh;agregamos 1 al resultado
    cmp var2D,09h   ;comparamos el divisor
    je resultado    ;igual
    ja  error       ;mayor
;/////////////////////////*
;-****--***si el factor es 2,4,8.    
it2fin:
    shl var1Ub,1    ;desplazamiento a la izquierda
    mov ah,var1Ub   ;pasamos var1Ub al registro ah
    mov resultadoBinario,ah  ;guardamos lo del registro ah en la variable
    jmp resultado   ;resultado
it4fin:
    shl var1Ub,2    ;desplazamiento a la izquierda
    mov ah,var1Ub   ;pasamos var1Ub al registro ah
    mov resultadoBinario,ah ;guardamos lo del registro ah en la variable
    jmp resultado   ;resultado 
it8fin:
    shl var1Ub,3    ;desplazamiento a la izquierda
    mov ah,var1Ub   ;pasamos var1Ub al registro ah
    mov resultadoBinario,ah ;guardamos lo del registro ah en la variable
    jmp resultado   ;resultado       
                                                    
                                                    
                                                                                                       
;-------------------    DIVISION  ---------------------------------


DIVISION:
    mov ax,@DATA
    mov ds,ax
    ;leemos las decenas
    mov ah,09h ;    ;imprimir cadena
    lea dx,msg5     ;mostramos la cadenas msg5
    int 21h         ;interrupcion de bios           
    guardar_V1D_D:    ;Guardamos las centenas en una variable        
    mov ah,01h      ;petcion para leer un caracter
    int 21h         ;interrupcion de sistema
    sub al,30h      ;restar 30h para convertir a ascii
    mov var1D_D,al    ;guardamos la poscion en variable 
    cmp var1D_D,0Ah   ;validamos que se ingrese valores menores a'10' en ascii
    ja error        ;si es mayor vamos a error
    je error        ;si es igual vamos a error
    jb guardar_V1U_D  ;si es menor pasamos a guardar las unidades
;//////////////////////////////////////          
guardar_V1U_D:        ;bloque guardar decenas         
 binarioDecimal_D:    ;convertimos las decenas a binario
    mov ah,var1Db_D   ;pasamos el valor de las decenas al registo ah
    add var1Db_D,00001010b ;sumamos 10 en binario por cada decena 
    dec al          ;decrementamos el registro al en 1
    cmp al,0        ;comparamos al con 0, si no repetimos sumar 10 en binario
    ja binarioDecimal_D;si es mayor a 0 regresamos a la etiqueta binarioDecimal_D    
;//////////////////////////////////////
;leemos las unidades        
    mov ah,01h      ;petcion para leer un caracter
    int 21h         ;interrupcion de sistema
    sub al,30h      ;restar 30h para convertir a ascii
    mov var1U_D,al    ;guardamos la poscion en variable 
    cmp var1U_D,0Ah   ;validamos que se ingrese valores menores a'10' en asci
    ja error        ;si es mayor vamos a error
    je error        ;si es igual vamos a error
    jb guardar_V_D    ;si es menor pasamos a convertir a binario 

guardar_V_D:    ;Bloque de codigo para convertir dec a bin 
          
binarioDecimal2_D:    ;Empezamos con los decimales 
    mov ah,var1Ub_D   ;Para las unidades
    add var1Ub_D,00000001b ;sumamos 1 en binario
    dec al          ;restamos 1 al registro al
    cmp al,0        ;si al no es 0, repetimos sumar 1 en binario
    ja binarioDecimal2_D  ;cuando sale del ciclo pasamos a las decimas
    mov bl, var1Db_D  ;guardamos el valor de las decimas en el registro bl
    mov ah,var1Db_D   ;guardamos en la variable de las unidades el registro ah
    add var1Ub_D,ah   ;sumamos las decenas y unidades en binario
    mov resultadoBinario,ah ;guardamos el resultado en un variable
;//////////////////////////////////////////
salto_linea_D:    
    mov ah, 09      ;muestra el caracter en pantalla 
    mov dx, offset salto ;direccion absoluta 
    lea dx, salto   ;mostramos en pantalla
    int 21h         ;interrupcion de sistema
;/////////////////////////////
;SEGUNDO FACTOR
segundo_factor_D:     ;bloque para el segundo factor
    mov ah,09h ;    ;imprimir cadena
    lea dx,msg6     ;cadena msg6
    int 21h         ;interrupcion de bios
                               
    mov ah,01h      ;petcion para leer un caracter
    int 21h         ;interrupcion de sistema
    sub al,30h      ;restar 30h para convertir a ascii
    mov var2D_D,al    ;guardamos la poscion en variable     
;//////////////////////////////////////
;iteramos
    cmp var2D_D,01h   ;validamos que se ingrese valores menores a'10' en ascii
    ja  it2_D         ;si es mayor it2_D
    jb  error       ;si es menor vamos a error

it2_D:                ;iteracion 2
    mov bh,var1Ub_D   ;guardamos en bh nuestro binario
    mov binBase_D,bh  ;guardamos en binBase_D el binario dividendo
    cmp var2D_D,02h   ;comparamos el divisor 
    ja  it4_D         ;mayor
    jb  error       ;menor
    je it2fin_D       ;igual
    
it4_D:                ;iteracion 3
    cmp var2D_D,04h   ;comparamos el divisor
    ja  it8_D         ;mayor
    jb  it3_D         ;menor
    je it4fin_D       ;igual
    
it8_D:                ;iteracion 4
    ;shr resultadoBinario,01b ;desplazamos a la derecha
    cmp var2D_D,08h   ;compara el divisor
    ja  it9_D         ;mayor
    jb  it5_D         ;menor
    je it8fin_D       ;igual
    
it3_D:                ;iteracion 5
    shr var1Ub_D,1    ;desplazamiento a la derecha
    mov ah,var1Ub_D   ;pasamos var1Ub_D al registro ah
    mov resultadoBinario,ah ;guardamos lo del registro ah en la variable
    sub resultadoBinario,01h;substraemos 1 al resultado
    cmp var2D_D,03h   ;comparamos el divisor 
    je resultado    ;si es igual vamos al resultado
    
it5_D:                ;iteracion 6
    shr var1Ub_D,2    ;desplazamiento a la derecha
    mov ah,var1Ub_D   ;pasamos var1Ub_D al registro ah
    mov resultadoBinario,ah;guardamos lo del registro ah en la variable
    sub resultadoBinario,01h;substraemos 1 al resultado
    cmp var2D_D,05h   ;comparamos el divisor
    ja  it6_D         ;mayor
    je resultado    ;igual
    
it6_D:                ;iteracion 7
    sub resultadoBinario,01h;substraemos 1 al resultado
    cmp var2D_D,06h   ;comparamos el divisor
    ja  it7_D         ;mayor
    je resultado    ;igual
    
it7_D:                ;iteracion 8
    sub resultadoBinario,01h;substraemos 1 al resultado
    cmp var2D_D,07h   ;comparamos el divisor
    je resultado    ;igual
    
it9_D:                ;iteracion 9
    shr var1Ub_D,3    ;desplazamiento a la derecha
    mov ah,var1Ub_D   ;pasamos var1Ub_D al registro ah
    mov resultadoBinario,ah;guardamos lo del registro ah en la variable
    sub resultadoBinario,01h;substraemos 1 al resultado
    cmp var2D_D,09h   ;comparamos el divisor
    je resultado    ;igual
    ja  error       ;mayor
;/////////////////////////*
;-****--***si el divisor es 2,4,8.    
it2fin_D:
    shr var1Ub_D,1    ;desplazamiento a la derecha
    mov ah,var1Ub_D   ;pasamos var1Ub_D al registro ah
    mov resultadoBinario,ah  ;guardamos lo del registro ah en la variable
    jmp resultado   ;resultado
    
it4fin_D:
    shr var1Ub_D,2    ;desplazamiento a la derecha
    mov ah,var1Ub_D   ;pasamos var1Ub_D al registro ah
    mov resultadoBinario,ah ;guardamos lo del registro ah en la variable
    jmp resultado   ;resultado 
    
it8fin_D:
    shr var1Ub_D,3    ;desplazamiento a la derecha
    mov ah,var1Ub_D   ;pasamos var1Ub_D al registro ah
    mov resultadoBinario,ah ;guardamos lo del registro ah en la variable
    jmp resultado   ;resultado   
                                                     
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
    lea dx, salto   ;mostramos en pantalla
    int 21h         ;interrupcion
    mov ah, 09      ;muestra el caracter en pantalla 
    mov dx, offset msg3 ;direccion absoluta 
    lea dx, msg3    ;mostramos en pantalla
    int 21h 
;/////////////////////////////
    ;convertir hexadecimal a decimal
    mov al,resultadoBinario ;pasamos el resultado al registro al
    cbw ;convierte el byte a word
    mov bl,diez;dividimos entre 10 para pasa el hex a dec
    idiv bl    ;idvi para guardar el sobrante
    MOV d, al  ;decena
    MOV u, AH  ;centena
    MOV DX, 0000H;dx en 0
    ADD d, 30H   ;convertimos decimal a ascii
    ADD u, 30H   ;convertimos decimal a ascii
    ADD DL, OFFSET d  ;al registro dl sumamos las decenas
    MOV AH, 09H  ;DESPLIEGA EL RESULTADO EN PANTALLA
    INT 21H      ;interrupcion de bios
;//////////////////////////////////////
    ;Seccion salir      
salir:
    mov ah,04ch   ;finaliza el programa
    int 21h
;/////////////////////////////////////
end

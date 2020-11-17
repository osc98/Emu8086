.model small

.data   ;seccion con nuestras variables
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
    
    ;leemos hasta 3 caracteres
    guardar_V1C:    ;Guardamos las centenas en una variable       
    mov ah,01h      ;petcion para leer un caracter
    int 21h         ;interrupcion de sistema
    sub al,30h      ;substraer 30h
    mov var1C,al    ;guardamos la poscion en variable 
    cmp var1C,0Ah   ;validamos que se ingrese valores menores a'10' en ascii
    ja error        ;si es mayor vamos a error
    je error        ;si es igual vamos a error
    jb guardar_V1D  ;si es menor pasamos a guardar las decimas
      
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
    mov ah,01h      ;petcion para leer un caracter
    int 21h         ;interrupcion de sistema
    sub al,30h      ;restar 30h para convertir a ascii
    mov var1U,al    ;guardamos la poscion en variable 
    cmp var1U,0Ah   ;validamos que se ingrese valores menores a'10' en asci
    ja error        ;si es mayor vamos a error
    je error        ;si es igual vamos a error
    jb validar1     ;si es menor pasamos a validar 
    
    validar1:       ;validamos que el valor este en el rango de 1-300
    cmp var1C,3     ;comparamos las centenas con '3'
    ja error        ;vamos a error si es mayor
    jb pedir_Segundo;si es menor a 300 pedimos el segundo numero
    je error        ;si es es igual vamos a error
;//////////////////////////////////////    
     ;pedimos el segundo numero
pedir_Segundo:      ;etiqueta pedir segundo numero
    mov ah,09h      ;funcion 09h para mostrar una cadena en pantalla
    lea dx,msg2     ;mostramos el mensaje 2
    int 21h         ;interrupcion de bios
    
    ;leemos hasta 3 caracteres
guardar_V2C:        ;Guardar las centenas de la varible 2       
     mov ah,01h     ;petcion para leer un caracter
     int 21h        ;interrupcion de sistema
     sub al,30h     ;restamos 30h en la tabla ascii
     mov var2C,al   ;guardamos la poscion en variable 
     cmp var2C,0Ah  ;comparamos var2c con 10 
     ja error       ;vamos a error si es mayor a 0Ah+30h en ascii 
     je error       ;vamos a error si es igual a 0Ah+30h en ascii
     jb guardar_V2D ;si es menor vamos a guardar las decimas
    
guardar_V2D:        ;Guardar las centenas de la varible 2            
     mov ah,01h     ;petcion para leer un caracter
     int 21h        ;interrupcion de sistema
     sub al,30h     ;restamos 30h para conversion a ascii
     mov var2D,al   ;guardamos la poscion en variable 
     cmp var2D,0Ah  ;comparamos var2d con 10
     ja error       ;vamos a error si es mayo a 0Ah+30h en ascii 
     je error       ;vamos a error si es igual a 0Ah+30h en ascii 
     jb guardar_V2U ;si es menor pasamos a guardar las unidades de la variable2
          
guardar_V2U:        ;etiqueta imprimir       
     mov ah,01h     ;petcion para leer un caracter
     int 21h        ;interrupcion de sistema
     sub al,30h     ;restamos 30h para conversion a ascii
     mov var2U,al   ;guardamos la poscion en variable     
     cmp var2U,0Ah  ;comparamos var2U con 10
     ja error       ;vamos a error si es mayo a 0Ah+30h en ascii
     je error       ;vamos a error si es igual a 0Ah+30h en ascii
     jb salto_linea ;si es menor hacemos un salto de linea
    
;//////////////////////////////////////
salto_linea:    
    mov ah, 09      ;muestra el caracter en pantalla 
    mov dx, offset salto ;direccion absoluta 
    lea dx, salto    ;mostramos en pantalla
    int 21h 
;//////////////////////////////////////         
;Seccion validar 
validar2:           ;validamos que el valor este en el rango de 1-300    
    cmp var2C,3     ;comparamos las centenas con '3'
    ja error        ;vamos a error si es mayor
    jb sumar_Unidades;vamos a validar3 si es menor
    je error        ;vamos a error si es igual
    
error:              ;etiqueta error
    mov ah,09       ;funcion para imprimir una cadena
    lea dx,msg4     ;imprimimos la variable msg4
    int 21h         ;interrupcion de bios
    jmp salir       ;finalizamos el programa
 
sumar_Unidades:     ;etiqueta suma Unidades
     mov al,var1U   ;pasamos el contenido de var1U al registro al
     add al,var2U   ;sumamos var1U con var2U
     add al,30h     ;al registro lo pasamos a ascii sumandole 30h
     mov u,al       ;a la variable u le damos el total de las operaciones anteriores
     cmp u,'9'      ;comparamos u con 9
     ja sumar_Uni_Dec   ;si es mayor usamos sumar_Uni_Dec
     je sumar_Decenas   ;si es igual pasamos a sumar_Decenas
     jb sumar_Decenas   ;si es menor pasamos a sumar_Decenas
     
sumar_Uni_Dec:      ;en caso de var1U y var2U sumen mas de 9 
     sub u,0ah      ;restamos 10 en hex para solo quedarnos con las unidades
     mov al,u       ;guardamos la variable u en el registro al
     push ax        ;ponemos en stack el registro al de ax
     mov al,var1D   ;guardamos en 'al' la variable 1 de las decenas 
     add al,var2D   ;sumamos los decimales
     add al,30h     ;convertimos en ascii
     add al,1       ;y agregamos el valor que sobro de las unidades
     mov d,al       ;ponemos en el registro al a la variable d
     cmp d,'9'      ;comparamos d para que no supere el numero 9
     ja sumar_Dec_Cen  ;en caso de ser mayor vamos a Dec_Cen
     je sumar_Centenas ;en caso de ser igual vamos a sumar_Centenas
     jb sumar_Centenas ;o en caso de ser menor vamos a sumar centenas

sumar_Decenas:  ;si las unidades no pasaron de 9
     push ax    ;hacemos un push de ax para guardar u en la pila
     mov al,var1D   ;guardamos en 'al' la variable 1 de las decenas 
     add al,var2D   ;sumamos los decimales
     add al,30h     ;convertimos en ascii
     mov d,al       ;ponemos en el registro al a la variable d
     cmp d,'9'      ;comparamos d para que no supere el numero 9
     ja sumar_Dec_Cen  ;en caso de ser mayor vamos a Dec_Cen
     je sumar_Centenas ;en caso de ser igual vamos a sumar_Centenas
     jb sumar_Centenas ;o en caso de ser menor vamos a sumar centenas  

sumar_Dec_Cen:      ;en caso de var1D y var2D sumen mas de 9
    sub d,0ah       ;restamos 10 en hex para solo quedarnos con las unidades 
    mov al,d        ;pasamos al registro al el valor de d
    push ax         ;ponemos en stack el registro al de ax
    mov al,var1C    ;guardamos en 'al' la variable 1 de las centenas
    add al,var2C    ;sumamos las centenas
    add al,30h      ;convertimos en ascii
    add al,1        ;y agregamos el valor que sobro de las decenas
    mov c,al        ;guardamos en c lo que contenga el registro al
    push ax         ;ponemos en la pila lo que tengamos en el registro ax al
    mov cx,3        ;iniciamos en 3 cx ya que esperamos un resultado de 3 digitos
    jmp imprimir    ;vamos a imprimir
     
sumar_Centenas:     ;si la suma de las decenas no pasan de 9
    push ax         ;ponemos en pila lo del registro ax al
    mov al,var1C    ;guardamos en al lo de la variable1 de las centenas
    add al,var2C    ;sumamos las centenas 
    add al,30h      ;convertimos en ascii
    mov c,al        ;guardamos lo de el registro al en c
    push ax         ;ponemos en pila lo que tengamos en el registro al
    mov cx,3        ;iniciamos en 3 cx ya que esperamos un resultado de 3 digitos
    jmp imprimir    ;vamos a imprimir

;//////////////////////////////////////
    ;Seccion imprimir
imprimir:           ;etiqueta imprimir
    mov ah,09       ;para mostrar una cadena
    lea dx,msg3     ;mostramos el mensaje 3
    pop ax          ;saca el dato de la cima de la pila      
    mov ah,02h      ;establecemos la posicion del cursor
    mov dl,al       ;pasamos  ah a dl 
    int 21h         ;interrupcion de bio
    loop imprimir   ;regresamos a la etiqueta imprimir
;//////////////////////////////////////
    ;Seccion salir      
salir:
    mov ah,04ch   ;finaliza el programa
    int 21h
;/////////////////////////////////////
end
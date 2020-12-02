;-------------------------------- MACRO IMPRIMIR CARACTER X CARACTER -------------------------------------------------------
printChar MACRO char
 MOV DL, 0
 MOV DL, char
 MOV AH, 02H
 int 21h;interrupcion de bios
ENDM

;--------------------------------   MACRO IMPRIMIR CADENA   -------------------------------------------------------
imprime macro texto
    mov ah,9h ;funcion para imprimir en pantalla
    lea dx,texto ;carga la direccion del texto a mostrar y lo mueve al registro dx
    int 21h;interrupcion de bios ;imprime el texto
endm

;--------------------------------   MACRO  LIMPIAR PANTALLA Y AX     -------------------------------------------------------
limpia macro 
    MOV AH,00H ;FUNCION PARA LIMPIAR PANTALLA
    MOV AL,03H ;MODO TEXTO 80X25
    INT 10H
    mov ax ,0C00h;registro limpio por completo;
    int 21h;interrupcion de bios 
    
endm
;--------------------------------   MACRO LEER POR CARACTER-------------------------------------------------------
leercaracter macro
    mov ah,08H
    int 21h;interrupcion de bios 
    mov ah,02h;establecemos la posicion del cursor
    mov dl,al ;pasamos  ah a dl 
    int 21h;interrupcion de bios             
endm     
     
.model small
.stack
;--------------------------------   DATOS Y VARIABLE -------------------------------------------------------

.data
;/////////////////////////////////  MENSAJES DE MENU  ///////////////////////////////////////////////////

    continuar db 13,10,'Presiona cualquier tecla para continuar','$';
    B db 13,10, '---------------------------------------------','$' ;
    C db 13,10, '','$' ;
    D db 13,10, '', '$' ;
    E db 13,10, '1. CREAR UN ARCHIVO DE TEXTO EN DISCO.', '$' 
    F db 13,10, '2. ABRIR EL ARCHIVO Y HACER LA CAPTURA DE DATOS POR TECLADO.', '$' ;
    G db 13,10, '3. LISTAR EN PANTALLA EL CONTENIDO DEL ARCHIVO.', '$' ;
    H db 13,10, '4. CERRAR EL ARCHIVO.', '$' ;
    I db 13,10, '5. ELIMINAR EL ARCHIVO EN DISCO.', '$' ;
    J db 13,10, ' 6. TERMINAR.', '$'
    K db 13,10, 'ELIJA SU OPCION : ','$' 
    A db 13,10, 'ARCHIVOS : MANEJO Y ADMINISTRACION DE DATOS','$' ;

;/////////////////////////////////////  MENSAJES PARA OP1   /////////////////////////////////////////////////////////////////////    
    Op1A db 13,10, 'ARCHIVOS : MANEJO Y ADMINISTRACION DE DATOS [ OPCION 1 ]', '$' 
    Op1B db 13,10, '------------------------------------','$'
    Op1C db 13,10, 'EL NOMBRE DEL NUEVO ARCHIVO A CREAR: ', '$' 
    Op1D db 13,10, 'AVISO : ARCHIVO CREADO EXITOSAMENTE !','$'

;/////////////////////////////////////  MENSAJES PARA OP2   /////////////////////////////////////////////////////////////////////    
    Op2A db 13,10, 'ARCHIVOS : MANEJO Y ADMINISTRACION DE DATOS [ OPCION 2 ]','$'
    Op2B db 13,10, 'POR FAVOR INGRESE El NOMBRE.TIPO ARCHIVO A EDITAR: ','$'
    Op2C db 13,10, 'POR FAVOR INGRESE LOS DATOS POR ALMACENAR : ','$'
    Op2D db 13,10, '--fin de la cita--,','$'

;/////////////////////////////////////  MENSAJES PARA OP3   /////////////////////////////////////////////////////////////////////    
    Op3A db 13,10, 'ARCHIVOS : MANEJO Y ADMINISTRACION DE DATOS [ OPCION 3 ]','$'
    Op3B db 13,10, 'POR FAVOR INGRESE El NOMBRE.TIPO ARCHIVO A LEER: ','$'
    Op3C db 13,10, 'EL CONTENIDO DEL ARCHIVO ES : ','$'

;/////////////////////////////////////  MENSAJES PARA OP4   /////////////////////////////////////////////////////////////////////    

    Op4A db 13,10, 'ARCHIVOS : MANEJO Y ADMINISTRACION DE DATOS [ OPCION 4 ]','$'
    Op4B db 13,10, 'POR FAVOR INGRESE El NOMBRE.TIPO ARCHIVO A CERRAR: ','$'
    Op4C db 13,10, 'EL ARCHIVO FUE CERRADO EXITOSAMENTE !','$'

;/////////////////////////////////////  MENSAJES PARA OP5   /////////////////////////////////////////////////////////////////////    

    Op5A db 13,10, 'ARCHIVOS : MANEJO Y ADMINISTRACION DE DATOS [ OPCION 5 ]','$'
    Op5B db 13,10, 'EL ARCHIVO  FUE ELIMINADO DE DISCO EXITOSAMENTE ! !','$'
    Op5C db 13,10, 'EL NOMBRE DEL NUEVO ARCHIVO A BORRAR: ', '$' 
    Op5D db 13,10, 'AVISO : ARCHIVO BORRADO EXITOSAMENTE !','$' 

;/////////////////////////////////////  MENSAJES  GENERICOS  /////////////////////////////////////////////////////////////////////    
    OpTecla db 13,10, 'PRESIONE CUALQUIER TECLA PARA REGRESAR AL MENU PRINCIPAL...: ','$' 
    ArcEscrito db 13,10, 'Archivo escrito','$' ;mensaje de archivo escrito        
    buffer db  ?,?,?,?,?,?,?;CONTENIDO DEL FICHERO
    nombre_Fichero db ?,?,?,?,?,?,?  ;NOMBRE DEL FICHERO
    nuevo_Contenido db ? ;NUEVO CONTENIDO DEL FICHERO
    hanlde db 0
.code
.startup
    mov ax,@data ;rutina que guarda en el registro ds, la posicion
    mov ds,ax ;del segmento de datos
 menu:
 limpia ;limpia pantalla y ax
 ;/////////////////////////////////  MENSAJES DE MENU  ///////////////////////////////////////////////////        
    imprime A ;
    imprime B ;
    imprime C ;
    imprime E ;
    imprime F ;
    imprime G ;
    imprime H ;
    imprime I ;
    imprime D ;
    imprime J ;

;////////////////////////////////////// COMPARACION (SWITCH) ////////////////////////////////////////////////////////////////
    Inicio:
        imprime K 
        mov ah,01h ;funcion que da la entrada de un caracter
        int 21h     ;interrupcion de bios
        cmp al,31h ;compara la entrada con el numero 1 en ASCII
        je impcrea ;realiza un salto a la etiqueta impcrea
        cmp al,32h ;compara la entrada con el numero 2 en ASCII
        je abrir_Capturar ;realiza un salto a la etiqueta abrir_Capturar
        cmp al,33h ;compara la entrada con el numero 3 en ASCII
        je listar ;realiza un salto a la etiqueta listar
        cmp al,34h ;compara la entrada con el numero 4 en ASCII
        je cerrar ;realiza un salto a la etiqueta cerrar
        cmp al,35h ;compara la entrada con el numero 5 en ASCII
        je eliminar ;realiza un salto a la etiqueta eliminar
        cmp al,36h ;compara la entrada con el numero 6 en ASCII
        je salir ;realiza un salto a la etiqueta salir

;/////////////////////////////// ETIQUETA PARA CREACION DEL FICHERO ///////////////////////////////////////////////////////////
   impcrea:
        limpia;limpia pantalla y ax
        imprime Op1A        ;llamamos al macro imprime con la variable Op1A
        imprime Op1B        ;llamamos al macro imprime con la variable Op1B
        imprime Op1C        ;llamamos al macro imprime con la variable Op1C
      lea si,nombre_Fichero;movemos lo del registro si a la variable del nombre del fichero
      call guarcrea;entramos a guardar el nombre del archivo a manipular
       guarcrea: ;etiqueta para el guardado 
        leercaracter;leemos un caracter con la macro de lectura
        cmp al,0dh;comparamos el caracter con 'enter'
        je concatenar;si es enter pasamos a concatenar los caracteres en tipo path
        Mov [si],ax; lo que tenemos en ax lo pasamos a si pero con  arreglo
        inc si;incrementamos la posicion si        
        jmp guarcrea;si no se tecleo un enter regresamos a la lectura
       concatenar:;etiqueta concatenar
        Mov [si], 0000h;reiniciamos la posicion si
        inc si;incrementamos la posicion si
        mov [si], '$';concatenamos a nuestra direcccion de archivo un final de cadena
        mov ah,3ch      ;funcion para crear un archivo
        mov cx,0        ;el tipo de fichero, en este caso normal
        mov dx,offset nombre_Fichero ;direccion del fichero
        int 21h;interrupcion de bios 
        imprime op1D    ;llamamos al macro imprime con la variable Op1C
        imprime c       ;llamamos al macro imprime con la variable Op1C
        imprime continuar;llamamos al macro imprime con la variable Op1C
        leercaracter;leemos un caracter con la macro de lectura
        jmp menu;regresamos al menu

;/////////////////////////////// ETIQUETA PARA EDICION DEL FICHERO ///////////////////////////////////////////////////////////                   
   abrir_Capturar:
   limpia;limpia pantalla y ax
        imprime Op2A;llamamos al macro imprime con la variable Op1C
        imprime Op2B;llamamos al macro imprime con la variable Op1C
        lea di,nombre_Fichero;movemos lo del registro di a la variable del nombre del fichero
        ; (di para no usar si al mismo tiempo del contenido)
        guarCapturar: ;etiqueta para el guardado  
        leercaracter;leemos un caracter con la macro de lectura
        cmp al,0dh;comparamos el caracter con 'enter'
        je concatenar2;si es enter pasamos a concatenar los caracteres en tipo path
        Mov [di],ax; lo que tenemos en ax lo pasamos a di pero con  arreglo
        inc di;incrementamos di
        jmp guarCapturar;si no es un enter, regresamos a la captura
       concatenar2:;etiqueta concatenar
        Mov [di], 0000h;reiniciamos posicion di
        inc di;incrementamos di
        mov [di], '$';concatenamos a nuestra direcccion de archivo un final de cadena
        mov di ,0C00h;registro limpio por completo
        imprime Op2C;llamamos al macro imprime con la variable Op1C
        imprime C;llamamos al macro imprime con la variable x
        
        ingresarr: 
        mov ah,01h ;funcion que da la entrada de un caracter
        int 21h;interrupcion de bios
        mov nuevo_Contenido[si],al ;mueve el caracter a un espacio de memoria
        inc si ;se incrementa el registro si
        cmp al,0Dh ;se compara la entrada con la tecla enter
        je ingresararc;si es enter pasamos a abrir el archivo
        jmp ingresarr
        
        ingresararc: ;es parte de ingresar y este escribe en el archivo
        mov ah,3dh ;funcion para abrir el fichero
        mov al,01h ;se elige el modo de acceso en este caso solo escritura
        mov dx,offset nombre_Fichero ;direccion del fichero
        int 21h;interrupcion de bios
        mov bx,ax ;movemos el handle a bx
        mov cx,si ;se ingresa el numero de nuevo_Contenido
        mov dx,offset nuevo_Contenido ;se ingresa la direccion donde esta el buffer de nuevo_Contenido
        mov ah,40h ;funcion para escribir en el fichero
        int 21h;interrupcion de bios
        
        imprime ArcEscrito ;llamamos al macro imprime con la variable x
        imprime c;llamamos al macro imprime con la variable x
        imprime continuar;llamamos al macro imprime con la variable x
        leercaracter;leemos un caracter con la macro de lectura
        jmp menu;regresamos al menu

;/////////////////////////////// ETIQUETA PARA MOSTRAR AL FICHERO EN PANTALLA ///////////////////////////////////////////////////////////       
   listar:
        limpia;limpia pantalla y ax
        imprime Op3A;llamamos al macro imprime con la variable x
        imprime Op3B;llamamos al macro imprime con la variable x
        lea di,nombre_Fichero;movemos lo del registro di a la variable del nombre del fichero
        guar_Listar:  
        leercaracter;leemos un caracter con la macro de lectura
        cmp al,0dh;comparamos el caracter con 'enter'
        je concatenar3;si es enter pasamos a concatenar los caracteres en tipo path
        Mov [di],ax;lo que tenemos en ax lo pasamos a di pero con  arreglo
        inc di;incrementamos di
        jmp guar_Listar;si no es un enter regresamos a guardar
       concatenar3:;etiqueta concatenar
        Mov [di], 0000h;reiniciamos la posicion di
        inc di;incrementamos di
        mov [di], '$';concatenamos el termino de cadena para nuestra direccion
        mov di ,0C00h;registro limpio por completo
        imprime Op3C;llamamos al macro imprime con la variable x
        imprime C;llamamos al macro imprime con la variable x
        mov al,010B;acceso de lectura y escritura
        
        mov ah,3dh ;abrir fichero    
        mov al,00h;solo lectura
        mov dx,offset nombre_Fichero; guardamos el nombre del archivo a dx para la interupcion
        int 21h;interrupcion de bios
        MOV BX, AX;pasamos el handle a bx   
        MOV AH, 3FH;leer el fichero
        MOV CX, 50;50 caracteres posibles de lectura        
        lea DX, buffer;;movemos lo del registro dx a la variable del contenido del fichero
        int 21h;interrupcion de bios  
        MOV AX, BX ;pasamos a bx lo de ax  
        lea si,buffer;movemos lo del registro si a la variable del contenido del fichero
        imparch: ;imprimi el contenido leido
        printChar [SI];imprimimos caracter a caracter del contenido segun posicion de si
        cmp [si],0dh;comparamos con un enter
        je impsalir;si es enter salimos y limpiamos variables
        inc si;incrementamos la posicion si 
        jmp imparch;si no se tecleo un enter regresamos a la impresion por caracteres
        impsalir:;salir del fichero
        MOV AX, 0;reiniciamos ax
        MOV AH, 3EH;interrupcion de cerrado de archivo
        int 21h;interrupcion de bios
            
        imprime C;llamamos al macro imprime con la variable x
        imprime continuar;llamamos al macro imprime con la variable x
        leercaracter;leemos un caracter con la macro de lectura
        jmp menu 
        
;/////////////////////////////// ETIQUETA PARA CERRAR AL FICHERO ///////////////////////////////////////////////////////////  
   cerrar:
        limpia;limpia pantalla y ax
        imprime Op4A;llamamos al macro imprime con la variable x
        imprime Op4B;llamamos al macro imprime con la variable x
        lea si,nombre_Fichero;movemos lo del registro si a la variable del nombre del fichero
        guarCerrar:  
        leercaracter;leemos un caracter con la macro de lectura
        cmp al,0dh;comparamos el caracter con 'enter'
        je concatenar4;si es enter pasamos a concatenar los caracteres en tipo path
        Mov [si],ax; lo que tenemos en ax lo pasamos a si pero con  arreglo
        inc si;incrementamos la posicion si
        jmp guarCerrar;si no se tecleo un enter regresamos a la lectura
       concatenar4:;etiqueta concatenar
        Mov [si], 0000h;reiniciamos la posicion si
        inc si;incrementamos la posicion si
        mov [si], '$';concatenamos a nuestra direcccion de archivo un final de cadena
        cerrado:
        mov ah,3eh;cerrado de archivo
        mov dx,offset nombre_Fichero;con la direccion que querramos cerrar
        int 21h;cierra archivo
        imprime Op4C;llamamos al macro imprime con la variable x   
        imprime continuar;llamamos al macro imprime con la variable x
        leercaracter;leemos un caracter con la macro de lectura
        jmp menu ;realiza un salto a la etiqueta main
        
;/////////////////////////////// ETIQUETA PARA BORRAR AL FICHERO ///////////////////////////////////////////////////////////          
   eliminar:
   limpia;limpia pantalla y ax
        imprime Op5A;llamamos al macro imprime con la variable x
        imprime Op5B;llamamos al macro imprime con la variable x
        imprime Op5C;llamamos al macro imprime con la variable x
      lea si,nombre_Fichero;movemos lo del registro si a la variable del nombre del fichero
      call guar_borrar;entramos a guardar el nombre del archivo a manipular
       guar_borrar:  
        leercaracter;leemos un caracter con la macro de lectura
        cmp al,0dh;comparamos el caracter con 'enter'
        je concatenarborrar;si es enter pasamos a concatenar los caracteres en tipo path
        Mov [si],ax; lo que tenemos en ax lo pasamos a si pero con  arreglo
        inc si;incrementamos la posicion si        
        jmp guar_borrar;si no se tecleo un enter regresamos a la lectura
       concatenarborrar:;etiqueta concatenar
        Mov [si], 0000h;reiniciamos la posicion si
        inc si;incrementamos la posicion si
        mov [si], '$';concatenamos a nuestra direcccion de archivo un final de cadena
        mov ah,41h ;funcion para crear un archivo
        lea dx, nombre_Fichero ;direccion del fichero
        int 21h;interrupcion de bios
        MOV BX, AX;handle a bx
        MOV AX, 0  ;limpio ax
        mov ah,3eh ;cerrar archivo
        int 21h;interrupcion de bios 
        imprime op5D;llamamos al macro imprime con la variable x
        imprime C;llamamos al macro imprime con la variable x
        imprime continuar;llamamos al macro imprime con la variable x
        leercaracter;leemos un caracter con la macro de lectura
        jmp menu;regresamos al menu
        
;/////////////////////////////// ETIQUETA PARA CERRAR EL PROGRAMA ///////////////////////////////////////////////////////////  
   salir:
    mov ah,04ch   ;finaliza el programa
    int 21h;interrupcion de bios

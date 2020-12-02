imprime macro texto
    mov ah,9h ;funcion para imprimir en pantalla
    lea dx,texto ;carga la direccion del texto a mostrar y lo mueve al registro dx
    int 21h ;imprime el texto
endm
limpia macro 
    mov ax,0600h  ;ah 06(es un recorrido), al 00(pantalla completa)
    mov bh,71h    ;fondo blanco(7), sobre azul(1)
    mov cx,0000h  ;es la esquina superior izquierda reglon: columna
    mov dx,184Fh ;es la esquina inferior derecha reglon: columna
    int 10h  ;interrupcion que llama al BIOS
endm


.model small
.stack
.data
    A db 13,10, 'ARCHIVOS : MANEJO Y ADMINISTRACION DE DATOS','$' ;
    B db 13,10, '---------------------------------------------','$' ;
    C db 13,10, '','$' ;
    D db 13,10, 'OPERACION DE ARCHIVOS', '$' ;
    E db 13,10, '1. CREAR UN ARCHIVO DE TEXTO EN DISCO.', '$' ;son los mensajes que conforman la interfaz
    F db 13,10, '2. ABRIR EL ARCHIVO Y HACER LA CAPTURA DE DATOS POR TECLADO.', '$' ;
    G db 13,10, '3. LISTAR EN PANTALLA EL CONTENIDO DEL ARCHIVO.', '$' ;
    H db 13,10, '4. CERRAR EL ARCHIVO.', '$' ;
    I db 13,10, '5. ELIMINAR EL ARCHIVO EN DISCO.', '$' ;
    J db 13,10, ' 6. TERMINAR.', '$'
    K db 13,10, 'ELIJA SU OPCION :: ','$' ;mensaje para elegir opcion

    Op1A db 13,10, 'ARCHIVOS : MANEJO Y ADMINISTRACION DE DATOS [ OPCIÓN 1 ]', '$' ;mensaje de archivo eliminado
    Op1B db 13,10 '-------------------------------------------','$'
    Op1C db 13,10, 'EL NOMBRE DEL NUEVO ARCHIVO A CREAR : datos_prueba.txt', '$' ;mensaje de archivo creado
    Op1D db 13,10, 'AVISO : ARCHIVO CREADO EXITOSAMENTE !','$' ;mensaje que indica donde empezar a escribir

    Op2A db 13,10, 'ARCHIVOS : MANEJO Y ADMINISTRACION DE DATOS [ OPCION 2 ]','$'
    Op2B db 13,10, '--fin de la cita--,','$'

    Op3A db 13,10, 'ARCHIVOS : MANEJO Y ADMINISTRACION DE DATOS [ OPCION 3 ]','$'
    Op3B db 13,10, 'EL CONTENIDO DEL ARCHIVO datos_prueba.txt ES :,','$'

    Op4A db 13,10, 'ARCHIVOS : MANEJO Y ADMINISTRACION DE DATOS [ OPCION 4 ]','$'
    Op4B db 13,10, 'EL ARCHIVO datos_prueba.txt FUE CERRADO EXITOSAMENTE !','$'

    Op5A db 13,10, 'ARCHIVOS : MANEJO Y ADMINISTRACION DE DATOS [ OPCION 5 ]','$'
    Op5B db 13,10, 'EL ARCHIVO datos_prueba.txt FUE ELIMINADO DE DISCO EXITOSAMENTE ! !','$'

    OpTecla db 13,10, 'PRESIONE CUALQUIER TECLA PARA REGRESAR AL MENU PRINCIPAL...: ','$' ;mensaje que indica lo que contieneel archivo


    ArcEscrito db 13,10, 'Archivo escrito', '$' ;mensaje de archivo escrito
    archivo db 'datos_prueba.txt', 0 ;etiqueta que contiene el nombre del archivo
    letras db 50 dup('$') ;espacio de memoria para los caracteres
    handle db 0 ;nos permite escribir en el archivo
.code
    Inicio:  
        mov ax,@data ;rutina que guarda en el registro ds, la posicion
        mov ds,ax ;del segmento de datos
        imprime A ;
        imprime B ;
        imprime C ;
        imprime D ;
        imprime E ;imprime toda la interfaz del programa
        imprime F ;
        imprime G ;
        imprime H ;
        imprime I ;
        imprime J ;
        imprime K 
        limpia



.model small
.stack
.data
cadena db '$' ;defino mi variable que contendra la cadena

.code
.startup

;limpiar pantalla
    mov ah,00h          ;leo un caracter sin eco
    mov al,03h          ;muevo el contenido a la localidad 03h
    int 10h             ;visualiza el caracter tecleado

    mov cx,10           ;declaramos el contador en 10
    mov si,0            ;si sera nuestro contador en la cadena del caracter
    leer:               ;etiqueta leer:
    mov ah,07h          ;registro acumulado ax en 07h
    int 21h             ;interrucion

 
;lee 10 caracteres y los gurda el cadena

     mov dl,al          ;es el contenido de 03h
     mov ah,02h         ;gu
     int 21h            ;interrupcion
     mov cadena[si],al  ;en la cadena posicion si guarda el caracter tecleado
     inc si             ;incrementa el contador si
     loop leer          ;ciclo loop, cx-1 
  
;imprimiendo caracter por caracter
    mov cx,10           ;contador cx 10
    mov si, offset cadena ;pasamos la cadena en offset
    imprimir:           ;etiqueta imprimir
    mov dl,[si]         ;es el contenido en la posicion si
    add dl,00h          ;iniciamos el codigo ascci en la posicon que teclemaos
    mov ah,02h          ;despliega el resultado
    int 21h             ;interrupcion
    inc si              ;incrementamos el registro si
    loop imprimir       ;ciclo loop , cx-1

.exit                   ;llamamos al final
end                     ;fin 
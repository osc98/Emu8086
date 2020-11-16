.model small

.data
    salto db 13, 10, "$";salto de linea
.code
.startup
    mov cx,18 ;iniciamos cx en 18
    
    meter:      ;etiqueta meter:
    mov ah,01h  ;petcion para leer un caracter
    int 21h     ;interrupcion de sistema
    push ax     ;metemos valor en pila
    loop meter  ;regresamos a meter
    
    mov ah, 09  ;muestra el caracter en pantalla 
    mov dx, offset salto ;direccion absoluta 
    lea dx, salto        ;mostramos en pantalla
    int 21h
    
    mov cx,18   ;iniciamos cx en 18 
    
    imprimir:   ;etiqueta imprimir
      pop ax    ;saca el dato de la cima de la pila      
      mov ah,02h;establecemos la posicion del cursor
      mov dl,al ;pasamos  ah a dl 
      int 21h   ;interrupcion de bio
    loop imprimir ;regresamos a la etiqueta imprimir
    
    
    salir:
      mov ah,04ch ;finaliza el programa
      int 21h
end
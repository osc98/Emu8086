.model small
.stack
.data
.code
.startup
mov al,7     ;primer numero base a multiplicar
mov bl,8     ;segundo numero base multiplicador
mul bl       ;multiplica lo del registro al con el registro bl

mov bl,10    ;esperamos resultados de 00 al 99

div bl       ;fuente de tipo byte. El cociente queda en AL (AL=1), y el resto queda en AH(AH=2)
mov bx,ax    ; almacena en AX el contenido de la direccion de memoria
or bx,3030h  ;el resultado bx se pasa a ascii acumulador de datos
mov ah,02h   ;la funcion 02H indica la operacion que coloca al cursor, carga la pantalla
mov dl,bl    ;mandamos a dl para poder ver en pantalla el caracter
int 21h      ;interrupcion para imprimir las decenas
mov ah,02h   ;la funcion 02H indica la operacion que coloca al cursor, carga la pantalla
mov dl,bh    ;pasamos el registro de 8 bits bh
int 21h      ;interrupcion para imprimir las unidades

.exit
end
.model small
.stack
.data
leido db "$"
cont dw 0h ;almacena el número de palabras leídas
handle dw ? ; identificador del manejador de archivo
mensaje db 13,10,"Numero de palabras en el archivo: ","$"
msjerror db 13,10,"Error, no se pudo abrir el archivo ","$"
archivo db "palabras.txt", 0 ;almacena el nombre del archivo a leer

.code
inicio:
mov ax, @data ;se asigna la dirección del segmento de datos
mov ds, ax ;inicializar segmento de datos

mov al, 0 ;modo de acceso para abrir archivo, 0 indica que se abrirá en modo lectura/escritura
mov dx, offset archivo ;carga en dx la dirección de memoria donde está la cadena ASCII con el nombre de fichero:
mov ah, 3dh ;función para abrir un fichero
int 21h ;llamada a la interrupción DOS
jc error ;si no se ejecutó correctamente: Flag de acarreo (Cf) = 1. Salta a la etiqueta error
mov handle, ax ;si no, mover a handle el manejador de fichero dado por el SO
jmp leer

error:
mov ah, 9h ;función para la visualización de una cadena de caracteres utilizando la int 21h

lea dx, msjerror ;Imprimir el mensaje de error
int 21h
jmp fin ;salta a la etiqueta fin

leer: ;leer archivo
mov ah, 3fh ;función para leer archivo lectura de un fichero
mov bx, handle
mov cx, 1 ;número de bytes a leer
mov dx, offset leido ;se indica el desplazamiento del buffer donde se depositaran los caracteres leídos
int 21h
cmp ax, 0 ;ax queda en 0 cuando llega al final del archivo
je cerrar ;si es 0 entonces va a la etiqueta cerrar para cerrar archivo
mov dl, leido
cmp dl, " " ;comparar si el byte leido es un espacio
je otrapalabra ;si el resultado de la comparacion indica que son iguales salta a la etiqueta otrapalabra
jmp caracter ;si no es espacio entonces salta a la etiqueta caracter

otrapalabra:
inc cont ;incrementa el número de palabras leídas

caracter:
jmp leer ;salta a la etiqueta leer

cerrar: ;cerramos archivo
inc cont ;función cerrar un fichero
mov ah, 3eh
mov bx, handle
int 21h

;imprimir el número de palabras leídas
mov ah, 9h ;función para la visualización de una cadena de caracteres utilizando la int 21h
lea dx, mensaje ;Imprimir el mensaje de la etiqueta resultado
int 21h
mov ax,cont ;movemos a ax lo que se encuentra en cont
AAM ;Ajuste ASCII en Multiplicación, resulta un valor decimal desempaquetado
;ah=al/10
;al=al%10
mov bx,ax
mov dl, bh ;carga la parte alta del registro bx en dl. Mostrar digito de la izquierda
add dl, 30h ;para convertir a ascii
mov ah,2h ;función salida de caracter de la int 21h
int 21h

mov dl, bl ;carga la parte baja del registro bx en dl. Mostrar digito de la derecha
add dl, 30h ;para convertir a ascii
mov ah,2h ;función salida de caracter de la int 21h
int 21h ;salta a la etiqueta fin
jmp fin

fin:
mov ax, 4ch ;función para terminar la ejecución del programa
int 21h

end inicio ;directiva de cierre del programa

Ejemplo: Archivo
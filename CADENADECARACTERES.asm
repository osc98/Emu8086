.model small ; Tipo de memoria que se utilizara(small)

.data

; definición de segmentos de datos para
mensaje db 'Ingresa la cadena','$' ; Mensaje a mostrar
salto db 10,13,'$' ; La secuencia 13, 10es el final de línea



cadena db 53 dup('$') ; Define 50 caracteres de entrada+3


; Para la rutina Input del dos

.code
mov ax, @data ; Rutina que guarda en el registro ds, la
mov ds,ax ; posición del segmento de datos.
mov ah,09h ; Función 9 de la int 21 para imprimir en



mov dx, offset mensaje
int 21h ; Transferir al MS-DOS
mov ah,09h
lea dx, salto ; Salto de línea
int 21h ; Transferir al MS-DOS
mov ah,0Ah
lea dx, cadena ; Carga la dirección de cadena y lo mueve al registro dx
int 21h ; Transferir al MS-DOS
mov ah,09h ; función 9 de la int 21 para imprimir en


lea dx, salto ; salto de línea
int 21h ; Transferir al MS-DOS
mov ah,09h ; función 9 de la int 21 para imprimir en



lea dx, cadena+2 ; Carga a dx la cadena a imprimir
int 21h ; Transferir al MS-DOS
mov ax,4c00h ; Fin del programa y vuelta al DOS   
int 21h
end
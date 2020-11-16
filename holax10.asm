stack segment STACK para 'stack'
db 64h dup(00h)
stack ends

data segment
	mensaje db "Hola Mundo", 0dh, 0ah, "$"
data ends

code segment
assume cs:code, ds:data, ss:stack
main proc far
prologo:
	push ds
	xor ax,ax
	mov ax,data
	mov ds,ax

mov cx,000ah
imprimirMensaje:
mov ah,09h
lea dx,mensaje
int 21h
loop imprimirMensaje

finalizar:
mov ah,4ch
int 21h
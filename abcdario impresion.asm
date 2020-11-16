.model small
.stack
.data

.code
mov cx, 25

ciclo: 

mov ah, 02h 
lea dx, cx
add dx, 40h
int 21h 

loop ciclo 

salir:
.exit
end
.model small
.stack
.data

   var1 db ?
   var2 db ?
   msg1 db '++ El primero es mayor++ $'
   msg2 db '++ El primero es menor++$'
   msg3 db '++ Son iguales++$'
   msg4 db '++ Primero valor++ $'
   msg5 db '++ Segundo valor++ $'

.code
.startup
 
   mov ah,00h
   mov al,03h
   int 10h

   mov ah,02h
   mov dx,0510h
   mov bh,0
   int 10h
   

   mov ah,09h
   lea dx,msg4
   int 21h

   mov ah,07h
   int 21h

   mov ah, 02h
   mov dl,al
   int 21h
   mov  var1,al
   ;//////////
   mov ah,09h
   lea dx,msg5
   int 21h

   mov ah,07h
   int 21h

   mov ah,02h
   mov dl,al
   int 21h
   mov var2,al
   ;////

  cmp var1,al
  ja mayor
  jb menor
  je igual

mayor:  

   mov ah,09h
   lea dx,msg1
   int 21h
   jmp salir

menor:

   mov ah,09h
   lea dx,msg2
   int 21h
   jmp salir

igual:

   mov ah,09h
   lea dx,msg3
   int 21h
   jmp salir


salir:

  .exit
   end
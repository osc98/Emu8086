.model small
.stack
.data

   var1 db ?    ;variable 1 vacia
   var2 db ?    ;variable 2 vacia
   var01 db ?   ;variable 01 vacia
   var02 db ?   ;variable 02 vacia
   msg1 db ,13,10,' Solo numeros menor a dos++ $'   ;variable del mensaje
   msg2 db ,13,10,' Adios++$'                       ;variable del mensaje
   msg3 db ,13,10,' Hola++$'                        ;variable del mensaje
   msg4 db '[1] Adios----[2] Hola++ $'              ;variable del mensaje

.code
.startup
 
   mov ah,00h   ;leo un caracter sin eco
   mov al,03h   ;muevo el contenido a la localidad 03h
   int 10h      ;visualiza el caracter tecleado

   mov ah,02h   ;despliega el resultado
   mov dx,0510h ;el registro cx pasa a 0510h localidad
   mov bh,0     ;pasa el registro interno del microprocesador 
   int 10h      ;controla los servicios de pantalla
   

   mov ah,09h   ;visualiza la cadena caracteres
   lea dx,msg4  ;mostramos la variable msg4
   int 21h      ;interrupcion de pantalla

   mov ah,07h   ;registro acumulado ax en 07h
   int 21h      ;interrupcion de pantalla

   mov ah, 02h  ;despliega el resultado
   mov dl,al    ;es el contenido de 03h
   
   mov  var1,al ;guardamos el valor de al en la variable
   
   
   mov ah, 02h  ;despliega el resultado
   mov var01,1  ;guardamos el valor 1 en la var01
   mov var01,al ;asignamos var01 al registro al
   int 21h      ;interrupcion para mostrar pantalla
  cmp var1, '2' ;hacemos la comparacion del var1 con 2
  ja mayor      ;si es mayor vamos a etiqueta mayor
  jb menor      ;si es menor vamos a etiqueta menor
  je igual      ;si es igual a 2 va aetiqueta igual

mayor:  

   mov ah,09h
   lea dx,msg1 ;imprimimos la variable msg1
   int 21h
   jmp salir

menor:

   mov ah,09h
   lea dx,msg2 ;imprimimos la variable msg2
   int 21h
   jmp salir

igual:

   mov ah,09h
   lea dx,msg3 ;imprimimos la variable msg3
   int 21h
   jmp salir


salir:

  .exit
   end       ;Fin
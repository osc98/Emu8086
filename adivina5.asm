.model small
.stack
.data
   linefeed db 13, 10, "$"
   var1 db ?    ;variable 1 vacia
   var01 db ?   ;variable 01 vacia
   var02 db ?   ;variable 02 vacia
   msg1 db ,13,10,'Ingresa un numero y el sistema lo incrementara o  decrementara hasta que sea igual a 5$'   ;variable del mensaje
   msgR db ,13,10,'La variable tiene el valor de 5$'  
    ;variable del mensaje
   msg2 db ,13,10,' mas 1$'                        ;variable del mensaje
   msg3 db ,13,10,'menos 1$'              ;variable del mensaje

.code
.startup
   mov ah,09h   ;visualiza la cadena caracteres
   lea dx,msg1  ;mostramos la variable msg4
   int 21h      ;interrupcion de pantalla    
   mov ah, 09 
   mov dx, offset linefeed 
   int 21h
   mov ah,07h   ;registro acumulado ax en 07h
   int 21h      ;interrupcion de pantalla
   mov ah, 02h  ;despliega el resultado
   mov dl,al    ;es el contenido de 03h   
   mov  var1,al ;guardamos el valor de al en la variable 
   mov ah, 02h  ;despliega el resultado
   mov var01,1  ;guardamos el valor 1 en la var01
   mov var01,al ;asignamos var01 al registro al
   int 21h      ;interrupcion para mostrar pantalla
   jmp comparar
comparar:       
   cmp var1, '5' ;hacemos la comparacion del var1 con 5
   ja mayor      ;si es mayor vamos a etiqueta mayor
   jb menor      ;si es menor vamos a etiqueta menor
   je igual      ;si es igual a 2 va aetiqueta igual

mayor:  
   mov ah,09h
   lea dx,msg3 ;imprimimos la variable msg1
   int 21h
   dec var1     ;decrementamos el vvalor de var1
   jmp comparar

menor:
   mov ah,09h
   lea dx,msg2 ;imprimimos la variable msg2
   int 21h     
   inc var1    ;incrementamos el valor de var1
   jmp comparar

igual:

   mov ah,09h
   lea dx,msgR ;imprimimos la variable msg3
   int 21h
   jmp salir

salir:

  .exit
   end       ;Fin
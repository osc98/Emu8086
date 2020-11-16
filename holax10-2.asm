.model tiny           ;Declaro el modelo del programa
                                            
.data                 ;Segmento de datos
    msg: db "Hola Mundo!",13,10,"$" ;Declaramos nuestra variable con el mensaje 
                                             
.code                 ;Segmento de codigo
    
    final macro       ;Declara el macro final
    mov ax,0c07h      ;Se regresa el control al usuario
    int 21h           ;Ejecuta la interrupcion
   
   .exit              ;Finaliza el programa
    endm              ;Fin de macro 
   
.start                ;Inicio de las instrucciones
    
    mov cx,10         ;uso cx para el registro de contador
    for1:             ;declaro el primer loop que es el equivalente a for        
    push cx           ;almacena registros usados en este procedimiento
    mov cx,10         ;se vuelve a usar el registro de contador para el segundo loop
    
    for2:             ;declaro el segundo loop que es el equivalente a for
    mov ah,09h        ;hago peticion para desplegar en pantalla
    lea dx,msg        ;imprimo en pantalla la variable msg
    int 21h           ;ejecutamos interrupcion
    
    loop for2         ;realiza el bucle a for2
    pop cx            ;recupera al contador de ciclo
    loop for1         ;hace el ciclo a for1
       
    salir:            ;Declaro salir
    final         ;Llamo a finalizar
       
end ;fin instrucciones

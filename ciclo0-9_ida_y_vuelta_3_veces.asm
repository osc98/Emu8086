.model tiny           ;Declaro el modelo del programa
                                            
.data                 ;Segmento de datos
                                                 
.code                 ;Segmento de codigo
    
    final macro       ;Declara el macro final
    mov ax,0c07h      ;Se regresa el control al usuario
    int 21h           ;Ejecuta la interrupcion
   
   .exit              ;Finaliza el programa
    endm              ;Fin de macro 
   
.start                ;Inicio de las instrucciones
    
    mov cx,5          ;uso cx para el registro de contador
    for1:
    push cx           ;declaro el primer loop que es el equivalente a for        
    mov cx,0Bh        ; inicializo contador en once

    repite:
    mov dl,cl         ; muevo el valor del contador a dl para imprimir
    dec cl            ; decremento el contador en uno
    add dl,2Fh        ; sumo 2Fh o 47 a dl para convertirlo al codigo ascii y poder imprimirlo
    mov ah,02h        ; funcion para imprimir un caracter
    int 21h           ; imprimo
    cmp cl,00h        ; compara si en el contador hay un ':'
    jne repite        ; sino es verdadera la ultima comparacion regresa a repite
                      ; si lo es pasa a la siguiente instruccion
    pop cx
    loop for1         ;hace el ciclo a for1
       
    salir:            ;Declaro salir
    final             ;Llamo a finalizar
       
end ;fin instrucciones

.MODEL SMALL  ;MODELO DE LA MEMORIA    
.DATA         ;DECLARACION DE LAS VARIABLES A USAR 
mensaje DB  " RESULTADO DE ROL:  $"

.code  
MOV AX,@DATA       ;INICIALIZA EL SEGMENTO          
MOV DS,AX          ;DE DATOS   
MOV BL,10000001b   ;equivale a 81 y a Å en ascii
ROL BL, 2          ;se desplaza dos a la izquierda
                   ;quedando 00000110 que es 6 
mov  dX, bX        ;pasamos el valor a dx
add  dX, 48        ;sumamos 48 para convertir el 6 a ascii 
mov  ah, 02h       ;lo usamos para imprimir un caracter
int  21h           ;interrupcion de pantalla
     
END
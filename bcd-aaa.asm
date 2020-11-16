.model small

.code

     mov  ax,9                ;ax=9 decimal
     add  al,8                ;sumamos 8+9    
     daa                      ;convertimos 011h a decimal '17'
     mov  ax,9                ;ax=9 decimal
     add  al,8                ;sumamos 8+9
     aaa                      ;AX=011h
     
     mov  ax,00001001b        ;ax=9 en binario
     add  al,00000011b        ;al=3 en binario
     daa                      ;AX=9+3=0b hexadecimal =12 decimal
     
     mov  ax,9                ;ax= 9 en decimal
     add  al,3                ;al=3 en decimal
     aaa                      ;AX=0C Hexadeciaml

     mov  ax,4C00h            ;Llamamos a finalizar
     int  21h                 ;Terminar el programa
end
.MODEL SMALL
     .STACK 100H
     .DATA
        NUM DW ?                                   
        lbk    db 13,10,'$'   ;LINE BREAK.
        numstr db '$$$$$'     ;STRING FOR 4 DIGITS.

     .CODE
     MAIN PROC
          MOV AX,@DATA
          MOV DS,AX

         MOV NUM, 0         ;FIRST NUMBER.
     START:
         CMP NUM, 100       ;IF NUM <= 100...
         JBE PRINT          ;...DISPLAY NUM.           
         JMP END_

     PRINT:
;         MOV AH,2            ;THIS CODE
;         MOV DL,NUM          ;DISPLAYS
;         INT 21H             ;ONE CHAR ONLY.

     ;CONVERT NUMBER TO STRING.
         mov  si, offset numstr
         mov  ax, num
         call number2string    ;RETURNS NUMSTR.

     ;DISPLAY STRING.
         mov  ah, 9
         mov  dx, offset numstr
         int 21h     

     ;DISPLAY LINE BREAK.
         mov  ah, 9
         mov  dx, offset lbk
         int 21h     

         INC NUM              ;NUM++.
         JMP START

     END_:
         MOV Ax,4C00H
         int 21h
         MAIN ENDP

;------------------------------------------
;CONVERT A NUMBER IN STRING.
;ALGORITHM : EXTRACT DIGITS ONE BY ONE, STORE
;THEM IN STACK, THEN EXTRACT THEM IN REVERSE
;ORDER TO CONSTRUCT STRING (STR).
;PARAMETERS : AX = NUMBER TO CONVERT.
;             SI = POINTING WHERE TO STORE STRING.

number2string proc 
  call dollars ;FILL STRING WITH $.
  mov  bx, 10  ;DIGITS ARE EXTRACTED DIVIDING BY 10.
  mov  cx, 0   ;COUNTER FOR EXTRACTED DIGITS.
cycle1:       
  mov  dx, 0   ;NECESSARY TO DIVIDE BY BX.
  div  bx      ;DX:AX / 10 = AX:QUOTIENT DX:REMAINDER.
  push dx      ;PRESERVE DIGIT EXTRACTED FOR LATER.
  inc  cx      ;INCREASE COUNTER FOR EVERY DIGIT EXTRACTED.
  cmp  ax, 0   ;IF NUMBER IS
  jne  cycle1  ;NOT ZERO, LOOP. 
;NOW RETRIEVE PUSHED DIGITS.
cycle2:  
  pop  dx        
  add  dl, 48  ;CONVERT DIGIT TO CHARACTER.
  mov  [ si ], dl
  inc  si
  loop cycle2  

  ret
number2string endp       

;------------------------------------------
;FILLS VARIABLE WITH '$'.
;USED BEFORE CONVERT NUMBERS TO STRING, BECAUSE
;THE STRING WILL BE DISPLAYED.
;PARAMETER : SI = POINTING TO STRING TO FILL.

proc dollars                 
  mov  cx, 5
  mov  di, offset numstr
dollars_loop:      
  mov  bl, '$'
  mov  [ di ], bl
  inc  di
  loop dollars_loop

  ret
endp  

;------------------------------------------

     END MAIN
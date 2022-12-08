.486
.model flat, c
.code
Funct PROC
push ebp
mov ebp,esp
 mov ecx,[ebp+16]
mov edi,[ebp+12]
mov esi,[ebp+8]
L: lodsb
mov [edi+ecx-1],al
 loop L
 mov esi,offset Text
 add edi,[ebp+16]
 mov ecx,22
rep movsb
 pop ebp
 ret
Funct ENDP
Text DB ' - Перевернутая строка'
END
section .text
global _start:
_start:

;counting largest and smallest words
mov eax,4
mov ebx,1
mov ecx,msg
mov edx,len
int 80h


mov edi,string
mov byte[n],0
cld
read:
pusha
mov eax,3
mov ebx,0
mov ecx,d
mov edx,1
int 80h
popa
cmp byte[d],10
je end_read
mov al,byte[d]
stosb
inc byte[n]
jmp read
end_read:

cld
mov esi,string
mov edi,str
movzx ecx,byte[n]
mov byte[m],0
mov byte[small],255
mov byte[large],0

find:

lodsb
cmp al,32
je checkword
cmp al,9
je checkword

stosb
inc byte[m]


l:
loop find
jmp checkword

l2:
mov eax,4
mov ebx,1
mov ecx,msgs
mov edx,lens
int 80h


cld
mov esi,strs
movzx ecx,byte[small]
call prints
call printl

mov eax,4
mov ebx,1
mov ecx,msgl
mov edx,lenl
int 80h


cld
mov esi,strl
movzx ecx,byte[large]
call prints
call printl

jmp exit

checkword:
mov dl,byte[m]
cmp dl,byte[small]
jb smaller
next:
cmp dl,byte[large]
ja larger
cmp ecx,0
je l2
mov edi,str
mov byte[m],0
jmp l

smaller:
mov byte[small],dl

pusha
pushf
cld
mov esi,str
mov edi,strs
movzx ecx,byte[small]

mov2:
movsb
loop mov2

popf
popa

jmp next

larger:
mov byte[large],dl

pusha
pushf
cld
mov esi,str
mov edi,strl
movzx ecx,byte[large]

mov3:
movsb
loop mov3

popf
popa
mov edi,str
mov byte[m],0
cmp ecx,0
je l2
jmp l







cld
mov esi,string
movzx ecx,byte[n]
prints:

lodsb
mov byte[d],al
pusha
mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h
popa
loop prints

end_print:
ret

printl:
pusha
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa
ret

exit:
mov eax,1
mov ebx,0
int 80h


toprint:
pusha
pushf
mov esi,str
movzx ecx,byte[m]
call prints
call printl
popf
popa





section .bss
string:resw 50
d:resb 1
n:resb 1
str:resw 50
strl:resw 50
strs:resw 50
m:resb 1
small:resb 1
large:resb 1

section .text
newline:db 0Ah
tab:db " "
msg:db "Enter string: "
len:equ $-msg
msgl:db "Largest word: "
lenl:equ $-msgl
msgs:db "Smallest word: "
lens:equ $-msgs

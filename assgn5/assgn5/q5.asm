section .text
global _start:
_start:

;replacing a word
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h


cld
mov edi,string
mov byte[len],0
call read
mov dl,byte[n]
mov byte[len],dl

;reading word to be replaced
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h

cld
mov edi,old
mov byte[l1],0
call read
mov dl,byte[n]
mov byte[l1],dl



;reading word with which replaced
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h

mov edi,new
mov byte[l2],0
cld
call read
mov dl,byte[n]
mov byte[l2],dl


cld
mov esi,string
mov edi,str
movzx ecx,byte[len]
mov byte[m],0

replace:
lodsb
cmp al,32
je compare
cmp al,9
je compare

stosb
inc byte[m]

l:
loop replace

jmp compare
jmp exit

compare:
pusha
pushf

mov esi,str
mov edi,old
movzx ecx,byte[m]
cld
same:

cmpsb
jne printword
loop same

mov esi,new
movzx ecx,byte[l2]
cld
call prints
call printtab
popf
popa
mov edi,str
mov byte[m],0
cmp ecx,0
je exit
jmp l


printword:


mov esi,str
movzx ecx,byte[m]
cld
call prints
call printtab
popf
popa
mov edi,str
mov byte[m],0
cmp ecx,0
je exit
jmp l





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
ret


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

printtab:
pusha
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h
popa
ret

exit:
mov eax,1
mov ebx,0
int 80h


section .bss
string:resw 50
d:resb 1
n:resb 1
m:resb 1
l1:resb 1
l2:resb 1
len:resb 1
str:resw 50
old:resw 50
new:resw 50

section .text
newline:db 0Ah
tab:db " "
msg1:db "Enter string: "
len1:equ $-msg1
msg2:db "Enter word to be replaced: "
len2:equ $-msg2
msg3: db "Enter the word to be replaced with: "
len3:equ $-msg3

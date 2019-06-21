section .text
global _start:
_start:

;searching in an array
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
mov edi,string
movzx ecx,byte[n]
mov al,'A'

search:
scasb
je found
loop search
mov word[num],0
call print_num
jmp exit

found:
mov word[num],1
call print_num
jmp exit

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
ret

print_num:
pusha
cmp word[num],0
je print0
mov byte[nod],0

extract_d:
cmp word[num],0
je print
inc byte[nod]
mov ax,word[num]
mov bx,10
mov dx,0
div bx
push dx
mov word[num],ax
jmp extract_d

print:
cmp byte[nod],0
je end_print
dec byte[nod]
pop dx
add dx,30h
mov word[d],dx

mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h

jmp print

end_print:
popa
ret

print0:
mov eax,4
mov ebx,1
mov ecx,zero
mov edx,1
int 80h
jmp end_print


exit:
mov eax,1
mov ebx,0
int 80h


section .bss
string:resw 50
d:resb 1
n:resb 1
num:resw 1
nod:resb 1

section .text
zero:db "0"

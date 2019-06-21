section .text
global _start:
_start:

;call read_num
;call print_num

;readm
call read_num
mov ax,word[num]
mov word[m],ax

mov eax,a
mov ebx,0
mov byte[i],0
readarray:
call read_num
mov dx,word[num]
mov word[eax+2*ebx],dx
inc ebx
inc byte[i]
mov dl,byte[m]
cmp byte[i],dl
jb readarray

mov byte[i],0
mov eax,a
mov ebx,0

printarray:
mov dx,word[eax+2*ebx]
mov word[num],dx
call print_num

pusha
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h
popa

 inc byte[i]
inc ebx
mov dl,byte[i]
cmp dl,byte[m]
jb printarray






exit:
mov eax,1
mov ebx,0
int 80h

read_num:
pusha
mov word[num],0

read_d:

mov eax,3
mov ebx,0
mov ecx,d
mov edx,1
int 80h

cmp byte[d],10
je end_read
cmp byte[d],32
je end_read

sub byte[d],30h
mov ax,word[num]
mov bx,10
mul bx
mov bl,byte[d]
mov bh,0
add ax,bx
mov word[num],ax
jmp read_d
end_read:
popa
ret

print_num:
pusha
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

section .text
tab:db " "

section .bss
d:resw 1
num:resw 1
nod:resw 1
a:resw 50
i:resw 1
m:resw 1

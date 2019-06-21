section .text
global _start:
_start:


;factorial of a number
;read n
mov eax,4
mov ebx,1
mov ecx,msg
mov edx,len
int 80h

call read_num
mov ax,word[num]
mov word[n],ax

mov dword[f],1
call factorial
mov eax,dword[f]
mov dword[num],eax
call print_num


exit:
mov eax,1
mov ebx,0
int 80h

factorial:
cmp word[n],0
je ret0
mov eax,dword[f]
mov ebx,dword[n]
mul ebx
mov dword[f],eax
dec word[n]
call factorial
ret0:
ret

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
cmp dword[num],0
je print0
mov byte[nod],0

extract_d:
cmp dword[num],0
je print
inc byte[nod]
mov eax,dword[num]
mov ebx,10
mov edx,0
div ebx
push edx
mov dword[num],eax
jmp extract_d

print:
cmp byte[nod],0
je end_print
dec byte[nod]
pop edx
add dl,30h
mov byte[d],dl

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


printtab:
pusha
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h
popa
ret

section .text
tab:db " "
zero:db "0"
msg:db "Enter n: "
len:equ $-msg

section .bss
d:resw 1
num:resd 1
nod:resw 1
n:resd 1
f:resd 1

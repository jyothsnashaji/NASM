section .text
global _start:
_start:


;sum of numbers upto n
mov eax,4
mov ebx,1
mov ecx,msg
mov edx,len
int 80h

;read n
call read_num
mov ax,word[num]
mov word[n],ax

mov word[sum],0
call addNumbers
mov ax,word[sum]
mov word[num],ax
call print_num


exit:
mov eax,1
mov ebx,0
int 80h

addNumbers:
cmp word[n],0
je ret0
mov ax,word[n]
add word[sum],ax
dec word[n]
call addNumbers
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
num:resw 1
nod:resw 1
n:resw 1
sum:resw 1

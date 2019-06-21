section .text
global _start:
_start:

;reading numbers
mov eax,4
mov ebx,1
mov ecx,msg
mov edx,len
int 80h


mov eax,a
mov ecx,0
mov byte[i],0
reada:
call read_num
mov bx,word[num]
mov word[eax+2*ecx],bx
inc ecx
inc byte[i]
cmp byte[i],10
jb reada



call sum

call print_num





exit:
mov eax,1
mov ebx,0
int 80h



sum:
mov ebx,a
mov ecx,0
mov byte[i],0
mov word[num],0

findsquare:
mov ax,word[ebx+2*ecx]
mov dx,ax
mul dx
add word[num],ax
;call print_num
inc ecx
inc byte[i]
cmp byte[i],10
jb findsquare
ret





read_num:
pusha
mov word[num],0

loop_read:
mov eax,3
mov ebx,0
mov ecx,d
mov edx,1
int 80h

cmp byte[d],10
je end_read
cmp byte[d],32
je end_read

mov ax,word[num]
mov bx,10
mul bx
mov bl, byte[d]
mov bh,0
sub bl,30h
add ax,bx
mov word[num],ax
jmp loop_read
end_read:
popa
ret

print_num:

mov byte[nod],0
pusha
cmp word[num],0
je print0

extract_num:
cmp word[num],0
je print_no
inc byte[nod]

mov dx,0
mov ax,word[num]
mov bx,10
div bx
push dx
mov word[num],ax
jmp extract_num

print_no:
cmp byte[nod],0
je end_print
dec byte[nod]
pop dx
mov byte[d],dl
add byte[d],30h

mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h
jmp print_no
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

section .bss
d:resb 1
nod:resw 1
num:resw 1
a:resw 50
i:resb 1

section .data
zero:db "0"
msg:db "Enter the numbers: "
len:equ $-msg

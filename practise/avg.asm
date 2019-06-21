section .data
fmt1:db "%lf",0
fmt2:db "%lf",10

section .bss
num:resq 1
nod:resw 1
a:resq 20
d:resw 1
i:resw 1

section .text
global main:

extern printf
extern scanf

main:
call read_num

mov byte[i],0
fldz

sum:
mov ax,word[num]
cmp word[i],ax
jnb pp
call read

fadd st1

inc byte[i]
jmp sum
pp:

fild qword[num]

fdivr st1
call print


exit:
mov eax,1
mov ebx,0
int 80h

read:
push ebp
mov ebp,esp
sub esp,8
lea eax,[ebp-8]
push eax
push fmt1
call scanf
fld qword[ebp-8]
mov esp,ebp
pop ebp
ret

print:
push ebp
mov ebp,esp
sub esp,8

fst qword[ebp-8]
push fmt2
call printf
mov esp,ebp
pop ebp
ret
read_num:
pusha
mov word[num],0


readd:
mov eax,3
mov ebx,0
mov ecx,d
mov edx,1
int 80h

cmp word[d],10
je end
sub word[d],30h
mov ax,word[num]
mov dx,10
mul dx
add ax,word[d]
mov word[num],ax

jmp readd
end:
popa
ret

print_num:
mov word[nod],0
pusha
check:
cmp word[num],0
je startprint
mov ax,word[num]
mov bx,10
mov dx,0
div bx
push dx
inc word[nod]
mov word[num],ax
jmp check
startprint:
cmp word[nod],0
je endp
dec word[nod]
pop dx
mov word[d],dx
add word[d],30h

mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h
jmp startprint
endp:
popa
ret



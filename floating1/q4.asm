section .data
pi:dq 3.141592
two: dq 2.0
s: dq 0.00001
mes: db'Enter Number:',0Ah
mesl: equ $-mes
mek: db'Enter K',0Ah
mekl: equ $-mek
msg: db'',0Ah
msgl: equ $-msg
format1: db "%lf",0
format2: db "%lf",10
section .bss
num:resw 1
n:resw 1
i:resd 1
j:resd 1
k:resq 1
q1:resq 1
q2:resq 1
float1:resq 1
float2:resq 1
float3:resq 1
array: resq 100

section .text
global main:
extern scanf
extern printf

main:
call arrayread

mov eax, 4
mov ebx, 1
mov ecx, mek
mov edx, mekl
int 80h

call read
fstp qword[k]
call sort
call exit


exit:
mov eax, 1
mov ebx, 0
int 80h


sort:
mov word[i],0
fori:
mov ax, word[i]
inc ax
mov word[j], ax
forj:
call swap
inc word[j]
mov ax, word[n]
cmp ax, word[j]
ja forj
inc word[i]
mov ax, word[n]
dec ax
cmp ax, word[i]
ja fori
ret

swap:
call free
mov eax,dword[i]
mov ebx,dword[j]
fld qword[array + 8*eax]
fld qword[array + 8*ebx]
fadd st1
fstp qword[q1]
fstp qword[q2]
fld qword[q1]
fld qword[k]
fsub st1
fabs
fld qword[s]
fcomi st1
ja same1
jmp same
same1:
fld qword[array + 8*eax]
call print
fld qword[array + 8*ebx]
call print
mov eax, 4
mov ebx, 1
mov ecx, msg
mov edx, msgl
int 80h
same:
call free
ret




free:
ffree st0
ffree st1
ffree st2
ffree st3
ffree st4
ffree st5
ffree st6
ffree st7
ret















arrayprint:
mov word[i], 0
printing:
mov eax,dword[i]
fld qword[array + 8*eax]
call print
inc word[i]
mov ax, word[i]
cmp ax, word[n]
jne printing
ret

arrayread:
mov eax, 4
mov ebx, 1
mov ecx, mes
mov edx, mesl
int 80h

mov eax, 3
mov ebx, 0
mov ecx, n
mov edx, 1
int 80h
sub word[n], 30h
mov word[i],0
reading:
call read
mov eax,dword[i] 
fstp qword[array + 8*eax]
inc word[i]
mov ax, word[i]
cmp ax, word[n]
jne reading 
ret

read:
push ebp
mov ebp, esp
sub esp,8
lea eax,[esp]
push eax
push format1
call scanf
fld qword[ebp-8]
mov esp, ebp
pop ebp
ret


print:
push ebp
mov ebp,esp
sub esp,8
fst qword[ebp-8]
push format2
call printf
mov esp, ebp
pop ebp
ret

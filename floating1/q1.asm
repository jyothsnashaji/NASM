section .data
pi:dq 3.141592
two: dq 2.0
mes: db'Enter Number:',0Ah
mesl: equ $-mes
format1: db "%lf",0
format2: db "%lf",10
section .bss
num:resw 1
float1:resq 1
float2:resq 1

section .text
global main:
extern scanf
extern printf

main:

call read
fmul qword[pi]
fmul qword[two]
call print
call exit

exit:
mov eax, 1
mov ebx, 0
int 80h

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

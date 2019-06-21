section .data
pi:dq 3.141592
two: dq 2.0
four:dq 4.0
mes: db"Enter Number:",0Ah
mesl: equ $-mes
ml:db "-"
mll: equ $-ml
pl:db "+"
pll: equ $-pl
il:db "i",0Ah
ill: equ $-il
format1: db "%lf",0
format2: db "%lf",10
section .bss
u:resq 1
num:resw 1
float1:resq 1
float2:resq 1
float3:resq 1
b:resq 1
y:resw 1
b1:resq 1
a:resq 1
b2:resq 1
b4:resq 1
emp:resw 1
section .text
global main:
extern scanf
extern printf

main:

call read
fstp qword[float1]
call read
fstp qword[float2]
call read
fstp qword[float3]
fld qword[float2]
fchs
fdiv qword[two]
fst qword[b1]
fdiv qword[float1]
fstp qword[b]
fld qword[float2]
fmul st0
fld qword[four]
fmul qword[float1]
fmul qword[float3]
fstp qword[a]
fsub qword[a]
fst qword[u]
fldz
fcomi st1
ja nosq
real:	
fstp qword[u]
fsqrt
fdiv qword[two]
fdiv qword[float1]
fstp qword[b2]
fld qword[b]
fadd qword[b2]
call print
fld qword[b]
fsub qword[b2]
call print
jmp exit
nosq:
call sfree
fld qword[u]
fchs
fsqrt
fdiv qword[two]
fdiv qword[float1]
fstp qword[u]
fld qword[b]
call print 
call plus
call sfree
fld qword[u]
call print
call i
call sfree
fld qword[b]
call print 
call minus
call sfree
fld qword[u]
call print
call i
call sfree
call exit


plus:
pusha
mov eax,4
mov ebx,1
mov ecx,pl
mov edx,1
int 80h
popa
ret
minus:
pusha
mov eax,4
mov ebx,1
mov ecx,ml
mov edx,1
int 80h
popa
ret

i:
mov word[y], 'i'
pusha
mov eax,4
mov ebx,1
mov ecx,il
mov edx,ill
int 80h
popa
ret

exit:
mov eax, 1
mov ebx, 0
int 80h

sfree:
ffree st0
ffree st1
ffree st2
ffree st3
ffree st4
ffree st5
ffree st6
ffree st7
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

section .data
pi:dq 3.141592
one: dq 1.0
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
num1:resw 1
temp3: resq 1 
la:resq 1
float1:resq 1
float2:resq 1
float3:resq 1
b:resq 1
y:resw 1
b1:resq 1
a:resq 1
i:resw 1
j: resw 1
k:resq 1
temp:resq 1
temp8:resq 1
temp5:resw 1
b2:resq 1
fib2:resq 1
num2:resq 1
b4:resq 1
fib1:resw 1
emp:resw 1
section .text
global main:
extern scanf
extern printf

main:
mov word[temp5],0
call read
fstp qword[k]
fldpi
fmul qword[two]
fld qword[k]
fprem
fstp qword[k]
fstp qword[la]
fld qword[k]
fsin
call print
fstp qword[temp]
fldz
mov word[i], 1
fori:
call some
add word[i],2
mov ax, word[i]
;;cmp ax,49
fld qword[temp3]
fldz
fcomi st1
jne fori1
jmp fori2
fori1:
fstp qword[temp8]
fstp qword[temp3]
jmp fori
fori2:
fstp qword[temp8]
fstp qword[temp3]
call print
call exit

some:
mov ax, word[i]
mov word[j], ax
mov word[num], ax
fld qword[k]
forj:
cmp word[j], 1
je exit5
dec word[j]
fmul qword[k]
jmp forj
exit5:
call fact
fdiv qword[fib2]
fstp qword[temp3]
cmp word[temp5],0
jne su
fadd qword[temp3]
mov word[temp5], 1
jmp exit9
su:
fsub qword[temp3]
mov word[temp5],0
exit9:
ret




exit:
mov eax, 1
mov ebx, 0
int 80h



fact:
pusha
mov word[fib1], 1
fild word[num]
fild word[fib1]
jmp extra
fun:
fld qword[num2]
fld qword[fib2]
extra:
fmul st1
fstp qword[fib2]
fsub qword[one]
dec word[num]
mov ax, word[num]
cmp ax, 0
je fun1
fstp qword[num2]
jmp fun
fun1:
fstp qword[num2]
popa
ret









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

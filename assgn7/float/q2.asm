section .data
msg1:db "Enter a:"
len1:equ $-msg1
msg2:db "Enter b:"
len2:equ $-msg2
msg3:db "Enter c:"
len3:equ $-msg3
four:dd 4
zero:dd 0
two:dd 2
tab:db " "
fmt1:db "%lf",0
fmt2:db "%lf",10







section .text


global main:
extern printf
extern scanf


main:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h


call read ;read a

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h

call read ;read b

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h

call read ;read c

fmul st2
fimul dword[four]
fld st1
fmul st0
fsub st1
;check root exist


fsqrt
fld st3
fimul dword[two]
fld st1
fdiv st1
fld st4
fchs
fdiv st2
fadd st1
call print


;fsub st1
;fsub st1

call print




;call print

exit:
mov eax,1
mov ebx,0
int 80h

space:
pusha
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h
popa
ret

read:
push ebp
mov ebp,esp

sub esp,8
lea eax,[esp]
push eax
push fmt1
call scanf
fld qword[ebp-8]
mov esp,ebp
pop ebp
ret


print:
pusha
push ebp
mov ebp,esp

sub esp,8
fst qword[ebp-8]

push fmt2
call printf
mov esp,ebp
pop ebp
popa
ret




section .bss
num:resw 1



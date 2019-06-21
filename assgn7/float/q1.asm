section .data
two:dd 2
msg1:db "Enter r:"
len1:equ $-msg1
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

call read

;movzx eax,byte[two]
fimul dword[two]
fldpi
fmul st1





call print

exit:
mov ebx,0
mov eax,1
int 80h

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
push ebp
mov ebp,esp

sub esp,8
fst qword[ebp-8]

push fmt2
call printf
mov esp,ebp
pop ebp

ret




section .bss
num:resw 1



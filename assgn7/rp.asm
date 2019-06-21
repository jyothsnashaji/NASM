section .text


global main:
extern printf
extern scanf

;to read and print integers using printf and scanf
main:
call read
call print

exit:
mov ebx,0
mov eax,1
int 80h

read:
push ebp
mov ebp,esp

sub esp,2
lea eax,[ebp-2]
push eax
push fmt1
call scanf
mov ax,word[ebp-2]
mov word[num],ax

mov esp,ebp
pop ebp
ret


print:
push ebp
mov ebp,esp

sub esp,2
mov ax,word[num]
push eax
push fmt2
call printf
mov esp,ebp
pop ebp

ret




section .bss
num:resw 1

section .data
fmt1:db "%d",0
fmt2:db "%d",10

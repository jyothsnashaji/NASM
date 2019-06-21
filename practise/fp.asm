section .data
fmt1:db "%lf",0
fmt2:db "%lf",10

global main:
extern printf
extern scanf

main:

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

print:
push ebp
mov ebp,esp

sub esp,8
fst qword[ebp-8]
push fmt2
call printf
mov esp,ebp
pop ebp

exit:
mov eax,1
mov ebx,0
int 80h



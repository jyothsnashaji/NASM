section .data
fmt1:db "%lf",0
fmt2:db "%lf",10

section .bss
num:resw 1
i:resw 1
j:resq 1
x:resq 1
term:resq 1
sum:resq 1
exp:resq 1
sinv:resq 1

section .text


global main:
extern printf
extern scanf


main:
call read
fst qword[x]
fsin
call print
fstp qword[sinv]
call free

mov byte[sum],0

mov byte[j],1
mov byte[i],1
mov byte[exp],1
;fld qword[exp]
;fld qword[j]
fld qword[x]
fidiv dword[j]
;fst qword[sum]
;call print

fstp qword[term]
call free
fld1
;call print
fld qword[term]

;call print

loop1:
cmp byte[i],30
je goprint
fmul st1
;call print
fstp qword[exp]
call free


mov dx,0
mov ax,word[i]
mov bx,2
div bx
cmp dx,1
jne loop1check

;fld qword[exp]
;fld qword[sum]

mov dx,0
mov ax,word[i]
inc ax
mov bx,2
div bx
mov dx,0
div bx
cmp dx,1
je addt

subt:
fld qword[exp]
;call print
fld qword[sum]
;call print
fsub st1
;call print
fstp qword[sum]



loop1check:

call free
inc byte[i]
inc byte[j]
;fld qword[j]
fld qword[x]
fidiv dword[j]
fstp qword[term]
call free
fld qword[exp]
fld qword[term]
jmp loop1

goprint:
fld qword[sum]
call print

exit:
mov ebx,0
mov eax,1
int 80h

addt:
fld qword[exp]
fld qword[sum]
fadd st1
;call print
fstp qword[sum]

jmp loop1check


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


free:
ffree st0
ffree st1
ffree st3
ffree st4
ffree st5
ffree st6
ffree st7
ret




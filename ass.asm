"f(int)":
        push    rbp
        mov     rbp, rsp
        mov     DWORD PTR [rbp-20], edi
        mov     DWORD PTR [rbp-4], 0
        mov     DWORD PTR [rbp-8], 0
        jmp     .L2
.L3:
        mov     eax, DWORD PTR [rbp-8]
        mov     edx, DWORD PTR [rbp-20]
        mov     ecx, eax
        sar     edx, cl
        mov     eax, edx
        and     eax, 1
        mov     DWORD PTR [rbp-12], eax
        mov     edx, DWORD PTR [rbp-8]
        mov     eax, edx
        sal     eax, 3
        sub     eax, edx
        and     eax, 31
        mov     edx, DWORD PTR [rbp-12]
        mov     ecx, eax
        sal     edx, cl
        mov     eax, edx
        xor     DWORD PTR [rbp-4], eax
        add     DWORD PTR [rbp-8], 1
.L2:
        mov     eax, DWORD PTR [rbp-8]
        cdqe
        cmp     rax, 31
        jbe     .L3
        mov     eax, DWORD PTR [rbp-4]
        pop     rbp
        ret
"g(int)":
        push    rbp
        mov     rbp, rsp
        mov     DWORD PTR [rbp-4], edi
        mov     eax, DWORD PTR [rbp-4]
        sar     eax
        xor     eax, DWORD PTR [rbp-4]
        pop     rbp
        ret
"h(int)":
        push    rbp
        mov     rbp, rsp
        mov     DWORD PTR [rbp-20], edi
        mov     DWORD PTR [rbp-4], 0
        jmp     .L8
.L9:
        mov     eax, DWORD PTR [rbp-20]
        xor     DWORD PTR [rbp-4], eax
        sar     DWORD PTR [rbp-20]
.L8:
        cmp     DWORD PTR [rbp-20], 0
        jne     .L9
        mov     eax, DWORD PTR [rbp-4]
        pop     rbp
        ret
.LC0:
        .string "%2d -> %08x -> %08x -> %08x\n"
"main":
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     DWORD PTR [rbp-4], 0
        jmp     .L12
.L13:
        mov     eax, DWORD PTR [rbp-4]
        mov     edi, eax
        call    "f(int)"
        mov     DWORD PTR [rbp-8], eax
        mov     eax, DWORD PTR [rbp-8]
        mov     edi, eax
        call    "g(int)"
        mov     DWORD PTR [rbp-12], eax
        mov     eax, DWORD PTR [rbp-12]
        mov     edi, eax
        call    "h(int)"
        mov     DWORD PTR [rbp-16], eax
        mov     esi, DWORD PTR [rbp-16]
        mov     ecx, DWORD PTR [rbp-12]
        mov     edx, DWORD PTR [rbp-8]
        mov     eax, DWORD PTR [rbp-4]
        mov     r8d, esi
        mov     esi, eax
        mov     edi, OFFSET FLAT:.LC0
        mov     eax, 0
        call    "printf"
        add     DWORD PTR [rbp-4], 1
.L12:
        cmp     DWORD PTR [rbp-4], 31
        jle     .L13
        mov     eax, 0
        leave
        ret

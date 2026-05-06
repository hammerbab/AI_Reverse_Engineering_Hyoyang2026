"mix(unsigned int)":
        push    rbp
        mov     rbp, rsp
        mov     DWORD PTR [rbp-4], edi
        mov     eax, DWORD PTR [rbp-4]
        rol     eax, 13
        xor     DWORD PTR [rbp-4], eax
        mov     eax, DWORD PTR [rbp-4]
        imul    eax, eax, 1540483477
        mov     DWORD PTR [rbp-4], eax
        mov     eax, DWORD PTR [rbp-4]
        ror     eax, 15
        xor     DWORD PTR [rbp-4], eax
        mov     eax, DWORD PTR [rbp-4]
        imul    eax, eax, 668265261
        mov     DWORD PTR [rbp-4], eax
        mov     eax, DWORD PTR [rbp-4]
        shr     eax, 16
        xor     DWORD PTR [rbp-4], eax
        mov     eax, DWORD PTR [rbp-4]
        pop     rbp
        ret
"hash(char const*)":
        push    rbp
        mov     rbp, rsp
        sub     rsp, 24
        mov     QWORD PTR [rbp-24], rdi
        mov     DWORD PTR [rbp-4], -2128831035
        jmp     .L4
.L5:
        mov     rax, QWORD PTR [rbp-24]
        lea     rdx, [rax+1]
        mov     QWORD PTR [rbp-24], rdx
        movzx   eax, BYTE PTR [rax]
        movzx   eax, al
        xor     DWORD PTR [rbp-4], eax
        mov     eax, DWORD PTR [rbp-4]
        mov     edi, eax
        call    "mix(unsigned int)"
        mov     DWORD PTR [rbp-4], eax
.L4:
        mov     rax, QWORD PTR [rbp-24]
        movzx   eax, BYTE PTR [rax]
        test    al, al
        jne     .L5
        mov     eax, DWORD PTR [rbp-4]
        shr     eax, 13
        xor     DWORD PTR [rbp-4], eax
        mov     eax, DWORD PTR [rbp-4]
        imul    eax, eax, -1028477387
        mov     DWORD PTR [rbp-4], eax
        mov     eax, DWORD PTR [rbp-4]
        shr     eax, 16
        xor     DWORD PTR [rbp-4], eax
        mov     eax, DWORD PTR [rbp-4]
        leave
        ret
"secure_compare(unsigned int, unsigned int)":
        push    rbp
        mov     rbp, rsp
        mov     DWORD PTR [rbp-20], edi
        mov     DWORD PTR [rbp-24], esi
        mov     DWORD PTR [rbp-4], 0
        mov     eax, DWORD PTR [rbp-20]
        xor     eax, DWORD PTR [rbp-24]
        or      DWORD PTR [rbp-4], eax
        cmp     DWORD PTR [rbp-4], 0
        sete    al
        movzx   eax, al
        pop     rbp
        ret
.LC0:
        .string "Enter string: "
.LC1:
        .string "Hash: %08x\n"
.LC2:
        .string "Match!"
.LC3:
        .string "Not match."
"main":
        push    rbp
        mov     rbp, rsp
        sub     rsp, 272
        mov     edi, OFFSET FLAT:.LC0
        mov     eax, 0
        call    "printf"
        mov     rdx, QWORD PTR "stdin"[rip]
        lea     rax, [rbp-272]
        mov     esi, 256
        mov     rdi, rax
        call    "fgets"
        lea     rax, [rbp-272]
        mov     rdi, rax
        call    "hash(char const*)"
        mov     DWORD PTR [rbp-4], eax
        mov     eax, DWORD PTR [rbp-4]
        mov     esi, eax
        mov     edi, OFFSET FLAT:.LC1
        mov     eax, 0
        call    "printf"
        mov     DWORD PTR [rbp-8], -559038737
        mov     edx, DWORD PTR [rbp-8]
        mov     eax, DWORD PTR [rbp-4]
        mov     esi, edx
        mov     edi, eax
        call    "secure_compare(unsigned int, unsigned int)"
        test    eax, eax
        setne   al
        test    al, al
        je      .L10
        mov     edi, OFFSET FLAT:.LC2
        call    "puts"
        jmp     .L11
.L10:
        mov     edi, OFFSET FLAT:.LC3
        call    "puts"
.L11:
        mov     eax, 0
        leave
        ret

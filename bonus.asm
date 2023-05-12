%include "../include/io.mac"
section .data

section .text
    global bonus
    extern printf

bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
    ; esi e primu edx al doilea
    ; avem 9 cazuri
    ; 4 colturi, 4 rame si centru
    ; primele chestii care merg
    ;add byte[ecx], 2
    ;add byte[ecx + 1], 2
    xor esi, esi
    xor edi, edi
    mov esi, ecx ; partea de sus
    add ecx, 4
    mov edi, ecx ; partea de jos


    ; PRINTF32 `unu:%d\n\x0\n`, esi
    ; PRINTF32 `doi:%d\n\x0\n`, edx
    cmp eax, 0
    jz south
    ; cmp eax, 7
    ; jz north
    ; cmp ebx, 0
    ; jz west
    ; cmp ebx, 7
    ; jz east

    ; ; acum luam vecinii diagonali(nu ne aflam pe rama)
    ; add dword[esi - 8 - 1], 1
    ; add dword[esi - 8 + 1], 1
    ; add dword[esi + 8 - 1], 1
    ; add dword[esi + 8 + 1], 1

    ;PRINTF32 `indice:%d\n\x0\n`, eax
    jmp end

south:
    cmp ebx, 0 ; verificam daca e colt 0, 0 si analog pentru restu
    jz corner_0_0
    cmp ebx, 7
    jz corner_0_7

    ;mov ecx, 1
    ;imul ecx, byte[]
    ;shl
;     add dword[esi + 8 + 1], 1
;     add dword[esi + 8 - 1], 1
     jmp end

; north:
;     cmp ebx, 0 ;
;     jz corner_7_0
;     cmp ebx, 7
;     jz corner_7_7
;     add dword[esi - 8 + 1], 1
;     add dword[esi - 8 - 1], 1
;     jmp end

corner_0_0:
    add byte[edi + 1], 2
    jmp end

corner_0_7:
    add byte[edi + 1], 64
    jmp end

; corner_7_0:
;     add dword[esi - 8 + 1], 1
;     jmp end

; corner_7_7:
;     add dword[esi - 8 - 1], 1
;     jmp end

; west:
;     add dword[esi - 8 + 1], 1
;     add dword[esi + 8 + 1], 1
;     jmp end

; east:
;     add dword[esi - 8 - 1], 1
;     add dword[esi + 8 - 1], 1
;     jmp end

    ;add byte[ecx + 5], 2


    ; PRINTF32 `unu:%d\n\x0\n`, esi
    ; PRINTF32 `doi:%d\n\x0\n`, edx

end:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

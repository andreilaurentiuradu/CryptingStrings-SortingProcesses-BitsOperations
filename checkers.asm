%include "../include/io.mac"

section .data

section .text
	global checkers
    extern printf
checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY

    ;; FREESTYLE STARTS HERE
    ; avem 9 cazuri
    ; 4 colturi, 4 rame si centru
    mov esi, eax ;linia
    shl esi, 3 ;nr de bytes pt o linie(inmultim cu 2 ^ 3)
    add esi, ebx ;adaugam acum coloana
    add esi, ecx ;pozitia damei


    cmp eax, 0
    jz south
    cmp eax, 7
    jz north
    cmp ebx, 0
    jz west
    cmp ebx, 7
    jz east

    ; acum luam vecinii diagonali
    add dword[esi - 8 - 1], 1
    add dword[esi - 8 + 1], 1
    add dword[esi + 8 - 1], 1
    add dword[esi + 8 + 1], 1

    PRINTF32 `indice:%d\n\x0\n`, eax
    jmp end

south:
    cmp ebx, 0 ; verificam daca e colt 0, 0
    jz corner_0_0
    cmp ebx, 7
    jz corner_0_7
    add dword[esi + 8 + 1], 1
    add dword[esi + 8 - 1], 1
    jmp end

north:
    cmp ebx, 0 ;
    jz corner_7_0
    cmp ebx, 7
    jz corner_7_7
    add dword[esi - 8 + 1], 1
    add dword[esi - 8 - 1], 1
    jmp end

corner_0_0:
    add dword[esi + 8 + 1], 1
    jmp end

corner_0_7:
    add dword[esi + 8 - 1], 1
    jmp end

corner_7_0:
    add dword[esi - 8 + 1], 1
    jmp end

corner_7_7:
    add dword[esi - 8 - 1], 1
    jmp end

west:
    add dword[esi - 8 + 1], 1
    add dword[esi + 8 + 1], 1
    jmp end

east:
    add dword[esi - 8 - 1], 1
    add dword[esi + 8 - 1], 1
    jmp end
end:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

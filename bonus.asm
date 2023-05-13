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
    ; avem 18 cazuri
    ; 4 colturi, 4 rame si centru pentru fiecare intreg din edi respectiv edi
    xor esi, esi
    xor edi, edi
    mov esi, ecx ; partea de sus
    add ecx, 4
    mov edi, ecx ; partea de jos


    ; PRINTF32 `unu:%d\n\x0\n`, esi
    ; PRINTF32 `doi:%d\n\x0\n`, edx
    cmp eax, 0
    jz south
    cmp eax, 7
    jz north

    cmp eax, 4
    jz middle_esi

    cmp eax, 3
    jz middle_edi

    cmp ebx, 0
    jz west_high
    cmp ebx, 7
    jz east_high

    cmp eax, 4
    jl center_down
    ; ai de completat aici cu un for si dupa adaugi la ambele linii
    ; else center_up

    jmp end

center_down:
    ; ai de completat aici cu un for si dupa adaugi la ambele linii
    jmp end
middle_edi:
    cmp ebx, 0
    jz left_edi_corner
    cmp ebx, 7
    jz right_edi_corner

    xor edx, edx
    mov edx, 5

    ;PRINTF32 `linie:%d\x0\n`, eax
    ;PRINTF32 `coloana:%d\n\x0\n`, ebx
    ; mutam 5-ul exact cate pozitii avem nevoie la dreapta in functie de ebx care retine coloana
    ;PRINTF32 `inainte:%d\n\x0\n`, edx

    for_middle_edi:
        cmp ebx, 1
        jz continue_middle_edi
        imul edx, 2
        ;PRINTF32 `ed:%d\n\x0\n`, edi
        dec ebx
        jmp for_middle_edi

    continue_middle_edi:
    ;PRINTF32 `intra_aici:%d\n\x0\n`, edx
        add byte[esi], dl
        add byte[edi + 2], dl
    jmp end

left_edi_corner:
    add byte[esi], 2
    add byte[edi + 2], 2
    jmp end

right_edi_corner:
    add byte[esi], 64
    add byte[edi + 2], 64
    jmp end

middle_esi:

    cmp ebx, 0
    jz left_esi_corner
    cmp ebx, 7
    jz right_esi_corner

    xor edx, edx
    mov edx, 5

    ;PRINTF32 `linie:%d\x0\n`, eax
    ;PRINTF32 `coloana:%d\n\x0\n`, ebx
    ; mutam 5-ul exact cate pozitii avem nevoie la dreapta in functie de ebx care retine coloana
    ;PRINTF32 `inainte:%d\n\x0\n`, edx
    for_middle_esi:
        cmp ebx, 1
        jz continue_middle_esi
        imul edx, 2
        ;PRINTF32 `mid_esi:%d\n\x0\n`, edx
        dec ebx
        jmp for_middle_esi

    continue_middle_esi:
    ;PRINTF32 `intra_aici:%d\n\x0\n`, edx
        add byte[esi + 1], dl
        add byte[edi + 3], dl
    jmp end

left_esi_corner:
    add byte[esi + 1], 2
    add byte[edi + 3], 2
    jmp end

right_esi_corner:
    add byte[esi + 1], 64
    add byte[edi + 3], 64
    jmp end

south:
    cmp ebx, 0 ; verificam daca e colt 0, 0 si analog pentru restu
    jz corner_0_0
    cmp ebx, 7
    jz corner_0_7

    ; punem un 5 in edx (echivalentul lui 1 0 1 in binar)
    ; exact cum trebuie sa fie pe linia anterioara in matrice
    xor edx, edx
    mov edx, 5

    ; mutam 5-ul exact cate pozitii avem nevoie la dreapta in functie de ebx care retine coloana
    for_south:
        cmp ebx, 1
        jz continue_south
        imul edx, 2
        dec ebx
        jmp for_south

    continue_south:
    ; adaugam pe 5 shiftat
    add byte[edi + 1], dl
    jmp end

north:
    cmp ebx, 0
    jz corner_7_0
    cmp ebx, 7
    jz corner_7_7


    xor edx, edx
    mov edx, 5
    PRINTF32 `da\n\x0\n`, edx
    ; mutam 5-ul exact cate pozitii avem nevoie la dreapta in functie de ebx care retine coloana
    for_north:
        cmp ebx, 1
        jz continue_north
        imul edx, 2
        dec ebx
        jmp for_north

    continue_north:
    PRINTF32 `%d\n\x0\n`, edx
    add byte[esi + 2], dl
    jmp end

corner_0_0:
    add byte[edi + 1], 2
    jmp end

corner_0_7:
    add byte[edi + 1], 64
    jmp end

corner_7_0:
    add byte[esi + 2], 2
    jmp end

corner_7_7:
    add byte[esi + 2], 64
    jmp end

west_high:
    cmp eax, 3
    jl west_low

    cmp eax, 6
    jz next_west_high

    ; 5, 0
    add byte[esi + 2], 2
    add byte[esi], 2
    jmp end

    ; 6, 0
    next_west_high:
    add byte[esi + 3], 2
    add byte[esi + 1], 2
    jmp end

west_low:
    PRINTF32 `unu:%d\n\x0\n`, esi
    cmp eax, 1
    jz next_west_low

    ; 2, 0
    add byte[edi + 1], 2
    add byte[edi + 3], 2
    jmp end

    ; 1, 0

    next_west_low:
    add byte[edi], 2
    add byte[edi + 2], 2
    jmp end

east_high:
    cmp eax, 3
    jl east_low

    cmp eax, 6
    jz next_east_high

    ; 5, 7
    add byte[esi + 2], 64
    add byte[esi], 64
    jmp end

    ; 6, 7
    next_east_high:
    add byte[esi + 3], 64
    add byte[esi + 1], 64
    jmp end

east_low:
    cmp eax, 1
    jz next_east_low

    ; 2, 7
    add byte[edi + 1], 64
    add byte[edi + 3], 64
    jmp end

    ; 1, 7
    next_east_low:
    add byte[edi], 64
    add byte[edi + 2], 64
    jmp end

end:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

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
    xor esi, esi
    mov esi, ecx ; partea de sus

    add ecx, 4
    xor edi, edi
    mov edi, ecx ; partea de jos

    ; initializam registrii
    xor ecx, ecx
    xor edx, edx

    mov dl, 5 ; punem in dl ca sa putem face shiftarea
    mov ecx, ebx ; punem coloana in ecx pt shl
    cmp ecx, 0 ; daca e pe coloana 0
    jz zero_col

    dec ecx ; ne folosim de ebx pentru a pune 1 pe colturile din stanga
    shl dl, cl ; pe baza lui ebx(coloana)


    jmp zone ; mergem in una din zone

zero_col:
    ; daca e pe coloana 0
    shr dl, 1 ;impartim la 2

zone:
    ; dl contine acum forma byte-ului
    PRINTF32 `octet:%d\n\x0\n`, edx
    cmp eax, 4
    jge up
    jmp down

down:
    cmp eax, 0
    je down_border ; daca e pe marginea de sus
    cmp eax, 3
    je down_middle_border ; daca e pe marginea de jos primului nr

center_loop_down:
    cmp eax, 1
    je put_bytes_down
    add edi, 1
    ;PRINTF32 `doi:%d\n\x0\n`, edi
    dec eax
    jmp center_loop_down

put_bytes_down:
    mov byte[edi], dl
    mov byte[edi + 2], dl
    jmp end

down_middle_border:
    mov byte[edi + 2], dl
    mov byte[esi], dl
    jmp end

down_border:
    mov byte[edi + 1], dl
    jmp end

up:
    cmp eax, 7
    je up_border ; daca e pe marginea de sus
    cmp eax, 4
    je up_middle_border ; daca e pe marginea de jos primului nr

; pentru centrul primului nr
center_loop_up:
    cmp eax, 5
    je put_bytes_up
    add esi, 1
    dec eax
    jmp center_loop_up

; punem octetii
put_bytes_up:
    mov byte[esi], dl
    mov byte[esi + 2], dl
    jmp end

up_border: ; marginea de sus a primului nr
    mov byte[esi + 2], dl
    jmp end

up_middle_border: ; marginea de jos a primului nr
    ;PRINTF32 `unu:%d\n\x0\n`, esi
    mov byte[esi + 1], dl
    mov byte[edi + 3], dl

    jmp end

    ; add byte[edi], 128 ; sa adaugam 1 la valoarea din byteul lui esi
    ; PRINTF32 `unu:%d\n\x0\n`, esi
    ; PRINTF32 `doi:%d\n\x0\n`, edx
    ;;;;;;;;esi
    ;;;;;;;;edi
end:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY



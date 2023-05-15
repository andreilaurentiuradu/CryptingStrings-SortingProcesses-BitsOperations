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
    ; retinem in esi partea de sus, respectiv in edi partea de jos
    xor esi, esi
    mov esi, ecx
    add ecx, 4
    xor edi, edi
    mov edi, ecx

    ; initializam registrii
    xor ecx, ecx
    xor edx, edx

    ; punem 00000101 in registrul dl
    mov dl, 5
    ; retinem coloana in ecx
    mov ecx, ebx
    cmp ecx, 0
    jz zero_col

    ; daca nu e pe coloana 0 cream byteul ce reprezinta linia
    ; shiftand la stanga in nr cu nr_coloanei - 1 pozitii
    dec ecx
    shl dl, cl

    jmp zone

zero_col:
    ; daca e pe coloana 0 shiftam la dreapta numarul
    ;(shiftare la stanga a unei linii in matrice)
    shr dl, 1

zone:
    ; verificam in ce zona ne aflam in matrice
    ; (board[0] sau board[1])
    ; dl contine acum forma byte-ului
    cmp eax, 4
    jge up
    jmp down

down:
    ; daca ne aflam in partea inferioara matricei
    ; verificam daca se afla pe vreuna din marginile sus/jos
    cmp eax, 0
    je down_border
    cmp eax, 3
    je down_middle_border

center_loop_down:
    ; daca nu se afla pe vreo margine
    ; determinam liniile pe care se poate deplasa dama
    cmp eax, 1
    je put_bytes_down
    add edi, 1
    dec eax
    jmp center_loop_down

put_bytes_down:
    ; punem byteul dl pe liniile corespunzatoare
    mov byte[edi], dl
    mov byte[edi + 2], dl
    jmp end

down_middle_border:
    ; daca e pe rama de sus a partii inferioare a matricei
    ; punem byteul dl pe liniile corespunzatoare
    mov byte[edi + 2], dl
    mov byte[esi], dl
    jmp end

down_border:
    ; daca e pe rama de jos a partii inferioare a matricei
    ; punem byteul dl pe linia corespunzatoare
    mov byte[edi + 1], dl
    jmp end

up:
    ; daca ne aflam pe partea superioara a matricei
    ; verificam daca ne aflam pe vreuna din marginile sus/jos
    cmp eax, 7
    je up_border
    cmp eax, 4
    je up_middle_border

center_loop_up:
    ; daca nu se afla pe vreo margine
    ; determinam liniile pe care se poate deplasa dama
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

up_border:
    ; daca e pe marginea de sus a partii superioare a matricei
    ; punem byte-ul pe linia corespunzatoare
    mov byte[esi + 2], dl
    jmp end

up_middle_border:
    ; daca e pe marginea de jos a partii superioare a matricei
    ; punem byteul pe linia corespunzatoare
    mov byte[esi + 1], dl
    mov byte[edi + 3], dl

    jmp end

end:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY



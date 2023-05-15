%include "../include/io.mac"
%assign octet 8
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


    ; verificam daca ne aflam pe una dintre cele 4 rame
    cmp eax, 0
    jz south
    cmp eax, 7
    jz north
    cmp ebx, 0
    jz west
    cmp ebx, 7
    jz east

    ; acum luam vecinii diagonali(nu ne aflam pe rama)
    add dword[esi - octet - 1], 1
    add dword[esi - octet + 1], 1
    add dword[esi + octet - 1], 1
    add dword[esi + octet + 1], 1

    jmp end

; rama de jos
south:
    ; verificam daca e colt
    cmp ebx, 0
    jz corner_0_0
    cmp ebx, 7
    jz corner_0_7
    ; daca nu e colt marcam cele 2 pozitii
    add dword[esi + 8 + 1], 1
    add dword[esi + 8 - 1], 1
    jmp end

; rama de sus
north:
    ; verificam daca e colt
    cmp ebx, 0
    jz corner_7_0
    cmp ebx, 7
    jz corner_7_7
    add dword[esi - 8 + 1], 1
    add dword[esi - 8 - 1], 1
    jmp end

; daca e coltul stanga jos
corner_0_0:
    ; marcam pozitia corespunzatoare
    add dword[esi + 8 + 1], 1
    jmp end

; daca e coltul dreapta jos
corner_0_7:
    ; marcam pozitia corespunzatoare
    add dword[esi + 8 - 1], 1
    jmp end

; daca e coltul stanga sus
corner_7_0:
    ; marcam pozitia corespunzatoare
    add dword[esi - 8 + 1], 1
    jmp end

; daca e coltul dreapta sus
corner_7_7:
    ; marcam pozitia corespunzatoare
    add dword[esi - 8 - 1], 1
    jmp end

; rama din stanga(fara colt)
west:
    ; marcam cele 2 pozitii
    add dword[esi - 8 + 1], 1
    add dword[esi + 8 + 1], 1
    jmp end

; rama din dreapta(fara colt)
east:
    ; marcam cele 2 pozitii
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

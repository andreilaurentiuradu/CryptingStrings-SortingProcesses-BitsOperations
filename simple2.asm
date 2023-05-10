%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
    ;; Your code starts here

    ; initializari
    mov byte[edi + ecx], 0
move:
    xor eax, eax ; initializam eax cu 0
    mov al, byte[esi + ecx - 1] ; sau mov eax, [esi + ecx - 1] ; punem cate un caracter
    add al, dl ; adaugam steps (nr pana in 26 deci e in dl tot)
    cmp al, 'Z' ;verificam daca facem overflow
    jle not_overflow ; daca nu facem
    sub al, 26 ; daca facem scadem 26
    mov byte [edi + ecx - 1], al ; punem in sirul edi(cel criptat)
next:
    loop move

jmp end ; cand s-a terminat loopul mergem la final

not_overflow:
    mov byte [edi + ecx - 1], al ; punem in sirul edi(cel criptat) caracterul criptat
    jmp next ; ne intoarcem in loop

end:
    ;; Your code ends here
    ;; DO NOT MODIFY
    popa
    leave
    ret

    ;; DO NOT MODIFY

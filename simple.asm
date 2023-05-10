%include "../include/io.mac"

; section .data
;     alfabet: db 26 ; nr de litere din alfabet
;     last: db 'Z' ; ultima litera din alfabet

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
    xor eax, eax ; initializam eax cu 0
    ;PRINTF32 `%s\n\x0\n`, esi ; afisam stringul
    xor ebx, ebx
move:
    ;PRINTF32 `%d\n\x0\n`, ebx ; afisam nr caracterului
    xor eax, eax ; initializam eax cu 0
    mov al, byte[esi + ebx] ; sau mov eax, [esi + ecx - 1] ; punem cate un caracter
    add al, dl ; adaugam steps (nr pana in 26 deci e in dl tot)
    cmp al, 'Z' ;verificam daca facem overflow
    jle not_overflow ; daca nu facem
    sub al, 26 ; daca facem scadem 26
    mov byte [edi + ebx], al ; punem in sirul edi(cel criptat)
    ;PRINTF32 `%c\n\x0\n`, [edi + ebx]

next: ; verificam daca am ajuns la final altfel incrementam ebx
    cmp ebx, ecx
    jz end
    inc ebx
    jmp move

not_overflow:
    mov byte [edi + ebx], al ; punem in sirul edi(cel criptat) caracterul criptat
    ;PRINTF32 `%c\n\x0\n`, [edi + ebx]
    jmp next ; ne intoarcem in loop
    ;; Your code ends here

end:
    mov byte[edi + ebx], 0
    PRINTF32 `%s\n\x0\n`, edi

    ;; DO NOT MODIFY
    popa
    leave
    ret

    ;; DO NOT MODIFY

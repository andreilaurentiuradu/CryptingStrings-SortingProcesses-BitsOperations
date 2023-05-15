%include "../include/io.mac"
%assign alfabet 26
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

    ; punem terminatorul de sir
    mov byte[edi + ecx], 0
for_loop:
    ; initializam eax cu 0
    xor eax, eax
    ; punem cate un caracter
    mov al, byte[esi + ecx - 1]
    ; adaugam step (nr <= 26 deci e in dl tot)
    add al, dl
    ;verificam daca trecem de Z prin adunarea stepului
    cmp al, 'Z'
    ; daca nu trecem
    jle not_over_bound
    ; daca trecem scadem nr de litere din alfabet
    sub al, alfabet
    ; punem in sirul criptat
    mov byte [edi + ecx - 1], al
next:
    loop for_loop

jmp end ; cand s-a terminat loopul mergem la final

; daca nu facem overflow
not_over_bound:
    ; punem in sirul edi(cel criptat) caracterul criptat
    mov byte [edi + ecx - 1], al 
    jmp next ; ne intoarcem in loop

end:
    ;; Your code ends here
    ;; DO NOT MODIFY
    popa
    leave
    ret

    ;; DO NOT MODIFY

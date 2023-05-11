%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs
    extern printf

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
    ;;;;;;mai ai esi si edi
    xor ecx, ecx
    mov ecx, eax ;luam nr de procese
    ;PRINTF32 `nr_procese:%d\n\x0\n`, ecx



for_first:
    ;PRINTF32 `primul:%d\n\x0\n`, ecx ; afisam nr procesului de la sfarsit

    xor esi, esi ;il pastram pentru primul proces incepand cu finalul
    mov esi, ecx ; adresa de o inmultim cu 5
    imul esi, 5 ; adresa inmultita cu 5
    sub esi, 5 ; scadem o adresa
    add esi, edx
    ;PRINTF32 `unu:%u\n\x0\n`, ebx

    push ecx ; retinem valoarea curenta a lui ecx ca sa iteram tot cu ecx in loopul 2
    ; daca nu e 0 facem dec ecx
    ;dec ecx ; ca sa luam de la urmatorul proces

    for_second:
        xor ebx, ebx ; esi e intermediar iar ebx retine valoarea
        mov bl, byte[esi + proc.prio] ; punem in bl prioritatea

        ; cream adresa de la inceputul fiecarui element din vectorul de structuri
        mov edi, ecx
        imul edi, 5
        sub edi, 5
        add edi, edx
        xor eax, eax
        mov al, byte[edi + proc.prio] ;mov al, byte[edx + edi + proc.pid]
        cmp al, bl ; daca prio-ul e mai mare decat al unuia urmator
        jg swap1 ; verificam daca trebuie interschimbare
        jne continue ; daca au aceeasi prio ne ducem la continue

        ; ajunge aici doar daca au acelasi prio
        xor eax, eax
        mov ax, word[edi + proc.time]
        xor ebx, ebx
        mov bx, word[esi + proc.time]
        cmp ax, bx
        jg swap2
        jne continue

        ; ajunge aici doar daca au acelasi prio si acelasi time
        xor eax, eax
        mov ax, word[edi + proc.pid]
        xor ebx, ebx
        mov bx, word[esi + proc.pid]
        cmp ax, bx
        jg swap3
        jne continue


    continue:
        ;PRINTF32 `doi:%u\n\x0\n`, eax
        loop for_second ; ne intoarcem la inceputul celui de al doilea loop si decrementam

    pop ecx
    loop for_first ;ne intoarcem la inceputul primului loop si decrementam ecx
    jmp pentru_afisare ; sa nu faca iar swap

swap1:
    ; interschimbam in vector toate componentele
    mov byte[edi + proc.prio], bl
    mov byte[esi + proc.prio], al

swap2:
    ; la prio egale interschimbam time si pid
    mov ax, word[edi + proc.time]
    mov bx, word[esi + proc.time]
    mov word[edi + proc.time], bx
    mov word[esi + proc.time], ax

swap3:
    ; la prio si time egale interschimbam pid
    mov ax, word[edi + proc.pid]
    mov bx, word[esi + proc.pid]
    mov word[edi + proc.pid], bx
    mov word[esi + proc.pid], ax
    ; ne intorcem in loop2
    jmp continue


; doar pentru afisare
pentru_afisare
    mov ecx, 13

afisare:
    ;PRINTF32 `primul:%d\n\x0\n`, ecx ; afisam nr procesului de la sfarsit

    xor esi, esi ;il pastram pentru primul proces incepand cu finalul
    mov esi, ecx ; adresa de o inmultim cu 5
    imul esi, 5 ; adresa inmultita cu 5
    sub esi, 5 ; scadem o adresa

    xor eax, eax
    ; esi e intermediar iar eax retine valoarea
    mov ax, word[edx + esi + proc.time] ; punem in al prioritatea
    ;PRINTF32 `pid:%u\n\x0\n`, eax

    loop afisare ;ne intoarcem la inceputul primului loop si decrementam ecx


end:

;PRINTF32 `prio:%u\n\x0\n`, ebx
    ;mov bx, word[edx + eax + proc.time] ; punem in bx timeul
    ;PRINTF32 `time:%u\n\x0\n`, ebx
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

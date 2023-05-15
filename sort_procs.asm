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

    ; pastram in ecx numarul de procese
    mov ecx, eax

for_first:

    ; punem in esi adresa ultimului proces
    ; ne bazam pe formula esi = adresa_primului_proces +
    ; indicele_procesului * dimesiunea_unui proces
    mov esi, ecx
    imul esi, proc_size
    sub esi, proc_size
    add esi, edx

    ; retinem valoarea curenta a lui ecx ca sa iteram tot cu ecx in loopul 2
    push ecx

for_second:
    ; initializam ebx
    xor ebx, ebx

    ; punem in bl prioritatea elementului mai aproape de sfarsit
    mov bl, byte[esi + proc.prio]

    ; cream adresa de la inceputul fiecarui element din vectorul de structuri
    mov edi, ecx
    imul edi, proc_size
    sub edi, proc_size
    add edi, edx

    ; initializam eax
    xor eax, eax
    ; punem in al prioritatea elementului mai aproape de inceput
    mov al, byte[edi + proc.prio]

    ; comparam prioritatea
    cmp al, bl
    jg swap1
    jne continue

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

; daca nu au aceeasi prioritate
continue:
    ; ne intoarcem la inceputul celui de al doilea loop si decrementam
    loop for_second

    ; punem inapoi in ecx indicele la care am ramas pentru primul loop
    pop ecx

    ; ne intoarcem la inceputul primului loop si decrementam ecx
    loop for_first
    ; s-a terminat al doilea loop
    jmp end

; avem in dreapta un element cu prioritatea mai mica
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

end:

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

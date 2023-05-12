%include "../include/io.mac"

    ;;
    ;;   TODO: Declare 'avg' struct to match its C counterpart
    ;;
struc avg
    .quo: resw 1
    .remain: resw 1
endstruc

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs
    extern printf

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY

    ;; Your code starts here
    mov edx, ecx ; acum avem procesele in edx
    mov ecx, ebx ; contorul
    PRINTF32 `nr_procese:%d\n\x0\n`, ecx
for_loop:
    ;PRINTF32 `indice:%d\n\x0\n`, ecx
    xor esi, esi ;il pastram pentru primul proces incepand cu finalul
    mov esi, ecx ; adresa de o inmultim cu 5
    imul esi, 5 ; adresa inmultita cu 5
    sub esi, 5 ; scadem o adresa
    add esi, edx ; adaugam vectorul de structuri
    xor ebx, ebx ; initializam

    xor ebx, ebx
    mov bl, byte[esi + proc.prio] ; luam prio
    inc dword[prio_result + ebx * 4 - 4] ; incrementam in prio_result

    xor edi, edi
    mov di, word[esi + proc.time] ; luam time
    ;PRINTF32 `time:%d\n\x0\n`, edi ; il afisam
    add dword[time_result + ebx * 4 - 4], edi ; il adaugam la pozitia corespunzatoare din time_result
    ;PRINTF32 `prio:%d\n\x0\n`, ebx
    loop for_loop

    mov edi, eax ;retinem vectorul de avg

    mov ecx, 5 ; il luam pe post de contor
for_avg:
    ;mov ebx, dword[time_result + ecx * 4 - 4]
    ;PRINTF32 `time:%d   \x0`, ebx
    ;mov ebx, dword[prio_result + ecx * 4 - 4]
    ;PRINTF32 `prio:%d  \x0`, ebx

    mov ebx, dword[prio_result + ecx * 4 - 4] ; pastram prioul
    xor eax, eax ; initializam
    xor edx, edx ; initializam
    ;mov word[edi + ecx * 2 - 2 + avg.quo], ax ; initializam cu 0
    ;mov word[edi + ecx * 2 - 2 + avg.remain], dx ; initializam cu 0

    cmp ebx, 0 ; comparam sa vedem daca e impartire la 0
    jz continue ; daca impartim la 0
    ;PRINTF32 `!zero%d   \n\x0`, ebx
    mov eax, dword[time_result + ecx * 4 - 4] ; pastram timpul
    div ebx ; facem impartirea

    ; mov word[edi + ecx * 2 - 2 + avg.quo], ax
    ; mov word[edi + ecx * 2 - 2 + avg.remain], dx
    mov word[edi + ecx * 4 - 4 + avg.quo], ax ; mutam in avg catul
    mov word[edi + ecx * 4 - 4 + avg.remain], dx ; mutam in avg restul
continue:
    PRINTF32 `catul:%u  \x0`, eax
    PRINTF32 `restul:%u\n\x0`, edx
    loop for_avg

    ;; Your code ends here

end:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

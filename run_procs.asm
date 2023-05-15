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
    ; retinem procesele in registrul edx
    mov edx, ecx
    ; retinem nr de procese in ecx
    mov ecx, ebx ; contorul

for_loop:

    ; retinem in esi adresa ultimului proces din vector
    xor esi, esi
    mov esi, ecx
    imul esi, proc_size
    sub esi, proc_size
    add esi, edx

    ; retinem prioritatea sa in bl
    xor ebx, ebx
    mov bl, byte[esi + proc.prio] ; luam prio

    ; contorizam in vectorul prio_result aparitia
    ; unui nou element cu o anumita prioritate
    inc dword[prio_result + ebx * 4 - 4]

    ; analog pentru campul time
    xor edi, edi
    mov di, word[esi + proc.time]

    ; adunam time-ul in pozitia corespunzatoare din vectorul time_result
    add dword[time_result + ebx * 4 - 4], edi

    ; ne intoarcem la inceputul loopului
    loop for_loop

    ; retinem vectorul de avg
    mov edi, eax
    ; numarul de elemente din avg
    mov ecx, 5
for_avg:

    ; pastram nr de procese cu o anumita prioritate
    mov ebx, dword[prio_result + ecx * 4 - 4]
    ; initializam registrii folositi de div
    xor eax, eax
    xor edx, edx

    ; daca nu exista un proces cu acea prioritate
    cmp ebx, 0
    jz continue

    ; pastram timpul retinut de time_result pentru fiecare prioritate
    mov eax, dword[time_result + ecx * 4 - 4]
    ; facem media
    div ebx
    ; mutam in avg catul si restul
    mov word[edi + ecx * 4 - 4 + avg.quo], ax
    mov word[edi + ecx * 4 - 4 + avg.remain], dx
continue:
    ; trecem la urmatoarea prioritate
    loop for_avg

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

; subtask 2 - bsearch

section .text
    global binary_search
    ;; no extern functions allowed

binary_search:
    ;; create the new stack frame
    push ebp
    mov ebp, esp
    ;; save the preserved registers de la task1
    push edi
    push esi
    push ebx

    ;; recursive bsearch implementation goes here
    ; adresa vectorului
    mov eax, ecx
    ; adresa nr cautat
    mov ebx, edx
    ; adresa indexului de start L-ul
    mov ecx, [ebp + 8]
    ; adresa indexului de sfarsit R-ul
    mov edx, [ebp + 12]
    inc edx

While:
    ; conditia while-ului
    cmp ecx, edx
    jg negasit

    mov esi, ecx
    add esi, edx
    ; esi = m = floor((L + R) / 2)
    shr esi, 1
    ; A[m]
    mov edi, [eax + (4 * esi)]

    ; comparam A[m] si T
    cmp edi, ebx
    jl maiMic

    cmp edi, ebx
    jg maiMare

    mov eax, esi
    jmp sfarsit

maiMic:
    inc esi
    mov ecx, esi
    jmp While

maiMare:
    dec esi
    mov edx, esi
    jmp While


negasit:
    ; daca nu s-a gasit numarul, se returneaza -1
    mov eax, -1

sfarsit:
    pop ebx
    pop esi
    pop edi
    leave
    ret
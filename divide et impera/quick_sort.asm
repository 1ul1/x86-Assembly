; subtask 1 - qsort

section .text
    global quick_sort
    ;; no extern functions allowed

quick_sort:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    push edi
    push esi
    push ebx

    ;; recursive qsort implementation goes here
    ; pointer spre vector
    mov edx, [ebp + 8]
    ; salvam indexul de inceput
    mov eax, [ebp + 12]
    ; & indexul de sfarsit
    mov ebx, [ebp + 16]
    ; comparam indexii de inceput si sfarsit sa verificam daca mai trebuie sortat
    cmp eax, ebx
    ; daca nu, trece direct la sfarsit
    jge sfarsit

    ; vrem sa aflam pivotul, pe care il definim ca elementul cu indicele ebx

    ; Calculam adresa elementului din vector cu indicele ebx
    ; acesta este pivotul
    mov edi, [edx + (4 * ebx)]
    ; salvam indicele primului element
    mov ecx, eax

ForSort:
    ; conditia pentru for
    cmp eax, ebx
    jge ForOut
    ;aflam elementul cu indicele eax
    mov esi, [edx + (4 * eax)]

    ; Comparam acest element cu pivotul
    cmp esi, edi
    jle Swap

    ; for-ul merge de la eax la ebx
    inc eax
    jmp ForSort

Swap:
    ; salves ebx pe stiva ca sa eliberez registrul pentru a face swap
    push ebx
    ; pe cel de pe indicele eax il am salvat in esi, mai am nevoie de ecx
    mov ebx, [edx + (4 * ecx)]
    ; trebuie sa fac swap intre elementele cu indicii eax si ecx
    mov [edx + (4 * eax)], ebx
    ; trebuie sa fac swap intre elementele cu indicii eax si ecx
    mov [edx + (4 * ecx)], esi
    pop ebx
    ; for-ul merge de la eax la ebx
    inc eax
    inc ecx
    jmp ForSort

ForOut:
    ; trebuie sa fac swap intre indicii ecx si ebx
    ; observam ca nu mai este nevoie de pivot si de elementul de pe indicele eax
    ; parcurgem vectorul si salvam in edi elementul cu indicele ecx
    mov edi, [edx + (4 * ecx)]
    ; analog
    mov esi, [edx + (4 * ebx)]
    ; analog
    mov [edx + (4 * ecx)], esi
    ; analog
    mov [edx + (4 * ebx)], edi

    ; reapelarea qsort-ului
    mov esi, [ebp + 12]
    ; indicele de final devine ecx - 1
    dec ecx
    ; il adaugam pe stiva
    push ecx
    ; indicele de inceput, acelasi
    push esi
    ; adaugam in stiva pointerul spre vector
    push edx
    call quick_sort
    ; reapelam functia
    add esp, 12
    ; inidicele de final este acelasi
    push ebx
    inc ecx
    ; indicele de start este acelasi + 1
    push ecx
    push edx
    call quick_sort
    ; a doua reapelare a functiei
    add esp, 12


sfarsit:
    ;restituim valorile registrilor
    pop ebx
    pop esi
    pop edi

    leave
    ret

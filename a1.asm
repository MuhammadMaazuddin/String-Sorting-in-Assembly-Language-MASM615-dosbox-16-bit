.model small
.stack 100h

.data
    nam BYTE 'Enter size of array: $'
    e BYTE 'Enter $'
    n BYTE ' name: $'
    outp BYTE 'Array in accending array is: $'
    string BYTE 50 DUP (?), '$'
    values dw 10 DUP (0), '$'
    sort BYTE 50 DUP (?), '$'
    names BYTE ?
    temp BYTE 15 DUP (?)
    val dw 0FFFFh

.code
main proc
    mov ax, @data
    mov ds, ax

    mov dx, offset nam
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h

    mov names, al
    sub names, 48

    mov dx, 10
    mov ah, 2
    int 21h

    mov cx, 0
    mov cl, names
    mov si, offset string
    mov di, offset values

    input1:
        mov dx, offset e
        mov ah, 9
        int 21h

        mov dx, 0
        mov dl, names
        add dx, 48
        sub dx, cx
        inc dx
        mov ah, 2
        int 21h

        mov dx, offset n
        mov ah, 9
        int 21h

        push cx
        mov cx, 1

        input2:
            mov ah, 1
            int 21h

            cmp al, 13
            je stop
            mov ah, 0
            mov [si], al
            mul cl
            add [di], ax
            inc si
            inc cx
            jmp input2

        stop:

        pop cx
        add di, 2
        inc si

        loop input1


    mov bp, offset sort
    mov cx, 0
    mov cl, names

    L1:
        mov si, offset string
        mov di, offset values
        push cx
        push bp
        mov cx, 0
        mov cl, names
        mov ax, val

        L2:
            cmp [di], ax
            jae not_swap

            mov ax, [di]

            push di
            mov di, offset temp
            mov bx, 0
             L7:
                push bx
                mov bl, 0
                mov [di], bl
                pop bx
                inc di
                inc bx
                cmp bx, 15
                jne L7

            pop di
            mov bp, offset temp

            L3:
                mov bl, [si]
                push di
                mov di, bp
                mov [di], bl
                pop di
                inc si
                inc bp
                mov bl, [si]
                cmp bl, 0
                jne L3

            inc si
            add di, 2
            loop L2
            jmp here

            not_swap:
                L4:
                    inc si
                    mov bl, [si]
                    cmp bl, 0
                    jne L4

                inc si
                add di, 2

            loop L2

        here:
        mov di, offset values

        L6:
            cmp [di], ax
            je exit

            add di, 2
            jmp L6

        exit:
        mov bx, val
        mov [di], bx

        pop bp
        pop cx

        push si
        mov si, offset temp

        L5:
            mov bl, [si]
            push di
            mov di, bp
            mov [di], bl
            pop di
            inc si
            inc bp
            mov bl, [si]
            cmp bl, 0
            jne L5

        pop si
        inc bp
        dec cx
        cmp cx, 0
        ja L1

    mov dx, offset outp
    mov ah, 9
    int 21h

    mov si, offset sort
    mov cx, 0
    mov cl, names

    output1:
        output2:
            mov dl, [si]
            mov ah, 2
            int 21h
            inc si
            mov bl, [si]
            cmp bl, 0
            jne output2
        loop output1
    

mov ah, 4ch
int 21h
main endp


end
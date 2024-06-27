@ Define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ Text section
.text
.align 2
.global print_piles

print_piles:
    push {fp, lr}
    add fp, sp, #4
    sub sp, sp, #16

    str r0, [fp, #-16]
    str r1, [fp, #-20]

    mov r3, #0
    str r3, [fp, #-8]

loop6:
    ldr r3, [fp, #-8]
    lsl r3, r3, #2
    ldr r2, [fp, #-16]
    add r3, r2, r3
    ldr r3, [r3]

    mov r1, r3
    ldr r0, =format_str
    bl printf

    ldr r3, [fp, #-8]
    add r3, r3, #1
    str r3, [fp, #-8]

    ldr r2, [fp, #-8]
    ldr r3, [fp, #-20]
    cmp r2, r3
    blt loop6

    mov r0, #10
    bl putchar

    sub sp, fp, #4
    pop {fp, pc}


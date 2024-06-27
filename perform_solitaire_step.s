@ Define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ Text section
.text
.align 2
.global perform_solitaire_step

perform_solitaire_step:
    push {fp, lr}
    add fp, sp, #4
    sub sp, sp, #24

    str r0, [fp, #-24]
    str r1, [fp, #-28]

    mov r3, #0
    str r3, [fp, #-8]

    mov r3, #0
    str r3, [fp, #-12]

loop2:
    ldr r3, [fp, #-12]
    lsl r3, r3, #2
    ldr r2, [fp, #-24]
    add r3, r2, r3
    ldr r3, [r3]
    cmp r3, #0
    ble skip1

    ldr r3, [fp, #-12]
    lsl r3, r3, #2
    ldr r2, [fp, #-24]
    add r3, r2, r3
    ldr r2, [r3]
    sub r2, r2, #1
    str r2, [r3]

    ldr r3, [fp, #-8]
    add r3, r3, #1
    str r3, [fp, #-8]

skip1:
    ldr r3, [fp, #-12]
    add r3, r3, #1
    str r3, [fp, #-12]

    ldr r3, [fp, #-28]
    ldr r3, [r3]
    ldr r2, [fp, #-12]
    cmp r2, r3
    blt loop2

    mov r3, #0
    str r3, [fp, #-16]

    mov r3, #0
    str r3, [fp, #-20]

loop3:
    ldr r3, [fp, #-20]
    lsl r3, r3, #2
    ldr r2, [fp, #-24]
    add r3, r2, r3
    ldr r3, [r3]
    cmp r3, #0
    ble skip2

    ldr r3, [fp, #-20]
    lsl r3, r3, #2
    ldr r2, [fp, #-24]
    add r2, r2, r3
    ldr r3, [fp, #-16]
    add r1, r3, #1
    str r1, [fp, #-16]

    lsl r3, r3, #2
    ldr r1, [fp, #-24]
    add r3, r1, r3
    ldr r2, [r2]
    str r2, [r3]

skip2:
    ldr r3, [fp, #-20]
    add r3, r3, #1
    str r3, [fp, #-20]

    ldr r3, [fp, #-28]
    ldr r3, [r3]
    ldr r2, [fp, #-20]
    cmp r2, r3
    blt loop3

    ldr r3, [fp, #-16]
    add r2, r3, #1
    str r2, [fp, #-16]

    lsl r3, r3, #2
    ldr r2, [fp, #-24]
    add r3, r2, r3
    ldr r2, [fp, #-8]
    str r2, [r3]

    ldr r3, [fp, #-28]
    ldr r2, [fp, #-16]
    str r2, [r3]

    sub sp, fp, #4
    pop {fp, pc}


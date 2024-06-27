@ Define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ Text section
.text
.align 2
.global generate_starting_configuration

generate_starting_configuration:
    push {fp, lr}
    add fp, sp, #4
    sub sp, sp, #16

    str r0, [fp, #-16]
    str r1, [fp, #-20]
    mov r3, #45
    str r3, [fp, #-8]

    ldr r3, [fp, #-20]
    mov r2, #0
    str r2, [r3]

loop1:
    bl rand
    mov r3, r0
    ldr r1, [fp, #-8]
    mov r0, r3
    bl __aeabi_idivmod
    mov r3, r1
    add r3, r3, #1
    str r3, [fp, #-12]

    ldr r3, [fp, #-20]
    ldr r3, [r3]
    add r1, r3, #1
    ldr r2, [fp, #-20]
    str r1, [r2]

    lsl r3, r3, #2
    ldr r2, [fp, #-16]
    add r3, r2, r3
    ldr r2, [fp, #-12]
    str r2, [r3]

    ldr r2, [fp, #-8]
    ldr r3, [fp, #-12]
    sub r3, r2, r3
    str r3, [fp, #-8]

    ldr r3, [fp, #-8]
    cmp r3, #0
    bgt loop1

    sub sp, fp, #4
    pop {fp, pc}


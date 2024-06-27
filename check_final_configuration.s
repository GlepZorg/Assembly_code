@ Define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ Text section
.text
.align 2
.global check_final_configuration

check_final_configuration:
    push {fp, lr}
    add fp, sp, #4
    sub sp, sp, #56

    str r0, [fp, #-56]
    str r1, [fp, #-60]

    ldr r3, [fp, #-60]
    cmp r3, #9
    beq final_check

    mov r3, #0
    b end_final_check

final_check:
    sub r3, fp, #52
    mov r2, #40
    mov r1, #0
    mov r0, r3
    bl memset

    mov r3, #0
    str r3, [fp, #-8]

loop4:
    ldr r3, [fp, #-8]
    lsl r3, r3, #2
    ldr r2, [fp, #-56]
    add r3, r2, r3
    ldr r3, [r3]
    cmp r3, #0
    ble skip3

    ldr r3, [fp, #-8]
    lsl r3, r3, #2
    ldr r2, [fp, #-56]
    add r3, r2, r3
    ldr r3, [r3]
    cmp r3, #9
    ble skip4

skip3:
    mov r3, #0
    b end_final_check

skip4:
    ldr r3, [fp, #-8]
    lsl r3, r3, #2
    ldr r2, [fp, #-56]
    add r3, r2, r3
    ldr r2, [r3]

    lsl r3, r2, #2
    sub r1, fp, #4
    add r3, r1, r3
    ldr r3, [r3, #-48]
    add r1, r3, #1
    lsl r3, r2, #2
    sub r2, fp, #4
    add r3, r2, r3
    str r1, [r3, #-48]

    ldr r3, [fp, #-8]
    add r3, r3, #1
    str r3, [fp, #-8]

    ldr r2, [fp, #-8]
    ldr r3, [fp, #-60]
    cmp r2, r3
    blt loop4

    mov r3, #1
    str r3, [fp, #-12]

loop5:
    ldr r3, [fp, #-12]
    lsl r3, r3, #2
    sub r2, fp, #4
    add r3, r2, r3
    ldr r3, [r3, #-48]
    cmp r3, #1
    beq check_next
    mov r3, #0
    b end_final_check

check_next:
    ldr r3, [fp, #-12]
    add r3, r3, #1
    str r3, [fp, #-12]

    ldr r3, [fp, #-12]
    cmp r3, #9
    ble loop5

    mov r3, #1

end_final_check:
    mov r0, r3
    sub sp, fp, #4
    pop {fp, pc}


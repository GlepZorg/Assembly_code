@ Define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ Data section
.data
.balign 4
.global start_msg
start_msg: .asciz "Starting configuration:\n"
.global final_msg
final_msg: .asciz "Final configuration reached!\n"
.global format_str
format_str: .asciz "%d "

@ Text section
.text
.align 2
.global main
.global generate_starting_configuration
.global perform_solitaire_step
.global check_final_configuration
.global print_piles

main:
    push {fp, lr}
    add fp, sp, #4
    sub sp, sp, #184

    sub r3, fp, #184
    mov r2, #180
    mov r1, #0
    mov r0, r3
    bl memset

    mov r3, #0
    str r3, [fp, #-188]
    mov r0, #0
    bl time
    mov r3, r0
    mov r0, r3
    bl srand

    sub r2, fp, #188
    sub r3, fp, #184
    mov r1, r2
    mov r0, r3
    bl generate_starting_configuration

    ldr r0, =start_msg
    bl puts

    ldr r2, [fp, #-188]
    sub r3, fp, #184
    mov r1, r2
    mov r0, r3
    bl print_piles

loop_start:
    sub r2, fp, #188
    sub r3, fp, #184
    mov r1, r2
    mov r0, r3
    bl perform_solitaire_step

    ldr r2, [fp, #-188]
    sub r3, fp, #184
    mov r1, r2
    mov r0, r3
    bl print_piles

    ldr r2, [fp, #-188]
    sub r3, fp, #184
    mov r1, r2
    mov r0, r3
    bl check_final_configuration

    mov r3, r0
    cmp r3, #0
    beq loop_start

    ldr r0, =final_msg
    bl puts

    mov r3, #0
    mov r0, r3
    sub sp, fp, #4
    pop {fp, pc}


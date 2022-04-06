#include "cep_platform.h"
.text
.globl reveil
/* void reveil(uint32_t delta_t); */
reveil:
/* A reprendre depuis fct_timer.s */
# $$$ etd_strip_begin
    li   t2, CLINT_TIMER
    lw   t0, 0(t2) /* low */
    lw   t1, 4(t2) /* high */
    add  t0, a0, t0
    sltu a0, t0, a0 /* détection d'un dépassement */
    add  t1, a0, t1
    li   t2, CLINT_TIMER_CMP
    li   t3, -1
    sw   t3, 0(t2) /* low: no smaller than old value */
    sw   t1, 4(t2) /* high: no smaller than new value */
    sw   t0, 0(t2) /* low: new value */
# $$$ etd_strip_end
    ret

.globl gestion_interruptions
gestion_interruptions:
    addi sp, sp, -4 # Juste ra à sauver
    sw   ra, 0(sp)
    andi t0, a0, 0xf
    li   t1, IRQ_M_TMR  # Interruption d'horloge
    bne  t0, t1, interruption_externe
    jal  mon_vecteur_horloge
    j    retour
interruption_externe:
    /* À compléter : gestion des boutons poussoirs */
# $$$ etd_strip_begin
    /* mise au frais du pointeur présent dans param */
    lw   t2, param
    /* lecture des boutons poussoirs pour acquitter l'interruption niveau périphérique */
    lui  t0, %hi(REG_PINS_ADDR)
    lw   t1, %lo(REG_PINS_ADDR)(t0)
    srli t1, t1, 16
    andi t0, t1, 0x1
    beqz t0, retour
btn1:
    sw   zero, 0(t2) # tics est (*param)+0
    j    retour
# $$$ etd_strip_end
retour:
    lw   ra, 0(sp)
    addi sp, sp, 4
    ret

    .data
    .globl param
/* struct compt *param; */
param: .long 0x0

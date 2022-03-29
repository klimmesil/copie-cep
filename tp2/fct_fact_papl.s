/*
uint32_t fact_papl(uint32_t n)
{
    if (n <= 1) {
        return 1;
    } else {
        uint64_t tmp = n*fact_papl(n-1);
        if ((tmp >> 32) > 0)
            erreur_fact(n);
        return (uint32_t)tmp;
    }
}
*/

    .text
    .globl fact_papl
    /* uint32_t fact_papl(uint32_t n) */
/* DEBUT DU CONTEXTE
fonction :
     fact_papl      : non feuille
contexte :
     tmp            : pile *(sp+0)
     n              : registre a0; pile *(sp+8)
     ra             : pile *(sp+12)
 */
fact_papl:
/* A compléter */
    /* np=0 nv=2 nr=2 */
    addi    sp, sp, -16
    sw      a0, 8(sp)
    sw      ra, 12(sp)
fact_papl_fin_prologue:
if:
    /* n <= 1 */
    slti    t0, a0, 2
    beqz    t0, else

    /* return 1; */
    li      a0, 1
    j       fact_papl_debut_epilogue

    j       endif
else:
    /* uint64_t tmp = n*fact_papl(n-1) */
    addi    a0, a0, -1
    jal     fact_papl
    /* t1 = lower32 n*fact_papl(n-1) */
    lw      t0, 8(sp)
    mul     t1, t0, a0
    /* t2 = higher32 n*fact_papl(n-1) */
    mulhu   t2, t0, a0
    sw      t1, 0(sp)
    sw      t2, 4(sp)
ifcheck:
    /* if ((tmp >> 32) > 0) */
    beqz    t2, endcheck
    /* erreur_fact(n) */
    lw      a0, 8(sp)
    jal     erreur_fact
endcheck:
    /* return (uint32_t)tmp; */
    lw      a0, 0(sp)
    j       fact_papl_debut_epilogue
endif:
fact_papl_debut_epilogue:
    lw      ra, 12(sp)
    addi    sp, sp, 16
    ret

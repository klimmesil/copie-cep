/*
uint32_t fact(uint32_t n)
{
    if (n <= 1) {
        return 1;
    } else {
        return n * fact(n - 1);
    }
}
*/

    .text
    .globl fact
    /* uint32_t fact(uint32_t n) */
/* DEBUT DU CONTEXTE
fonction :
     fact   : non feuille
contexte :
    n       : registre a0; pile *(sp+0)
    ra      : pile *(sp+4)
 */
fact:
/* A compléter */
    /* np=0 nv=0 nr=2 */
    addi    sp, sp, -8
    sw      a0, 0(sp)
    sw      ra, 4(sp)
fact_fin_prologue:
if:
    /* n < 2 */
    slti    t0, a0, 2
    beqz    t0, else
    /* return 1 */
    li      a0, 1
    j       fact_debut_epilogue
else:
    /* on prepare l'appel */
    addi    a0, a0, -1
    /* fact(n-1) */
    jal     fact
    /* on recupere n */
    lw      t0, 0(sp)
    /* return n* fact(n-1) */
    mul     a0, a0, t0
    j       fact_debut_epilogue
endif:
fact_debut_epilogue:
    lw      ra, 4(sp)
    addi    sp, sp, 8
    ret

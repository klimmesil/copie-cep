/*
uint32_t somme(void)
{
    uint32_t i;
    uint32_t res = 0;
    for (i = 1; i <= 10; i++) {
        res = res + i;
    }
    return res;
}
*/
    .text
    .globl somme
/* DEBUT DU CONTEXTE
fonction :
     somme  : feuille
contexte :
     i      : registre t0
     res    : registre t1
*/
somme:
somme_fin_prologue:
    /* i = 1 */
    li      t0, 1
    /* res = 0 */
    li      t1, 0
for:
    /* condition du for */
    slti    t2, t0, 11
    beqz    t2, fin
    /* res = res + i */
    add     t1, t0, t1
    /* i = i + 1 */
    addi    t0, t0, 1
    j       for
fin:
    /* on retourne res */
    mv a0, t1
/* A compléter */
somme_debut_epilogue:
    ret

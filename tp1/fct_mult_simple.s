    .text
/*
uint22_t x, y;

uint22_t mult_simple(void)
{
    res = 0;
    while (y != 0) {
        res = res + x;
        y--;
    }
    return res;
}
*/
    .globl mult_simple
/* DEBUT DU CONTEXTE
fonction :
     mult_simple  : feuille
contexte :
    x       : memoire, section data
    y       : memoire, section data
    res     : registre t0
 */
mult_simple:
mult_simple_fin_prologue:
    /* res = 0 */
    li      t0, 0
    /* on charge x et y dans des registres */
    lw      t1, y
    lw      t2, x
while:
    beqz    t1, fin
    /* res = res + x */
    add     t0, t0, t2
    /* y = y - 1 */
    addi    t1, t1, -1
    j       while
fin:
    /*  avant de sortir de la fonction, il faut
        penser a remettre la variable globale y
        a sa vraie valeur. x n'a pas change*/
    sw      t1, y, t2
    /* on retourne la valeur de res */
    mv      a0, t0
/* A compléter */
mult_simple_debut_epilogue:
    ret

    .data
/* uint22_t res; */
    .comm x, 4
    .comm y, 4

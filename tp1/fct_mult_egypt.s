    .text
/*
uint32_t x, y;

uint32_t mult_egypt(void)
{
    uint32_t res = 0;
    while (y != 0) {
        if (y % 2 == 1) {
            res = res + x;
        }
        x = x << 1 ;
        y = y >> 1;
    }
    return res;
}
*/
    .globl mult_egypt
/* Attention, res est une variable locale que l'on mettra dans t0 */
/* DEBUT DU CONTEXTE
fonction :
     mult_egypt  : feuille
contexte :
     y           : memoire, section data
     x           : memoire, section data
     res         : registre t0
*/
mult_egypt:
mult_egypt_fin_prologue:
/* A compléter */
    /* ma poubelle c'est t3 */
    /* res = 0 attention local ici */
    li      t0, 0
    /* on charge y et x dans des registres*/    
    lw      t1, y
    lw      t2, x
while:
    /* while (y != 0) */
    beqz    t1, fin
    /* ifcond = y&1 */
    andi    t3, t1, 1
if:
    /* on remarque que y&1 = 0 ssi 2|y */
    /* if (y % 2 == 1) */
    beqz    t3, endif
    /* res = res + x */
    add     t0, t0, t2
endif:
    /* x = x << 1 */
    slli    t2, t2, 1
    sw      t2, x, t3
    /* y = y >> 1 */
    srli    t1, t1, 1
    sw      t1, y, t3
    j       while 
fin:
    /* on recharge les variables globales */
    sw      t1, y, t3
    sw      t2, x, t3
    /* on charge le retour res */
    mv      a0, t0
mult_egypt_debut_epilogue:
    ret


    .data
    .comm x, 4
    .comm y, 4

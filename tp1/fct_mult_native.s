    .text
/*
uint32_t x, y;

uint32_t mult_native(void)
{
    return x*y;
}
*/
    .globl mult_native
/* DEBUT DU CONTEXTE
fonction :
     mult_native      : feuille
contexte :
    y                 : memoire, section data
    x                 : memoire, section data
 */
mult_native:
mult_native_fin_prologue:
/* A compléter */
    /* on charge x et y dans la sortie */
    lw t0, x
    lw t1, y
    /* on charge x*y dans la sortie */
    mul a0, t0, t1
mult_native_debut_epilogue:
    /* on saute apres l'appel */
    ret

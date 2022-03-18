/*
uint8_t res8;

uint8_t somme8(void)
{
    uint8_t i;
    res8 = 0;
    for (i = 1; i <= 24; i++) {
        res8 = res8 + i;
    }
    return res8;
}
*/

    .globl somme8
/* DEBUT DU CONTEXTE
fonction :
     somme8         : feuille
contexte :
     i              : registre t0
     res8           : memoire, section data
 */
somme8:
somme8_fin_prologue:
/* A compléter */
    /* i = 1 */
    li      t0, 1
    /* je saute l'etape lbu t0, res8, car on met res8 = 0 */
    /* res = 0 */
    li      t1, 0
for:
    /* t2 = i<25?1:0 */
    slti    t2, t0, 25
    beqz    t2, fin
    /* res8 = res8 + i */
    add     t1, t1, t0
    /* i++, loop */
    addi    t0, t0, 1
    j for
fin:
    /* load local into global */
    sb      t1, res8, t0
    /* return res */
    mv      a0, t1
somme8_debut_epilogue:
    /* jump to caller */
    ret

    .data
/* uint8_t res8;
 la variable globale res8 étant définie dans ce fichier, il est nécessaire de
 la définir dans la section .data du programme assembleur : par exemple, avec
 la directive .comm vu qu'elle n'est pas initialisée
*/
    .comm res8, 1

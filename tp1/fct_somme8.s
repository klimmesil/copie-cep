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
    /* ma poubelle c'est t3 */
    /* i = 1 */
    li      t0, 1
    /* res = 0 */
    lbu     t1, res8
    li      t1, 0
    sb      t1, res8, t3
for:
    /* t2 = i<25?1:0 */
    slti    t2, t0, 25
    beqz    t2, fin
    /* res8 = res8 + i */
    add     t1, t1, t0
    sb      t1, res8, t3
    /* i++, loop */
    addi    t0, t0, 1
    j for
fin:
    /* load local into global */
    sb      t1, res8, t3
    /* return res */
    lbu     a0, res8
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

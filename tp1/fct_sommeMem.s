/*
uint32_t res;

uint32_t sommeMem(void)
{
    uint32_t i;
    res = 0;
    for (i = 1; i <= 10; i++) {
        res = res + i;
    }
    return res;
}
*/
    .globl sommeMem
/* DEBUT DU CONTEXTE
fonction :
     sommeMem  : feuille
contexte :
     res    : memoire, section data
     i      : registre t0
 */
sommeMem:
sommeMem_fin_prologue:
    /* res = 0 */ 
    li      t1, 0
    sw      t1, res, t2 /* t2 sert a charger res dans t1 */
    /* initialisation de i a 1 */
    li      t0, 1
for:
    /* fin potentielle du for */
    slti    t2, t0, 11
    beqz    t2, fin
    /* res = res+i */
    add     t1, t0, t1
    sw      t1, res, t2
    /* i = i + 1 */
    addi    t0, t0, 1
    j       for
/* A compléter */
fin:
    /* on ecrit la valeur de res a l'addresse memoire res */
    sw      t1, res, t2 /* t2 est maintenant random */

    /* on retourne res */
    lw      a0, res
sommeMem_debut_epilogue:
    ret

    .data
/* uint32_t res;
 la variable globale res étant définie dans ce fichier, il est nécessaire de
 la définir dans la section .data du programme assembleur : par exemple, avec
 la directive .comm vu qu'elle n'est pas initialisée
*/
    .comm res, 4

/*
void tri_nain(int32_t tab[], uint32_t taille)
{
    uint32_t i = 0;
    while(i < taille - 1) {
        if (tab[i] > tab[i+1]) {
            int32_t tmp = tab[i];
            tab[i] = tab[i+1];
            tab[i + 1] = tmp;
            if (i > 0) {
                i = i - 1;
            }
        } else {
            i = i + 1;
        }
    }
}
*/

    .text
    .globl tri_nain_opt
/* Version du tri optimisée sans respecter la contrainte de la traduction
 * systématique pour les accès mémoire (et le calcul de leurs adresses)
   Complétez le contexte ci-dessous en indiquant les registres qui contiendront
   des variables temporaires.  */
/* DEBUT DU CONTEXTE
fonction :
     tri_nain_opt   : feuille
contexte :
    tab             : registre a0
    taille          : registre a1
    i               : registre t0
    tmp             : registre t1
    &tab[i]         : registre t2
    tab[i+1]        : registre t4
    tab[i]          : registre t5
 */
tri_nain_opt:
    /* pas besoin de toucher a sp */
tri_nain_opt_fin_prologue:
    /* uint32_t i = 0 */
    li      t0, 0
while:
    /* i < taille - 1 */
    addi    t2, a1, -1 /* t2 = taille - 1 */
    bgeu    t0, t2, endwhile

if:
    /* tab[i] > tab[i+1] */
    /* equivalent a tab[i] >= tab[i+1] + 1 */
    slli    t2, t0, 2 /* on compte par 4 bytes */
    add     t2, t2, a0 /* t2 = &tab[i] */
    lw      t5, 0(t2) /* t5 = tab[i] */
    addi    t3, t0, 1 /* t3 = i+1 */
    slli    t3, t3, 2 /* on compte par 4 bytes */
    add     t3, t3, a0 /* t3 = &tab[i+1] */
    lw      t4, 0(t3) /* t4 = tab[i+1] */
    addi    t6, t4, 1 /* t6 = tab[i+1] + 1 */

    blt     t5, t6, else

    /* int32_t tmp = tab[i] */
    /* t5 contient justement tab[i] */
    mv      t1, t5

    /* tab[i] = tab[i+1]; */
    /* t4 contient justement tab[i+1] */
    /* t2 contient justement &tab[i] */
    sw      t4, 0(t2)

    /* tab[i + 1] = tmp; */
    /* t3 contient justement &tab[i+1] */
    sw      t1, 0(t3)

if2:
    /* i > 0 */
    /* ie i != 0 (i est unsigned) */
    beqz    t0, endif2

    /* i = i - 1 */
    addi    t0, t0, -1

    j endif2
endif2:

    j       endif
else:
    /* i = i + 1 */
    addi    t0, t0, 1

    j       endif
endif:
    j       while
endwhile:
tri_nain_opt_debut_epilogue:
    ret

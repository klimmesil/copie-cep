/*
void tri_min(int32_t tab[], uint32_t taille)
{
    uint32_t i, j, ix_min;
    int32_t tmp;
    for (i = 0; i < taille - 1; i++) {
        for (ix_min = i, j = i + 1; j < taille; j++) {
            if (tab[j] < tab[ix_min]) {
                ix_min = j;
            }
        }
        tmp = tab[i];
        tab[i] = tab[ix_min];
        tab[ix_min] = tmp;
    }
}
#ENTREE 45
*/
    .text
    .globl tri_min
/* void tri_min(int32_t tab[], uint32_t taille) */
/* DEBUT DU CONTEXTE
fonction :
     tri_min    : feuille
contexte :
    tab         : registre a0
    taille      : registre a1
    i           : registre t0
    j           : registre t1
    ix_min      : registre t2
    tmp         : registre t3
 */
tri_min:
tri_min_fin_prologue:
    /* i = 0 */
    li      t0, 0
whilei:
    /* i < taille */
    slt     t4, t0, a1
    beqz    t4, endi
    /* ix-min = i */
    mv      t2, t0
    /* j = i + 1 */
    addi    t1, t0, 1
whilej:
    /* j < taille */
    slt     t4, t1, a1
    beqz    t4, endj
if:
    /* tab[j] < tab[ix_min] */
    mv      t5, t1
    slli    t5, t5, 2
    add     t5, t5, a0
    lw      t5, 0(t5)
    mv      t6, t2
    slli    t6, t6, 2
    add     t6, t6, a0
    lw      t6, 0(t6)
    slt     t4, t5, t6
    beqz    t4, endif

    /* ix_min = j */
    mv      t2, t1
endif:

    /* j++ */
    addi    t1, t1, 1
    j       whilej
endj:
    /* tmp = tab[i] */
    mv      t4, t0
    slli    t4, t4, 2
    add     t4, t4, a0
    lw      t3, 0(t4)

    /* tab[i] = tab[ix_min] */
    mv      t5, t2
    slli    t5, t5, 2
    add     t5, t5, a0
    lw      t6, 0(t5)
    sw      t6, 0(t4)

    /* tab[ix_min] = tmp */
    sw      t3, 0(t5)
    /* i++ */
    addi    t0, t0, 1 
    j       whilei
endi:
tri_min_debut_epilogue:
    ret


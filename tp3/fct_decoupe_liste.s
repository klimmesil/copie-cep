/*
struct cellule_t *decoupe_liste(struct cellule_t *l, struct cellule_t **l1, struct cellule_t **l2)
{
    struct cellule_t fictif1, fictif2;
    *l1 = &fictif1;
    *l2 = &fictif2;
    while (l != NULL) {
        if (l->val % 2 == 1) {
            (*l1)->suiv = l;
            *l1 = l;
        } else {
            (*l2)->suiv = l;
            *l2 = l;
        }
        l = l->suiv;
    }
    (*l1)->suiv = NULL;
    (*l2)->suiv = NULL;
    *l1 = fictif1.suiv;
    *l2 = fictif2.suiv;
    return l;
}
*/
    .text
    .globl decoupe_liste
/*
Fonction feuille : A priori pile inchangée, mais besoin de l'adresse des
variables locales => implantation des variables locales en pile.
Besoin de 2*2 mots de 32 bits dans la pile (PILE+16)
-> fictif1 à sp+0, fictif2 à sp+8
   (2 mots mémoire chacun : un pour le champ val, un pour le champ suiv)

DEBUT DU CONTEXTE
Fonction :
  decoupe_liste : feuille
Contexte :
  l             : registre a0, paramètre de type (struct cellule_t *)
  l1            : registre a1, paramètre de type (struct cellule_t **)
  l2            : registre a2, paramètre de type (struct cellule_t **)
  fictif2.suiv  : pile à sp+12 (champ de type cellule_t *)
  fictif2.val   : pile à sp+8  (champ de type int32_t)
  fictif1.suiv  : pile à sp+4  (champ de type cellule_t *)
  fictif1.val   : pile à sp+0  (champ de type int32_t)
*/
decoupe_liste:
    /* struct cellule_t fictif1, fictif2 */
    /* NOTE: la pile est inutile car il s'agit
        d'une feuille. J'ai fait n'importe quoi
        car je pensais faire quelque chose de
        recursif. Mais bon ca marche. */
    addi    sp, sp, -16
decoupe_liste_fin_prologue:
    /* *l1 = &fictif1 */
    sw      sp, 0(a1)
    /* *l2 = &fictif2 */
    addi    t0, sp, 8
    sw      t0, 0(a2)
while:
    /* l != NULL */
    mv      t1, a0
    beqz    t1, end
if:
    /* l -> val $ 2 == 1 */
    lw      t2, 0(a0)
    andi    t2, t2, 0x1
    beqz    t2, else

    /* *(l1)->suiv = l */
    lw      t3, 0(a1) /* *l1 */
    sw      a0, 4(t3)
    /* *l1 = l */
    sw      a0, 0(a1)

    j       endif
else:
    /* (*l2)->suiv = l */
    lw      t4, 0(a2) /* *l2 */
    sw      a0, 4(t4)
    /* *l2 = l */
    sw      a0, 0(a2)
endif:
    /* l = l->suiv */
    lw      a0, 4(a0)
    j       while
end:
    /* *(l1)->suiv = NUll */
    lw      t3, 0(a1) /* *l1 */
    sw      zero, 4(t3)
    /* (*l2)->suiv = NULL */
    lw      t4, 0(a2) /* *l2 */
    sw      zero, 4(t4)
    /* *l1 = fictif1.suiv */
    lw      t5, 4(sp)
    sw      t5, 0(a1)
    /* *l2 = fictif2.suiv */
    lw      t6, 12(sp)
    sw      t6, 0(a2)
    /* l est deja dans a0 */
decoupe_liste_debut_epilogue:
    addi    sp, sp, 16
    ret

/*
void inverse_liste(struct cellule_t **l)
{
   struct cellule_t *res, *suiv;
   res = NULL;
   while (*l != NULL) {
       suiv = (*l)->suiv;
       (*l)->suiv = res;
       res = *l;
       *l = suiv;
   }
   *l = res;
}
*/
    .text
    .globl inverse_liste
/* void inverse_liste(struct cellule_t **l) */
/* DEBUT DU CONTEXTE
fonction :
     inverse_liste  : feuille
contexte :
     l              : registre a0
     res            : registre t0
     suiv           : registre t1
 */
inverse_liste:
inverse_liste_fin_prologue:
    /* res = NULL */
    li      t0, 0
while:
    /* on charge *l dans t2 */
    lw      t2, 0(a0)
    /* *l != NULL */
    beqz    t2, end
    /* suiv = (*l)->suiv */
    lw      t1, 4(t2)
    /* (*l)->suiv = res */
    sw      t0, 4(t2)
    /* res = *l */
    mv      t0, t2
    /* *l = suiv */
    sw      t1, 0(a0)
    
    j       while
end:
    /* *l = res */
    sw      t0, 0(a0)
inverse_liste_debut_epilogue:
    ret

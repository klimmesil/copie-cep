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
     nom_de_fonction  : feuille ou non feuille
contexte :
     parametre_0      : registre a0
     parametre_1      : registre ai; pile *(sp+n)
     variable_locale0 : registre t0
     variable_locale1 : pile *(sp+k)
     ra               : pile *(sp+p)
     variable_globale : memoire [section nom_de_section]
 */
inverse_liste:
inverse_liste_fin_prologue:
inverse_liste_debut_epilogue:
    ret

/*
bool abr_est_present_tail_call(uint32_t val, struct noeud_t *abr)
{
   if (abr == NULL) {
       return false;
   } else if (val == abr->val) {
       return true;
   } else if (val < abr->val) {
       return abr_est_present_tail_call(val, abr->fg);
   } else {
       return abr_est_present_tail_call(val, abr->fd);
   }
}
*/

    .text
    .globl abr_est_present_tail_call
/* DEBUT DU CONTEXTE
fonction :
     abr_est_present_tail_call  : feuille
contexte :
    val                         : registre a0
    abr                         : registre a1
 */

/* struct noeud_t { */
   /* uint32_t val;                // valeur du noeud */
   /* struct noeud_t *fg;          // fils gauche */
   /* struct noeud_t *fd;          // fils droite */
/* }; */

abr_est_present_tail_call:
    /* pas besoin de toucher a la pile! */
abr_est_present_tail_call_fin_prologue:
if:
    /* abr == NULL */
    bnez    a1, elseif1

    /* return false */
    li      a0, 0
    j       abr_est_present_tail_call_debut_epilogue
elseif1:
    /* val == abr->val */
    lw      t0, 0(a1) /* abr->val */
    bne     a0, t0, elseif2

    /* return true */
    li      a0, 1
    j       abr_est_present_tail_call_debut_epilogue
elseif2:
    /* val < abr->val */
    /* t0 contient deja abr->val */
    bge     a0, t0, else

    /* return abr_est_present(val, abr->fg) */
    lw      a1, 4(a1)
    /* en realite, le ra que l'on fournit est
       celui que main nous a donne */
    j       abr_est_present_tail_call
else:
    /* cas val > abr->val */

    /* return abr_est_present(val, abr->fd) */
    lw      a1, 8(a1)
    /* en realite, le ra que l'on fournit est
       celui que main nous a donne */
    j       abr_est_present_tail_call
abr_est_present_tail_call_debut_epilogue:
    /* dans les cas recursifs on n'arrivera meme pas ici */
    ret

/*
bool abr_est_present(uint32_t val, struct noeud_t *abr)
{
   if (abr == NULL) {
       return false;
   } else if (val == abr->val) {
       return true;
   } else if (val < abr->val) {
       return abr_est_present(val, abr->fg);
   } else {
       return abr_est_present(val, abr->fd);
   }
}
*/

    .text
    .globl abr_est_present
/* DEBUT DU CONTEXTE
fonction :
     abr_est_present    : non feuille
contexte :
     val                : registre a0; pile *(sp+0)
     abr                : registre a1; pile *(sp+4)
     ra                 : pile *(sp+8)
*/

/* struct noeud_t { */
   /* uint32_t val;                // valeur du noeud */
   /* struct noeud_t *fg;          // fils gauche */
   /* struct noeud_t *fd;          // fils droite */
/* }; */

abr_est_present:
    /* np=0 nv=0 nr=3 */
    addi    sp, sp, -12
    sw      a0, 0(sp)
    sw      a1, 4(sp)
    sw      ra, 8(sp)
abr_est_present_fin_prologue:
if:
    /* abr == NULL */
    bnez    a1, elseif1

    /* return false */
    li      a0, 0
    j       abr_est_present_debut_epilogue
elseif1:
    /* val == abr->val */
    lw      t0, 0(a1) /* abr->val */
    bne     a0, t0, elseif2

    /* return true */
    li      a0, 1
    j       abr_est_present_debut_epilogue
elseif2:
    /* val < abr->val */
    /* t0 contient deja abr->val */
    bge     a0, t0, else

    /* return abr_est_present(val, abr->fg) */
    lw      a1, 4(a1)
    jal     abr_est_present
    j       abr_est_present_debut_epilogue
else:
    /* cas val > abr->val */

    /* return abr_est_present(val, abr->fd) */
    lw      a1, 8(a1)
    jal     abr_est_present
    j       abr_est_present_debut_epilogue
abr_est_present_debut_epilogue:
    lw      ra, 8(sp)
    addi    sp, sp, 12
    ret

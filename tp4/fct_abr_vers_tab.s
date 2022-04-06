/*
void abr_vers_tab(struct noeud_t *abr)
{
    if (abr != NULL) {
        abr_vers_tab(abr->fg);
        *ptr = abr->val;
        ptr++;
        struct noeud_t *fd = abr->fd;
        free(abr);
        abr_vers_tab(fd);
    }
}
*/

    .text
    .globl abr_vers_tab
/* DEBUT DU CONTEXTE
fonction :
     abr_vers_tab   : non feuille
contexte :
     abr            : registre a0; pile *(sp+0)
     fd             : pile *(sp+4)
     ra             : pile *(sp+8)
     ptr            : memoire, section data
 */

/* struct noeud_t { */
   /* uint32_t val;                // valeur du noeud */
   /* struct noeud_t *fg;          // fils gauche */
   /* struct noeud_t *fd;          // fils droite */
/* }; */

abr_vers_tab:
    /* np=0 nv=1 nr=2 */
    addi    sp, sp, -12
    sw      a0, 0(sp)
    sw      zero, 4(sp)
    sw      ra, 8(sp)
abr_vers_tab_fin_prologue:
if:
    /* abr != NULL */
    beqz    a0, fi

    /* abr_vers_tab(abr->fg); */
    lw      a0, 4(a0) /* a0 = abr->fg */
    jal     abr_vers_tab

    /* *ptr = abr->val */
    lw      a0, 0(sp) /* a0 = abr */
    lw      t0, 0(a0) /* t0 = abr->val */
    lw      t1, ptr /* t1 = ptr */
    sw      t0, 0(t1) /* *ptr = t0 */

    /* ptr++ */
    lw      t0, ptr /* t0 = ptr */
    addi    t0, t0, 4 /* t0 = ptr + 4 */
    sw      t0, ptr, t1 /* t1 poubelle */

    /* struct noeud_t *fd = abr->fd; */
    /* a0 = abr ca n'a pas change */
    lw      t0, 8(a0) /* t0 = abr->fd */
    sw      t0, 4(sp)

    /* free(abr) */
    /* a0 = abr ca n'a pas change */
    jal     free

    /* abr_vers_tab(fd) */
    lw      a0, 4(sp) /* a0 = fd */
    jal     abr_vers_tab
fi:
abr_vers_tab_debut_epilogue:
    lw      ra, 8(sp)
    addi    sp, sp, 12
    ret

    .data
    /* ptr est de taille 32 bits de type uint32_t * */
    .comm ptr, 4

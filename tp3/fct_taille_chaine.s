/*
uint32_t taille_chaine(const char *chaine)
{
    uint32_t taille = 0;
    while (chaine[taille] != '\0') {
        taille++;
    }
    return taille;
}
*/
    .text
    .globl taille_chaine
/* uint32_t taille_chaine(const char *chaine) */
/* DEBUT DU CONTEXTE
fonction :
     taille_chaine  : feuille
contexte :
    chaine          : registre a0
    taille          : registre t0
 */

taille_chaine:
taille_chaine_fin_prologue:
    /* uint32_t taille=0 */
    li      t0, 0
while:
    /* prochain charactere */
    lb      t1, 0(a0)
    beqz    t1, end
    /* taille++ */
    addi    t0, t0, 1
    /* on pointe sur le prochain charactere */
    addi    a0, a0, 1
    j       while
end:
    mv      a0, t0
taille_chaine_debut_epilogue:
    ret

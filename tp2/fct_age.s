/*
uint32_t age(uint32_t annee_naissance)
{
    uint32_t age;
    age = 2022 - annee_naissance;
    return age;
}
*/

    .text
    .globl age
    /* uint32_t age(uint32_t annee_naissance) */
/* DEBUT DU CONTEXTE
    Fonction :
      age : feuille
    Contexte imposé :
      annee_naissance  : registre a0
      uint32_t age     : pile *(sp+0)
*/
age:
/* A compléter */
    /* uint32_t age */
    addi    sp, sp, -4
    /* j'utiliserai le registre t0 pour age */
age_fin_prologue:
    /* age = -annee_naissance */
    sub     t0, zero, a0
    /* age = 2022 - annee_naissance */
    addi    t0, t0, 2022
    sw      t0, 0(sp)
    /* return age */
    lw      a0, 0(sp)
age_debut_epilogue:
    addi    sp, sp, 4
    ret

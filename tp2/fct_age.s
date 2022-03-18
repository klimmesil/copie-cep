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
age_fin_prologue:
age_debut_epilogue:
    ret

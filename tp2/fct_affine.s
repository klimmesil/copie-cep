/*
uint32_t affine(uint32_t a, uint32_t b, uint32_t x)
{
   return mult(x, a) + b;
}
*/

    .text
    .globl affine
    /* uint32_t affine(uint32_t a, uint32_t b, uint32_t x) */
/* DEBUT DU CONTEXTE
fonction :
     affine : non feuille
contexte :
    a       : registre a0; pile *(sp+0)
    b       : registre a1; pile *(sp+4)
    x       : registre a2; pile *(sp+8)
    ra      : pile *(sp+12)
 */
affine:
/* A compléter */
    /* np=0 nv=0 nr=4*/
    addi    sp, sp, -16
    sw      a0, 0(sp)
    sw      a1, 4(sp)
    sw      a2, 8(sp)
    sw      ra, 12(sp)
affine_fin_prologue:
    /* on appelle mult */
    mv      a1, a0 /* on place bien les arguments */
    mv      a0, a2
    jal     mult

    /* on recupere b comme */
    lw      t0, 4(sp)

    /* return mult(x, a) + b */
    add     a0, a0, t0
affine_debut_epilogue:
    lw      ra, 12(sp)
    addi    sp, sp, 16
    ret

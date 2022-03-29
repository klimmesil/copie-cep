/*
bool palin(const char *ch)
{
    uint32_t inf, sup;
    inf = 0;
    sup = strlen(ch) - 1;
    while (inf < sup && ch[inf] == ch[sup]) {
        inf++;
        sup--;
    }
    return inf >= sup;
}
*/
    .text
    .globl palin
    /* bool palin(char *ch) */
/* DEBUT DU CONTEXTE
fonction :
     palin      : non feuille
contexte :
    inf         : pile *(sp+0)
    sup         : pile *(sp+4)
    ch          : registre a0; pile *(sp+8)
    ra          : pile *(sp+12)
 */
palin:
    /* np=0 nv=2 nr=2 */
    addi    sp, sp, -16
    sw      a0, 8(sp)
    sw      ra, 12(sp)
palin_fin_prologue:
    /* inf = 0 */
    sw      zero, 0(sp)
    /* a0 = strlen(ch) */
    jal     strlen
    /* sup = strlen(ch) - 1 */
    addi    t0, a0, -1
    sw      t0, 4(sp)
while:
    /* inf < sup */
    lw      t0, 0(sp) /* inf */
    lw      t1, 4(sp) /* sup */
    slt     t2, t0, t1
    beqz    t2, end
    /* ch[inf] == ch[sup] */
    lw      t0, 0(sp) /* inf */
    lw      t1, 4(sp) /* sup */
    lw      t3, 8(sp)
    add     t0, t0, t3 /* &(char[inf]) */
    lb      t0, 0(t0)
    add     t1, t1, t3 /* &(char[sup]) */
    lb      t1, 0(t1)
    bne     t0, t1, end

    /* inf++ */
    lw      t0, 0(sp)
    addi    t0, t0, 1
    sw      t0, 0(sp)
    /* sup-- */
    lw      t1, 4(sp)
    addi    t1, t1, -1
    sw      t1, 4(sp)

    j       while
end:
    /* reutrn inf >= sup */
    lw      t0, 0(sp) /* inf */
    lw      t1, 4(sp) /* sup */
    addi    t1, t1, -1 /* astuce: inf > sup-1 comme sup >= 0 */
    slt     a0, t1, t0
palin_debut_epilogue:
    lw      ra, 12(sp)
    addi    sp, sp, 16
    ret

#!/bin/bash
QEMU="${RVDIR:=/matieres/3MMCEP/riscv}/bin/qemu-system-riscv32"
QEMU_OPTS="-machine cep -nographic"

exos=$(awk 'match($0,/BINS\s*=\s*(.*)/,a){print a[1]}' Makefile)
for exo in $exos
do
  if [ -s test/$exo.sortie ]
  then
    echo "Analyse de $exo"
    if ! grep 'D[EÉ]BUT DU CONTEXTE' fct_${exo}.s > /dev/null 2>&1 ; then
      echo 'Pas de balise "DEBUT DU CONTEXTE", impossible de vérifier votre contexte'
      exit 1
    fi
    make $exo.stxetd
    if [ -s $exo.stxetd ]; then exit 1; fi
    echo "Vérification rapide de la syntaxe de $exo correcte"
    make $exo
    if [ -f $exo ]
    then 
      echo "La génération de $exo a bien réussi."
    else
      echo "La génération de $exo a échoué."
      exit 1
    fi
    timeout 10 $QEMU $QEMU_OPTS -kernel $exo < test/$exo.entree > $exo.sortie
    if cmp --silent $exo.sortie test/$exo.sortie
    then
      echo "La sortie de $exo est bien identique à test/$exo.sortie."
    else
      echo "La sortie de $exo n'est pas celle décrite dans test/$exo.sortie."
      exit 1
    fi
    echo ""
  fi
done
exit 0

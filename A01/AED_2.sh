#!/bin/bash

declare -a Nmec=(97505 98474 98388) 

declare -a tasks=( $(seq 1 32) )
declare -a programers=( $(seq 1 8) )

gcc -Wall -O2 job_selection.c -o a -lm


for s in ${Nmec[@]}; do

    for t in ${tasks[@]}; do
        for p in ${programers[@]}; do
            if (( $t >= $p )); then
                (./a $s $t $p 0)
            fi
        done
    done

    cd 0$s
    grep "Melhor lucro = " *.txt | sed -e 's/_0.txt:Melhor lucro =//' -e 's/_/ /' >lucro_$s
    grep "Solution time = " *.txt | sed -e 's/_0.txt:Solution time =//' -e 's/_/ /' >STime_$s
    grep "Máximo de tasks feitas  =" *.txt | sed -e 's/_0.txt:Máximo de tasks feitas  =//' -e 's/_/ /' >MaxT_$s
    grep "Dinheiro recebido por cada programador =" *.txt | sed -e 's/_0.txt:Dinheiro recebido por cada programador =//' -e 's/_/ /' >LP_$s
    cd ..
done
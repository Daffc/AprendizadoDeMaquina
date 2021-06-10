#!/usr/bin/env bash


#Gerando Vetores de Características:
#   Caso Base X = 20, Y = 10
#   Variar em 5 para Cada uma das dimenções, mantendo a outra estática.

INI=1000
FIM=20000
OUTPUT="saidas"

for SIZE in $(seq $INI 4000 $FIM); do 
    echo $SIZE 
    ./scripts/knn.py dados/train.txt dados/test.txt $SIZE &
    ./scripts/knn.py dados/train.txt dados/test.txt $(($SIZE+1000)) &
    ./scripts/knn.py dados/train.txt dados/test.txt $(($SIZE+2000)) &
    ./scripts/knn.py dados/train.txt dados/test.txt $(($SIZE+3000)) 
    wait
done;
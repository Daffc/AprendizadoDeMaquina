#!/usr/bin/env bash


#Gerando Vetores de Características:
#   Caso Base X = 20, Y = 10
#   Variar em 5 para Cada uma das dimenções, mantendo a outra estática.

MIN=1
MAX=32
OUTPUT="saidas"

if ! [ -d "$OUTPUT" ]; then
    mkdir saidas;
fi

if ! [ -d "$OUTPUT/features" ]; then
    mkdir saidas;
fi

if ! [ -d "$OUTPUT/knn" ]; then
    mkdir saidas/knn;
fi

echo --------------------------------;
echo ----------Vetor De Variaveis -------------;
echo --------------------------------;

for X in $(seq $MIN $MAX); do 
    for Y in $(seq $MIN 4 $MAX); do 
        ./digits.py $X $Y &
        ./digits.py $X $(($Y+1)) &
        ./digits.py $X $(($Y+2)) &
        ./digits.py $X $(($Y+3)) 
    done;
    wait
done;

echo --------------------------------;
echo ---------- Movendo -------------;
echo --------------------------------;


mv features_* saidas/features/


echo --------------------------------;
echo ---------- KNN -------------;
echo --------------------------------;
for X in $(seq $MIN $MAX); do 
    for Y in $(seq $MIN 4 $MAX); do 
        echo $X $Y;
	    { time ./knn.py saidas/features/features_$X-$Y.txt 3 > saidas/knn/knn_output_$X-$Y.txt ;} 2>> saidas/knn/knn_output_$X-$Y.txt &
        { time ./knn.py saidas/features/features_$X-$(($Y+1)).txt 3 > saidas/knn/knn_output_$X-$(($Y+1)).txt ;} 2>> saidas/knn/knn_output_$X-$(($Y+1)).txt &   
        { time ./knn.py saidas/features/features_$X-$(($Y+2)).txt 3 > saidas/knn/knn_output_$X-$(($Y+2)).txt ;} 2>> saidas/knn/knn_output_$X-$(($Y+2)).txt &  
        { time ./knn.py saidas/features/features_$X-$(($Y+3)).txt 3 > saidas/knn/knn_output_$X-$(($Y+3)).txt ;} 2>> saidas/knn/knn_output_$X-$(($Y+3)).txt 
    done;
    wait
done;

wait


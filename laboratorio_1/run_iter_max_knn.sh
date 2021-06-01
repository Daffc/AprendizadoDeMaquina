#!/usr/bin/env bash

# Variando quantidade de visinhos para dimensões XY melhor classificadoras (X=20, Y=25)

X=20
Y=25
MINK=1
MAXK=512
OUTPUT="saidas"

if ! [ -d "$OUTPUT" ]; then
    mkdir saidas;
fi

if ! [ -d "$OUTPUT/knn_max_$X-$Y" ]; then
    mkdir saidas/knn_max_$X-$Y;
fi

for K in $(seq $MINK 4 $MAXK); do 
    echo $K;
        { time ./knn.py saidas/features/features_$X-$Y.txt $(($K+0)) > saidas/knn_max_$X-$Y/knn_max_$(($K+0)).txt ;} 2>> saidas/knn_max_$X-$Y/knn_max_$(($K+0)).txt &
        { time ./knn.py saidas/features/features_$X-$Y.txt $(($K+1)) > saidas/knn_max_$X-$Y/knn_max_$(($K+1)).txt ;} 2>> saidas/knn_max_$X-$Y/knn_max_$(($K+1)).txt &   
        { time ./knn.py saidas/features/features_$X-$Y.txt $(($K+2)) > saidas/knn_max_$X-$Y/knn_max_$(($K+2)).txt ;} 2>> saidas/knn_max_$X-$Y/knn_max_$(($K+2)).txt &  
        { time ./knn.py saidas/features/features_$X-$Y.txt $(($K+3)) > saidas/knn_max_$X-$Y/knn_max_$(($K+3)).txt ;} 2>> saidas/knn_max_$X-$Y/knn_max_$(($K+3)).txt 
    wait
done;

wait


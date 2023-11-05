#!/bin/bash

cd example_ago_miRNA
echo "Predicting structure of AGO-miRNA complex"
echo "Running command: ../../run_RF2NA.sh pred P:AGO2_human.fa R:miRNA.fa"
../../run_RF2NA.sh pred P:AGO2_human.fa R:miRNA.fa

for i in {0..299}
do
    echo "Running cd ../example_pos_$i" 
    cd ../example_pos_$i
    echo "Predicting structure of $i-th positive mRNA bidning site"
    echo "Running command: ../../run_RF2NA.sh pred R:gene.fa"
    ../../run_RF2NA.sh pred R:gene.fa
    
    echo "Running cd ../example_neg_$i" 
    cd ../example_neg_$i
    echo "Predicting structure of $i-th negative mRNA bidning site"
    echo "Running command: ../../run_RF2NA.sh pred R:gene.fa"
    ../../run_RF2NA.sh pred R:gene.fa
done

cd ..
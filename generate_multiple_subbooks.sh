#!/bin/bash

## declare filenames
declare -a filenames=(
    "building_a_generalised_simulator/chapter" \
    "probabilistic_learning_algorithms/chapter" \
    "probabilistic_learning_software/chapter" \
    "generalised_simulation_inference/chapter" \
    "optimising_interactions_with_any_system/chapter" \
    "controlling_parasitic_infections/chapter" \
    "algo_trading_on_financial_markets/chapter" \
    "sustainable_angling_for_fish/chapter" \
    "managing_a_rugby_match/chapter" \
    "optimising_relief_chain_logistics/chapter"
)

## loop through filenames
counter=0
for filename in "${filenames[@]}"
do
   rm $filename.pdf
   rm $filename.xdv
   rm $filename.bbl
   rm $filename.blg
   rm $filename.log
   rm $filename.out
   rm $filename.aux
   rm $filename.fdb_latexmk
   rm $filename.fls
   rm $filename.synctex.gz
   export CHAPTER_NUMBER=$counter
   export CHAPTER_TO_COMPILE=$filename
   latexmk -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -jobname="$filename" subbook.tex
   read -p "Compiled $filename as chapter $((counter+1)). Press Enter to resume ..."
   counter=$((counter+1))
done
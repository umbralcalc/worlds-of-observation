#!/bin/bash

## declare filenames
declare -a filenames=(
    "building_a_generalised_simulator/chapter" \
    "numerical_time_evolution_of_probabilities/chapter" \
    "empirical_probabilistic_reweighting_algorithms/chapter" \
    "generalised_simulation_inference/chapter" \
    "interacting_with_any_system/chapter" \
    "optimising_actions_for_control_objectives/chapter" \
    "controlling_parasitic_infections/chapter" \
    "algo_trading_on_financial_markets/chapter" \
    "sequential_experiment_design/chapter" \
    "angling_for_freshwater_fish/chapter" \
    "managing_a_rugby_match/chapter" \
    "optimising_humanitarian_aid_logistics/chapter"
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
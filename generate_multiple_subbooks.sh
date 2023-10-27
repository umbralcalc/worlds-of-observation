#!/bin/bash

## declare filenames
declare -a filenames=(
    "building_a_generalised_simulator/chapter" \
    "numerical_time_evolution_of_probabilities/chapter" \
    "empirical_probabilistic_reweighting_algorithms/chapter" \
    "generalised_simulation_inference/chapter" \
    "interacting_with_any_system/chapter" \
    "optimising_actions_for_control_objectives/chapter" \
    "influencing_house_prices/chapter" \
    "resource_allocation_for_epidemics/chapter" \
    "algo_trading_on_financial_markets/chapter" \
    "sequential_experimental_design/chapter" \
    "angling_for_freshwater_fish/chapter" \
    "managing_a_rugby_match/chapter" \
    "real_time_optimisation_of_supply_chain_logistics/chapter" \
    "stimulating_brain_network_responses/chapter" \
    "inferring_2d_spatial_dynamics/chapter" \
    "a_world_of_hydrodynamic_ensembles/chapter" \
    "quantum_system_control/chapter"
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
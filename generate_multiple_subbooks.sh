#!/bin/bash

## declare filenames
declare -a filenames=(
    "building_a_generalised_simulator/chapter" \
    "simulating_a_financial_market/chapter" \
    "quantum_jumps_on_generic_networks/chapter" \
    "empirical_probabilistic_filtering/chapter" \
    "generalised_map_inference/chapter" \
    "inferring_2d_spatial_dynamics/chapter" \
    "learning_from_ants_on_curved_surfaces/chapter" \
    "a_world_of_hydrodynamic_ensembles/chapter" \
    "interacting_with_systems_in_general/chapter" \
    "angling_for_freshwater_fish/chapter" \
    "managing_a_rugby_match/chapter" \
    "influencing_house_prices/chapter" \
    "optimising_actions_for_control_objectives/chapter" \
    "resource_allocation_for_epidemics/chapter" \
    "quantum_system_control/chapter"
)

## declare chapter frontpage sizes
declare -a frontpagesizes=(
    "7cm" \
    "7cm" \
    "7cm" \
    "7cm" \
    "5cm" \
    "7cm" \
    "7cm" \
    "7cm" \
    "7cm" \
    "7cm" \
    "7cm" \
    "7cm" \
    "7cm" \
    "7cm" \
    "7cm"
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
   export CHAPTER_FRONTPAGE="images/page-design-$((counter+1)).png"
   export CHAPTER_FRONTPAGE_SIZE=${frontpagesizes[$counter]}
   latexmk -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -jobname="$filename" subbook.tex
   read -p "Compiled $filename as chapter $((counter+1)). Press Enter to resume ..."
   counter=$((counter+1))
done
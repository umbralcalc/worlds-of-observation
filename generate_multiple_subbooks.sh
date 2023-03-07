#!/bin/bash

## declare filenames
declare -a filenames=(
    "building_a_generalised_simulator/chapter" \
    "simulating_a_financial_market/chapter" \
    "quantum_jumps_on_generic_networks/chapter" \
    "empirical_dynamical_emulators/chapter" \
    "inferring_dynamical_2d_maps/chapter" \
    "learning_from_ants_on_curved_surfaces/chapter" \
    "a_world_of_hydrodynamic_ensembles/chapter" \
    "generalised_statistical_inference_tools/chapter" \
    "interacting_with_systems_in_general/chapter" \
    "angling_for_freshwater_fish/chapter" \
    "managing_a_rugby_match/chapter" \
    "influencing_house_prices/chapter" \
    "optimising_actions_for_control_objectives/chapter" \
    "resource_allocation_for_epidemics/chapter" \
    "quantum_system_control/chapter"
)

## loop through filenames
counter=0
for filename in "${filenames[@]}"
do
   export CHAPTER_NUMBER=$counter
   export CHAPTER_TO_COMPILE=$filename
   latexmk -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -jobname="$filename" subbook.tex
   counter=$((counter+1))
done
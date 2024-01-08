#!/bin/bash

## declare filenames
declare -a filenames=(
    "building_a_generalised_simulator/chapter" \
    "probabilistic_learning_methods/chapter" \
    "probabilistic_online_learning_software/chapter" \
    "online_simulation_inference/chapter" \
    "optimising_system_interactions/chapter" \
    "simple_state_transitions/chapter" \
    "spatial_density_fields/chapter" \
    "distributed_state_networks/chapter" \
    "multi_stage_pipelines/chapter" \
    "centralised_exchanges/chapter"
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
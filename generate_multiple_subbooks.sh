#!/bin/bash

## declare filenames
declare -a filenames=(
    "generalising_simulation_engines/chapter" \
    "online_simulation_inference/chapter" \
    "optimising_system_interactions/chapter" \
    "environment_archetypes/chapter"
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
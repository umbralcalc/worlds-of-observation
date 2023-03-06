#!/bin/bash

## declare filenames
declare -a filenames=(
    "building_a_generalised_simulator/chapter" \
    "angling_for_freshwater_fish/chapter" \
    "managing_a_rugby_match/chapter"
)

## loop through filenames
for filename in "${filenames[@]}"
do
   sed -i "122s/.*/\input{${filename}/chapter.tex}/" subbook.tex
   latexmk -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -jobname="$filename" subbook.tex
done

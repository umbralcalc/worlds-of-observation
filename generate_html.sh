#!/bin/bash
pandoc book.tex \
-f latex \
-t html \
-s \
--mathjax="https://polyfill.io/v3/polyfill.min.js?features=es6" \
--template template \
-o index.html \
--csl ieee.csl \
--bibliography book.bib

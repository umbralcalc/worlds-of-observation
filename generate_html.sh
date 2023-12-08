#!/bin/bash

# generate home page
pandoc --template template.html \
--mathjax \
-f markdown \
-t html \
-o index.html \
README.md;
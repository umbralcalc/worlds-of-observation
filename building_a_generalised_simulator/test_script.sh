#!/bin/bash
pandoc chapter.tex \
-o chapter.md \
-f latex \
-t markdown \
-s \
--bibliography ../book.bib

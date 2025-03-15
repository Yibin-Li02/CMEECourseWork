#!/bin/bash

# 1. Run data preparation script
Rscript Miniproject.R

# 2. Run model fitting script
ipython3 Miniproject.py


# 3. Run Latex compilation script
chmod +x latex.sh
./latex.sh Miniproject.tex

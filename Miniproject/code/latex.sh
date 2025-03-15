#!/bin/bash

# Define output directory
OUTPUT_DIR="../results"
PDF_NAME="Miniproject.pdf"  # Change this to the desired PDF name



# Compile LaTeX document to PDF with shell escape for texcount
pdflatex -shell-escape Miniproject.tex

# Run BibTeX for citations
bibtex Miniproject

# Run pdflatex twice more to resolve references
pdflatex -shell-escape Miniproject.tex
pdflatex -shell-escape Miniproject.tex

# Move the output PDF to the output directory
mv Miniproject.pdf $OUTPUT_DIR/$PDF_NAME

# Clean auxiliary files
rm *.aux
rm *.log
rm *.bbl
rm *.blg
rm *.out
rm *.txt

echo "Compilation completed. Check $OUTPUT_DIR/$PDF_NAME for the final PDF."



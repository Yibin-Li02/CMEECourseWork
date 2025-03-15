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

# Get the word count without saving to file
WORDCOUNT=$(texcount -sum -inc -0 Miniproject.tex | awk '{print $1}')

# Pass the word count as an environment variable to LaTeX
pdflatex -shell-escape "\def\wordcountnumber{$WORDCOUNT} \input{Miniproject.tex}"

# Move the output PDF to the output directory
mv Miniproject.pdf $OUTPUT_DIR/$PDF_NAME

# Clean auxiliary files
rm *.aux
rm *.log
rm *.bbl
rm *.blg
rm *.out

echo "Word Count: $WORDCOUNT"
echo "Compilation completed. Check $OUTPUT_DIR/$PDF_NAME for the final PDF."


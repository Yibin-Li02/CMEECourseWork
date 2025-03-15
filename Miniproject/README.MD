# Miniproject

## Overview

This repository contains a mini-project focused on modeling logistic growth using R and Python. The project includes data analysis, simulations, and a LaTeX report documenting the findings.

*Author: Yibin.Li ([Yibin.Li24\@imperial.ac.uk](mailto:Yibin.Li24@imperial.ac.uk))*

*Created: 03/2025*

## Directory Structure

```         
Miniproject/
│── code/                # Contains scripts and LaTeX report
│── results/             # Placeholder for analysis results
│── data/                # Contains datasets
│── sandbox/             # Temporary workspace
```

### **Files and Their Purpose**

-   **code/**
    -   `Miniproject.R`: Main R script for data analysis and modeling
    -   `Miniproject.py`: Python script (alternative or supplementary analysis)
    -   `Miniproject.tex`: LaTeX source file for the project report
    -   `reference.bib`: Bibliographic references for the LaTeX report
    -   `run.Miniproject.sh`: Shell script to execute the project workflow
    -   `latex.sh`: Shell script to compile the LaTeX report
    -   `wordcount.txt`: Word count statistics for the report
-   **data/**
    -   `LogisticGrowthData.csv`: Dataset containing logistic growth data
    -   `LogisticGrowthMetaData.csv`: Metadata for the dataset
-   **results/**
    -   `.gitkeep`: Placeholder file, suggesting that analysis results should be stored here
-   **sandbox/**
    -   `.gitkeep`: Placeholder for temporary work

## Requirements

To run this project, ensure you have the following dependencies installed:

### **R Requirements**

-   R (version 4.0+ recommended)

-   Required R packages (install using `install.packages()`, if necessary):

    ``` r
    install.packages(c("ggplot2", "dplyr", "tidyverse"))
    ```

### **Python Requirements**

-   Python 3.8+

-   Required Python packages (install using `pip`):

    ``` sh
    pip install numpy pandas matplotlib scipy lmfit statsmodels
    ```

    -   **numpy** - For numerical computations
    -   **pandas** - For data manipulation and analysis
    -   **matplotlib** - For data visualization
    -   **scipy** - For statistical functions and probability distributions
    -   **lmfit** - For curve fitting and optimization
    -   **statsmodels** - For statistical modeling and econometric analysis

### **LaTeX Requirements**

-   A LaTeX distribution (e.g., TeX Live, MiKTeX)
-   `pdflatex` and `bibtex` for compiling the report

## How to Run

### **1. Run the Project Workflow**

Execute the `run.Miniproject.sh` script to run the entire analysis workflow, including R and Python scripts:

``` sh
bash run.Miniproject.sh
```

This script automates the execution of the R and Python scripts, processing the logistic growth data and generating analysis results.

### **2. Compile the LaTeX Report**

Use the provided `latex.sh` script to compile the LaTeX report:

``` sh
bash latex.sh
```

This script runs `pdflatex` and `bibtex` to compile the `Miniproject.tex` file into a final PDF report, ensuring all references are properly formatted.

## Notes

-   The `results/` directory will contain generated outputs.
-   The `sandbox/` directory is for temporary or intermediate files.

## Contact

For any questions or clarifications, please contact the project author.

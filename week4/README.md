# CMEE Coursework: Week 4

*Author: Yibin.Li ([Yibin.Li24\@imperial.ac.uk](mailto:Yibin.Li24@imperial.ac.uk))*\
*Created: 10/2024*



## Table of Contents

1.  [Introduction](#introduction)

2.  [Language and Dependency](#language-and-dependency)

3.  [Description of Code Files](#description-of-code-files)

4.  [Data](#data)

5.  [Results](#results)

6.  [Sandbox](#sandbox)



## Introduction

This coursework contains several R scripts and data files that demonstrate various data analysis and visualization tasks.

In order to keep the `results` empty, put the **Florida.pdf** to the `code` directory.

When running the **Florida.tex**, first running the **Florida.R**, then use the following command to specify the output location of the result file:

``` bash
pdflatex -output-directory=../results Florida.tex
```



## Language and Dependency

-   **R**: The scripts are written in the R programming language.
-   **Dependency**: To run the R scripts, an R environment (version 4.0 or higher) is required with the following packages installed:
    -   `ggplot2` for data visualization
    -   `dplyr` for data manipulation
    -   `tidyr` for data tidying
    -   `readr` for reading data files
    -   `purrr` for functional programming tasks
    -   `tibble` for enhanced data frames
    -   `magrittr` for piping operations



## Description of Code Files

The `code` directory includes several R scripts that perform various tasks for Week 4:

-   **Florida.R**: Analyzes temperature data from Key West, Florida, and produces visualizations and a LaTeX report.

-   **PP_Regress.R**: Performs regression analysis on predator-prey data from the provided dataset.

-   **TreeHeight.R**: Calculates tree heights based on trigonometric formulas using data from the `trees.csv` file.

-   **Florida.tex**: LaTeX file that contains the report generated from the analysis in `Florida.R`.

-   **Florida.pdf**: PDF report generated from `Florida.tex` summarizing the findings of the temperature analysis.



## Data

The `data` directory contains the following files:

-   **EcolArchives-E089-51-D1.csv**: A dataset containing ecological data used for predator-prey regression analysis.
-   **KeyWestAnnualMeanTemperature.RData**: An R data file containing annual mean temperature data from Key West, used in `Florida.R` for analysis.
-   **trees.csv**: A CSV file containing data on various tree species, including measurements used in `TreeHeight.R`.



## Results

The `results` directory contains the outputs generated by the scripts after processing the data.

The `results` is now empty.



## Sandbox

The `sandbox` directory contains test files and experimentation scripts.

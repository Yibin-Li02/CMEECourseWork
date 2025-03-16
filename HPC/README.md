# CMEE 2024 HPC Project

## Overview

This project is part of the CMEE 2024 HPC exercises and focuses on running demographic and neutral models using high-performance computing (HPC). The project includes R scripts for modeling population dynamics, `.rda` files for processed results, and shell scripts for executing them on an HPC cluster.

*Author: Yibin.Li ([Yibin.Li24\@imperial.ac.uk](mailto:Yibin.Li24@imperial.ac.uk))*

*Created: 03/2025*

## Project Objectives

-   **Demographic Modeling:** Implement deterministic and stochastic population models.
-   **Neutral Simulations:** Run neutral models to assess species abundance distributions.
-   **HPC Execution:** Optimize computations using parallel cluster jobs.

## Directory Structure

```         
code/
│── Demographic.R                          # Implements demographic models
│── yl2524_HPC_2024_demographic_cluster.R  # Runs demographic models on HPC
│── yl2524_HPC_2024_main.R                 # Main script with user settings
│── yl2524_HPC_2024_neutral_cluster.R      # Runs neutral model on HPC
│── run_demographic_cluster.sh             # Submits demographic jobs to HPC
│── run_neutral_cluster.sh                 # Submits neutral model jobs to HPC
│── Demographic_o_e_files/                 # Logs for demographic cluster jobs
│── Neutral_o_e_files/                     # Logs for neutral cluster jobs
│── challenge_A_data.rda                   # Data file for Challenge A
│── challenge_B_results.rda                # Results from Challenge B
│── challenge_C_results.rda                # Results from Challenge C
│── challenge_D_results.rda                # Results from Challenge D
│── Challenge_E_results.rda                # Results from Challenge E
│── demographic_cluster_*.rda              # Results from demographic model runs
│── neutral_cluster_output_*.rda           # Results from neutral model simulations
│── processed_neutral_results.rda          # Final processed results from neutral simulations
```

### **Files and Their Purpose**

-   **Demographic.R**
    -   Implements stochastic and deterministic demographic models.
    -   Defines functions for running simulations and calculating population dynamics.
-   **yl2524_HPC_2024_demographic_cluster.R**
    -   Executes the demographic model on an HPC cluster.
    -   Reads job indices from the cluster environment.
-   **yl2524_HPC_2024_main.R**
    -   Stores user details and provides essential functions.
    -   Can be sourced by other scripts to maintain consistency.
-   **yl2524_HPC_2024_neutral_cluster.R**
    -   Executes neutral model simulations on the cluster.
    -   Sources `yl2524_HPC_2024_main.R` for shared functions.
-   **Challenge Data and Results (`.rda` files)**
    -   `challenge_a_results.rda` to `challenge_E_results.rda` - The .rda files make sure run the Challenge questions function quickly (\<1 min).
    -   `demographic_cluster_*.rda` - Contains multiple demographic model run outputs.
    -   `neutral_cluster_output_*.rda` - Outputs from neutral model simulations.
    -   `processed_neutral_results.rda` - Final compiled results for neutral model analysis.
-   **run_demographic_cluster.sh**
    -   Submits the demographic model job to an HPC cluster.
    -   Requests **5 minutes runtime**, **1 CPU**, and **1GB RAM**.
-   **run_neutral_cluster.sh**
    -   Submits the neutral model job to an HPC cluster.
    -   Requests **12 hours runtime**, **1 CPU**, and **4GB RAM**.

## Requirements

### **R Dependencies**

-   **R (version 4.0+ recommended)**

-   **Required R packages:**

    ``` r
    install.packages(c("ggplot2"))
    ```

    -   Additional dependencies might be required based on external functions.
    -   Run `sessionInfo()` in R to confirm all installed packages.

### **HPC Environment**

-   Requires a job scheduling system (e.g., SLURM, PBS).
-   Environment variables such as `PBS_ARRAY_INDEX` should be accessible.

## How to Run

### **1. Submit Demographic Model Jobs to the Cluster**

Execute the script to submit jobs:

``` sh
qusb -J 1-100 run_demographic_cluster.sh
```

This will queue multiple demographic model runs.

### **2. Submit Neutral Model Jobs to the Cluster**

``` sh
qusb -J 1-100  run_neutral_cluster.sh
```

This will start neutral model simulations on the cluster.

### **3. Analyze Results**

-   Once the jobs are completed, use the generated logs to analyze population dynamics and species distributions.

## Contact

For any questions or clarifications, please contact the project author.

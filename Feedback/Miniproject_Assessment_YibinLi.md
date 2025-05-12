# Miniproject Feedback and Assessment

## Report

**"Guidelines" below refers to the MQB report [MQB Miniproject report guidelines](https://mulquabio.github.io/MQB/notebooks/Appendix-MiniProj.html#the-report) [here](https://mulquabio.github.io/MQB/notebooks/Appendix-MiniProj.html) (which were provided to the students in advance).**

**Title:** “Assessment of Mechanistic and Phenomenological Models for Bacterial Growth”

- **Introduction (15%)**  
  - **Score:** 12/15  
  - Broad coverage of logistic, Gompertz, Baranyi, polynomials. A clearer research gap or question would help.

- **Methods (15%)**  
  - **Score:** 11/15  
  - 275 subsets, repeated NLS. Baranyi has partial coverage. Not detailing param bounds or iteration. [MQB Miniproject report guidelines](https://mulquabio.github.io/MQB/notebooks/Appendix-MiniProj.html#the-report) prefer thorough reproducibility detail.

- **Results (20%)**  
  - **Score:** 15/20  
  - Convergence rates show Baranyi fails often; Gompertz is strong. Table 1 offers numeric detail, but referencing more model “wins” or how many times each was best would help.

- **Tables/Figures (10%)**  
  - **Score:** 7/10  
  - Table 1 is not fully embedded in text. The [MQB Miniproject report guidelines](https://mulquabio.github.io/MQB/notebooks/Appendix-MiniProj.html#the-report) suggest more explicit commentary on the table.

- **Discussion (20%)**  
  - **Score:** 15/20  
  - Argues polynomials handle incomplete data well, while mechanistic is more interpretable. More reflection on sample-size constraints or expansions recommended.

- **Style/Structure (20%)**  
  - **Score:** 14/20  
  - Mostly coherent flow. Cross-referencing results in the discussion more explicitly would align better with [MQB Miniproject report guidelines](https://mulquabio.github.io/MQB/notebooks/Appendix-MiniProj.html#the-report).

**Report Score:** 74  
**Summary:** Demonstrates a thorough multi-model approach, especially including Baranyi. More explicit numeric breakdown of best-fitting models plus deeper referencing of results/figures would help.

---


## Computing

### Project Structure & Workflow

**Strengths**

* **Clear directory conventions**: The `README.MD` documents `code/`, `data/`, `results/`, and `sandbox/` folders, giving users an immediate sense of where to place and find files .
* **Unified orchestration script**: `run_MiniProject.sh` chains Python and R steps, plus LaTeX compilation, into a single command, facilitating reproducible end‑to‑end runs .
* **Language-appropriate tools**: Data wrangling is handled in Python (`DataPrep.py`), statistical tidying in R (`DataPrep.R`), model fitting in R (`ModelFitting.R`), and plotting in R (`Plotting.R`), leveraging each ecosystem’s strengths.

**Suggestions**

1. **Directory Layout Enforcement**:

   * Move scripts into `code/` (e.g. `code/DataPrep.py`, `code/DataPrep.R`) and datasets into `data/`. Ensure `run_MiniProject.sh` references these paths (e.g. `python3 code/DataPrep.py`).
   * Use `results/` for all outputs and ensure clear separation between raw (`data/`) and processed (`results/`) files.
2. **Environment Management**:

   * **Python**: Provide a `requirements.txt` and wrap installation in `run_MiniProject.sh`:

     ```bash
     python3 -m venv venv && source venv/bin/activate
     pip install -r requirements.txt
     ```
   * **R**: Initialize **renv** in `code/` so collaborators can run `Rscript -e "renv::restore()"` before `DataPrep.R`.
3. **Shell Script Robustness**:

   * Switch to a portable shebang: `#!/usr/bin/env bash` and add `set -euo pipefail` to detect errors early.
   * Prepend `cd "$(dirname "$0")"` so the script executes relative to its own location regardless of the working directory.
   * Redirect all output to a timestamped log in `results/`, e.g.: `bash run_MiniProject.sh 2>&1 | tee results/pipeline_$(date +"%Y%m%d_%H%M%S").log`.

---

### README File

**Strengths**

* **Concise overview**: Author/date, project goal, and directory structure are clearly stated .
* **Dependency lists**: R and Python package requirements are enumerated, alerting users to install necessary libraries.

**Suggestions**

1. **Installation Instructions**:

   * Replace free-form `install.packages()` and `pip install` commands with references to lockfiles (`renv.lock`, `requirements.txt`).
   * Provide a step-by-step section:

     ```bash
     git clone <repo>
     cd Miniproject/code
     # Python environment
     python3 -m venv venv && source venv/bin/activate
     pip install -r ../requirements.txt
     # R environment
     Rscript -e "renv::restore()"
     # Run full pipeline
     bash run_MiniProject.sh
     ```
2. **Directory Map**:

   * Show a tree diagram under “Directory Structure” highlighting where data, code, and results live.
3. **Script Descriptions**:

   * Under **code/**, list each script’s inputs and outputs:

     * `DataPrep.py` → reads `LogisticGrowthData.csv`, writes `GrowthDataID.csv`.
     * `DataPrep.R` → reads `GrowthDataID.csv`, writes `GrowthDataTidy.csv`.
     * …and so on.
4. **License & Contact**:

   * Add a `LICENSE` file (e.g. MIT) and a “Data” section citing `LogisticGrowthData.csv` provenance.

---

### Code   Structure & Syntax

####  DataPrep.py (Python wrangling)

**Strengths**

* Uses **pandas** for efficient CSV operations and unit inspection .
* Generates a composite `ID` and reindexes it to integers for downstream splits.

**Suggestions**

1. **Path Handling**: Replace hard-coded `"../data/..."` with `pathlib.Path(__file__).resolve().parent.parent / 'data' / 'LogisticGrowthData.csv'` for cross-platform portability.
2. **Vectorized ID Assignment**: Instead of nested Python loops, use:

   ```python
   df['ID'] = pd.Categorical(
     df['Species'] + '_' + df['Temp'].astype(str) + '_' + df['Medium'] + '_' + df['Citation']
   ).codes
   ```
3. **Script Encapsulation**: Wrap logic in `main()` and guard with `if __name__ == '__main__':` to allow imports and unit testing.
4. **Logging**: Use Python’s `logging` module rather than `print()`, enabling configurable verbosity and structured logs.

####  DataPrep.R (R tidying)

**Strengths**

* Straightforward filtering of negative times and PopBio values; creation of `LogPopBio` column .

**Suggestions**

1. **Path Robustness**: Use `here::here('data', 'GrowthDataID.csv')` for I/O, avoiding relative paths that can break if cwd changes.
2. **Pipeline Encapsulation**: Wrap sequential steps into functions (`clean_data()`, `filter_ids()`) and invoke them in a main guard to reduce side effects and improve testability.
3. **ID Reordering Simplification**: After filtering small groups, regenerate IDs via:

   ```r
   data <- data %>% mutate(ID = dense_rank(ID) - 1)
   ```
4. **Progress Reporting**: Use `message()` or `cli::cli_alert()` to report counts of dropped rows and IDs, aiding transparency.

####  ModelFitting.R (NLLS fitting)

**Strengths**

* Implements four candidate models—quadratic, cubic via `lm()`, logistic, Gompertz via `nlsLM()`—and computes AICc and R² .
* Employs multi-start sampling for logistic and Gompertz to mitigate local minima issues.

**Suggestions**

1. **Generic Fit Function**: Abstract model fits into a helper:

   ```r
   fit_model <- function(data, formula, start, lower, upper) {
     nlsLM(formula, data, start = start, lower = lower, upper = upper)
   }
   ```
2. **Leverage nls.multstart**: Replace manual `for(j in 1:100)` loops with `nls.multstart::nls_multstart()`, specifying `iter = 50` and bounds to handle multi-start and convergence internally.
3. **Seed Management**: Call `set.seed()` once outside loops to ensure reproducible starting draws.
4. **Error Logging**: Capture both errors and warnings via `tryCatch()`, storing messages in a data frame rather than silently omitting failed fits.
5. **Vectorize across IDs**: Use `purrr::map_df(data_by_ID, ~ process_id(.x))` to cleanly accumulate results, rather than manual index loops and preallocated data frames.

#### Plotting.R

**Strengths**

* Dynamically reconstructs model predictions over a fine time grid for each ID and saves individual PNGs .
* Generates a composite panel plot of top-performing IDs by AICc.

**Suggestions**

1.  Switch to `ggplot2` for layered plotting, faceting, and theme consistency. E.g:

   ```r
   df_pred %>% ggplot(aes(Time, LogPopBio)) +
     geom_point() +
     geom_line(aes(y = quad_pred), color='black') + ... +
     facet_wrap(~ Model)
   ```
2. Merge `data` and `all_data` into a long-format tibble before plotting, enabling a single `ggplot2` call rather than custom loops.
3. Define a named color palette once (`palette <- c(quadratic='black', cubic='blue', ...)`) and apply via `scale_color_manual()` for coherence across plots.
4. Use `fs::dir_create()` to ensure `results/` exists and `purrr::walk()` to iterate plot functions, reducing boilerplate loops.
5. Use `patchwork` or `cowplot` to assemble multiple panels and collect legends centrally, rather than manual `par(mfrow=...)` and `legend()` hacks.

---

### NLLS Fitting Approach

**Strengths**

* Quadratic, cubic, logistic, and Gompertz models cover empirical and mechanistic approaches.
* Randomization of `r_start` improves convergence across heterogeneous datasets.
* In-sample R² and AICc provide a balanced metric set for model selection.

**Suggestions**

1. `nls.multstart` would simplify multi-start logistics and bound enforcement, capturing convergence flags, residual SD, and parameter CIs automatically.
2. Set biologically informed `lower`/`upper` for all parameters (e.g. `r >= 0`, `K >= N0`), and alert when solutions lie at bounds.
3. Implement time-series Cross-Validation (e.g. leave-last-point-out) to evaluate predictive performance beyond training fit metrics.
4. Compute Akaike weights to quantify relative support and visualize distributions across IDs.
5. Aggregate and export convergence statuses, error messages, and fit durations per ID for systematic audit.

---

## 5. Summary

Your pipeline thoughtfully combines Python and R, with clear separation of wrangling, modeling, and plotting. To elevate it further:

* **Standardize environments** via lockfiles (`requirements.txt`, `renv`) and enforce them in `run_MiniProject.sh`.
* **Modularize** repetitive code into well‑named functions or shared utility libraries to enhance readability and testability.
* **Adopt specialized libraries** (`nls.multstart`, `purrr`, `ggplot2`, `patchwork`) to streamline multi-start fitting, data iteration, and visualization.
* **Implement structured logging** of both successes and failures across all pipeline stages.

## **Score: 75**

---

## Overall Score: (74 + 75)/2 = 74.5
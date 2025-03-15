import time
start_time = time.time()
import os
import pandas as pd
import numpy as np
from lmfit import Model
import matplotlib.pyplot as plt
from scipy.stats import norm
from statsmodels.regression.rolling import RollingOLS
import statsmodels.api as sm

# ---------------------------
# SET DIRECTORIES
# ---------------------------
# Assuming that both the read file and output files are in the "result" folder relative to the "code" folder.
input_dir = os.path.join("../results")
output_dir = os.path.join("../results")

# ---------------------------
# 1. READ AND FILTER DATA
# ---------------------------
data = pd.read_csv(os.path.join(input_dir, "Cleaned_GrowthData.csv"))
unique_ids = data["subset_id"].unique()

# Filter out subsets with <= 5 data points
filtered_data = data.groupby("subset_id").filter(lambda x: len(x) > 5)
total_filtered_subsets = filtered_data["subset_id"].nunique()

# ---------------------------
# 2. HELPER FUNCTIONS
# ---------------------------
def calculate_rmax(sub, window_size=5):
    """Estimate rmax using rolling OLS on log-transformed popbio."""
    sub["log_pop"] = np.log(sub["popbio"])
    if len(sub) < window_size:
        return 0.1
    X = sm.add_constant(sub["time"])
    rolling_ols = RollingOLS(sub["log_pop"], X, window=window_size).fit()
    growth_rates = rolling_ols.params["time"]
    return np.nanmax(growth_rates) if np.isfinite(np.nanmax(growth_rates)) else 0.1

# Growth models
def quadratic_model(t, a, b, c):
    return a + b*t + c*t**2

def cubic_model(t, a, b, c, d):
    return a + b*t + c*t**2 + d*t**3

def logistic_model(t, N0, K, rmax):
    return (N0 * K * np.exp(rmax * t)) / (K + N0 * (np.exp(rmax * t) - 1))

def gompertz_model(t, N0, K, rmax, tlag):
    return N0 + (K - N0) * np.exp(-np.exp((rmax * np.exp(1) * (tlag - t)) / ((K - N0) * np.log(10)) + 1))

def baranyi_model(t, N0, rmax, K, h0):
    At = t + (1 / rmax) * np.log(np.exp(-rmax * t) + np.exp(-h0) - np.exp(-rmax * t - h0))
    term = (np.exp(rmax * At) - 1) / np.exp(K - N0)
    term = np.where(term < -1, -0.999, term)  # Avoid NaN
    y = N0 + rmax * At - np.log(1 + term)
    return np.exp(y)

# Metrics functions

def calc_r2(fit_pred, observed):
    rss = np.sum((observed - fit_pred) ** 2)
    tss = np.sum((observed - np.mean(observed)) ** 2)
    return 1 - (rss / tss)

def calculate_akaike_weights(aic_values):
    min_aic = min(aic_values.values())
    delta_aic = {m: aic - min_aic for m, aic in aic_values.items()}
    akaike_weights = {m: np.exp(-0.5 * delta) for m, delta in delta_aic.items()}
    total_weight = sum(akaike_weights.values())
    return {m: w / total_weight for m, w in akaike_weights.items()}

# ---------------------------
# NEW: FUNCTION TO CALCULATE TOTAL RUNTIME
# ---------------------------
def calculate_total_runtime(start_time):
    """Calculate the total runtime since the start_time."""
    return time.time() - start_time

# ---------------------------
# 3. GLOBAL STRUCTURES
# ---------------------------
models = ["Quadratic", "Cubic", "Logistic", "Modified_Gompertz", "Baranyi"]
model_colors = {
    "Quadratic": "blue",
    "Cubic": "green",
    "Logistic": "red",
    "Modified_Gompertz": "purple",
    "Baranyi": "orange"
}

all_results = []      # Detailed per-subset results
failed_fits = []      # Error logs
successful_fits = []  # Detailed list of successful fits (per subset)

# Count of subsets with a valid fit (0 < R2 < 1) per model
successful_fit_counts = {m: 0 for m in models}

# For selection counts (exactly as in the original script)
model_counts_aicc = {m: 0 for m in models}
model_counts_bic = {m: 0 for m in models}

# For best fitting dataset (based on Akaike weights)
model_best_aic_weights = {m: -np.inf for m in models}
model_best_datasets = {m: None for m in models}

total_subsets_available = 0  # Total number of subsets available for fitting

# ---- NEW GLOBAL DICTIONARIES TO STORE SUBSET DATA & FITTED PREDICTIONS ----
subset_data_dict = {}         # key: subset_id, value: dataframe (sub)
subset_predictions_dict = {}  # key: subset_id, value: dictionary of model predictions

# ---------------------------
# 4. MAIN LOOP: FIT MODELS PER SUBSET
# ---------------------------
for subset_id in unique_ids:
    sub = data[data["subset_id"] == subset_id].sort_values("time")
    sub = sub[sub["popbio"] > 0]
    if len(sub) < 5:
        failed_fits.append({"subset_id": subset_id, "Model": "N/A", "Error": "Subset too small"})
        continue

    total_subsets_available += 1
    sub["log_pop"] = np.log(sub["popbio"])
    
    # Save a copy of the subset data for later use
    subset_data_dict[subset_id] = sub.copy()
    
    # Deterministic starting values
    N0_start = sub["log_pop"].min() if not np.isnan(sub["log_pop"].min()) else 1
    K_start = sub["log_pop"].max() if not np.isnan(sub["log_pop"].max()) else 10
    if len(sub) > 2:
        tlag_start = sub["time"].iloc[np.argmax(np.diff(np.diff(sub["log_pop"])))]
    else:
        tlag_start = sub["time"].min()
    rmax_start = calculate_rmax(sub)
    h0_start = np.clip(1 / (rmax_start + 0.01), 0.01, 5)
    
    # Initialize best fit dictionary for all models
    best_fit = {m: {"r2": -np.inf, "AICc": None, "BIC": None, "popt": None, "predictions": None} for m in models}
    t_fit = np.linspace(sub["time"].min(), sub["time"].max(), 100)
    
    # -- For deterministic models (Quadratic, Cubic), do one fit --
    for det_model in ["Quadratic", "Cubic"]:
        try:
            if det_model == "Quadratic":
                coefs = np.polyfit(sub["time"], sub["log_pop"], 2)
                popt = coefs.tolist()
                fit_pred_original = np.polyval(coefs, sub["time"])
                predictions = np.polyval(coefs, t_fit)
            elif det_model == "Cubic":
                coefs = np.polyfit(sub["time"], sub["log_pop"], 3)
                popt = coefs.tolist()
                fit_pred_original = np.polyval(coefs, sub["time"])
                predictions = np.polyval(coefs, t_fit)
            observed = sub["log_pop"].values
            predicted = np.array(fit_pred_original)
            residuals = observed - predicted
            RSS = np.sum(residuals**2)
            n = len(observed)
            k = len(popt)
            AIC = n * np.log(RSS / n) + 2 * k
            AICc = AIC + (2 * k * (k + 1)) / (n - k - 1) if n > k + 1 else np.inf
            BIC = n * np.log(RSS / n) + k * np.log(n)
            r2 = calc_r2(predicted, observed)
            if 0 < r2 < 1:
                best_fit[det_model] = {
                    "r2": r2,
                    "AICc": AICc,
                    "BIC": BIC,
                    "popt": popt,
                    "predictions": predictions
                }
            # If not valid, do not update.
        except Exception as e:
            failed_fits.append({"subset_id": subset_id, "Model": det_model, "Error": str(e)})
    
    # -- For non-linear models, run 50 iterations with random starting values --
    for rep in range(50):
        for model in ["Logistic", "Modified_Gompertz", "Baranyi"]:
            try:
                if model == "Logistic":
                    logistic_N0 = np.random.normal(loc=N0_start, scale=0.1)
                    logistic_K  = np.random.normal(loc=K_start, scale=0.1)
                    logistic_rmax = np.random.normal(loc=rmax_start, scale=0.05)
                    mod = Model(logistic_model)
                    params = mod.make_params(N0=logistic_N0, K=logistic_K, rmax=logistic_rmax)
                    params["rmax"].set(min=0.1)
                    result = mod.fit(sub["log_pop"], params, t=sub["time"])
                    popt = [result.params["N0"].value, result.params["K"].value, result.params["rmax"].value]
                    fit_pred_original = result.best_fit
                    predictions = result.eval(t=t_fit)
                elif model == "Modified_Gompertz":
                    gompertz_N0 = np.random.normal(loc=N0_start, scale=0.1)
                    gompertz_K  = np.random.normal(loc=K_start, scale=0.1)
                    gompertz_rmax = np.random.normal(loc=rmax_start, scale=0.05)
                    mod = Model(gompertz_model)
                    params = mod.make_params(N0=gompertz_N0, K=gompertz_K, rmax=gompertz_rmax, tlag=tlag_start)
                    result = mod.fit(sub["log_pop"], params, t=sub["time"])
                    popt = [result.params["N0"].value, result.params["K"].value, result.params["rmax"].value, result.params["tlag"].value]
                    fit_pred_original = result.best_fit
                    predictions = result.eval(t=t_fit)
                elif model == "Baranyi":
                    baranyi_N0 = np.random.normal(loc=N0_start, scale=0.1)
                    baranyi_K  = np.random.normal(loc=K_start, scale=0.1)
                    baranyi_rmax = rmax_start
                    baranyi_h0 = np.random.normal(loc=h0_start, scale=0.1)
                    mod = Model(baranyi_model)
                    params = mod.make_params(N0=baranyi_N0, rmax=baranyi_rmax, K=baranyi_K, h0=baranyi_h0)
                    params["rmax"].set(min=0.1)
                    params["h0"].set(min=0.01, max=5)
                    result = mod.fit(sub["log_pop"], params, t=sub["time"])
                    popt = [result.params["N0"].value, result.params["rmax"].value, result.params["K"].value, result.params["h0"].value]
                    fit_pred_original = result.best_fit
                    predictions = result.eval(t=t_fit)
                
                observed = sub["log_pop"].values
                predicted = np.array(fit_pred_original)
                residuals = observed - predicted
                RSS = np.sum(residuals**2)
                n = len(observed)
                k = len(popt)
                AIC = n * np.log(RSS / n) + 2 * k
                AICc = AIC + (2 * k * (k + 1)) / (n - k - 1) if n > k + 1 else np.inf
                BIC = n * np.log(RSS / n) + k * np.log(n)
                r2 = calc_r2(predicted, observed)
                if 0 < r2 < 1 and r2 > best_fit[model]["r2"]:
                    best_fit[model] = {
                        "r2": r2,
                        "AICc": AICc,
                        "BIC": BIC,
                        "popt": popt,
                        "predictions": predictions
                    }
            except Exception as e:
                failed_fits.append({
                    "subset_id": subset_id,
                    "Iteration": rep,
                    "Model": model,
                    "Error": str(e)
                })
    
    # ---------------------------
    # 4D. AGGREGATE BEST FIT RESULTS PER SUBSET (only include valid fits)
    # ---------------------------
    aicc_values = {}
    bic_values = {}
    model_predictions = {}
    for model in models:
        res = best_fit[model]
        if res["r2"] is None or not (0 < res["r2"] < 1):
            continue  # skip invalid fits
        aicc_values[model] = res["AICc"]
        bic_values[model]  = res["BIC"]
        model_predictions[model] = (t_fit, res["predictions"])
        all_results.append({
            "subset_id": subset_id,
            "Model": model,
            "AICc": res["AICc"],
            "BIC": res["BIC"],
            "R2": res["r2"]
        })
        successful_fits.append({
            "subset_id": subset_id,
            "Model": model,
            "AICc": res["AICc"],
            "BIC": res["BIC"],
            "R2": res["r2"]
        })
        # Count this subset as a successful fit for the model.
        successful_fit_counts[model] += 1

    # ---------------------------
    # 4E. DETERMINE BEST MODEL FOR THE SUBSET (using original method)
    # ---------------------------
    best_model_aicc = None
    if aicc_values:
        for m, val in aicc_values.items():
            if best_model_aicc is None or val < best_model_aicc[1]:
                best_model_aicc = (m, val)
    best_model_bic = None
    if bic_values:
        for m, val in bic_values.items():
            if best_model_bic is None or val < best_model_bic[1]:
                best_model_bic = (m, val)
    if best_model_aicc:
        model_counts_aicc[best_model_aicc[0]] += 1
    if best_model_bic:
        model_counts_bic[best_model_bic[0]] += 1

    # ---------------------------
    # 4F. CALCULATE AKAIKE WEIGHTS (based on valid AICc values) and update best dataset via Akaike weight
    # ---------------------------
    valid_aicc_dict = {m: val for m, val in aicc_values.items() if val is not None and np.isfinite(val)}
    if valid_aicc_dict:
        min_aicc = min(valid_aicc_dict.values())
        akaike_weights = {m: np.exp(-0.5 * (valid_aicc_dict[m] - min_aicc)) for m in valid_aicc_dict}
        total_weight = sum(akaike_weights.values())
        akaike_weights = {m: w/total_weight for m, w in akaike_weights.items()}
        for m, w in akaike_weights.items():
            if w > model_best_aic_weights[m]:
                model_best_aic_weights[m] = w
                model_best_datasets[m] = subset_id

    # ---------------------------
    # 4G. PLOT THE BEST-FIT CURVES (skip models with invalid predictions)
    # ---------------------------
    x_min = sub["time"].min()
    x_max = sub["time"].max()
    x_margin = 0.05 * (x_max - x_min)
    plt.figure(facecolor='w')
    plt.scatter(sub["time"], sub["log_pop"], label="Data", color="black")
    for model_name, preds in model_predictions.items():
        if preds is None:
            continue
        x_vals, y_vals = preds
        if x_vals is None or y_vals is None or len(x_vals)==0 or len(y_vals)==0:
            continue
        plt.plot(x_vals, y_vals, label=model_name, color=model_colors.get(model_name))
    plt.xlabel("time")
    plt.ylabel("log(popbio)")
    plt.title(f"Growth Curves for subset_id: {subset_id}")
    plt.legend()
    plt.xlim(x_min - x_margin, x_max + x_margin)
    plt.savefig(os.path.join(output_dir, f"growth_curve_{subset_id}.pdf"))
    plt.close()
    
    # ---- STORE THE predictions from this subset for later use ----
    subset_predictions_dict[subset_id] = model_predictions

# ---------------------------
# 5. OUTPUT CSV FILES
# ---------------------------
# Summary: Frequency = (# of subsets with a valid fit for the model) / (total subsets available)
summary_list = []
for model in models:
    count = successful_fit_counts.get(model, 0)
    frequency = count / total_subsets_available if total_subsets_available > 0 else 0
    summary_list.append({
        "Model": model,
        "Successful_Fit_Count": count,
        "Frequency": frequency
    })
df_summary = pd.DataFrame(summary_list)
df_summary.to_csv(os.path.join(output_dir, "Successful_Fits.csv"), index=False)

# Output selection counts (using the same method as the uploaded script)
df_aicc = pd.DataFrame.from_dict(model_counts_aicc, orient='index', columns=["Best_Selected_AICc_Count"])
df_aicc.to_csv(os.path.join(output_dir, "Model_AICc_Selection_Counts.csv"), index=True)
df_bic = pd.DataFrame.from_dict(model_counts_bic, orient='index', columns=["Best_Selected_BIC_Count"])
df_bic.to_csv(os.path.join(output_dir, "Model_BIC_Selection_Counts.csv"), index=True)

# Output detailed results per model
for model in models:
    model_results = [res for res in all_results if res["Model"] == model]
    pd.DataFrame(model_results).to_csv(os.path.join(output_dir, f"{model}_Results.csv"), index=False)

# ... [existing code above remains unchanged] ...

pd.DataFrame(failed_fits).to_csv(os.path.join(output_dir, "Failed_Fits.csv"), index=False)
pd.DataFrame(successful_fits).to_csv(os.path.join(output_dir, "Successful_Fits_Details.csv"), index=False)
pd.DataFrame(all_results).to_csv(os.path.join(output_dir, "All_Results.csv"), index=False)

# Output Model_Best_Fitting_Dataset based on Akaike weights (global best per model)
best_fit_summary = []
for model in models:
    best_dataset = model_best_datasets.get(model, None)
    best_weight = model_best_aic_weights.get(model, -np.inf)
    best_fit_summary.append({
        "Model": model,
        "Best_Fitting_Dataset_ID": best_dataset,
        "Best_Akaike_Weight": best_weight
    })
pd.DataFrame(best_fit_summary).to_csv(os.path.join(output_dir, "Model_Best_Fitting_Dataset.csv"), index=False)

# ---------------------------
# 6. NEW: GENERATE PDFS FOR BEST-FITTING DATASETS PER MODEL
# ---------------------------
# For each model, get its best-fitting subset id and re-plot ALL fitted growth curves for that subset.
for model in models:
    best_subset_id = model_best_datasets.get(model, None)
    if best_subset_id is None:
        continue
    # Retrieve the stored data and predictions for this subset
    sub = subset_data_dict.get(best_subset_id, None)
    model_predictions = subset_predictions_dict.get(best_subset_id, {})
    if sub is None or not model_predictions:
        continue

    x_min = sub["time"].min()
    x_max = sub["time"].max()
    x_margin = 0.05 * (x_max - x_min)
    plt.figure(facecolor='w')
    plt.scatter(sub["time"], sub["log_pop"], label="Data", color="black")
    for mod_name, preds in model_predictions.items():
        if preds is None:
            continue
        x_vals, y_vals = preds
        if x_vals is None or y_vals is None or len(x_vals)==0 or len(y_vals)==0:
            continue
        plt.plot(x_vals, y_vals, label=mod_name, color=model_colors.get(mod_name))
    plt.xlabel("time")
    plt.ylabel("log(popbio)")
    plt.title(f"Growth Curves for subset_id: {best_subset_id}")
    plt.legend()
    plt.xlim(x_min - x_margin, x_max + x_margin)
    # Save PDF with the name: <Model>_<subset_id>.pdf
    plt.savefig(os.path.join(output_dir, f"{model}.pdf"))
    plt.close()

# ---------------------------
# 7. NEW: GENERATE CSV FILE FOR R² STATISTICS
# ---------------------------
# For each model, count how many times R² is > 0.7 (and < 1) among the successful fits,
# then calculate the frequency relative to the total number of datasets that successfully fit the model.
r2_stats = []
for model in models:
    # Count fits for which R² is greater than 0.7 and less than 1.
    count_r2_range = sum(1 for fit in successful_fits if fit["Model"] == model and fit["R2"] > 0.7 and fit["R2"] < 1)
    total_success = successful_fit_counts.get(model, 0)
    frequency = count_r2_range / total_success if total_success > 0 else 0
    r2_stats.append({
        "Model": model,
        "Count_R2_in_range": count_r2_range,
        "Successful_Fit_Count": total_success,
        "Frequency": frequency
    })

df_r2_stats = pd.DataFrame(r2_stats)
df_r2_stats.to_csv(os.path.join(output_dir, "R2_Statistics.csv"), index=False)

# ---------------------------
# 8. NEW: CALCULATE AND OUTPUT TOTAL RUNTIME
# ---------------------------
total_runtime = calculate_total_runtime(start_time)
print("Total running time: {:.2f} seconds".format(total_runtime))
df_runtime = pd.DataFrame([{"Total_Runtime_seconds": total_runtime}])
df_runtime.to_csv(os.path.join(output_dir, "Runtime.csv"), index=False)

# Table Shells

Table shells are the blank structure of a table — row and column headers with
placeholder notation instead of real numbers — drafted during the planning
stage (alongside `docs/statistical_analysis_plan.md`) before the analysis is
run. Committing to the structure in advance keeps the analysis from being
shaped around whatever numbers happen to come out. Below, each shell is shown
next to the filled-in version produced from the actual analysis.

---

## Table 1 Shell — Baseline Characteristics

| Characteristic | Overall (N=XXXX) | Alive (n=XXXX) | Deceased (n=XXXX) |
|---|---|---|---|
| Age, mean (SE), years | XX.X (X.X) | XX.X (X.X) | XX.X (X.X) |
| Systolic BP, mean (SE), mmHg | XXX.X (X.X) | XXX.X (X.X) | XXX.X (X.X) |
| Total cholesterol, mean (SE), mg/dL | XXX.X (X.X) | XXX.X (X.X) | XXX.X (X.X) |
| HDL cholesterol, mean (SE), mg/dL | XX.X (X.X) | XX.X (X.X) | XX.X (X.X) |
| BMI, mean (SE), kg/m² | XX.X (X.X) | XX.X (X.X) | XX.X (X.X) |
| BMI category, % |  |  |  |
| &nbsp;&nbsp;Underweight | X.X | X.X | X.X |
| &nbsp;&nbsp;Normal | XX.X | XX.X | XX.X |
| &nbsp;&nbsp;Overweight | XX.X | XX.X | XX.X |
| &nbsp;&nbsp;Obese | XX.X | XX.X | XX.X |
| Smoking status, % |  |  |  |
| &nbsp;&nbsp;Never | XX.X | XX.X | XX.X |
| &nbsp;&nbsp;Former | XX.X | XX.X | XX.X |
| &nbsp;&nbsp;Current | XX.X | XX.X | XX.X |
| Diabetes, % | XX.X | XX.X | XX.X |
| Hypertension, % | XX.X | XX.X | XX.X |
| Sex, % male | XX.X | XX.X | XX.X |
| Race/ethnicity, % |  |  |  |

**Filled version:** [`output/tables/table1_baseline_characteristics.pdf`](../output/tables/table1_baseline_characteristics.pdf)
— see `docs/results_summary.md` for the key numbers in plain language.

---

## Table 2 Shell — Cox Proportional Hazards, All-Cause Mortality

| Risk Factor | Unadjusted HR (95% CI) | Adjusted HR (95% CI) | p-value (adjusted) |
|---|---|---|---|
| Systolic BP (per 10 mmHg) | X.XX (X.XX–X.XX) | X.XX (X.XX–X.XX) | X.XXX |
| Total cholesterol (per 40 mg/dL) | X.XX (X.XX–X.XX) | X.XX (X.XX–X.XX) | X.XXX |
| HDL cholesterol | X.XX (X.XX–X.XX) | X.XX (X.XX–X.XX) | X.XXX |
| Current vs. never smoking | X.XX (X.XX–X.XX) | X.XX (X.XX–X.XX) | X.XXX |
| Former vs. never smoking | X.XX (X.XX–X.XX) | X.XX (X.XX–X.XX) | X.XXX |
| BMI: Obese vs. normal | X.XX (X.XX–X.XX) | X.XX (X.XX–X.XX) | X.XXX |
| BMI: Overweight vs. normal | X.XX (X.XX–X.XX) | X.XX (X.XX–X.XX) | X.XXX |
| BMI: Underweight vs. normal | X.XX (X.XX–X.XX) | X.XX (X.XX–X.XX) | X.XXX |
| Diabetes | X.XX (X.XX–X.XX) | X.XX (X.XX–X.XX) | X.XXX |

## Table 3 Shell — Cox Proportional Hazards, Cardiovascular Mortality (Adjusted)

| Risk Factor | Adjusted HR (95% CI) | p-value |
|---|---|---|
| Systolic BP (per 10 mmHg) | X.XX (X.XX–X.XX) | X.XXX |
| Total cholesterol (per 40 mg/dL) | X.XX (X.XX–X.XX) | X.XXX |
| HDL cholesterol | X.XX (X.XX–X.XX) | X.XXX |
| Current vs. never smoking | X.XX (X.XX–X.XX) | X.XXX |
| Former vs. never smoking | X.XX (X.XX–X.XX) | X.XXX |
| BMI: Obese vs. normal | X.XX (X.XX–X.XX) | X.XXX |
| Diabetes | X.XX (X.XX–X.XX) | X.XXX |

**Filled versions:** [`output/tables/table2_cox_models.pdf`](../output/tables/table2_cox_models.pdf)
(contains both Tables 2 and 3) — see `docs/results_summary.md` for interpretation.

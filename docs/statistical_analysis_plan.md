# Statistical Analysis Plan (SAP)

**Project:** Cardiovascular Risk Factors and Mortality — NHANES 1999–2000 Cohort
**Version:** 0.1 (draft, written before data merge/analysis)

## 1. Background and Objective

Midlife cardiovascular risk factors (elevated blood pressure, dyslipidemia, smoking,
diabetes, obesity) are established predictors of cardiovascular and all-cause
mortality. This analysis estimates the association between these risk factors,
measured at NHANES 1999–2000 baseline exam, and subsequent all-cause and
cardiovascular mortality through the most recent NCHS mortality follow-up period.

## 2. Data Sources

| Component | File | Key variables |
|---|---|---|
| Demographics | DEMO | age, sex, race/ethnicity, education, survey weights/design |
| Body measures | BMX | BMI |
| Blood pressure | BPX | systolic/diastolic blood pressure |
| Cholesterol | LAB13/TCHOL, LAB13AM/HDL | total cholesterol, HDL |
| Smoking | SMQ | smoking status |
| Diabetes | DIQ | diabetes diagnosis |
| Mortality | NCHS Public-Use Linked Mortality File | follow-up time, vital status, cause of death |

## 3. Eligibility Criteria

- Age ≥ 45 years at baseline exam (midlife-onward, consistent with ARIC's enrollment
  rationale for cardiovascular/dementia risk).
- Eligible for mortality follow-up per NCHS linkage flag.
- Non-missing baseline blood pressure, cholesterol, BMI, smoking, and diabetes status.

*Exclusions and their counts will be documented in a CONSORT-style flow as part of
Table 1, to make attrition transparent (bias mitigation).*

## 4. Variable Definitions

- **Outcome 1:** all-cause mortality (event/censored, person-months of follow-up).
- **Outcome 2:** cardiovascular mortality (NCHS underlying cause of death: diseases
  of the heart), treating other causes of death as competing/censored.
- **Exposures:** systolic blood pressure (continuous, and hypertensive ≥140/90 or on
  treatment), total and HDL cholesterol (continuous), current/former/never smoking,
  diagnosed diabetes, BMI category (underweight/normal/overweight/obese).
- **Covariates:** age, sex, race/ethnicity, education (potential confounders,
  selected a priori rather than by stepwise selection, to avoid data-driven bias).

## 5. Analytic Approach

1. **Table 1 — baseline characteristics**, overall and by vital status at follow-up
   end, accounting for the complex survey design (`PROC SURVEYMEANS` / `PROC
   SURVEYFREQ` with strata, PSU, and exam weights).
2. **Primary analysis — Cox proportional hazards regression** (`PROC SURVEYPHREG`)
   for time to death, adjusted for the covariates above, incorporating survey design
   to produce nationally representative, variance-corrected estimates.
3. **Proportional hazards assumption** checked via Schoenfeld-type residuals /
   time-interaction terms.
4. **Sensitivity analyses:** unweighted vs. weighted comparison; cardiovascular-
   specific vs. all-cause mortality; complete-case vs. multiple imputation for
   covariates with informative missingness (planned, not yet implemented).

## 6. Bias Considerations

- Survey design weights and clustering are required for nationally representative
  and correctly-estimated variance; ignoring them would understate standard errors.
- Reverse causation: baseline exam excludes prevalent CVD where flagged, to reduce
  the chance that subclinical disease is driving both the risk factor and early
  mortality.
- Confounder selection is specified in advance (Section 4) rather than chosen after
  seeing results, to avoid analysis-driven bias.

## 7. Deliverables

- Table 1 shell (baseline characteristics).
- Table 2 shell (unadjusted and adjusted hazard ratios with 95% CIs).
- Kaplan–Meier curves by key exposure categories.
- Brief written report interpreting findings in the context of the existing
  cardiovascular epidemiology literature.

## Open Items

- [ ] Confirm exact NHANES lab component file names for the 1999–2000 cycle
      against the current codebook (file naming has varied slightly by cycle).
- [ ] Confirm current end date of NCHS mortality follow-up for this cycle.
- [ ] Decide on final missing-data approach (complete case vs. imputation).

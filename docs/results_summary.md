# Results Summary

**Sample:** 2,188 NHANES 1999–2000 participants aged ≥45 at baseline, with complete
data on all analytic variables, followed for vital status through the NCHS
2019 mortality linkage (~20 years). 1,150 deaths (52.6%) occurred during
follow-up, of which 317 (27.6% of deaths) were attributed to heart disease.

## Table 1 — Baseline Characteristics

Baseline risk factor burden was substantially higher among those who died during
follow-up than among survivors:

| Characteristic | Survivors | Decedents |
|---|---|---|
| Mean age (years) | 54.7 | 67.4 |
| Mean systolic BP (mmHg) | 127.5 | 139.4 |
| Diabetes prevalence | — | 65% of diabetics died vs. 40% of non-diabetics |
| Hypertension prevalence | — | 57% of hypertensives died vs. 35% of non-hypertensives |

See `output/tables/table1_baseline_characteristics.rtf` for the full weighted table.

## Table 2 — Cox Proportional Hazards, All-Cause Mortality (adjusted for age, sex,
race/ethnicity, education)

| Risk factor | Adjusted HR | 95% CI | p-value |
|---|---|---|---|
| Systolic BP (per 10 mmHg) | 1.06 | 1.03–1.09 | <0.001 |
| Current smoking (vs. never) | 2.52 | 2.06–3.07 | <0.001 |
| Former smoking (vs. never) | 1.03 | 0.87–1.21 | 0.74 |
| Diabetes | 1.65 | 1.30–2.08 | <0.001 |
| Total cholesterol (per 40 mg/dL) | 1.01 | 0.94–1.09 | 0.74 |
| HDL cholesterol | 1.00 | — | 0.52 |

## Table 3 — Cox Proportional Hazards, Cardiovascular Mortality (adjusted)

Same direction of effects as all-cause mortality, with one notable difference:
**obesity was a significant predictor of CVD-specific mortality (HR 1.70, p<0.001)**
despite not reaching significance for all-cause mortality — consistent with obesity's
mortality risk being concentrated in cardiovascular causes rather than distributed
across all causes of death.

## Figures

**Figure 1. Kaplan-Meier survival by smoking status.** Unadjusted probability
of survival over ~20 years of follow-up, stratified by baseline smoking
status, with 95% confidence bands. Never smokers show consistently higher
survival than current or former smokers (see note below on former smoking).

![Kaplan-Meier survival curves by smoking status](../output/figures/km_by_smoking.png)

**Figure 2. Kaplan-Meier survival by diabetes status.** Same population and
follow-up period, stratified by baseline diabetes diagnosis. A consistent,
widening survival disadvantage for participants with diabetes, consistent
with the adjusted hazard ratio of 1.65 reported above.

![Kaplan-Meier survival curves by diabetes status](../output/figures/km_by_diabetes.png)

### A note on the smoking curve: crude vs. adjusted effects

The unadjusted smoking KM plot appears to show "Former" smokers with survival
nearly as poor as "Current" smokers, both well below "Never" smokers. This
looks inconsistent with the *adjusted* Cox results above, where former
smoking was not a significant predictor (HR 1.03) while current smoking was
(HR 2.52) — but it isn't a contradiction, it's confounding. Former smokers
are, on average, older than current smokers (they've had more time to quit),
so some of the apparent "former smoking hurts survival" in the crude,
unadjusted plot is really an age effect showing through. Once the Cox model
adjusts for age, that apparent penalty for former smoking disappears,
leaving only current smoking as an independent predictor. This is a concrete
illustration of exactly the kind of confounding `docs/statistical_analysis_plan.md`
was written to guard against by specifying adjustment covariates in advance.

## Model Diagnostics

A time-interaction term for systolic blood pressure was non-significant (p=0.94),
providing no evidence against the proportional hazards assumption for that variable.

## Interpretation and Limitations

- Findings are directionally consistent with the established cardiovascular
  epidemiology literature (elevated BP, smoking, and diabetes as independent
  predictors of mortality), which is the expected result for a correctly
  specified model on this data — not a novel finding, since this is a portfolio
  demonstration rather than original research.
- Total and HDL cholesterol were not independently significant predictors of
  all-cause mortality after adjustment — a well-documented finding in the
  literature once age, smoking, and other risk factors are accounted for, not
  an analytic error.
- The smoking questionnaire (SMQ) was administered to only ~4,880 of 9,965
  NHANES 1999-2000 participants (a NHANES subsample design feature), which
  is the primary driver of attrition from 9,965 to the final analytic
  sample of 2,188. This analysis used the standard MEC exam weight
  (`WTMEC2YR`) as an approximation; a fully rigorous treatment would use a
  subsample-specific weight if one is documented for this module, since
  the survey design should match the reason for excluding certain participants.

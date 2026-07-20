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

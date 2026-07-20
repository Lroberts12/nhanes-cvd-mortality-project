# Bias Considerations and How They Were Handled

This project intentionally documents bias-mitigation decisions as they're made,
rather than only after the fact — the same practice expected of an analyst
working on a cohort study like ARIC.

## 1. Confounder selection specified before seeing results

Covariates (age, sex, race/ethnicity, education) were chosen a priori in
`docs/statistical_analysis_plan.md` Section 4, based on established
cardiovascular epidemiology, rather than selected afterward by stepwise
methods or by which variables happened to be significant. Choosing
confounders based on the results being modeled is a common source of
overstated findings.

## 2. Survey design weighting (complex sample bias)

NHANES uses a multi-stage, unequal-probability sample design, not a simple
random sample. Every analysis in this project accounts for it —
`PROC SURVEYMEANS`, `PROC SURVEYFREQ`, and `PROC SURVEYPHREG` all specify
`strata`, `cluster`, and `weight`. Ignoring the design (i.e., running
`PROC MEANS`/`PROC PHREG` directly) would understate standard errors and
could bias point estimates away from being nationally representative.

## 3. Differential missingness in the smoking questionnaire (selection bias)

NHANES administers some questionnaire modules to only a subsample of
participants, not everyone. In the 1999-2000 cycle, the smoking module
(`SMQ`) was completed by only ~4,880 of 9,965 participants. Combined with
the age ≥45 eligibility criterion and requiring complete data on all
analytic variables, this is the primary reason the final analytic sample
(2,188) is much smaller than the full eligible cohort — **not** because of
data quality problems, but because of how NHANES was designed.

This matters because if subsample selection is related to the outcome (e.g.,
sicker or healthier people were more/less likely to complete that module),
restricting to complete cases on `smoke_status` could bias the smoking
estimates specifically. This analysis used the standard MEC exam weight
(`WTMEC2YR`) as an approximation, since a subsample-specific weight was not
readily available for this module. A fully rigorous treatment would either
(a) obtain and apply the correct subsample weight, or (b) use multiple
imputation for smoking status among the excluded participants rather than
complete-case analysis. This tradeoff is disclosed here rather than hidden.

## 4. Reverse causation / prevalent disease at baseline

Because NHANES 1999-2000 is a single baseline exam rather than a
multi-visit cohort like ARIC, there's a risk that a risk factor measured at
baseline is actually a *consequence* of undiagnosed existing disease (e.g.,
low blood pressure due to heart failure, rather than low blood pressure
protecting against it), which would bias the association toward showing
the risk factor as protective. This project restricts to ages 45+ rather
than including younger ages where this concern is less relevant, but does
not have a way to exclude undiagnosed prevalent CVD at baseline the way a
multi-exam cohort could — this is disclosed as a limitation rather than
addressed, since the data doesn't support fully addressing it.

## 5. Proportional hazards assumption, not just model fit

Rather than assuming the Cox model's proportional hazards assumption
holds, `sas/05_cox_regression.sas` includes an explicit diagnostic (a
blood-pressure × log-time interaction term) to check for it — see
`docs/results_summary.md` for the result (no evidence of violation).

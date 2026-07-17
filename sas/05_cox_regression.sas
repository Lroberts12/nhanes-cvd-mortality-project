/*******************************************************************************
  05_cox_regression.sas

  Cox proportional hazards models (survey-weighted) for all-cause and
  cardiovascular mortality, per docs/statistical_analysis_plan.md Section 5.
*******************************************************************************/

%let root = /home/u12345678/nhanes-cvd-mortality-project;  /* <-- update this */
libname proj "&root./data/derived";

ods rtf file="&root./output/tables/table2_cox_models.rtf" style=journal;

title "Table 2. Hazard Ratios for All-Cause Mortality";
title2 "Survey-weighted Cox Proportional Hazards Model, NHANES 1999-2000";

/* Unadjusted */
proc surveyphreg data=proj.analytic;
  strata sdmvstra;
  cluster sdmvpsu;
  weight wtmec2yr;
  class smoke_status (ref="Never") bmi_cat (ref="Normal") diabetes (ref="0") / param=ref;
  model fu_months*died_allcause(0) = sbp_avg lbxtc lbdhdd smoke_status bmi_cat diabetes;
  hazardratio 'Systolic BP (per 10 mmHg)' sbp_avg / units=10;
  hazardratio 'Total cholesterol (per 40 mg/dL)' lbxtc / units=40;
  hazardratio smoke_status;
  hazardratio bmi_cat;
  hazardratio diabetes;
run;

/* Adjusted for age, sex, race/ethnicity, education */
proc surveyphreg data=proj.analytic;
  strata sdmvstra;
  cluster sdmvpsu;
  weight wtmec2yr;
  class smoke_status (ref="Never") bmi_cat (ref="Normal") diabetes (ref="0")
        riagendr (ref="1") ridreth1 (ref="3") / param=ref;
  model fu_months*died_allcause(0) = sbp_avg lbxtc lbdhdd smoke_status bmi_cat
        diabetes ridageyr riagendr ridreth1 dmdeduc2;
  hazardratio 'Systolic BP (per 10 mmHg)' sbp_avg / units=10;
  hazardratio 'Total cholesterol (per 40 mg/dL)' lbxtc / units=40;
  hazardratio smoke_status;
  hazardratio bmi_cat;
  hazardratio diabetes;
run;

title "Table 3. Hazard Ratios for Cardiovascular Mortality (Adjusted)";
proc surveyphreg data=proj.analytic;
  strata sdmvstra;
  cluster sdmvpsu;
  weight wtmec2yr;
  class smoke_status (ref="Never") bmi_cat (ref="Normal") diabetes (ref="0")
        riagendr (ref="1") ridreth1 (ref="3") / param=ref;
  model fu_months*died_cvd(0) = sbp_avg lbxtc lbdhdd smoke_status bmi_cat
        diabetes ridageyr riagendr ridreth1 dmdeduc2;
run;

ods rtf close;
title;

/* --- Proportional hazards assumption check (unweighted diagnostic) ---
   SURVEYPHREG does not provide PH diagnostics directly; PROC PHREG (unweighted)
   is used here only to screen for gross PH violations via time-interaction
   terms, not as the inferential model. */
proc phreg data=proj.analytic;
  class smoke_status (ref="Never") bmi_cat (ref="Normal") / param=ref;
  model fu_months*died_allcause(0) = sbp_avg lbxtc lbdhdd smoke_status bmi_cat
        diabetes ridageyr;
  sbp_time = sbp_avg * log(fu_months);
  ph_test: test sbp_time;
run;

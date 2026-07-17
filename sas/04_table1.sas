/*******************************************************************************
  04_table1.sas

  Table 1 shell: baseline characteristics, overall and by vital status,
  accounting for the NHANES complex survey design (strata, PSU, exam weights).
*******************************************************************************/

%let root = /home/u12345678/nhanes-cvd-mortality-project;  /* <-- update this */
libname proj "&root./data/derived";

ods rtf file="&root./output/tables/table1_baseline_characteristics.rtf" style=journal;

title "Table 1. Baseline Characteristics, NHANES 1999-2000 (Age >= 45)";
title2 "Overall and by Vital Status at Mortality Follow-up";

/* Continuous variables: weighted mean (SE) via SURVEYMEANS */
proc surveymeans data=proj.analytic mean stderr;
  strata sdmvstra;
  cluster sdmvpsu;
  weight wtmec2yr;
  var ridageyr sbp_avg lbxtc lbdhdd bmxbmi;
  domain died_allcause;
run;

/* Categorical variables: weighted proportions via SURVEYFREQ */
proc surveyfreq data=proj.analytic;
  strata sdmvstra;
  cluster sdmvpsu;
  weight wtmec2yr;
  tables (bmi_cat smoke_status diabetes hypertension riagendr ridreth1) * died_allcause
        / row nowt;
run;

ods rtf close;
title;

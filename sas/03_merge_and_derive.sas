/*******************************************************************************
  03_merge_and_derive.sas

  Merges NHANES exam/questionnaire components with the mortality linkage file
  by SEQN, applies eligibility criteria, and derives analytic variables per
  docs/statistical_analysis_plan.md.
*******************************************************************************/

%let root = /home/u64553528/sasuser.v94/nhanes-cvd-mortality-project;
libname proj "&root./data/derived";

/* Sort each component by SEQN before merging */
proc sort data=work.demo;  by seqn; run;
proc sort data=work.bmx;   by seqn; run;
proc sort data=work.bpx;   by seqn; run;
proc sort data=work.lab13; by seqn; run;
proc sort data=work.smq;   by seqn; run;
proc sort data=work.diq;   by seqn; run;
proc sort data=proj.mortality; by seqn; run;

data proj.analytic (label="Analytic dataset: CVD risk factors and mortality");
  merge work.demo (in=a)
        work.bmx  (in=b)
        work.bpx
        work.lab13
        work.smq
        work.diq
        proj.mortality (in=m);
  by seqn;

  /* Baseline eligibility criteria per SAP Section 3 */
  if a and m;                          /* must be in demographics and mortality-eligible */
  if eligstat = 1;                     /* eligible for mortality follow-up */
  if ridageyr >= 45;                   /* midlife-onward, mirrors ARIC's enrollment age */

  /* --- Derived exposures --- */

  /* Average systolic BP across up to 3 readings */
  array sbp_readings {3} bpxsy1 bpxsy2 bpxsy3;
  sbp_avg = mean(of sbp_readings{*});

  hypertension = (sbp_avg >= 140) or (bpxdi1 >= 90);

  /* BMI category */
  length bmi_cat $20;
  if      bmxbmi = . then bmi_cat = "Missing";
  else if bmxbmi <  18.5 then bmi_cat = "Underweight";
  else if bmxbmi <  25.0 then bmi_cat = "Normal";
  else if bmxbmi <  30.0 then bmi_cat = "Overweight";
  else bmi_cat = "Obese";

  /* Smoking status: SMQ020 = smoked >=100 cigarettes in life, SMQ040 = current smoking */
  length smoke_status $20;
  if smq020 = 2 then smoke_status = "Never";
  else if smq020 = 1 and smq040 in (1,2) then smoke_status = "Current";
  else if smq020 = 1 and smq040 = 3 then smoke_status = "Former";
  else smoke_status = "Missing";

  /* Diabetes: DIQ010 = 1 (yes) / 2 (no) / 3 (borderline) */
  diabetes = (diq010 = 1);

  /* --- Outcomes --- */
  died_allcause = (mortstat = 1);
  died_cvd = (mortstat = 1 and ucod_leading = "001");   /* "001" = diseases of heart, per NCHS recode */
  fu_months = permth_exm;                            /* follow-up time from exam date */

  /* Exclude records missing key analytic variables */
  if nmiss(sbp_avg, lbxtc, lbdhdl, bmxbmi) = 0
     and smoke_status ne "Missing";
run;

proc means data=proj.analytic n nmiss;
  var ridageyr sbp_avg lbxtc lbdhdl bmxbmi fu_months;
run;

proc freq data=proj.analytic;
  tables bmi_cat smoke_status diabetes hypertension died_allcause died_cvd;
run;

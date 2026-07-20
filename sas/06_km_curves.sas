/*******************************************************************************
  06_km_curves.sas

  Kaplan-Meier survival curves by smoking status and by diabetes status,
  built as custom PROC SGPLOT step charts (rather than PROC LIFETEST's
  default plots) for a cleaner, more modern look.
*******************************************************************************/

%let root = /home/u64553528/sasuser.v94/nhanes-cvd-mortality-project;
libname proj "&root./data/derived";

ods graphics on / imagefmt=png width=7in height=4.5in;
ods listing gpath="&root./output/figures" style=htmlblue;

/* --- Compute survival estimates (no default plots, just the numbers) --- */
proc lifetest data=proj.analytic outsurv=work.surv_smoking noprint;
  time fu_months*died_allcause(0);
  strata smoke_status;
run;

proc lifetest data=proj.analytic outsurv=work.surv_diabetes noprint;
  time fu_months*died_allcause(0);
  strata diabetes;
run;

/* --- Custom step plot: survival by smoking status --- */
ods graphics / reset=all imagename="km_by_smoking";
proc sgplot data=work.surv_smoking noautolegend;
  styleattrs datacontrastcolors=(CX1B9E77 CXD95F02 CX7570B3);
  band x=fu_months lower=sdf_lcl upper=sdf_ucl / group=smoke_status transparency=0.75;
  step x=fu_months y=survival / group=smoke_status lineattrs=(thickness=2.5);
  xaxis label="Follow-up Time (months)" grid;
  yaxis label="Survival Probability" min=0 max=1 grid;
  title "Kaplan-Meier Survival Estimates by Smoking Status";
  keylegend / title="Smoking Status" position=bottom;
run;

/* --- Custom step plot: survival by diabetes status --- */
ods graphics / reset=all imagename="km_by_diabetes";
proc sgplot data=work.surv_diabetes noautolegend;
  styleattrs datacontrastcolors=(CX1B9E77 CXD95F02);
  band x=fu_months lower=sdf_lcl upper=sdf_ucl / group=diabetes transparency=0.75;
  step x=fu_months y=survival / group=diabetes lineattrs=(thickness=2.5);
  xaxis label="Follow-up Time (months)" grid;
  yaxis label="Survival Probability" min=0 max=1 grid;
  title "Kaplan-Meier Survival Estimates by Diabetes Status";
  keylegend / title="Diabetes" position=bottom;
run;

ods listing close;

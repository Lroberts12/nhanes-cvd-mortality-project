/*******************************************************************************
  02_import_mortality.sas

  Reads the NCHS Public-Use Linked Mortality File for NHANES 1999-2000, using
  the fixed-width layout from NCHS's own SAS_ReadInProgramAllSurveys.sas
  (NHANES version), rather than hand-written byte offsets.
*******************************************************************************/

%let root = /home/u64553528/sasuser.v94/nhanes-cvd-mortality-project;
libname proj "&root./data/derived";

%let survey = NHANES_1999_2000;
%let infilnm = &root./data/raw/;   /* must end with a slash */

proc format;
  value eligfmt
    1 = "Eligible"
    2 = "Under age 18, not available for public release"
    3 = "Ineligible";

  value mortfmt
    0 = "Assumed alive"
    1 = "Assumed deceased"
    . = "Ineligible or under age 18";

  value flagfmt
    0 = "No - Condition not listed as a multiple cause of death"
    1 = "Yes - Condition listed as a multiple cause of death"
    . = "Assumed alive, under age 18, ineligible for mortality follow-up, or MCOD not available";

  value $ucodfmt
    "001" = "Diseases of heart (I00-I09, I11, I13, I20-I51)"
    "002" = "Malignant neoplasms (C00-C97)"
    "003" = "Chronic lower respiratory diseases (J40-J47)"
    "004" = "Accidents (unintentional injuries) (V01-X59, Y85-Y86)"
    "005" = "Cerebrovascular diseases (I60-I69)"
    "006" = "Alzheimer's disease (G30)"
    "007" = "Diabetes mellitus (E10-E14)"
    "008" = "Influenza and pneumonia (J09-J18)"
    "009" = "Nephritis, nephrotic syndrome and nephrosis (N00-N07, N17-N19, N25-N27)"
    "010" = "All other causes (residual)"
    "   " = "Ineligible, under age 18, assumed alive, or no cause of death data available";

  value premiss
    . = "MISSING"
    other = "PRESENT";
run;

data work.&survey;
  infile "&infilnm.&survey._MORT_2019_PUBLIC.dat" lrecl=61 pad missover;
  input
    seqn            1-6
    eligstat        15
    mortstat        16
    ucod_leading    $17-19
    diabetes_mcod   20
    hyperten_mcod   21
    permth_int      43-45
    permth_exm      46-48
  ;

  label
    seqn           = 'NHANES Respondent Sequence Number'
    eligstat       = 'Eligibility Status for Mortality Follow-up'
    mortstat       = 'Final Mortality Status'
    ucod_leading   = 'Underlying Leading Cause of Death: Recode'
    diabetes_mcod  = 'Diabetes Flag from Multiple Cause of Death (MCOD)'
    hyperten_mcod  = 'Hypertension Flag from Multiple Cause of Death (MCOD)'
    permth_int     = 'Person-Months of Follow-up from NHANES Interview Date'
    permth_exm     = 'Person-Months of Follow-up from NHANES MEC Exam Date'
  ;

  format
    eligstat                     eligfmt.
    mortstat                     mortfmt.
    ucod_leading                 $ucodfmt.
    diabetes_mcod hyperten_mcod  flagfmt.
    permth_int permth_exm        premiss.
  ;
run;

proc contents data=work.&survey varnum;
run;

proc freq data=work.&survey;
  tables eligstat mortstat ucod_leading diabetes_mcod hyperten_mcod / missing;
run;

/* Keep only what the analytic merge needs */
data proj.mortality;
  set work.&survey;
  keep seqn eligstat mortstat ucod_leading permth_int permth_exm;
run;

/*******************************************************************************
  02_import_mortality.sas

  Reads the NCHS Public-Use Linked Mortality File for the NHANES 1999-2000 cycle.

  IMPORTANT: NCHS distributes this as a fixed-width text file, along with its own
  SAS "read-in" program on the mortality linkage page. Paste that NCHS-provided
  program below (in place of the placeholder INPUT statement) rather than
  hand-writing byte offsets — a wrong offset silently misaligns every field.

  https://www.cdc.gov/nchs/data-linkage/mortality-public.htm
*******************************************************************************/

%let root = /home/u12345678/nhanes-cvd-mortality-project;  /* <-- update this */

/* -----------------------------------------------------------------------
   PLACEHOLDER: replace this data step with the NCHS-provided SAS program
   for the 1999-2000 public-use mortality file. It will produce a dataset
   (commonly named NHANES_1999_2000_MORT_2019_PUBLIC or similar) containing
   at minimum:
     seqn        - respondent ID, links to NHANES exam/questionnaire files
     eligstat    - eligibility for mortality follow-up
     mortstat    - 0/1 vital status (assumed alive / assumed deceased)
     ucod_leading- underlying cause of death, leading causes recode
                   (value 001 = Diseases of heart)
     permth_int  - person-months of follow-up from interview date
     permth_exm  - person-months of follow-up from exam date
   ----------------------------------------------------------------------- */

/* <PASTE NCHS SAS PROGRAM HERE, POINTING infile AT
   &root./data/raw/NHANES_1999_2000_MORT_2019_PUBLIC.dat> */

libname proj "&root./data/derived";
data proj.mortality;
  set work.nhanes_1999_2000_mort_2019_public; /* rename to match NCHS output dataset */
  keep seqn eligstat mortstat ucod_leading permth_int permth_exm;
run;

proc freq data=proj.mortality;
  tables eligstat mortstat ucod_leading;
run;

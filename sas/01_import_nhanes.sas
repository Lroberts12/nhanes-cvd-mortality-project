/*******************************************************************************
  01_import_nhanes.sas

  Reads the NHANES 1999-2000 exam/questionnaire components (distributed by CDC
  as SAS Transport files, .xpt) into native SAS datasets in WORK, then saves
  permanent copies to the project library.

  BEFORE RUNNING:
  - Download the .xpt files listed in data/raw/README.md into data/raw/
  - Update ROOT below to the full path of this project folder on your machine
    (in SAS OnDemand for Academics this is usually under your SAS Studio home,
    e.g. after uploading the project folder to "My Folder")
*******************************************************************************/

%let root = /home/u12345678/nhanes-cvd-mortality-project;  /* <-- update this */

libname raw "&root./data/raw";
libname proj "&root./data/derived";  /* create this folder if it doesn't exist */

/* The XPORT engine reads CDC's SAS transport files directly */
libname demo_x xport "&root./data/raw/DEMO.xpt";
libname bmx_x  xport "&root./data/raw/BMX.xpt";
libname bpx_x  xport "&root./data/raw/BPX.xpt";
libname chol_x xport "&root./data/raw/TCHOL.xpt";   /* confirm exact file name against codebook */
libname smq_x  xport "&root./data/raw/SMQ.xpt";
libname diq_x  xport "&root./data/raw/DIQ.xpt";

/* Copy each transport member into WORK as a native SAS dataset */
proc copy in=demo_x out=work;
run;
proc copy in=bmx_x out=work;
run;
proc copy in=bpx_x out=work;
run;
proc copy in=chol_x out=work;
run;
proc copy in=smq_x out=work;
run;
proc copy in=diq_x out=work;
run;

/* Sanity check: row counts and key variables present */
proc contents data=work.demo varnum;
run;

proc means data=work.bmx n nmiss mean min max;
  var bmxbmi;
run;

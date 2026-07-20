# Raw Data (not committed)

This folder holds the raw NHANES files. They are left out of git (see the repo's
`.gitignore`) because they're large, freely re-downloadable, and portfolio repos
generally shouldn't carry raw third-party data — only the code that produces the
analysis from it.

## Files to download here

From https://wwwn.cdc.gov/nchs/nhanes/Default.aspx, select the **1999–2000** cycle
and download these components as SAS Transport (`.xpt`) files:

| Component | Description |
|---|---|
| DEMO | Demographics |
| BMX | Body measures |
| BPX | Blood pressure |
| Cholesterol (Total + HDL) | Lab component, exact file name varies by cycle — check the current codebook page |
| SMQ | Smoking questionnaire |
| DIQ | Diabetes questionnaire |

From https://ftp.cdc.gov/pub/health_statistics/NCHS/datalinkage/linked_mortality/,
download:
- `NHANES_1999_2000_MORT_2019_PUBLIC.dat` — the mortality data
- `SAS_ReadInProgramAllSurveys.sas` — NCHS's universal SAS read-in program

Use their program to read the fixed-width `.dat` file rather than a hand-written
one, since a wrong byte offset would silently misalign every record.

Keep the original file names; the `sas/` programs reference them directly.

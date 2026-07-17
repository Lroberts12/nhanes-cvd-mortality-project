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

From https://www.cdc.gov/nchs/data-linkage/mortality-public.htm, download the
**public-use linked mortality file for the 1999–2000 cycle**, along with the SAS
input program NCHS provides on that same page for reading the fixed-width file —
use their program rather than a hand-written one, since a wrong byte offset would
silently misalign every record.

Keep the original file names; the `sas/` programs reference them directly.

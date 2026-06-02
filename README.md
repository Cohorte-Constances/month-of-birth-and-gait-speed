# Month of birth and gait speed

This repository contains the SAS 9.4 programs used for the statistical analyses in the article on the association between month of birth and gait speed.

---

## Programs

| File | Description | Outputs |
|------|-------------|---------|
| `prg_0.sas` | Multiple imputation of missing values | — |
| `prg_1.sas` | Relation between age and gait speed | Fast: Figure 1 · Usual: Supplementary Figure 4 |
| `prg_2.sas` | Relation between month of birth and gait speed (after multiple imputation) | Fast: Table 2, Figure 2 · Usual: Supplementary Table 4, Supplementary Figure 5 |
| `prg_3.sas` | Contribution of mediators to the relation between month of birth and gait speed | Fast: Table 3 · Usual: Supplementary Table 5 |
| `prg_4.sas` | Relation between month of birth and gait speed — complete case analysis | Fast: Supplementary Table 6 · Usual: Supplementary Table 7 |
| `prg_5.sas` | Relation between binary month of birth and gait speed (after multiple imputation) | Fast: Supplementary Table 8 |

---

## Variable dictionary

| Variable | Description |
|----------|-------------|
| `GS_fast` / `GS_usual` | Fast / usual gait speed (cm/s) |
| `centre` | Study centre |
| `birth_cohort_10` | Birth cohort (0 = 1940s, 1 = 1950s, 2 = 1960s, 3 = 1970s) |
| `age_c` | Age centered at 45 years (age − 45) |
| `age_c2` | `age_c` squared |
| `age_c_r` | `age_c` rounded to the nearest integer |
| `month_birth` | Month of birth |

---

## Software

These analyses were conducted using **SAS version 9.4** (SAS Institute Inc., Cary, NC, USA).

/***************************************************************************************************************************************************************************************
List of programs SAS9.4.
prg_0.sas	 	multiple imputation of missing values
prg_1.sas	 	relation between age and gait speed 												(fast: Figure 1; usual: Supplementary figure 4)
prg_2.sas	 	relation between month of birth and gait speed after multiple imputation 			(fast: Table 2, Figure 2; usual: Supplementary table 4, Supplementary figure 5)
prg_3.sas	 	contribution of mediators to the relation between month of birth and gait speed 	(fast: Table 3; usual: Supplementary table 5)
prg_4.sas	 	relation between month of birth and gait speed: complete case analysis 				(fast: Supplementary table 6; usual: Supplementary table 7)
prg_5.sas	 	relation between binary month of birth and gait speed after multiple imputation 	(fast: Supplementary table 8)
***************************************************************************************************************************************************************************************/

/************************************************************************************************************************************************
Dictionary
GaitSpeed01									0: GS > age-specific median
											1: GS <= age-specific median
											for fast GS or usual GS (cm/s)
centre 										study centre
birth_cohort_10								birth cohort (0-1940s, 1-1950s, 2-1960s, 3-1970s)
m1 m2 m3 m4 m6 m7 m8 m9 m10 m11 m12			month of birth coded as 11 dummy variables; m5 (May) is the referennce and not included in the model
age_c										age centered at 45 years (age - 45)
age_c2										age_c squared
month6										continuous month (1 to 12) divided by 6
semester									semester of birth (0-1st semester; 1-2nd semester)
************************************************************************************************************************************************/

/*********************************************************************************/
/*********************************************************************************/
/*********************************************************************************/
/********** ANALYSES ADJUSTED FOR CENTER & BIRTH COHORT **************************/
/*********************************************************************************/
/*********************************************************************************/
/*********************************************************************************/

/* Note: age is not included in the model since GaitSpeed01 is defined based on age-specific percentiles */

* categorical month with May as the reference ;
* categorical month with May as the reference ;
* categorical month with May as the reference ;
ods output parameterestimates=coef   covb=cov  ;
proc glimmix data = analysis noclprint method=laplace   ;
class  centre birth_cohort_10 / ref=first;
model GaitSpeed01(event='1') = m1 m2 m3 m4   m6 m7 m8 m9 m10 m11 m12 / dist=binary link=logit ddfm=none chisq solution covb ; 
random intercept / subject=birth_cohort_10 s type=cs ;
random intercept / subject=centre(birth_cohort_10) s type=cs;
by _Imputation_ ; 
run;

ods output  parameterestimates = coefb  TESTMULTSTAT=global_effect_month  ;
proc mianalyze parms=coef covb(effectvar=rowcol)=cov   ; 
modeleffects  m1 m2 m3 m4   m6 m7 m8 m9 m10 m11 m12   ;
global_effect_month : test m1, m2, m3, m4,   m6, m7, m8, m9, m10, m11, m12 / mult ;
run;


* continuous month - difference per increase in 6 months;
* continuous month - difference per increase in 6 months;
* continuous month - difference per increase in 6 months;
ods output parameterestimates=coef ;
proc glimmix data = analysis noclprint method=laplace   ;
class  centre  birth_cohort_10  / ref=first;
model GaitSpeed01event='1') = month6 / dist=binary link=logit ddfm=none chisq   solution covb ; 
random intercept / subject=birth_cohort_10 s type=cs ;
random intercept / subject=centre(birth_cohort_10) s type=cs;
by _Imputation_ ; 
run;

ods output  parameterestimates = coef2   ; 
proc mianalyze parms=coef ;
modeleffects   month6       ;
run;


* semester - reference, 1st semester;
* semester - reference, 1st semester;
* semester - reference, 1st semester;
ods output parameterestimates=coef   ;
proc glimmix data = analysis noclprint method=laplace   ;
class  centre birth_cohort_10 / ref=first;
model GaitSpeed01(event='1') = semester / dist=binary link=logit ddfm=none chisq solution covb ; 
random intercept / subject=birth_cohort_10 s type=cs ;
random intercept / subject=centre(birth_cohort_10) s type=cs;
by _Imputation_ ; 
run;

ods output  parameterestimates = coef    ;
proc mianalyze parms=coef2   ; 
modeleffects semester   ;
run;

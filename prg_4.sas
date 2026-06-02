/***************************************************************************************************************************************************************************************
List of programs SAS9.4.
prg_0.sas	 	multiple imputation of missing values
prg_1.sas	 	relation between age and gait speed 												(fast: Figure 1; usual: Supplementary figure 4)
prg_2.sas	 	relation between month of birth and gait speed after multiple imputation 			(fast: Table 2, Figure 2; usual: Supplementary table 4, Supplementary figure 5)
prg_3.sas	 	contribution of mediators to the relation between month of birth and gait speed 	(fast: Table 3; usual: Supplementary table 5)
prg_4.sas	 	relation between month of birth and gait speed: complete case analysis 				(fast: Supplementary table 6; usual: Supplementary table 7)
prg_5.sas	 	relation between binary month of birth and gait speed after multiple imputation 	(fast: Supplementary table 8)
***************************************************************************************************************************************************************************************/

/**************************************************************************************************************************************
Dictionary
GaitSpeed									fast GS or usual GS (cm/s)
centre 										study centre
birth_cohort_10								birth cohort (0-1940s, 1-1950s, 2-1960s, 3-1970s)
m1 m2 m3 m4 m6 m7 m8 m9 m10 m11 m12			month of birth coded as 11 dummy variables; m5 (May) is the referennce and not included
age_c										age centered at 45 years (age - 45)
age_c2										age_c squared
month6										continuous month (1 to 12) divided by 6
spl3_1 & spl3_2								restricted cubic splines - 3 knots (3, 6, 9)
t1 t2 t3									month of birth coded as 3 dummy variables; t0 is the referennce and not included
semester									semester of birth (0-1st semester; 1-2nd semester)
*************************************************************************************************************************************/

proc sort data = non_imputed ; by id ; run ;

/*********************************************************************************/
/*********************************************************************************/
/*********************************************************************************/
/************************** ANALYSES ADJUSTED FOR CENTER *************************/
/*********************************************************************************/
/*********************************************************************************/
/*********************************************************************************/

* categorical month with May as the reference ;
* categorical month with May as the reference ;
* categorical month with May as the reference ;
ods output solutionf=coef  estimates=adjusted_mean  fitstatistics=aic  covb=cov  ;
proc mixed data = non_imputed noclprint method=ml   ;
class  centre   / ref=first;
model GaitSpeed = m1 m2 m3 m4    m6 m7 m8 m9 m10 m11 m12  / s ddfm=kr covb e3 ; 
random intercept / subject=centre s type=un ;
estimate '1'  intercept 1 m1  1   ;
estimate '2'  intercept 1 m2  1   ;
estimate '3'  intercept 1 m3  1   ;
estimate '4'  intercept 1 m4  1   ;
estimate '5'  intercept 1         ;
estimate '6'  intercept 1 m6  1   ;
estimate '7'  intercept 1 m7  1   ;
estimate '8'  intercept 1 m8  1   ;
estimate '9'  intercept 1 m9  1   ;
estimate '10' intercept 1 m10 1   ;
estimate '11' intercept 1 m11 1   ;
estimate '12' intercept 1 m12 1   ;
run;

ods output tests3=global_effect_month ;
proc mixed data = non_imputed noclprint method=ml   ;
class  centre month  / ref=first;
model GaitSpeed = month / s ddfm=kr covb e3 ; 
random intercept / subject=centre s type=un ;
run;

* continuous month - difference per increase in 6 months;
* continuous month - difference per increase in 6 months;
* continuous month - difference per increase in 6 months;
ods output solutionf=coef fitstatistics= aic  covb=cov  ;
proc mixed data = non_imputed noclprint method=ml   ;
class  centre     / ref=first;
model GaitSpeed = month6  / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
run;


* trimester - reference, 1st trimester;
* trimester - reference, 1st trimester;
* trimester - reference, 1st trimester;
ods output solutionf=coef estimates=adjusted_mean fitstatistics= aic  covb=cov ;
proc mixed data = non_imputed noclprint method=ml   ;
class  centre   / ref=first;
model GaitSpeed = t1 t2 t3    / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
estimate '0'  intercept 1          ;
estimate '1'  intercept 1 t1  1    ;
estimate '2'  intercept 1 t2  1    ;
estimate '3'  intercept 1 t3  1    ;
run;

ods output tests3=global_effect_trimester ;
proc mixed data = non_imputed noclprint method=ml   ;
class  centre trimester  / ref=first;
model GaitSpeed = trimester / s ddfm=kr covb e3 ; 
random intercept / subject=centre s type=un ;
run;


* semester ;
* semester ;
* semester ;
ods output solutionf=coef estimates=adjusted_mean fitstatistics= aic covb=cov  ;
proc mixed data = non_imputed noclprint method=ml   ;
class  centre   / ref=first;
model GaitSpeed = semester  / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
estimate '0'  intercept 1       		 ;
estimate '1'  intercept 1 semestre  1 	 ;
run;


* additional non_imputed (test of linearity): restricted cubic spline with 3 knots;
* additional non_imputed (test of linearity): restricted cubic spline with 3 knots;
* additional non_imputed (test of linearity): restricted cubic spline with 3 knots;
ods output solutionf=coef fitstatistics= aic covb=cov   ;
proc mixed data = non_imputed noclprint method=ml   ;
class  centre   / ref=first;
model GaitSpeed = spl3_mois_1 spl3_mois_2  / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
run;



/*********************************************************************************/
/*********************************************************************************/
/*********************************************************************************/
/********** ANALYSES ADJUSTED FOR CENTER, AGE, & BIRTH COHORT ********************/
/*********************************************************************************/
/*********************************************************************************/
/*********************************************************************************/

* categorical month with May as the reference ;
* categorical month with May as the reference ;
* categorical month with May as the reference ;
ods output solutionf=coef  estimates=adjusted_mean  fitstatistics=aic  covb=cov ;
proc mixed data = non_imputed noclprint method=ml   ;
class  centre birth_cohort_10 / ref=first;
model GaitSpeed = m1 m2 m3 m4    m6 m7 m8 m9 m10 m11 m12 age_c age_c2 / s ddfm=kr covb e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
estimate '1'  intercept 1 m1  1 age_c 12 age_c2 144   ;
estimate '2'  intercept 1 m2  1 age_c 12 age_c2 144   ;
estimate '3'  intercept 1 m3  1 age_c 12 age_c2 144   ;
estimate '4'  intercept 1 m4  1 age_c 12 age_c2 144   ;
estimate '5'  intercept 1       age_c 12 age_c2 144   ;
estimate '6'  intercept 1 m6  1 age_c 12 age_c2 144   ;
estimate '7'  intercept 1 m7  1 age_c 12 age_c2 144   ;
estimate '8'  intercept 1 m8  1 age_c 12 age_c2 144   ;
estimate '9'  intercept 1 m9  1 age_c 12 age_c2 144   ;
estimate '10' intercept 1 m10 1 age_c 12 age_c2 144   ;
estimate '11' intercept 1 m11 1 age_c 12 age_c2 144   ;
estimate '12' intercept 1 m12 1 age_c 12 age_c2 144   ;
run;

ods output tests3=global_effect_month ;
proc mixed data = non_imputed noclprint method=ml   ;
class  centre month  birth_cohort_10 / ref=first;
model GaitSpeed = month age_c age_c2  / s ddfm=kr covb e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
run;


* continuous month - difference per increase in 6 months;
* continuous month - difference per increase in 6 months;
* continuous month - difference per increase in 6 months;
ods output solutionf=coef estimates=adjusted_mean fitstatistics= aic  covb=cov  ;
proc mixed data = non_imputed noclprint method=ml   ;
class  centre  birth_cohort_10  / ref=first;
model GaitSpeed = month6 age_c age_c2       / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
run;


* trimester - reference, 1st trimester;
* trimester - reference, 1st trimester;
* trimester - reference, 1st trimester;
ods output solutionf=coef estimates=adjusted_mean fitstatistics= aic  covb=cov ;
proc mixed data = non_imputed noclprint method=ml   ;
class  centre birth_cohort_10 / ref=first;
model GaitSpeed = t1 t2 t3 age_c age_c2       / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
estimate '0'  intercept 1       age_c 12 age_c2 144   ;
estimate '1'  intercept 1 t1  1 age_c 12 age_c2 144   ;
estimate '2'  intercept 1 t2  1 age_c 12 age_c2 144   ;
estimate '3'  intercept 1 t3  1 age_c 12 age_c2 144   ;
run;

ods output tests3=global_effect_trimester ;
proc mixed data = non_imputed noclprint method=ml   ;
class  centre trimester birth_cohort_10 / ref=first;
model GaitSpeed = trimester age_c age_c2   / s ddfm=kr covb e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
run;


* semester - reference, 1st semester;
* semester - reference, 1st semester;
* semester - reference, 1st semester;
ods output solutionf=coef estimates=adjusted_mean fitstatistics= aic covb=cov  ;
proc mixed data = non_imputed noclprint method=ml   ;
class  centre birth_cohort_10 / ref=first;
model GaitSpeed = semester  age_c age_c2  / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
estimate '0'  intercept 1       		age_c 12 age_c2 144   ;
estimate '1'  intercept 1 semestre  1 	age_c 12 age_c2 144   ;
run;


* additional non_imputed (test of linearity): restricted cubic spline with 3 knots;
* additional non_imputed (test of linearity): restricted cubic spline with 3 knots;
* additional non_imputed (test of linearity): restricted cubic spline with 3 knots;
ods output solutionf=coef fitstatistics= aic covb=cov   ;
proc mixed data = non_imputed noclprint method=ml   ;
class  centre birth_cohort_10   / ref=first;
model GaitSpeed = spl3_mois_1 spl3_mois_2   age_c age_c2 / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
run;

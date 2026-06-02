/***************************************************************************************************************************************************************************************
List of programs SAS9.4.
prg_0.sas	 	multiple imputation of missing values
prg_1.sas	 	relation between age and gait speed 												(fast: Figure 1; usual: Supplementary figure 4)
prg_2.sas	 	relation between month of birth and gait speed after multiple imputation 			(fast: Table 2, Figure 2; usual: Supplementary table 4, Supplementary figure 5)
prg_3.sas	 	contribution of mediators to the relation between month of birth and gait speed 	(fast: Table 3; usual: Supplementary table 5)
prg_4.sas	 	relation between month of birth and gait speed: complete case analysis 				(fast: Supplementary table 6; usual: Supplementary table 7)
prg_5.sas	 	relation between binary month of birth and gait speed after multiple imputation 	(fast: Supplementary table 8)
***************************************************************************************************************************************************************************************/

/************************************************************************************************
Dictionary
GaitSpeed			fast GS or usual GS (cm/s)
centre 				study centre
birth_cohort_10		birth cohort (0-1940s, 1-1950s, 2-1960s, 3-1970s)
age_c				age centered at 45 years (age - 45)
age_c2				age_c squared
age_c_r				age_c rounded to the nearest integer
************************************************************************************************/

* association between age and gait speed with a quadratic effect of continuous age ; 
* association between age and gait speed with a quadratic effect of continuous age ; 
* association between age and gait speed with a quadratic effect of continuous age ;

ods output solutionf=age estimates=estim_age  fitstatistics= aic_age covb=cov_age ;
proc mixed data = analysis noclprint method=ml   ;
class  centre birth_cohort_10 / ref=first;
model GaitSpeed =  age_c age_c2    / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
estimate '0 '  intercept 1 age_c 0  age_c2 0     ;
estimate '1 '  intercept 1 age_c 1  age_c2 1     ;
estimate '2 '  intercept 1 age_c 2  age_c2 4     ;
estimate '3 '  intercept 1 age_c 3  age_c2 9     ;
estimate '4 '  intercept 1 age_c 4  age_c2 16    ;
estimate '5 '  intercept 1 age_c 5  age_c2 25    ;
estimate '6 '  intercept 1 age_c 6  age_c2 36    ;
estimate '7 '  intercept 1 age_c 7  age_c2 49    ;
estimate '8 '  intercept 1 age_c 8  age_c2 64    ;
estimate '9 '  intercept 1 age_c 9  age_c2 81    ;
estimate '10'  intercept 1 age_c 10 age_c2 100   ;
estimate '11'  intercept 1 age_c 11 age_c2 121   ;
estimate '12'  intercept 1 age_c 12 age_c2 144   ;
estimate '13'  intercept 1 age_c 13 age_c2 169   ;
estimate '14'  intercept 1 age_c 14 age_c2 196   ;
estimate '15'  intercept 1 age_c 15 age_c2 225   ;
estimate '16'  intercept 1 age_c 16 age_c2 256   ;
estimate '17'  intercept 1 age_c 17 age_c2 289   ;
estimate '18'  intercept 1 age_c 18 age_c2 324   ;
estimate '19'  intercept 1 age_c 19 age_c2 361   ;
estimate '20'  intercept 1 age_c 20 age_c2 400   ;
estimate '21'  intercept 1 age_c 21 age_c2 441   ;
estimate '22'  intercept 1 age_c 22 age_c2 484   ;
estimate '23'  intercept 1 age_c 23 age_c2 529   ;
estimate '24'  intercept 1 age_c 24 age_c2 576   ;
estimate '25'  intercept 1 age_c 25 age_c2 625   ;
by _Imputation_ ; 
run;

ods output  parameterestimates = age2  ;
proc mianalyze parms=age     ;
modeleffects intercept age_c age_c2   ;
run;

proc sort data = estim_age ; by Label ; run ;
ods output  parameterestimates = estim_age2 ;
proc mianalyze data=estim_age ;
modeleffects estimate ;
stderr StdErr ;
by Label ;
run;


* association between categorical age (per 1 year) and gait speed  ; 
* association between categorical age (per 1 year) and gait speed  ; 
* association between categorical age (per 1 year) and gait speed  ; 

ods output solutionf=age  estimates=estim_age  fitstatistics=aic_age covb=cov_age ;
proc mixed data = analysis noclprint method=ml   ;
class  centre age_c_r birth_cohort_10  / ref=first;
model GaitSpeed = age_c_r   / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
estimate '0 '  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1    ;
estimate '1 '  intercept 1 age_c_r 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '2 '  intercept 1 age_c_r 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '3 '  intercept 1 age_c_r 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '4 '  intercept 1 age_c_r 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '5 '  intercept 1 age_c_r 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '6 '  intercept 1 age_c_r 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '7 '  intercept 1 age_c_r 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '8 '  intercept 1 age_c_r 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '9 '  intercept 1 age_c_r 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '10'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '11'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '12'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '13'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '14'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '15'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0    ;
estimate '16'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0    ;
estimate '17'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0    ;
estimate '18'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0    ;
estimate '19'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0    ;
estimate '20'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0    ;
estimate '21'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0    ;
estimate '22'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0    ;
estimate '23'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0    ;
estimate '24'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0    ;
estimate '25'  intercept 1 age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0    ;
by _Imputation_ ; 
run;

ods output  parameterestimates = age2 ;
proc mianalyze parms(classvar=full)=age      ;
class age_c_r ;
modeleffects intercept age_c_r   ;
run;

proc sort data = estim_age ; by Label ; run ;
ods output  parameterestimates = estim_age2 ;
proc mianalyze data=estim_age ;
modeleffects estimate ;
stderr StdErr ;
by Label ;
run;

* difference between two adjacent ages ;
* difference between two adjacent ages ;
* difference between two adjacent ages ;

ods output  estimates=estim_age   ;
proc mixed data = analysis noclprint method=ml   ;
class  centre age_c_r birth_cohort_10  / ref=first;
model GaitSpeed = age_c_r   / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
estimate '1  vs 0 '  age_c_r 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  -1   ;
estimate '2  vs 1 '  age_c_r -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  0   ;
estimate '3  vs 2 '  age_c_r 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  0   ;
estimate '4  vs 3 '  age_c_r 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  0   ;
estimate '5  vs 4 '  age_c_r 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  0   ;
estimate '6  vs 5 '  age_c_r 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  0   ;
estimate '7  vs 6 '  age_c_r 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  0   ;
estimate '8  vs 7 '  age_c_r 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  0   ;
estimate '9  vs 8 '  age_c_r 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  0   ;
estimate '10 vs 9 '  age_c_r 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  0   ;
estimate '11 vs 10'  age_c_r 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0  0   ;
estimate '12 vs 11'  age_c_r 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0  0   ;
estimate '13 vs 12'  age_c_r 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0  0   ;
estimate '14 vs 13'  age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0  0   ;
estimate '15 vs 14'  age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0  0   ;
estimate '16 vs 15'  age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0  0   ;
estimate '17 vs 16'  age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0  0   ;
estimate '18 vs 17'  age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0  0   ;
estimate '19 vs 18'  age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0  0   ;
estimate '20 vs 19'  age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0  0   ;
estimate '21 vs 20'  age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0  0   ;
estimate '22 vs 21'  age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0  0   ;
estimate '23 vs 22'  age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0  0   ;
estimate '24 vs 23'  age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0  0   ;
estimate '25 vs 24'  age_c_r 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1  0   ;
by _Imputation_ ; 
run;

proc sort data = estim_age  ; by Label ; run ;
ods output  parameterestimates = estim_age2 ;
proc mianalyze data=estim_age  ;
modeleffects estimate ;
stderr StdErr ;
by Label ;
run;

proc means data=estim_age2 ; var Estimate StdErr ; run;

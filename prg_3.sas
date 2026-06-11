/***************************************************************************************************************************************************************************************
List of programs SAS9.4.
prg_0.sas	 	multiple imputation of missing values
prg_1.sas	 	relation between age and gait speed 												(fast: Figure 1; usual: Supplementary figure 4)
prg_2.sas	 	relation between month of birth and gait speed after multiple imputation 			(fast: Table 2, Figure 2; usual: Supplementary table 4, Supplementary figure 5)
prg_3.sas	 	contribution of mediators to the relation between month of birth and gait speed 	(fast: Table 3; usual: Supplementary table 5)
prg_4.sas	 	relation between month of birth and gait speed: complete case analysis 				(fast: Supplementary table 6; usual: Supplementary table 7)
prg_5.sas	 	relation between binary month of birth and gait speed after multiple imputation 	(fast: Supplementary table 8)
***************************************************************************************************************************************************************************************/

/*********************************************************************************************************************************************
Dictionary
GaitSpeed									fast GS or usual GS (cm/s)
centre 										study centre
birth_cohort_10								birth cohort (0-1940s, 1-1950s, 2-1960s, 3-1970s)
month										semester of birth (0-1st semester; 1-2nd semester) OR continuous month (1 to 12) divided by 6
age_c										age centered at 45 years (age - 45)
age_c2										age_c squared

M0			Without covariates
M1			M0 + Sex
M2			M1 + Socio-professional characteristics
M3			M2 + Health behaviours
M4			M3 + Anthropometric characteristics
M5			M4 + Cardiovascular diseases & risk factors & Comorbidites
M6.1.		M5 + Grip strength
M6.2.		M5 + Phonological fluency_phonological
M7.1.		Fully adjusted model with Phonological fluency_phonological
M7.2.		Fully adjusted model without cognition
*******************************************************************************************************************************************/

* M0: model without any mediator ;
ods output solutionf=coef ;
proc mixed data = analysis noclprint method=ml   ;
class  centre birth_cohort_10  / ref=first;
model GaitSpeed = month age_c age_c2  / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
by _Imputation_ ; 
run;

ods output  parameterestimates = coef2  ;
proc mianalyze parms=coef  ;
modeleffects month ;
run;

* M1: Mediator = Sex ;
* PR = 100 * (beta_month_M1 - beta_month_M0) / beta_month_M0 ;
ods output solutionf=coef ;
proc mixed data = analysis noclprint method=ml   ;
class  centre birth_cohort_10  / ref=first;
model GaitSpeed = 	month age_c age_c2 
					sex / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
by _Imputation_ ; 
run;

ods output  parameterestimates = coef2  ;
proc mianalyze parms=coef  ;
modeleffects month ;
run;


* M2: Mediator = Sociodemographic characteristics;
* PR = 100 * (beta_month_M2 - beta_month_M1) / beta_month_M1;
ods output solutionf=coef ;
proc mixed data = analysis noclprint method=ml   ;
class  centre birth_cohort_10 education marital_status  strenuous_work / ref=first;
model GaitSpeed = 	month age_c age_c2 
					sex 
					education  marital_status  strenuous_work  / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
by _Imputation_ ; 
run;

ods output  parameterestimates = coef2  ;
proc mianalyze parms=coef  ;
modeleffects month ;
run;


* M3: Mediator = health behaviours ;
* PR = 100 * (beta_month_M3 - beta_month_M2) / beta_month_M2 ;
ods output solutionf=coef ;
proc mixed data = analysis noclprint method=ml   ;
class  centre birth_cohort_10 education  marital_status  strenuous_work alcohol physical_activity smoking fruits vegetables / ref=first;
model GaitSpeed = 	month age_c age_c2 
					sex 
					education  marital_status  strenuous_work  
					alcohol physical_activity smoking fruits vegetables / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
by _Imputation_ ; 
run;

ods output  parameterestimates = coef2  ;
proc mianalyze parms=coef  ;
modeleffects month ;
run;


* M4: Mediator = Anthropometric characteristics ;
* PR = 100 * (beta_month_M4 - beta_month_M3) / beta_month_M3 ;
ods output solutionf=coef ;
proc mixed data = analysis noclprint method=ml   ;
class  centre birth_cohort_10 education  marital_status  strenuous_work alcohol physical_activity smoking fruits vegetables / ref=first;
model GaitSpeed = 	month age_c age_c2 
					sex 
					education  marital_status  strenuous_work  
					alcohol physical_activity smoking fruits vegetables 
					BMI height / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
by _Imputation_ ; 
run;

ods output  parameterestimates = coef2  ;
proc mianalyze parms=coef  ;
modeleffects month ;
run;


* M5: Mediator = cardiovascular risk factors/diseases & comorbidities ;
* PR = 100 * (beta_month_M5 - beta_month_M4) / beta_month_M4 ;
ods output solutionf=coef ;
proc mixed data = analysis noclprint method=ml   ;
class  centre birth_cohort_10 education  marital_status  strenuous_work alcohol physical_activity smoking fruits vegetables 
	   hypertension diabetes CVD hypercholesterolemia respiratory rheumatological orthopedic cesd sensory / ref=first;
model GaitSpeed = 	month age_c age_c2 
					sex 
					education  marital_status  strenuous_work  
					alcohol physical_activity smoking fruits vegetables 
					BMI height 
					hypertension diabetes CVD hypercholesterolemia respiratory rheumatological orthopedic cesd sensory / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
by _Imputation_ ; 
run;

ods output  parameterestimates = coef2  ;
proc mianalyze parms=coef  ;
modeleffects month ;
run;


* M6.1.: Mediator = grip strength ;
* PR = 100 * (beta_month_M61 - beta_month_M5) / beta_month_M5;
ods output solutionf=coef ;
proc mixed data = analysis noclprint method=ml   ;
class  centre birth_cohort_10 education  marital_status  strenuous_work alcohol physical_activity smoking fruits vegetables 
	   hypertension diabetes CVD hypercholesterolemia respiratory rheumatological orthopedic cesd sensory / ref=first;
model GaitSpeed = 	month age_c age_c2 
					sex 
					education  marital_status  strenuous_work  
					alcohol physical_activity smoking fruits vegetables 
					BMI height 
					hypertension diabetes CVD hypercholesterolemia respiratory rheumatological orthopedic cesd sensory 
					grip_strength / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
by _Imputation_ ; 
run;

ods output  parameterestimates = coef2  ;
proc mianalyze parms=coef  ;
modeleffects month ;
run;


* M6.2.: Mediator = phonological fluency_phonological ;
* PR = 100 * (beta_month_M62b - beta_month_M5) / beta_month_M5;
ods output solutionf=coef ;
proc mixed data = analysis noclprint method=ml   ;
class  centre birth_cohort_10 education  marital_status  strenuous_work alcohol physical_activity smoking fruits vegetables 
	   hypertension diabetes CVD hypercholesterolemia respiratory rheumatological orthopedic cesd sensory / ref=first;
model GaitSpeed = 	month age_c age_c2 
					sex 
					education  marital_status  strenuous_work  
					alcohol physical_activity smoking fruits vegetables 
					BMI height 
					hypertension diabetes CVD hypercholesterolemia respiratory rheumatological orthopedic cesd sensory 
					fluency_phonological / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
by _Imputation_ ; 
run;

ods output  parameterestimates = coef2  ;
proc mianalyze parms=coef  ;
modeleffects month ;
run;


* M7.1.: Fully adjusted model with phonological fluency  ;
* PR = 100 * (beta_month_M72 - beta_month_M0) / beta_month_M0;
ods output solutionf=coef ;
proc mixed data = analysis noclprint method=ml   ;
class  centre birth_cohort_10 education  marital_status  strenuous_work alcohol physical_activity smoking fruits vegetables 
	   hypertension diabetes CVD hypercholesterolemia respiratory rheumatological orthopedic cesd sensory / ref=first;
model GaitSpeed = 	month age_c age_c2 
					sex 
					education  marital_status  strenuous_work  
					alcohol physical_activity smoking fruits vegetables 
					BMI height 
					hypertension diabetes CVD hypercholesterolemia respiratory rheumatological orthopedic cesd sensory 
					grip_strength
					fluency_phonological / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
by _Imputation_ ; 
run;

ods output  parameterestimates = coef2  ;
proc mianalyze parms=coef  ;
modeleffects month ;
run;


* M7.2.: Fully adjusted model without phonological fluency : same as M6.1.;
* PR = 100 * (beta_month_M73 - beta_month_M0) / beta_month_M0;
ods output solutionf=coef ;
proc mixed data = analysis noclprint method=ml   ;
class  centre birth_cohort_10 education  marital_status  strenuous_work alcohol physical_activity smoking fruits vegetables 
	   hypertension diabetes CVD hypercholesterolemia respiratory rheumatological orthopedic cesd sensory / ref=first;
model GaitSpeed = 	month age_c age_c2 
					sex 
					education  marital_status  strenuous_work  
					alcohol physical_activity smoking fruits vegetables 
					BMI height 
					hypertension diabetes CVD hypercholesterolemia respiratory rheumatological orthopedic cesd sensory 
					grip_strength / s ddfm=kr covb  e3 ; 
random intercept / subject=centre s type=un ;
random intercept / subject=birth_cohort_10(centre) s type=un;
by _Imputation_ ; 
run;

ods output  parameterestimates = coef2  ;
proc mianalyze parms=coef  ;
modeleffects month ;
run;


/* Bootstrap for the 95% CI of the PR */
proc surveyselect data= analysis out=analysis_boot
     seed = 4698 method = urs
	 samprate = 1 outhits rep = 500 ;
	 strata _Imputation_ ; 
run;

/* 	
The same analyses were performed separately for each of the 500 replicates.
The lower and upper 95% CIs of the PR were defined as the 5th and 95th percentiles respectively of the distribution of PR across the 500 replicates 
*/
	

/***************************************************************************************************************************************************************************************
List of programs SAS9.4.
prg_0.sas	 	multiple imputation of missing values
prg_1.sas	 	relation between age and gait speed 												(fast: Figure 1; usual: Supplementary figure 4)
prg_2.sas	 	relation between month of birth and gait speed after multiple imputation 			(fast: Table 2, Figure 2; usual: Supplementary table 4, Supplementary figure 5)
prg_3.sas	 	contribution of mediators to the relation between month of birth and gait speed 	(fast: Table 3; usual: Supplementary table 5)
prg_4.sas	 	relation between month of birth and gait speed: complete case analysis 				(fast: Supplementary table 6; usual: Supplementary table 7)
prg_5.sas	 	relation between binary month of birth and gait speed after multiple imputation 	(fast: Supplementary table 8)
***************************************************************************************************************************************************************************************/

proc mi data= analysis0 nimpute = 20 out = analysis0 seed = 4178 ;
class   		centre 				month_birth			birth_cohort_10 
				sex     	 
				education 			prof_category   	prof_category_father   	income   				marital_status		strenuous_work
				hypertension   		diabetes   			CVD   					hypercholesterolemia   	respiratory   
				rheumatological   	orthopedic          kidney_disease			sensory					CESD				cancer 
				alcohol  	 		physical_activity   smoking   				fruits   				vegetables 
				hour_examination   	general_health      balance   				fall   		stairs  	walk_1k   			carry_load ;
fcs logistic( 	centre 				month_birth			birth_cohort_10 
				sex     	 
				education 			prof_category   	prof_category_father   	income   				marital_status		strenuous_work
				hypertension   		diabetes   			CVD   					hypercholesterolemia   	respiratory   
				rheumatological   	orthopedic          kidney_disease			sensory					CESD				cancer 
				alcohol  	 		physical_activity   smoking   				fruits   				vegetables 
				hour_examination   	general_health      balance   				fall   		stairs  	walk_1k   			carry_load / details link=glogit) ; 
var		
/* categorical variables */
				centre 				month_birth			birth_cohort_10 
				sex     	 
				education 			prof_category   	prof_category_father   	income   				marital_status		strenuous_work
				hypertension   		diabetes   			CVD   					hypercholesterolemia   	respiratory   
				rheumatological   	orthopedic          kidney_disease			sensory					CESD				cancer 
				alcohol  	 		physical_activity   smoking   				fruits   				vegetables 
				hour_examination   	general_health      balance   				fall   		stairs  	walk_1k   			carry_load 
/* continuous variables */
				age_c		age_c2
				BMI 		height
				MMSE		TMT_A		TMT_B	wechsler	fluence_phonological	fluence_semantic	recall_immediate	recall_delayed
				grip_strength
				GS_usual	GS_fast  ;
run ;


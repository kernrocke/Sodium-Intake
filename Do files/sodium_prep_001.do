

**  GENERAL DO-FILE COMMENTS
**  program:		sodium_prep_001.do
**  project:      	Population Dietary Sodium Intake- Trinidad and Tobago 
**  author:       	Rocke 15-OCT-2018
**  task:          	Preparation of Dietary Sodium dataset


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 200

***Load sodium dataset
use "C:\Users\Rock\Dropbox\C_1\Consultations\Projects\Dietary Sodium Study\Data\Salt Data\Project_Salt_v3.dta", clear

***Recoding of Ethnicity to 3-categories
gen race=Ethnicity
recode race (3/max=3)
label var race "Ethnicity (recoded)"
label define race 1"Indo-decent" 2"Afro-decent" 3"Mixed-decent"
label value race race

***Cleaning Family History of Disease variables
recode Fam_HD (2/max=1)
recode Family_Dia (10=1)
recode Family_Cancer (10=1)


*** Create single FACTOR variable for all Family History of CNCDs
gen fam_disease = .
replace fam_disease = 1 	if Fam_HD==1
replace fam_disease = 2 	if Family_HTN==1
replace fam_disease = 3 	if Family_Dia==1
replace fam_disease = 4 	if Family_Cancer==1

label var fam_disease "Family History of CNCDs"
label define fam_disease 1"Heart Disease" 2"Hypertension" 3"Diabetes" 4"Cancer"
label value fam_disease fam_disease

*** Create single FACTOR variable for all Personal History of CNCDs
gen per_disease = .
replace per_disease = 1 	if Personal_HD==1
replace per_disease = 2 	if Personal_HTN==1
replace per_disease = 3 	if Personal_Dia==1
replace per_disease = 4 	if Personal_Cancer==1

label var per_disease "Personal History of CNCDs"
label define per_disease 1"Heart Disease" 2"Hypertension" 3"Diabetes" 4"Cancer"
label value per_disease per_disease

drop Fam_HD-Personal_No

order PID Sex Age race MStatus Edu fam_disease per_disease sodium_day calories_day

sort PID Sex Age

***Removing previous estimated Sodium Intake variables
drop beer1- Salt1
drop sodium sodium_day

***Saving the dataset
save "C:\Users\Rock\Dropbox\C_1\Consultations\Projects\Dietary Sodium Study\Data\Salt Data\Project_Salt_v4.dta", replace

//Closing log file
log close

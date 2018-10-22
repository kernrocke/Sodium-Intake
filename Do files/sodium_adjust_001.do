
cls

//Opening log file
log using "C:\Users\Rock\Desktop\Bitbucket\Sodium-Intake\Log files\sodium_adjust_001", text replace

*	============================================================================
*					The University of the West Indies
*
*	Title:			sodium_adjust_001.do
*	Created Date:	22/10/2018
*	Author:			Kern Rocke
*	Dataset:		Project_Salt_v4.dta
*	Purpose:		Adjustment of sodium intake
*	Last modfied:	22/10/2018
*	
*	============================================================================


*	============
*	1. SETUP
*	============

version 13
clear all
clear matrix
capture clear all
capture log close
clear all
macro drop _all
numlabel, add

set more 5
set seed 2581240
set linesize 250


*===============================================================================
*								Date Preparation
*===============================================================================		

//Data house keeping tasks

***Load prepared sodium dataset
use "C:\Users\Rock\Dropbox\C_1\Consultations\Projects\Dietary Sodium Study\Data\Salt Data\Project_Salt_v4.dta", clear


***Multiply intake of food items by dietary sodium level for each food item

gen beer1= Beer*14
gen Milk1= Milk*34
gen IceCream1= IceCream*33
gen Yogurt1= Yogurt*53
gen Meat1= Meat*67
gen Crackers1= Crackers*107
gen Eggs1= Eggs*70
gen Cereal1= Cereal*192
gen Chocolate1= Chocolate*13
gen Pasta1= Pasta*166
gen Chow1= Chow*285
gen Fries1= Fries*171
gen Preservatives1= Preservatives *220
gen Doughnut1= Doughnut *181
gen Butter1= Butter *82
gen ChickenBur1= ChickenBur *113
gen CannedFish1= CannedFish *466
gen Ham1= Ham *365
******************************************************************
gen Roti1= Roti *195
gen Doubles1= Doubles *166
gen Beans1= Beans *341
gen Cheese1= Cheese *174
gen Sada1= Sada *153
gen Soup1= Soup *459
gen Nuts1= Nuts *60
gen WheatBread1= WheatBread *276
gen Pies1= Pies *165
gen PButter1= PButter *73
gen WhiteBread1= WhiteBread *340
gen Souse1= Souse *191
gen Pizza1= Pizza *152
gen MeatPies1= MeatPies *207
gen Sauce1= Sauce *149
gen PorkSausage1= PorkSausage *1095
gen SoySauce1= SoySauce *502
gen Fish1= Fish *174
gen Dressings1= Dressings *197
gen BeefSausage1= BeefSausage *146
******************************************************************
gen Margarine1= Margarine *112
gen Ketchup1= Ketchup *167
gen SmokedFish1= SmokedFish *221
gen SRoll1= SRoll *117
gen SaltedBeef1= SaltedBeef *380
gen Bacon1= Bacon *116
gen CBeef1= CBeef *345
gen Snacks1= Snacks *596
gen BCereal1= BCereal *199
gen BPies1= BPies *241
gen Popcorn1= Popcorn *300
gen Soups1= Soups *830
gen MSG1= MSG *80
gen Chutney1= Chutney *68
gen Pigtail1= Pigtail *597
gen Gravy1= Gravy *159
gen Mustard1= Mustard *318
gen Seasonings1= Seasonings *220
gen Salt1= Salt *155
******************************************************************

*Summate food items sodium levels to calculate weekly sodium intake
egen sodium= rowtotal ( beer1- Salt1)

*Generate daily sodium intake level
gen sodium_day= sodium/7

*Apply ceilings and foundation criteria [500 mg for foundation and 8000 mg for ceiling]
recode sodium_day (min/500=500) (8000/max=8000)
summ sodium_day, detail

*Distribution of estimated daily sodium intake 
histogram sodium_day, normal

*Correlation of dietary intake and caloric intake
pwcorr sodium_day calories_day, sig

*Regression model for adjustment for total caloric intake, sex and age
*Use robust or jacknife standard errors
regress sodium_day calories_day i.Sex Age, vce(robust)

*Predict residuals from regression model
predict res, residuals

*Create new variable for adjusted sodium variable
gen adjus_sodium= sodium_day - res

*Apply ceilings and foundation criteria [500 mg for foundation and 8000 mg for ceiling]
recode adjus_sodium (min/500=500) (8000/max)

*Inspect normal distribution for adjusted sodium intake
histogram adjus_sodium, normal

*Compare mean intakes for unadjusted and adjusted sodium intake variables
sum sodium_day adjus_sodium
mean sodium_dau adjus_sodium


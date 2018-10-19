cls
*	============================================================================
*					The University of the West Indies
*
*	Title:			sodium_template.do
*	Created Date:	15/06/2016
*	Author:			Kern Rocke
*	Dataset:		Project_Salt_v3.dta
*	Purpose:		Data Management and Data cleaning
*	Last modfied:	18/10/2018
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


*	============================================================================
*								Organization and Preparation
*	============================================================================
/*	Within the folder for this project create seperate folders for your Do, Data,
	Log, Images/Charts and Excel files. */
	
global date	"181018"		//date program is run in YYMMDD format, change everytime the file is run
							// For example "910103" would be January 03, 1991
							
		global directory 	"FILE PATH"
		global do			"$(directory)\Do"
		global logs			"$(directory)\Logs"
		global data			"$(directory)\Data"
		global images		"$(directory)\Graphs"
		global excel		"$(directory)\Excel"

/* NOTE
 Within the Data folder, you will need a folder called "orginal" and one called 
 "working"
 Make sure all .do program files end in the correct date! 
 */

*===============================================================================
*								Date Preparation
*===============================================================================		

//Data house keeping tasks

//Opening log file
log using "FILE PATH", text replace

//Directory
cd "FILE PATH"

//Open dataset
use "\dataset.dta", clear

//Opening log file
log using "FILE PATH", text replace

*-------------------------------------------------------------------------------

*


//Saving dataset
save "FILE PATH", replace

//Closing log file
log close









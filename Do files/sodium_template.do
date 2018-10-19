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
							
		global directory 	"C:\Users\Rock\Desktop\Bitbucket\Sodium-Intake"
		global do			"$C:\Users\Rock\Desktop\Bitbucket\Sodium-Intake\Do files"
		global logs			"$C:\Users\Rock\Desktop\Bitbucket\Sodium-Intake\Log files"
		global data			"$C:\Users\Rock\Desktop\Bitbucket\Sodium-Intake\Data"
		global images		"$C:\Users\Rock\Desktop\Bitbucket\Sodium-Intake\Graphs"
		global excel		"$C:\Users\Rock\Desktop\Bitbucket\Sodium-Intake\Excel"

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
log using "C:\Users\Rock\Desktop\Bitbucket\Sodium-Intake\Log files\sodium_prep_00", text replace

//Directory
cd "C:\Users\Rock\Desktop\Bitbucket\Sodium-Intake\Data\Orginal"

//Open dataset
use "Project_Salt_v3.dta", clear

*-------------------------------------------------------------------------------

*


//Saving dataset
save "FILE PATH", replace

//Closing log file
log close









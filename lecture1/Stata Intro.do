*********************************************************
//Into to Stata
//Background: https://grodri.github.io/stata/tutorial.pdf
*********************************************************

//Set up your working environment

	//a. tell Stata your version, and to start fresh
	version 16
	clear
	capture log close

	//b. set working directory
	cd "/Users/denier/Dropbox/Alberta/SOC 509/Data/ LFS/"
	
	//c. set up a log file to record output
	log using lfslog, text replace
	
	/*annote everything using /**/ or // */


//Load data into Stata, save as Stata file
import delimited LFS_July17_21.csv

compress
save LFS_July17_21.dta, replace

clear
use LFS_July17_21.dta

//Can also read-in data from web 
*import delimited "https://raw.githubusercontent.com/MMaroto729/SOC-509/main/data/LFS_July17_21.csv"

//Inspect the data

describe
br

//Generate and manipulate variables
gen ontario=.
replace ontario=1 if prov==35
replace ontario=0 if inlist(prov, 10, 11, 12, 13, 24, 46, 47, 48, 59)

tab prov, gen(prcat)
tab ontario prcat6

rename prcat6 ONTARIO

gen edcat=.
replace edcat=0 if educ==0
replace edcat=1 if educ>0 & educ<.

//Descriptive statistics

summarize educ hrlyearn

sum educ
tab educ
tab educ, m

list educ hrlyearn if missing(hrlyearn)

graph twoway scatter hrlyearn educ, ///
title(Education and Earnings) xtitle(Education)

table educ

// Regression 

regress hrlyearn educ
predict pearn
graph twoway (scatter hrlyearn educ) (lfit hrlyearn educ) ///
, title(Education and Earnings) xtitle(Education)

//Use stata as a calculator with display
display 2+2
di 2+2
help display
log close

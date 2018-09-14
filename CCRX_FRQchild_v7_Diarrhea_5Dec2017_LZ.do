/*******************************************************************************
*
*  FILENAME:	CCRX_FRQchild_v2_Diarrhea_$date.do
*  PURPOSE:		Label and encode child diarrhea questions
*  CREATED:		Linnea Zimmerman (lzimme12@jhu.edu)
*  DATA IN:		CCRX_Combined_$date.dta
*  DATA OUT:	CCRX_Combined_$date.dta
*  UPDATES:		
*            6June2017 HC made changes in reshape line and merging sections
*			REVISION V7 corrected previous changes and create child_birthday from 
			reformatted date variables.
*******************************************************************************/

set more off

cd "$datadir"


*all of the data is imported 
clear
clear matrix
local CCRX $CCRX
local FQcsv $FQcsv
local FQcsv2 $FQcsv2


set obs 1
gen x=.
save `CCRX'_FRQchild.dta,  replace
tempfile tempFRQ
clear 

		 
	
	clear
	capture insheet using "$csvdir/`FQcsv'_children_rpt.csv", comma case names
	if _rc==0{
		tostring *, replace force
			
	save `tempFRQ', replace
	use `CCRX'_FRQchild.dta
	append using `tempFRQ', force
	save, replace
}


*If there is a second version of the form, this will import and append
	clear
	capture insheet using "$csvdir/`FQcsv2'_children_rpt.csv", comma case names
	if _rc==0{
		tostring *, replace force
		
	save `tempFRQ', replace
	use `CCRX'_FRQchild.dta
	append using `tempFRQ', force
	save, replace
}

use `CCRX'_FRQchild.dta
drop in 1
drop x
duplicates drop KEY, force
save, replace


*child_feces is multi-select, need to change to binary
/*REVISION v7 Changed to single select.  Dont need binary
gen child_feces_burn=0 if child_feces!=""
replace child_feces_burn=1 if (regexm(child_feces, ["burn"]))

gen child_feces_latdisp=0 if child_feces!=""
replace child_feces_latdisp=1 if (regexm(child_feces, ["latrine_disposal"]))

gen child_feces_bury=0 if child_feces!=""
replace child_feces_bury=1 if (regexm(child_feces, ["bury"]))

gen child_feces_garbage=0 if child_feces!=""
replace child_feces_garbage=1 if (regexm(child_feces, ["garbage"]))

gen child_feces_manure=0 if child_feces!=""
replace child_feces_manure=1 if (regexm(child_feces, ["manure"]))

gen child_feces_leave=0 if child_feces!=""
replace child_feces_leave=1 if (regexm(child_feces, ["leave"]))

gen child_feces_waste_water=0 if child_feces!=""
replace child_feces_waste_water=1 if (regexm(child_feces, ["waste_water"]))

gen child_feces_latused=0 if child_feces!=""
replace child_feces_latused=1 if (regexm(child_feces, ["latrine_used"]))
*/

label define child_feces_list 1 "burn" 2 "latrine_disposal" 3 "bury" 4 "garbage" ///
5 "manure" 6 "leave" 7 "waste_water" 8 "latrine_used"
encode child_feces, gen(child_fecesv2) lab(child_feces_list)
drop child_feces
rename child_fecesv2 child_feces

*REVISION v7 child birthday needs to be reformatted into MDY (eg Jan 1, 2017)
*and date variables dropped

foreach date in CBcb {
replace `date'_y=subinstr(`date'_y, "Jan", "Feb", .) if `date'_m=="1"
replace `date'_y=subinstr(`date'_y, "Jan", "Mar", .) if `date'_m=="2"
replace `date'_y=subinstr(`date'_y, "Jan", "Apr", .) if `date'_m=="3"
replace `date'_y=subinstr(`date'_y, "Jan", "May", .) if `date'_m=="4"
replace `date'_y=subinstr(`date'_y, "Jan", "Jun", .) if `date'_m=="5"
replace `date'_y=subinstr(`date'_y, "Jan", "Jul", .) if `date'_m=="6"
replace `date'_y=subinstr(`date'_y, "Jan", "Aug", .) if `date'_m=="7"
replace `date'_y=subinstr(`date'_y, "Jan", "Sep", .) if `date'_m=="8"
replace `date'_y=subinstr(`date'_y, "Jan", "Oct", .) if `date'_m=="9"
replace `date'_y=subinstr(`date'_y, "Jan", "Nov", .) if `date'_m=="10"
replace `date'_y=subinstr(`date'_y, "Jan", "Dec", .) if `date'_m=="11"
}
 rename CBcb_y child_birthday
 drop CB* cb*

capture label def yes_no_dnk_nr_list 0 no 1 yes -77 "-77" -88 "-88" -99 "-99"
encode diarrhea, gen(diarrheav2) lab(yes_no_dnk_nr_list)
drop diarrhea
rename diarrheav2 diarrhea

rename * *_
rename PARENT*_ PARENT*
sort KEY
bysort PARENT_KEY: gen totalchildODK=_N
bysort PARENT_KEY: gen childno=_n

capture drop count
//REVISION: SJ v7, have to drop KEY_first before reshaping
capture drop KEY_

reshape wide child*_ diarrhea_, i(PARENT_KEY) j(childno)
rename PARENT_KEY FQmetainstanceID
duplicates report FQmetainstanceID
//REVISION: SJ v7, use tempfile instead of real dataset
tempfile child_wide
save `child_wide', replace
*save `CCRX'_FQchild_WIDE_$date.dta, replace

use `CCRX'_Combined_$date.dta

preserve
keep if FQmetainstanceID!=""
keep FQmetainstanceID
duplicates drop FQmetainstanceID, force
merge 1:m FQmetainstanceID using `child_wide', gen(childmerge)
drop if childmerge==2
tempfile temp
save `temp', replace
restore
use `CCRX'_Combined_$date.dta
merge m:m FQmetainstanceID using `temp', nogen force


*merge 1:m FQmetainstanceID using `child_wide', gen(childmerge)
*drop if childmerge==2

save `CCRX'_Combined_$date.dta, replace
	



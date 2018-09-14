********************************************************************************
*
*  FILENAME:	CCRX-AbtModuleDataChecking-v##_$date-initials.do
*  PURPOSE:		Data quality checks for the PMA2020 anonymous abortion module 
*  CREATED:		Mridula Shankar (mshanka6@jhmi.edu)
*  DATA IN:		CCRX_Female_Questionnaire_v#_results.csv?
*  DATA OUT:	?
*  UPDATES:		
********************************************************************************

*Set directory
cd "$datadir"

*REVISION v02 11Apr2018 AR added macro
*Set Macros
local CCRX $CCRX

/*Call in dataset
use "C:\Users\annro\PMA2020\Data_Not_Shared\Nigeria\Round5\NGR5_Combined_11Apr2018.dta", clear
*/

preserve
*REVISION v02 11Apr2018 AR capitalized FRS_result
capture gen totalcompleted=1 if FRS_result==1
capture gen totalcompleted=1 if FRS_result=="completed"
gen NRDNKabtcommon=1 if abt_common==-88 | abt_common==-99
gen total_f1=1 if friend1_abt_yn!=. & FRS_result==1
gen NRDNKf1abt=1 if friend1_abt_yn==-88 | friend1_abt_yn==-99
gen NRDNKf1reg=1 if friend1_reg_yn_1==-88 | friend1_reg_yn_1==-99 |friend1_reg_yn_2==-88 | friend1_reg_yn_2==-99
*gen NRDNKf1mult_abt=1 if friend1_abt_mult_yn==-88 | friend1_abt_mult_yn==-99
*gen NRDNKf1mult_reg=1 if friend1_reg_mult_yn==-88 | friend1_reg_mult_yn==-99
*REVISION v03 13Apr2018 AR added a check for preg_chance_once
gen NRDNKpreg_chance=1 if preg_chances_once=="-88" | preg_chances_once=="-99"
gen NRselfabt=1 if self_abt_yn==-99
gen NRselfreg=1 if self_reg_yn_2==-99
*gen NRselfmult_abt=1 if self_abt_mult_yn==-99
*gen NRselfmult_reg=1 if self_reg_mult_yn==-99

*REVISION v02 11Apr2018 AR added by RE and GeoID for datamonitoring
collapse (sum) NR* totalcompleted total_f1 if totalcompleted==1, by (RE level1 level2) 

*REVISION v05 24Apr2018 SOB: Made abortion checks percents instead of counts
foreach var in abtcommon preg_chance {
gen NRDNK`var'_per=NRDNK`var'/totalcompleted *100
}
foreach var in selfabt selfreg {
gen NR`var'_per=NR`var'/totalcompleted *100
}
foreach var in f1abt f1reg {
gen NRDNK`var'_per= NRDNK`var'/total_f1 *100
}
export excel RE level1 level2 NRDNKabtcommon_per NRDNKpreg_chance_per NRselfabt_per NRselfreg_per totalcompleted NRDNKf1abt_per NRDNKf1reg_per total_f1 using `CCRX'_HHQFQErrors_$date.xls, firstrow(variables) sh(AbortionChecks) sheetreplace
restore



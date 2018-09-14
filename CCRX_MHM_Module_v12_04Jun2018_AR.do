/*******************************************************************************
*
*  FILENAME:	CCRX_MHM_Module_v1$date.do
*  PURPOSE:		Label and encode menstrual hygiene management questions
*  CREATED:		Linnea Zimmerman (lzimme12@jhu.edu)
*  DATA IN:		CCRX_Combined_$date.dta
*  DATA OUT:	CCRX_Combined_$date.dta
*  
*******************************************************************************/

capture label drop yes_no_dnk_nr_list
capture label define yes_no_dnk_nr_list -77 "-77" -88 "-88" -99 "-99" 0 "no" 1 "yes"

capture label define mhm_facilities_list 1 flush 2 vip 3 pit_with_slab 4 pit_no_slab 5 bucket ///
	6 composting 7 hanging 8 sleep_area 9 backyard 10 bush 11 other -99 "-99"

rename main_mhm main_mhm_cc
label var main_mhm_cc "What was the main place that you used for changing your used pads, cloths, or other sanitary materials?"
encode main_mhm_cc, gen(main_mhm_ccv2) lab(mhm_facilities_list)
order main_mhm_ccv2, after(main_mhm_cc)
drop main_mhm_cc
rename main_mhm_ccv2 main_mhm_cc

label val main_mhm_cc mhm_facilities_list
label var main_mhm_conditions "While managing your menstrual hygiene, was this place: "
foreach x in  clean private safe lock water soap {
gen mhmmainfac_`x'=0 if main_mhm_conditions!="" & main_mhm_conditions!="-99"
replace mhmmainfac_`x'=1 if (regexm(main_mhm_conditions, "`x'"))
capture label val mhmmainfac_`x' yes_no_dnk_nr_list

capture gen mhmsanfac_`x'=0 if san_mhm_conditions!="" & san_mhm_conditions!="-99"
capture replace mhmsanfac_`x'=1 if (regexm(san_mhm_conditions, "`x'"))
capture label val mhmsanfac_`x' yes_no_dnk_nr_list
}

rename mhm_materials mhm_materials_cc
label var mhm_materials_cc "During your last menstrual period, what were all the materials that you used to absorb or collect your menstrual blood?"
split mhm_materials_cc, gen(mhm_materials_cc_)
local x=r(nvars)
foreach var in pad_once pad_multi new_cloth old_cloth cotton_wool diaper tampons toilet_paper ///
	undies bucket other {
gen mhmmat_cc_`var'=0 if mhm_materials_cc!="" & mhm_materials_cc!="-99" & mhm_materials_cc!="-77"
forval y=1/`x' {
replace mhmmat_cc_`var'=1 if mhm_materials_cc_`y'=="`var'"
}
}
capture drop mhm_materials_cc_*

label var mhm_reuse "Did you wash and reuse pads, cloths, or other sanitary materials during your last menstrual period?"
label var mhm_dry "During your last menstrual period, were the sanitary materials that you washed and reused completely dried before each reuse? "

encode mhm_reuse, gen(mhm_reusev2) lab(yes_no_dnk_nr_list) 
encode mhm_dry, gen(mhm_dryv2) lab(yes_no_dnk_nr_list)
drop mhm_reuse mhm_dry
rename *v2 *

label var mhm_private_disposal "During your last menstrual period, did you have a place to dispose of all of your used pads, cloths, or other sanitary materials that was private?"
foreach x in flush_toilet latrine waste_bin burning bush other {
gen mhm_disposal_`x'=0 if mhm_private_disposal!="" & mhm_private_disposal!="-99"
replace mhm_disposal_`x'=1 if (regexm(mhm_private_disposal, "`x'"))
label val mhm_disposal_`x' yes_no_dnk_nr_list
}

encode mhm_work_yn, gen(mhm_work_ynv2) lab(yes_no_dnk_nr_list)
	label var mhm_work_ynv2 "Worked outside of the household in last month?"
	
encode mhm_work_missed, gen(mhm_work_missedv2) lab(yes_no_dnk_nr_list)
	label var mhm_work_missedv2 "Missed work in the last month due to menstrual period"

encode mhm_school_yn, gen(mhm_school_ynv2) lab(yes_no_dnk_nr_list)
	label var mhm_school_ynv2 "Attended school in the last 12 months"
	
encode mhm_school_missed, gen(mhm_school_missedv2) lab(yes_no_dnk_nr_list)
	label var mhm_school_missedv2 "Missed school in last 12 months due to menstrual period"

capture confirm var first_menstruation
	if _rc==0 {
		destring first_menstruation, replace
		label var first_menstruation "Age at first menstruation"
		}

save, replace

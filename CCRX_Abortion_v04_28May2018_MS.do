********************************************************************************
*
*  FILENAME:	CCRX-Abortion-v##_$date-initials.do
*  PURPOSE:		Label and encode questions in abortion module of PMA2020 surveys
*  CREATED:		Mridula Shankar (mshanka6@jhmi.edu)
*  DATA IN:		CCRX_Female_Questionnaire_v#_results.csv
*  DATA OUT:	
* 
********************************************************************************

* Rename grp variables 
rename FR1_ABT* *
rename FR1_REG* *
rename FR2_ABT* *
rename FR2_REG* *
rename SELF_ABT* *
rename SELF_REG* *
rename ABT_NORMS* *

* Label variables
label var friend_count				"Number of close female friends"
label var friend1_name 				"Fake name of female friend 1"
label var friend1_age 				"Age of female friend 1"
label var friend1_school 			"Highest level of school attended by friend 1"
label var friend2_name 				"Fake name of female friend 2"
label var friend2_age 				"Age of female friend 2"
label var friend2_school 			"Highest level of school attended by friend 2"
label var abt_common				"How common abortion is in community"

capture label var abt_ways			"Ways that women can remove a pregnancy in community"
capture label var abt_ways_1		"Ways that women can remove a pregnancy in place where respondent lives"
capture label var abt_ways_2		"What can a woman do to remove a pregnancy in place where respondent lives"

label var abt_ways_main				"Most common way of removing a pregnancy in community"
label var abt_surg_where			"Locations for obtaining surgical procedure to remove a pregnancy"
label var abt_surg_where_main		"Most common location for obtaining a surgical procedure to remove a pregnancy"	
label var abt_meds_where			"Locations for obtaining medication to remove a pregnancy"
label var abt_meds_where_main   	"Most common location to obtain medication to remove a pregnancy"
label var friend1_abt_yn			"Friend1: Did something to remove pregnancy"
label var friend1_abt_year 			"Friend1: Year of pregnancy removal"
label var friend1_abt_mult_yn		"Friend1: Did more than one thing to remove pregnancy" 
label var friend1_abt_first			"Friend1: First thing did to remove pregnancy (if did multiple things)"
label var friend1_abt_only			"Friend1: What did to remove pregnancy (if only did only thing)" 
label var friend1_abt_where			"Friend1: Location of surgical procedure for pregnancy removal"
label var friend1_abt_meds			"Friend1: Location where medicines obtained for pregnancy removal"
label var friend1_abt_last			"Friend1: Last thing did to remove pregnancy (if did multiple things)"
label var friend1_abt_last_where	"Friend1: Final location of surgical procedure for pregnancy removal"	
label var friend1_abt_last_meds		"Friend1: Final location where medicines obtained for pregnancy removal"
label var friend1_abt_issues		"F1: Received treatment in health facility for issues with pregnancy removal"
label var friend1_reg_yn_1			"F1:Ever done something to reg period due to suspected preg if preg removal-yes"
label var friend1_reg_yn_2			"F1:Ever done something to reg period due to suspected preg if preg removal-no"			
label var friend1_reg_year			"Friend1: Year of period regulation"
label var friend1_reg_mult_yn		"Friend1: Did more than one thing to regulate period"
label var friend1_reg_first			"Friend1: First thing did to regulate period (if did multiple things)"
label var friend1_reg_only			"Friend1: What did to regulate period (if only did one thing)"
label var friend1_reg_where			"Friend1: Location of surgical procedure for period regulation"
label var friend1_reg_meds			"Friend1: Location where medicines obtained for period regulation"
label var friend1_reg_last			"Friend1: Last thing did for period to return (if did multiple things)"
label var friend1_reg_last_where	"Friend1: Final location of surgical procedure for period regulation"	
label var friend1_reg_last_meds		"Friend1: Final location where medicines obtained for period regulation"
label var friend1_reg_issues		"F1: Received treatment in health facility for issues with period regulation"

label var friend2_abt_yn			"Friend2: Did something to remove pregnancy"
label var friend2_abt_year 			"Friend2: Year of pregnancy removal"
label var friend2_abt_mult_yn		"Friend2: Did more than one thing to remove pregnancy" 
label var friend2_abt_first			"Friend2: First thing did to remove pregnancy (if did multiple things)"
label var friend2_abt_only			"Friend2: What did to remove pregnancy (if only did one thing)" 
label var friend2_abt_where			"Friend2: Location of surgical procedure for pregnancy removal"
label var friend2_abt_meds			"Friend2: Location where medicines obtained for pregnancy removal"
label var friend2_abt_last			"Friend2: Last thing did to remove pregnancy (if did multiple things)"
label var friend2_abt_last_where	"Friend2: Final location of surgical procedure for pregnancy removal"	
label var friend2_abt_last_meds		"Friend2: Final location where medicines obtained for pregnancy removal"
label var friend2_abt_issues		"F2: Received treatment in health facility for issues with pregnancy removal"
label var friend2_reg_yn_1			"F2:Ever done something to reg period due to suspected preg if preg removal-yes" 
label var friend2_reg_yn_2			"F2:Ever done something to reg period due to suspected preg if preg removal-no"			
label var friend2_reg_year			"Friend2: Year of period regulation"
label var friend2_reg_mult_yn		"Friend2: Did more than one thing to regulate period"
label var friend2_reg_first			"Friend2: First thing to regulate period (if did multiple things)"
label var friend2_reg_only			"Friend2: What did to regulate period (if only did one thing)"
label var friend2_reg_where			"Friend2: Location of surgical procedure for period regulation"
label var friend2_reg_meds			"Friend2: Location where medicines obtained for period regulation"
label var friend2_reg_last			"Friend2: Last thing did for period to return (if did multiple things)"
label var friend2_reg_last_where	"Friend2: Final location of surgical procedure for period regulation"	
label var friend2_reg_last_meds		"Friend2: Final location where medicines obtained for period regulation"
label var friend2_reg_issues		"F2: Received treatment in health facility for issues with period regulation"

label var self_abt_yn				"Self: Did something to remove pregnancy"
label var self_abt_year				"Self: Year of pregnancy removal"
label var self_abt_mult_yn			"Self: Did more than one thing to remove pregnancy" 
label var self_abt_first			"Self: First thing did to remove pregnancy (if did multiple things)"
label var self_abt_only				"Self: What did to remove pregnancy (if only did one thing)" 
label var self_abt_where			"Self: Location of surgical procedure for pregnancy removal"
label var self_abt_meds				"Self: Location where medicines obtained for pregnancy removal"
label var self_abt_last				"Self: Last thing she did to remove pregnancy (if did multiple things)"
label var self_abt_last_where 		"Self: Final location of surgical procedure for pregnancy removal"
label var self_abt_last_meds 		"Self: Final location where medicines obtained for pregnancy removal"
label var self_abt_issues 			"Received treatment in health facility for issues with pregnancy removal"
label var self_abt_confidant 		"Self: Told the following people about pregnancy removal experience"
label var self_reg_yn_1				"Ever done something to reg period due to suspected preg if preg removal-yes" 
label var self_reg_yn_2		    	"Ever done something to reg period due to suspected preg if preg removal-no"			
label var self_reg_year				"Self: Year of period regulation"			
label var self_reg_mult_yn			"Self: Did more than one thing to regulate period"
label var self_reg_first			"Self: First thing did to regulate period (if did multiple things)"
label var self_reg_only				"Self: What did to regulate period (if only did one thing)"
label var self_reg_where			"Self: Location of surgical procedure for period regulation"
label var self_reg_meds				"Self: Location where medicines obtained for period regulation"
label var self_reg_last				"Self: Last thing did for period to return (if did multiple things)"
label var self_reg_last_where		"Self: Final location of surgical procedure for period regulation"
label var self_reg_last_meds		"Self: Final location where medicines obtained for period regulation"
label var self_reg_issues			"Received treatment in health facility for issues with period regulation"
label var self_reg_confidant		"Self: Told the following people about period regulation experience"
 
capture label var why_abt_last		"Motivating reasons for removing pregnancy the last time" 
capture label var abt_other_yn		"Besides the last time, removed other pregnancies?" 
capture label var abt_other_count	"Number of times removed pregnancies besides the last time"
capture label var abt_first_y		"Year of removing pregnancy for the first time"

label var abt_health_risk			"It is ok to remove pregnancy if continuing pregnancy puts her health at risk"
label var abt_rape					"It is ok to remove pregnancy if pregnancy is a result of rape"
label var abt_afford				"It is ok to remove pregnancy if woman cannot afford to raise another child"
label var abt_unwanted				"It is ok to remove pregnancy if woman does not want to have another child"
label var abt_shame					"A woman who removes a pregnancy brings shame to her family"
label var abt_silence				"A woman who removes a pregnancy should not tell anyone"	
capture label var abt_legal			"Are there circumstances when removing a pregnancy is legal in India?"
capture label var abt_reg_same		"Do you think removal of pregnancy and period regulation are the same thing?"
 
capture label var abt_incest 		"Acceptable to remove a pregnancy if it occurs as a result of incest"
capture label var abt_law			"Know if there is a law on abortion in Cote d'Ivoire"
capture label var abt_legal 		"Are there instances when it is legal to have an abortion in Cote d'Ivoire"

label var flw_willing				"Willing to meet at a future date for in-depth interview"
label var flw_number_yn				"Own a phone"

* Destring variables 
foreach var of varlist friend_count friend1_age friend2_age {
capture destring `var', replace
}

* Variables and response options common to Rajasthan, Nigeria and Cote d'Ivoire
label define common_list 1 very_common 2 common 3 uncommon 4 not_common -88 "-88" -99 "-99"
encode abt_common, gen(abt_commonv2) lab(common_list) 
label define common_list 1 "Very common" 2 "Somewhat common" 3 "Not very common" ///
4 "Not at all common" -88 "-88" -99 "-99", replace

capture label define yes_uc_no_dnk_nr_list 0 no 1 yes 2 likely  -88 "-88" -99 "-99"  
foreach var of varlist friend1_abt_yn friend1_abt_mult_yn friend1_abt_issues friend1_reg_yn_1 friend1_reg_yn_2  ///
friend1_reg_mult_yn friend1_reg_issues friend2_abt_yn friend2_abt_mult_yn ///
friend2_abt_issues friend2_reg_yn_1 friend2_reg_yn_2 friend2_reg_mult_yn friend2_reg_issues {
capture encode `var', gen(`var'v2) lab(yes_uc_no_dnk_nr_list)
}


capture label define yes_no_nr_list 1 yes 0 no -99 "-99"
foreach var of varlist self_abt_yn self_abt_mult_yn self_reg_yn_1 self_reg_yn_2 ///
self_reg_mult_yn flw_willing flw_number_yn {
capture encode `var', gen(`var'v2) lab(yes_no_nr_list)
}

capture label define yes_no_dnk_nr_list 1 yes 0 no -88 "-88" -99 "-99"
foreach var of varlist self_abt_issues self_reg_issues {
capture encode `var', gen(`var'v2) lab(yes_no_dnk_nr_list)
} 

label define agree_list 1 much_agree 2 agree 3 neutral 4 disagree 5 much_disagree -99 "-99"
foreach var of varlist abt_health_risk abt_rape abt_afford abt_unwanted abt_shame abt_silence {
capture encode `var', gen(`var'v2) lab(agree_list)
}
label define agree_list 1 "Strongly agree" 2 "Agree" 3 "Neither agree nor disagree" 4 "Disagree" ///
5 "Strongly disagree" -99 "-99", replace 

capture {
split self_abt_confidant, gen(self_abt_conf_)
local x=r(nvars)
foreach var in partner sister brother mother father other_relative friend1 friend2 ///
other_friend other {
gen self_abt_tell_`var'=0 if self_abt_confidant!=""  
forval y=1/`x' {
replace self_abt_tell_`var'=1 if self_abt_conf_`y'=="`var'"
label val self_abt_tell_`var' yes_no_dnk_nr_list
}
}
capture drop self_abt_conf_*
order self_abt_tell_*, after(self_abt_confidant)
}

capture {
split self_reg_confidant, gen(self_reg_conf_)
local x=r(nvars)
foreach var in partner sister brother mother father other_relative friend1 friend2 ///
other_friend other {
gen self_reg_tell_`var'=0 if self_reg_confidant!=""  
forval y=1/`x' {
replace self_reg_tell_`var'=1 if self_reg_conf_`y'=="`var'"
label val self_reg_tell_`var' yes_no_dnk_nr_list
}
}
capture drop self_reg_conf_*
order self_reg_tell_*, after(self_reg_confidant) 
}

* Variables with response options specific to India
if "$CCRX"=="RJR4"  {

capture label define school_list 1 never 2 primary 3 secondary 4 higher 5 postgrad -99 "-99"
foreach var of varlist friend1_school friend2_school {
encode `var', gen(`var'v2) lab(school_list)
}

label define abortion_ways_list 1 surgery 2 pills_abortion 3 pills_fever 4 pills_oth ///
5 herbs 6 bleach 7 insert 8 other -88 "-88" -99 "-99"

foreach var of varlist abt_ways_main friend1_abt_first friend1_abt_only friend1_abt_last ///
friend1_reg_first friend1_reg_only friend1_reg_last friend2_abt_first friend2_abt_only ///
friend2_abt_last friend2_reg_first friend2_reg_only friend2_reg_last self_abt_first ///
self_abt_only self_abt_last self_reg_first self_reg_only self_reg_last {
capture encode `var', gen(`var'v2) lab(abortion_ways_list)
}

label define abortion_ways_list 1 "surgical procedure" 2 "pills called mifepristone or misoprostol" ///
3 "pills taken for fever" 4 "other pills" 5 "traditional methods, like herbs" 6 "Home remedies" ///
7 "Materials inserted into the vagina" 8 "other" -88 "-88" -99 "-99", replace

capture label define providers_list 1 govt_hosp 2 govt_disp 3 uhp 4 chc 5 anm ///
6 mobile_clinic_public 7 camp 8 icds 9 asha 10 fieldworker_public 11 ngo 12 private_hospital ///
13 private_doctor 14 mobile_clinic_private 15 ayush 16 healer 17 pharmacy 18 dai ///
19 shop 20 friend_relative 21 other -88 "-88" -99 "-99"

foreach var of varlist abt_surg_where_main abt_meds_where_main friend1_abt_where ///
friend1_abt_meds friend1_abt_last_where friend1_abt_last_meds friend1_reg_where ///
friend1_reg_meds friend1_reg_last_where friend1_reg_last_meds friend2_abt_where ///
friend2_abt_meds friend2_abt_last_where friend2_abt_last_meds friend2_reg_where ///
friend2_reg_meds friend2_reg_last_where friend2_reg_last_meds self_abt_where ///
self_abt_meds self_abt_last_where self_abt_last_meds self_reg_where self_reg_meds ///
self_reg_last_where self_reg_last_meds {
capture encode `var', gen(`var'v2) lab(providers_list)
}
label define providers_list 1 "Govt./Municipal Hospital" 2 "Govt. Dispensary" 3 "UFWC/UHC/UHP" ///
4 "CHC/Rural Hospital/PHC" 5 "Sub-Centre/ANM" 6 "Govt. Mobile clinic" 7 "Camp" 8 "Anganwadi/ICDS Centre" ///
9 "ASHA" 10 "Other Community-Based Worker" 11 "NGO or Trust Hospital/Clinic" 12 "Pvt hospital" ///
13 "Pvt. Doctor/Clinic" 14 "Pvt. Mobile Clinic" 15 "Vaidya/Hakim/Homeopath (Ayush)" 16 "Traditional Healer" ///
17 "Pharmacy/Drugstore" 18 "Dai (TBA)" 19 "Shop" 20 "Friend / parent / relative" 21 "Other" ///
-88 "-88" -99 "-99", replace 

split abt_ways, gen(abt_opt_)
local x=r(nvars)
foreach var in surgery pills_abortion pills_fever pills_oth herbs bleach insert other {
gen abt_ways_`var'=0 if abt_ways!="" 
forval y=1/`x' {
replace abt_ways_`var'=1 if abt_opt_`y'=="`var'"
label val abt_ways_`var' yes_no_dnk_nr_list
}
}
order abt_ways_*, after(abt_ways)
capture drop abt_opt_*

split abt_surg_where, gen(abt_surg_opt_)
local x=r(nvars)
foreach var in govt_hosp govt_disp uhp chc anm mobile_clinic_public camp icds asha ///
fieldworker_public ngo private_hospital private_doctor mobile_clinic_private ayush ///
healer pharmacy dai shop friend_relative other {
gen abt_surg_`var'=0 if abt_surg_where!=""  
forval y=1/`x' {
replace abt_surg_`var'=1 if abt_surg_opt_`y'=="`var'"
label val abt_surg_`var' yes_no_dnk_nr_list
}
}
capture drop abt_surg_opt_*

split abt_meds_where, gen(abt_meds_opt_)
local x=r(nvars)
foreach var in govt_hosp govt_disp uhp chc anm mobile_clinic_public camp icds asha ///
fieldworker_public ngo private_hospital private_doctor mobile_clinic_private ayush ///
healer pharmacy dai shop friend_relative other {
gen abt_meds_`var'=0 if abt_meds_where!="" 
forval y=1/`x' {
replace abt_meds_`var'=1 if abt_meds_opt_`y'=="`var'"
label val abt_meds_`var' yes_no_dnk_nr_list
}
}
capture drop abt_meds_opt_*


encode abt_legal, gen(abt_legalv2) lab(yes_no_dnk_nr_list)

						
label var abt_ways_surgery 					"Can remove a pregnancy through a surgical procedure, like D&C or 'cleaning'"
label var abt_ways_pills_abortion			"Can remove a pregnancy using pills called mifepristone or misoprostol"
label var abt_ways_pills_fever				"Can remove a pregnancy using pills you take when you have a fever"
label var abt_ways_pills_oth				"Can remove a pregnancy using other pills"
label var abt_ways_herbs					"Can remove a pregnancy using traditional methods, like herbs"
label var abt_ways_bleach					"Can remove a pregnancy using home remedies, like bleach"
label var abt_ways_insert					"Can remove a pregnancy by inserting materials into the vagina"
label var abt_ways_other					"Can remove a pregnancy using other ways"

label var abt_surg_govt_hosp				"Locations for a surgical procedure to remove a preg: Govt./Municipal Hospital" 
label var abt_surg_govt_disp				"Locations for a surgical procedure to remove a preg: Govt. Dispensary"
label var abt_surg_uhp						"Locations for a surgical procedure to remove a preg: UFWC/UHC/UHP"
label var abt_surg_chc						"Locations for a surgical procedure to remove a preg: CHC/Rural Hospital/PHC"
label var abt_surg_anm						"Locations for a surgical procedure to remove a preg: Sub-Centre/ANM"
label var abt_surg_mobile_clinic_public		"Locations for a surgical procedure to remove a preg: Govt. Mobile clinic"
label var abt_surg_camp						"Locations for a surgical procedure to remove a preg: Camp"
label var abt_surg_icds						"Locations for a surgical procedure to remove a preg: Anganwadi/ICDS Centre"
label var abt_surg_asha						"Locations for a surgical procedure to remove a preg: ASHA"
label var abt_surg_fieldworker_public		"Locations for a surgical procedure to remove a preg:Oth Community-Based Worker"
label var abt_surg_ngo						"Locations for a surgical procedure to remove a preg:NGO or Trust Hosp/Clinic"
label var abt_surg_private_hospital			"Locations for a surgical procedure to remove a preg: Pvt hospital"
label var abt_surg_private_doctor			"Locations for a surgical procedure to remove a preg: Pvt. Doctor/Clinic"
label var abt_surg_mobile_clinic_private	"Locations for a surgical procedure to remove a preg: Pvt. Mobile Clinic"
label var abt_surg_ayush					"Locations for a surgical procedure to remove a preg:Vaidya/Hakim/Homeopath(Ayush)"
label var abt_surg_healer					"Locations for a surgical procedure to remove a preg: Traditional Healer"
label var abt_surg_pharmacy					"Locations for a surgical procedure to remove a preg: Pharmacy/Drugstore"
label var abt_surg_dai						"Locations for a surgical procedure to remove a preg: Dai (TBA)"
label var abt_surg_shop						"Locations for a surgical procedure to remove a preg: Shop"
label var abt_surg_friend_relative			"Locations for a surgical procedure to remove a preg: Friend/parent/relative"
label var abt_surg_other					"Locations for a surgical procedure to remove a preg: Other"

label var abt_meds_govt_hosp				"Locations for obtaining medication to remove a preg: Govt./Municipal Hospital"
label var abt_meds_govt_disp				"Locations for obtaining medication to remove a preg: Govt. Dispensary"
label var abt_meds_uhp						"Locations for obtaining medication to remove a preg: UFWC/UHC/UHP"
label var abt_meds_chc						"Locations for obtaining medication to remove a preg: CHC/Rural Hospital/PHC"
label var abt_meds_anm						"Locations for obtaining medication to remove a preg: Sub-Centre/ANM"
label var abt_meds_mobile_clinic_public		"Locations for obtaining medication to remove a preg: Govt. Mobile clinic"
label var abt_meds_camp						"Locations for obtaining medication to remove a preg: Camp"
label var abt_meds_icds						"Locations for obtaining medication to remove a preg: Anganwadi/ICDS Centre"
label var abt_meds_asha						"Locations for obtaining medication to remove a preg: ASHA"
label var abt_meds_fieldworker_public		"Locations for obtaining medication to remove a preg:Oth Community-Based Worker"
label var abt_meds_ngo						"Locations for obtaining medication to remove a preg:NGO or Trust Hosp/Clinic"
label var abt_meds_private_hospital			"Locations for obtaining medication to remove a preg: Pvt hospital"
label var abt_meds_private_doctor			"Locations for obtaining medication to remove a preg: Pvt. Doctor/Clinic"
label var abt_meds_mobile_clinic_private	"Locations for obtaining medication to remove a preg: Pvt. Mobile Clinic"
label var abt_meds_ayush					"Locations for obtaining medication to remove a preg:Vaidya/Hakim/Homeopath(Ayush)"
label var abt_meds_healer					"Locations for obtaining medication to remove a preg: Traditional Healer"
label var abt_meds_pharmacy					"Locations for obtaining medication to remove a preg: Pharmacy/Drugstore"
label var abt_meds_dai						"Locations for obtaining medication to remove a preg: Dai (TBA)"
label var abt_meds_shop						"Locations for obtaining medication to remove a preg: Shop"
label var abt_meds_friend_relative			"Locations for obtaining medication to remove a preg: Friend/parent/relative"
label var abt_meds_other					"Locations for obtaining medication to remove a preg: Other"


}  /// Cleaning of India-specific response options ends here.  
		  
* Variables with response options specific to Nigeria
else if "$CCRX"=="NGR5" {

capture label define school_list 1 never 2 primary 3 secondary 4 higher -99 "-99"
foreach var in varlist friend1_school friend2_school {
capture encode `var', gen(`var'v2) lab(school_list)
}

label define abortion_ways_list 1 surgery 2 pills_abortion 3 pills_fever 4 pills_ec ///
5 pills_oth 6 injection 7 herbs 8 alcohol 9 salt 10 lemon 11 cough 12 insert 13 other ///
-88 "-88" -99 "-99"

foreach var of varlist abt_ways_main friend1_abt_first friend1_abt_only friend1_abt_last ///
friend1_reg_first friend1_reg_only friend1_reg_last friend2_abt_first friend2_abt_only ///
friend2_abt_last friend2_reg_first friend2_reg_only friend2_reg_last self_abt_first ///
self_abt_only self_abt_last self_reg_first self_reg_only self_reg_last {
capture encode `var', gen(`var'v2) lab(abortion_ways_list)
}

label define abortion_ways_list 1 "Surgical procedure" 2 "Pills called mifepristone or misoprostol" ///
3 "Pills you take when you have a fever" 4 "Emergency contraception pills" 5 "Other pills" ///
6 "Injection" 7 "Traditional methods, like herbs" 8 "Alcohol" 9 "Salt, potash, maggi, or kanwa" ///
10 "Lemon or lime" 11 "Cough syrup" 12 "Insert materials into the vagina" 13 "Other", replace

capture label define providers_list 1 govt_hosp 2 govt_health_center 3 FP_clinic 4 mobile_clinic_public ///
5 fieldworker_public 6 private_hospital 7 pharmacy 8 chemist 9 private_doctor 10 mobile_clinic_private ///
11 fieldworker_private 12 shop 13 church 14 friend_relative 15 ngo 16 market 17 other -88 "-88" -99 "-99"

foreach var of varlist abt_surg_where_main abt_meds_where_main friend1_abt_where ///
friend1_abt_meds friend1_abt_last_where friend1_abt_last_meds friend1_reg_where ///
friend1_reg_meds friend1_reg_last_where friend1_reg_last_meds friend2_abt_where ///
friend2_abt_meds friend2_abt_last_where friend2_abt_last_meds friend2_reg_where ///
friend2_reg_meds friend2_reg_last_where friend2_reg_last_meds self_abt_where ///
self_abt_meds self_abt_last_where self_abt_last_meds self_reg_where self_reg_meds ///
self_reg_last_where self_reg_last_meds {
capture encode `var', gen(`var'v2) lab(providers_list)
}
label define providers_list 1 "Government Hospital" 2 "Government Health Center" 3 "Family planning clinic" ///
4 "Mobile clinic (public)" 5 "TBA/Fieldworker (public)" 6 "Private hospital/clinic" 7 "Pharmacy" ///
8 "Chemist/PMS Store" 9 "Private doctor or nurse" 10 "Mobile clinic (private)" 11 "TBA/Fieldworker (private)" ///
12 "Shop" 13 "FBO/Church" 14 "Friend / relative" 15 "NGO" 16 "Market / hawking" 17 "Other" -88 "-88" -99 "-99", replace

split abt_ways, gen(abt_opt_)
local x=r(nvars)
foreach var in surgery pills_abortion pills_fever pills_ec pills_oth injection herbs ///
alcohol salt lemon cough insert other {
gen abt_ways_`var'=0 if abt_ways!="" 
forval y=1/`x' {
replace abt_ways_`var'=1 if abt_opt_`y'=="`var'"
label val abt_ways_`var' yes_no_dnk_nr_list
}
}
order abt_ways_surgery-abt_ways_other, after(abt_ways)
capture drop abt_opt_*

split abt_surg_where, gen(abt_surg_opt_)
local x=r(nvars)
foreach var in govt_hosp govt_health_center FP_clinic mobile_clinic_public fieldworker_public ///
private_hospital pharmacy chemist private_doctor mobile_clinic_private fieldworker_private ///
shop church friend_relative ngo market other {
gen abt_surg_`var'=0 if abt_surg_where!="" 
forval y=1/`x' {
replace abt_surg_`var'=1 if abt_surg_opt_`y'=="`var'"
label val abt_surg_`var' yes_no_dnk_nr_list
}
}
order abt_surg_govt_hosp-abt_surg_other, after(abt_surg_where)
capture drop abt_surg_opt_*

split abt_meds_where, gen(abt_meds_opt_)
local x=r(nvars)
foreach var in govt_hosp govt_health_center FP_clinic mobile_clinic_public fieldworker_public ///
private_hospital pharmacy chemist private_doctor mobile_clinic_private fieldworker_private ///
shop church friend_relative ngo market other {
gen abt_meds_`var'=0 if abt_meds_where!="" 
forval y=1/`x' {
replace abt_meds_`var'=1 if abt_meds_opt_`y'=="`var'"
label val abt_meds_`var' yes_no_dnk_nr_list
}
}
order abt_meds_govt_hosp-abt_meds_other, after(abt_meds_where)
capture drop abt_meds_opt_*

label var abt_ways_surgery 					"Can remove a pregnancy through a surgical procedure, like D&C or 'cleaning'"
label var abt_ways_pills_abortion			"Can remove a pregnancy using pills called mifepristone or misoprostol"
label var abt_ways_pills_fever				"Can remove a pregnancy using pills you take when you have a fever"
label var abt_ways_pills_ec				    "Can remove a pregnancy using emergency contraception pills"
label var abt_ways_pills_oth				"Can remove a pregnancy using other pills"
label var abt_ways_injection				"Can remove a pregnancy using an injection"
label var abt_ways_herbs					"Can remove a pregnancy using traditional methods, like herbs"
label var abt_ways_alcohol					"Can remove a pregnancy using alcohol"
label var abt_ways_salt					    "Can remove a pregnancy using salt, potash, maggi, or kanwa"
label var abt_ways_lemon					"Can remove a pregnancy using lemon or lime"
label var abt_ways_cough					"Can remove a pregnancy using cough syrup"
label var abt_ways_insert					"Can remove a pregnancy by inserting materials into the vagina"
label var abt_ways_other					"Can remove a pregnancy using other ways"

label var abt_surg_govt_hosp				"Locations for a surgical procedure to remove a preg: Government Hospital" 
label var abt_surg_govt_health_center		"Locations for a surgical procedure to remove a preg: Government Health Center"
label var abt_surg_FP_clinic				"Locations for a surgical procedure to remove a preg: Family planning clinic"
label var abt_surg_mobile_clinic_public		"Locations for a surgical procedure to remove a preg: Mobile clinic (public)"
label var abt_surg_fieldworker_public		"Locations for a surgical procedure to remove a preg: TBA/Fieldworker (public)"
label var abt_surg_private_hospital			"Locations for a surgical procedure to remove a preg: Private hospital/clinic"
label var abt_surg_pharmacy					"Locations for a surgical procedure to remove a preg: Pharmacy"
label var abt_surg_chemist					"Locations for a surgical procedure to remove a preg: Chemist/PMS Store"
label var abt_surg_private_doctor			"Locations for a surgical procedure to remove a preg: Private doctor or nurse"
label var abt_surg_mobile_clinic_private	"Locations for a surgical procedure to remove a preg: Mobile clinic (private)"
label var abt_surg_fieldworker_private		"Locations for a surgical procedure to remove a preg: TBA/Fieldworker (private)"
label var abt_surg_shop					    "Locations for a surgical procedure to remove a preg: Shop"
label var abt_surg_church					"Locations for a surgical procedure to remove a preg: FBO/Church"
label var abt_surg_friend_relative			"Locations for a surgical procedure to remove a preg: Friend/relative"
label var abt_surg_ngo						"Locations for a surgical procedure to remove a preg: NGO"
label var abt_surg_market					"Locations for a surgical procedure to remove a preg: Market/hawking"
label var abt_surg_other					"Locations for a surgical procedure to remove a preg: Other"

label var abt_meds_govt_hosp				"Locations for obtaining medication to remove a preg: Government Hospital" 
label var abt_meds_govt_health_center		"Locations for obtaining medication to remove a preg: Government Health Center"
label var abt_meds_FP_clinic				"Locations for obtaining medication to remove a preg: Family planning clinic"
label var abt_meds_mobile_clinic_public		"Locations for obtaining medication to remove a preg: Mobile clinic (public)"
label var abt_meds_fieldworker_public		"Locations for obtaining medication to remove a preg: TBA/Fieldworker (public)"
label var abt_meds_private_hospital			"Locations for obtaining medication to remove a preg: Private hospital/clinic"
label var abt_meds_pharmacy					"Locations for obtaining medication to remove a preg: Pharmacy"
label var abt_meds_chemist					"Locations for obtaining medication to remove a preg: Chemist/PMS Store"
label var abt_meds_private_doctor			"Locations for obtaining medication to remove a preg: Private doctor or nurse"
label var abt_meds_mobile_clinic_private	"Locations for obtaining medication to remove a preg: Mobile clinic (private)"
label var abt_meds_fieldworker_private		"Locations for obtaining medication to remove a preg: TBA/Fieldworker (private)"
label var abt_meds_shop					    "Locations for obtaining medication to remove a preg: Shop"
label var abt_meds_church					"Locations for obtaining medication to remove a preg: FBO/Church"
label var abt_meds_friend_relative			"Locations for obtaining medication to remove a preg: Friend/relative"
label var abt_meds_ngo						"Locations for obtaining medication to remove a preg: NGO"
label var abt_meds_market					"Locations for obtaining medication to remove a preg: Market/hawking"
label var abt_meds_other					"Locations for obtaining medication to remove a preg: Other"

 }  /// Cleaning of Nigeria-specific response options ends here. 
 
* Variables with response options specific to Cote d'Ivoire 
else if "$CCRX"=="CIR2" {

capture label define school_list 1 never 2 primary 3 secondary 4 tertiary -99 "-99"
foreach var in varlist friend1_school friend2_school {
capture encode `var', gen(`var'v2) lab(school_list)
}

label define abortion_ways_list 1 surgery 2 pills_abortion 3 pills_fever 4 pills_oth ///
5 herbs 6 bleach 7 insert 8 other -88 "-88" -99 "-99"

foreach var of varlist abt_ways_main friend1_abt_first friend1_abt_only friend1_abt_last ///
friend1_reg_first friend1_reg_only friend1_reg_last friend2_abt_first friend2_abt_only ///
friend2_abt_last friend2_reg_first friend2_reg_only friend2_reg_last self_abt_first ///
self_abt_only self_abt_last self_reg_first self_reg_only self_reg_last {
capture encode `var', gen(`var'v2) lab(abortion_ways_list)
}

label define abortion_ways_list 1 "Surgical procedure" 2 "Pills called mifepristone or misoprostol" ///
3 "Medicines you take when you have a fever" 4 "Other pills" 5 "Traditional methods not inserted, like herbs, potions" ///
6 "Ingested industrial products, like bleach, coke-nescafe mix" 7 "Insert materials into vagina, like stem, herb ball etc" ///
8 "Other", replace

capture label define providers_list 1 govt_hosp 2 govt_health_center 3 FP_clinic ///
4 mobile_clinic_public 5 other_public 6 private_hospital 7 pharmacy 8 private_doctor ///
9 mobile_clinic_private 10 health_agent 11 other_private 12 store 13 religious_org ///
14 friend_relative 15 comm_health_agent 16 other -88 "-88" -99 "-99"

foreach var of varlist abt_surg_where_main abt_meds_where_main friend1_abt_where ///
friend1_abt_meds friend1_abt_last_where friend1_abt_last_meds friend1_reg_where ///
friend1_reg_meds friend1_reg_last_where friend1_reg_last_meds friend2_abt_where ///
friend2_abt_meds friend2_abt_last_where friend2_abt_last_meds friend2_reg_where ///
friend2_reg_meds friend2_reg_last_where friend2_reg_last_meds self_abt_where ///
self_abt_meds self_abt_last_where self_abt_last_meds self_reg_where self_reg_meds ///
self_reg_last_where self_reg_last_meds {
capture encode `var', gen(`var'v2) lab(providers_list)
}
label define providers_list 1 "Government hospital" 2 "Government health center" 3 "Family planning clinic" ///
4 "Mobile clinic (public)" 5 "Other public" 6 "Private hospital / clinic" 7 "Pharmacy" ///
8 "Private doctor" 9 "Mobile clinic (private)" 10 "Health agent" 11 "Other private" ///
12 "Store" 13 "Religious organizations" 14 "Friend / parent" 15 "Community health agent" ///
16 "Other" -88 "-88" -99 "-99", replace


split abt_ways_1, gen(abt_opt_)
local x=r(nvars)
foreach var in surgery pills_abortion pills_fever pills_oth herbs bleach insert other {
gen abt_ways_1_`var'=0 if abt_ways_1!="" 
forval y=1/`x' {
replace abt_ways_1_`var'=1 if abt_opt_`y'=="`var'"
label val abt_ways_1_`var' yes_no_dnk_nr_list
}
}
order abt_ways_1_surgery-abt_ways_1_other, after(abt_ways_1)
capture drop abt_opt_*

split abt_ways_2, gen(abt_opt_)
local x=r(nvars)
foreach var in surgery pills_abortion pills_fever pills_oth herbs bleach insert other {
gen abt_ways_2_`var'=0 if abt_ways_2!="" 
forval y=1/`x' {
replace abt_ways_2_`var'=1 if abt_opt_`y'=="`var'"
label val abt_ways_2_`var' yes_no_dnk_nr_list
}
}
order abt_ways_2_surgery-abt_ways_2_other, after(abt_ways_2)
capture drop abt_opt_*


split abt_surg_where, gen(abt_surg_opt_)
local x=r(nvars)
foreach var in govt_hosp govt_health_center FP_clinic mobile_clinic_public other_public ///
private_hospital pharmacy private_doctor mobile_clinic_private health_agent ///
other_private store religious_org friend_relative comm_health_agent other {
gen abt_surg_`var'=0 if abt_surg_where!="" 
forval y=1/`x' {
replace abt_surg_`var'=1 if abt_surg_opt_`y'=="`var'"
label val abt_surg_`var' yes_no_dnk_nr_list
}
}
order abt_surg_govt_hosp-abt_surg_other, after(abt_surg_where)
capture drop abt_surg_opt_*

split abt_meds_where, gen(abt_meds_opt_)
local x=r(nvars)
foreach var in govt_hosp govt_health_center FP_clinic mobile_clinic_public other_public ///
private_hospital pharmacy private_doctor mobile_clinic_private health_agent ///
other_private store religious_org friend_relative comm_health_agent other {
gen abt_meds_`var'=0 if abt_meds_where!="" 
forval y=1/`x' {
replace abt_meds_`var'=1 if abt_meds_opt_`y'=="`var'"
label val abt_meds_`var' yes_no_dnk_nr_list
}
}
order abt_meds_govt_hosp-abt_meds_other, after(abt_meds_where)
capture drop abt_meds_opt_*

split why_abt_last, gen(abt_last_reason_)
local x=r(nvars)
foreach var in refusal means rape incest m_health f_health ready mature school ///
parents single wanted worried know other {
gen abt_reason_`var'=0 if why_abt_last!="" 
forval y=1/`x' {
replace abt_reason_`var'=1 if abt_last_reason_`y'=="`var'"
label val abt_reason_`var' yes_no_dnk_nr_list
}
}
order abt_reason_refusal-abt_reason_other, after(why_abt_last)
capture drop abt_last_reason_*


label var abt_ways_1_surgery 				"Can remove a pregnancy through a surgical procedure (curettage, MVA, etc.)"
label var abt_ways_1_pills_abortion			"Can remove a pregnancy using pills called mifepristone or misoprostol"
label var abt_ways_1_pills_fever			"Can remove a pregnancy using medicines you take when you have a fever"
label var abt_ways_1_pills_oth				"Can remove a pregnancy using other pills"
label var abt_ways_1_herbs					"Can remove a pregnancy using traditional methods not inserted into the vagina"
label var abt_ways_1_bleach					"Can remove a pregnancy using ingested industrial products"
label var abt_ways_1_insert					"Can remove a pregnancy by inserting materials into the vagina"
label var abt_ways_1_other					"Can remove a pregnancy using other ways"

label var abt_ways_2_surgery 				"Can remove a pregnancy through a surgical procedure (curettage, MVA, etc.)"
label var abt_ways_2_pills_abortion			"Can remove a pregnancy using pills called mifepristone or misoprostol"
label var abt_ways_2_pills_fever			"Can remove a pregnancy using medicines you take when you have a fever"
label var abt_ways_2_pills_oth				"Can remove a pregnancy using other pills"
label var abt_ways_2_herbs					"Can remove a pregnancy using traditional methods not inserted into the vagina"
label var abt_ways_2_bleach					"Can remove a pregnancy using ingested industrial products"
label var abt_ways_2_insert					"Can remove a pregnancy by inserting materials into the vagina"
label var abt_ways_2_other					"Can remove a pregnancy using other ways"

label var abt_surg_govt_hosp				"Locations for a surgical procedure to remove a preg: Government Hospital"
label var abt_surg_govt_health_center		"Locations for a surgical procedure to remove a preg: Government Health Center"
label var abt_surg_FP_clinic				"Locations for a surgical procedure to remove a preg: Family planning clinic"
label var abt_surg_mobile_clinic_public		"Locations for a surgical procedure to remove a preg: Mobile clinic (public)"
label var abt_surg_other_public				"Locations for a surgical procedure to remove a preg: Other public"
label var abt_surg_private_hospital			"Locations for a surgical procedure to remove a preg: Private hospital/clinic"
label var abt_surg_pharmacy					"Locations for a surgical procedure to remove a preg: Pharmacy"
label var abt_surg_private_doctor			"Locations for a surgical procedure to remove a preg: Private doctor"
label var abt_surg_mobile_clinic_private	"Locations for a surgical procedure to remove a preg: Mobile clinic (private)"
label var abt_surg_health_agent				"Locations for a surgical procedure to remove a preg: Health agent"
label var abt_surg_other_private			"Locations for a surgical procedure to remove a preg: Other private"
label var abt_surg_store					"Locations for a surgical procedure to remove a preg: Store"
label var abt_surg_religious_org			"Locations for a surgical procedure to remove a preg: Religious organizations"
label var abt_surg_friend_relative			"Locations for a surgical procedure to remove a preg: Friend/parent"
label var abt_surg_comm_health_agent		"Locations for a surgical procedure to remove a preg: Community health agent"
label var abt_surg_other					"Locations for a surgical procedure to remove a preg: Other"

label var abt_meds_govt_hosp				"Locations for obtaining medication to remove a preg: Government Hospital"
label var abt_meds_govt_health_center		"Locations for obtaining medication to remove a preg: Government Health Center"
label var abt_meds_FP_clinic				"Locations for obtaining medication to remove a preg: Family planning clinic"
label var abt_meds_mobile_clinic_public		"Locations for obtaining medication to remove a preg: Mobile clinic (public)"
label var abt_meds_other_public				"Locations for obtaining medication to remove a preg: Other public"
label var abt_meds_private_hospital			"Locations for obtaining medication to remove a preg: Private hospital/clinic"
label var abt_meds_pharmacy					"Locations for obtaining medication to remove a preg: Pharmacy"
label var abt_meds_private_doctor			"Locations for obtaining medication to remove a preg: Private doctor"
label var abt_meds_mobile_clinic_private	"Locations for obtaining medication to remove a preg: Mobile clinic (private)"
label var abt_meds_health_agent				"Locations for obtaining medication to remove a preg: Health agent"
label var abt_meds_other_private			"Locations for obtaining medication to remove a preg: Other private"
label var abt_meds_store					"Locations for obtaining medication to remove a preg: Store"
label var abt_meds_religious_org			"Locations for obtaining medication to remove a preg: Religious organizations"
label var abt_meds_friend_relative			"Locations for obtaining medication to remove a preg: Friend/parent"
label var abt_meds_comm_health_agent		"Locations for obtaining medication to remove a preg: Community health agent"
label var abt_meds_other					"Locations for obtaining medication to remove a preg: Other"

label var abt_reason_refusal				"Reasons for removing preg the last time: Husband's refusal to accept child"
label var abt_reason_means 					"Reasons for removing preg the last time: No means to take care of child"		
label var abt_reason_rape 					"Reasons for removing preg the last time: Rape"
label var abt_reason_incest					"Reasons for removing preg the last time: Incest"
label var abt_reason_m_health				"Reasons for removing preg the last time: Mother has health issues"
label var abt_reason_f_health				"Reasons for removing preg the last time: Possible health issues of foetus"
label var abt_reason_ready 					"Reasons for removing preg the last time: Not ready to take responsibility"
label var abt_reason_mature 				"Reasons for removing preg the last time: Too immature or young to have a child"
label var abt_reason_school					"Reasons for removing preg the last time: Wants to continue school"
label var abt_reason_parents 				"Reasons for removing preg the last time: Woman's parents want an abortion"
label var abt_reason_single 				"Reasons for removing preg the last time: Relationship issues/avoid single mum"
label var abt_reason_wanted 				"Reasons for removing preg the last time: Has all the children she wanted"
label var abt_reason_worried 				"Reasons for removing preg the last time: Worried how a child will affect life"
label var abt_reason_know 					"Reasons for removing preg the last time: Does not want others to know"
label var abt_reason_other					"Reasons for removing preg the last time: Other"


foreach var of varlist abt_other_yn abt_law abt_legal {
encode `var', gen(`var'v2) lab(yes_no_dnk_nr_list)
}

capture destring abt_other_count, replace

label define agree_list 1 much_agree 2 agree 3 neutral 4 disagree 5 much_disagree -99 "-99", replace
encode abt_incest, gen(abt_incestv2) lab(agree_list)
label define agree_list 1 "Strongly agree" 2 "Agree" 3 "Neither agree nor disagree" 4 "Disagree" ///
5 "Strongly disagree" -99 "-99", replace 

capture {
gen double abt_first_ySIF = date(abt_first_y, "MDY") 
format abt_first_ySIF %td
gen `abt_first_ySIF2=yofd(abt_first_ySIF)
drop abt_first_ySIF
rename abt_first_ySIF2 abt_first_ySIF
order abt_first_ySIF, after(abt_first_y)
}

capture label var abt_first_ySIF				"Self: Year (SIF) of first pregnancy removal"

}  /// Cleaning of Cote d'Ivoire-specific response options ends here.
		
unab vars: *v2
local stubs: subinstr local vars "v2" "", all
foreach var in `stubs'{
rename `var' `var'QZ
order `var'v2, after(`var'QZ)
}
rename *v2 *
drop *QZ


* Label new variables created (common to all countries)			
capture label var self_abt_tell_partner			"Told partner about pregnancy removal experience"				
capture label var self_abt_tell_sister			"Told sister about pregnancy removal experience"			
capture label var self_abt_tell_brother			"Told brother about pregnancy removal experience"			
capture label var self_abt_tell_mother			"Told mother about pregnancy removal experience"
capture label var self_abt_tell_father			"Told father about pregnancy removal experience"
capture label var self_abt_tell_other_relative	"Told other relative about pregnancy removal experience"
capture label var self_abt_tell_friend1			"Told friend1 about pregnancy removal experience"
capture label var self_abt_tell_friend2			"Told friend2 about pregnancy removal experience"
capture label var self_abt_tell_other_friend	"Told other friend about pregnancy removal experience"
capture label var self_abt_tell_other			"Told someone else about pregnancy removal experience"
capture label var self_reg_tell_partner 		"Told partner about period regulation experience"
capture label var self_reg_tell_sister			"Told sister about period regulation experience"
capture label var self_reg_tell_brother			"Told brother about period regulation experience"
capture label var self_reg_tell_mother			"Told mother about period regulation experience"
capture label var self_reg_tell_father			"Told father about period regulation experience"
capture label var self_reg_tell_other_relative	"Told other relative about period regulation experience"
capture label var self_reg_tell_friend1			"Told friend1 about period regulation experience"
capture label var self_reg_tell_friend2			"Told friend2 about period regulation experience"
capture label var self_reg_tell_other_friend	"Told other friend about period regulation experience"
capture label var self_reg_tell_other			"Told someone else about period regulation experience"	


foreach var of varlist friend1_abt_year friend1_reg_year friend2_abt_year friend2_reg_year ///
self_abt_year self_reg_year {
capture {
gen double `var'SIF = date(`var', "MDY") 
format `var'SIF %td
gen `var'SIF2=yofd(`var'SIF)
drop `var'SIF
rename `var'SIF2 `var'SIF
order `var'SIF, after(`var')
}

}

capture label var friend1_abt_yearSIF			"Friend1: Year (SIF) of pregnancy removal"
capture label var friend1_reg_yearSIF 			"Friend1: Year (SIF) of period regulation"
capture label var friend2_abt_yearSIF			"Friend2: Year (SIF) of pregnancy removal"
capture label var friend2_reg_yearSIF			"Friend2: Year (SIF) of period regulation"
capture label var self_abt_yearSIF  			"Self: Year (SIF) of pregnancy removal"  
capture label var self_reg_yearSIF				"Self: Year (SIF) of period regulation"


* Remove useless variables
drop sect_confidantes sect_abortion abt_sect_preamble friend1_reg_yn friend2_reg_yn ///
self_reg_yn abt_norms_preamble abt_norms_ok


		
			
		
		
		
		

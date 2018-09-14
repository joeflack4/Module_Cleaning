/*******************************************************************************
*
*  FILENAME:	CCRX_SDP_Abortion_v##_$date-initials.do
*  PURPOSE:		Label and encode abortion questions in SDP survey
*  CREATED:		Mridula Shankar (mshanka6@jhmi.edu)
*  DATA IN:		
*  DATA OUT:	
*  UPDATES:		v02-26Mar2018-MS
*					-Defined country-specific variable names 
*					-Made minor updates to question labels (limiting to 80 characters)
*				v03-29May2018_MS
*					-Added code for cleaning of Cote d'Ivoire SDP abortion module 
*					-Changed country-specific identifier to be "$CCRX"
*					-Modified code for splitting of multiple-option variables so that
*					denominator for resulting binary y/n vars includes all respondents, 
*					even those whose response codes are -99, -88 or -77. 
*******************************************************************************/
* Rename grp variables 
rename post_abt_trt_grp* *
rename abt_induced_grp* *
rename sales_avg_grp* *
rename sales_last_grp* *


*Label variables 
label var post_abt_0w_12w_yn			"Provision of PAC for pregnancies 12w or less"			
label var post_abt_12w_yn				"Provision of PAC for pregnancies of more than 12w"
label var post_abt_trained				"Number of providers in facility formally trained to provide PAC"
label var post_abt_days					"Number of days in the week that PAC trained provider is present in facility"
label var abt_days						"Days in a week that abortion trained provider is present at facility"
label var post_abt_care_0w_12w_1		"Methods in facility used for PAC or abortion for pregnancies 12w or less"		
label var post_abt_care_0w_12w_2		"Methods in facility used for abortion for pregnancies 12w or less"
label var post_abt_care_0w_12w_3		"Methods in facility used for PAC for pregnancies 12w or less"
label var post_abt_care_12w_1			"Methods in facility used for PAC or abortion for pregnancies of more than 12w"			
label var post_abt_care_12w_2			"Methods in facility used for abortion for pregnancies of more than 12w"	
label var post_abt_care_12w_3			"Methods in facility used for PAC for pregnancies of more than 12w"	
label var miso_instock					"Misoprostol stock"			
capture label var mife_instock			"Mifepristone stock"
label var miso_instock_2				"Misoprostol stock (advanced facility)"
capture label var mife_instock_2		"Mifepristone stock (advanced facility)"
label var mva_equip						"MVA equipment observed status"
label var inpatient_outpatient			"Outpatient/inpatient treatment of PAC patients"
label var outpatient_avg				"Number of PAC patients treated as outpatients in an average month" 
label var outpatient_last_month			"Number of PAC patients treated as outpatients in last completed month"
label var inpatient_avg					"Number of PAC patients treated as inpatients in an average month"
label var inpatient_last_month			"Number of PAC patients treated as inpatients in last completed month"
label var outpatient_avg_tot			"Total # of PAC patients treated as outpatients in an average month" 
label var inpatient_avg_tot				"Total # of PAC patients treated as inpatients in an average month"
label var patient_avg_tot				"Total # of PAC patients treated as inpatients or outpatients in an av. month"
label var outpatient_last_tot			"Total # of PAC patients treated as outpatients in last completed month" 
label var inpatient_last_tot			"Total # of PAC patients treated as inpatients in last completed month"
label var patient_last_tot				"Total # of PAC patients treated as in or outpatients in last completed month"
label var post_abt_ref_before			"# of PAC cases referred here after treated elsewhere in last completed month"
label var post_abt_ref_after			"Num. of treated PAC cases referred to another facility in last completed month" 
label var post_abt_prob					"Num. of PAC patients with complications: perf. uterus/gut, ICU adm, organ fail"
label var trt_miso						"Out of 10 typical PAC patients seen, number treated with misoprostol only"
capture label var trt_miso_mife			"Out of 10 typical PAC patients seen, number treated with mife & miso only"
label var trt_mva						"Out of 10 typical PAC patients seen in facility, number treated with MVA"
label var trt_eva						"Out of 10 typical PAC patients seen in facility, number treated with EVA "
label var trt_de						"Out of 10 typical PAC patients seen in facility, number treated with D&E"
label var trt_dc						"Out of 10 typical PAC patients seen in facility, number treated with D&C"
label var trt_laparotomy				"Out of 10 typical PAC patients seen in facility, number treated with laparotomy"
label var trt_dnk						"Out of 10 typical PAC patients seen in facility, don't know method of treatment" 
label var abt_avg_month					"In an average month, number of abortions provided to save a woman's life"
label var ind_miso						"Out of 10 typical abortions provided, number treated with misoprostol only"
capture label var ind_miso_mife			"Out of 10 typical abortions provided, number treated with mife & miso only"
label var ind_mva						"Out of 10 typical abortions provided, number treated with MVA"
label var ind_eva						"Out of 10 typical abortions provided, number treated with EVA"
label var ind_de						"Out of 10 typical abortions provided, number treated with D&E"
label var ind_dc						"Out of 10 typical abortions provided, number treated with D&C"
label var ind_dnk						"Out of 10 typical abortions provided, # for which don't know treatment method"
label var abt_services_provide			"Which of the following services and drugs provided at this facility"
label var miso_obs						"Misoprostol observed"
label var mife_obs						"Mifepristone observed"
label var avg_miso						"In an average month, number of people to whom misoprostol alone is sold"
label var avg_mife						"In an average month, number of people to whom mifepristone alone is sold"
label var avg_miso_mife					"In an average month, number of people to whom both mife and miso is sold"
label var last_miso						"In the last completed month, number of people to whom miso alone is sold"
label var last_mife						"In the last completed month, number of people to whom mife alone is sold"
label var last_miso_mife				"In the last completed month, number of people to whom miso and mife is sold"

* Country-specific variable names 
if "$CCRX"=="RJR4" {

label var provide_abt_0w_12w_yn			"Abortion provision for pregnancies 12w or less"
label var provide_abt_12w_yn			"Abortion provision for pregnancies of more than 12w"
label var abt_trained					"Number of providers in facility formally trained to provide abortion"
label var abt_last_month				"In last completed month, total number of abortions provided" 
label var abt_last_month_12w			"In last completed month, number of abortions provided for pregnancies >12w" 
label var sell_miso_yn					"Sell misoprostol"  
label var sell_mife_yn					"Sell mifepristone"  
}

else if "$CCRX"=="NGR5"  {

label var provide_abt_0w_12w_yn			"Abortion provision for pregnancies 12w or less to save a woman's life"
label var provide_abt_12w_yn			"Abortion provision for pregnancies of more than 12w to save a woman's life"
label var abt_trained					"Num. of providers formally trained to provide abortion to save a woman's life"
label var abt_last_month				"In last completed month, total # of abortions provided to save a woman's life" 
label var abt_last_month_12w			"In last completed month # of abts provided to save a woman's life for preg>12w"
label var sell_miso_yn					"Sell misoprostol, for example Cytotec, Misoclear or Emzo"  
label var sell_mife_yn					"Sell mifepristone, for example Mariprist or Mifepak"  
}

else if "$CCRX"=="CIR2" {
label var fp_abt_same_unit				"FP services available in the same unit where PAC services are provided"
label var provide_abt_0w_12w_yn			"Abortion provision for pregnancies 12w or less to save a woman's life"
label var provide_abt_12w_yn			"Abortion provision for pregnancies of more than 12w to save a woman's life"
label var abt_trained					"Num. of providers formally trained to provide abortion to save a woman's life"
label var abt_last_month				"In last completed month, total # of abortions provided to save a woman's life" 
label var abt_last_month_12w			"In last completed month # of abts provided to save a woman's life for preg>12w"
label var ind_laparotomy				"Out of 10 typical abortions provided, number treated with laparotomy"
label var sell_miso_yn					"Sell misoprostol, for example Cytotec"
label var sell_mife_yn					"Sell mifepristone"

}


* Destring variables 
foreach var of varlist post_abt_trained abt_trained outpatient_avg outpatient_avg_tot ///
outpatient_last_month outpatient_last_tot inpatient_avg inpatient_avg_tot patient_avg_tot ///
inpatient_last_month inpatient_last_tot patient_last_tot post_abt_ref_before post_abt_ref_after ///
post_abt_prob trt_miso trt_mva trt_eva trt_de trt_dc trt_laparotomy trt_dnk trt_tot ///
abt_avg_month abt_last_month abt_last_month_12w ind_miso ind_mva ind_eva ///
ind_de ind_dc ind_dnk ind_tot avg_miso avg_mife avg_miso_mife  {
capture destring `var', replace
}

* These two variables are present only in RJR4 and NGR5
if "$CCRX"=="RJR4" | "$CCRX"=="NGR5" {
foreach var of varlist trt_miso_mife ind_miso_mife {
capture destring `var', replace
}
}

* This variable is only present in CIR2
if "$CCRX"=="CIR2" {
capture destring ind_laparotomy, replace
}

       
* Encode variables

* This variable is only present in CIR2
if "$CCRX"=="CIR2" {
label define yes_no_nr_list 1 yes 0 no -99 "-99", replace
capture encode fp_abt_same_unit, gen(fp_abt_same_unitv2) lab(yes_no_nr_list)
}

label define yes_no_dnk_nr_list 1 yes 0 no -88 "-88" -99 "-99", replace
foreach var of varlist post_abt_0w_12w_yn post_abt_12w_yn provide_abt_0w_12w_yn ///
provide_abt_12w_yn sell_miso_yn sell_mife_yn {
capture encode `var', gen(`var'v2) lab(yes_no_dnk_nr_list)
} 

label define days_per_week_list 8 "24-7" 7 "7" 6 "6" 5 "5" 4 "4" 3 "3" 2 "2" 1 "1" ///
-88 "-88" -99 "-99"
foreach var of varlist post_abt_days abt_days {
capture encode `var', gen(`var'v2) lab(days_per_week_list)
}

capture label define stock_list 1 instock_obs 2 instock_unobs 3 outstock -88 "-88" -99 "-99" 
foreach var of varlist miso_instock miso_obs mife_obs {
capture encode `var', gen(`var'v2) lab(stock_list)
}

* This variable only present in RJR4 and NGR5
if "$CCRX"=="RJR4" | "$CCRX"=="NGR5" { 
capture encode  mife_instock, gen( mife_instockv2) lab(stock_list)
}
label define stock_list 1 "In-stock and observed" 2 "In-stock but not observed" 3 "Out of stock" ///
-88 "-88" -99 "-99", replace

capture label define stock2_list 1 instock_obs 2 instock_unobs 3 outstock 4 donotstock -88 "-88" -99 "-99"
capture encode miso_instock_2, gen(miso_instock_2v2) lab(stock2_list)

* This variable is present only in RJR4 and NGR5
if "$CCRX"=="RJR4" | "$CCRX"=="NGR5" {
capture encode mife_instock_2, gen(mife_instock_2v2) lab(stock2_list)
}

label define stock2_list 1 "In-stock and observed" 2 "In-stock but not observed" 3 "Out of stock" 4 "Do not stock" ///
-88 "-88" -99 "-99", replace 

capture label define equip_list 1 func1_obs1 2 func1_obs0 3 func0_obs1 4 func0_obs0 -88 "-88" -99 "-99"
capture encode mva_equip, gen(mva_equipv2) lab(equip_list)
label define equip_list 1 "Functional and observed" 2 "Functional and not observed" ///
3 "Not functional and observed" 4 "Not functional and not observed" -88 "-88" -99 "-99", replace 

label define inpatient_outpatient_list 1 in 2 out 3 both -88 "-88" -99 "-99"
capture encode inpatient_outpatient, gen(inpatient_outpatientv2) lab (inpatient_outpatient_list)
label define inpatient_outpatient_list 1 "Inpatient only" 2 "Outpatient only" 3 "Both" ///
-88 "-88" -99 "-99", replace 


*REVISION v03 29May2018 MS: Modified code below so that denominator for binary vars includes all respondents
if "$CCRX"=="RJR4" | "$CCRX"=="NGR5" {

capture {
split post_abt_care_0w_12w_1, gen(post_abt_care_type_)
local x=r(nvars)
foreach var in miso miso_mife mva eva de dc lap {
gen pacabt_method_`var'_0w_12w=0 if post_abt_care_0w_12w_1!=""  
forval y=1/`x' {
replace pacabt_method_`var'_0w_12w=1 if post_abt_care_type_`y'=="`var'"
label val pacabt_method_`var'_0w_12w yes_no_dnk_nr_list
}
}
drop post_abt_care_type_*
order pacabt_method_miso_0w_12w-pacabt_method_lap_0w_12w, after(post_abt_care_0w_12w_1) 
}

capture {
split post_abt_care_0w_12w_2, gen(abt_care_type_)
local x=r(nvars)
foreach var in miso miso_mife mva eva de dc lap {
gen abt_method_`var'_0w_12w=0 if post_abt_care_0w_12w_2!="" 
forval y=1/`x' {
replace abt_method_`var'_0w_12w=1 if abt_care_type_`y'=="`var'"
label val abt_method_`var'_0w_12w yes_no_dnk_nr_list
}
}
drop abt_care_type_*
order abt_method_miso_0w_12w-abt_method_lap_0w_12w, after(post_abt_care_0w_12w_2) 
}

capture {
split post_abt_care_0w_12w_3, gen(pac_care_type_)
local x=r(nvars)
foreach var in miso miso_mife mva eva de dc lap {
gen pac_method_`var'_0w_12w=0 if post_abt_care_0w_12w_3!=""  
forval y=1/`x' {
replace pac_method_`var'_0w_12w=1 if pac_care_type_`y'=="`var'"
label val pac_method_`var'_0w_12w yes_no_dnk_nr_list
}
}
drop pac_care_type_*
order pac_method_miso_0w_12w-pac_method_lap_0w_12w, after(post_abt_care_0w_12w_3) 
}

capture {
split post_abt_care_12w_1, gen(post_abt_care_type_)
local x=r(nvars)
foreach var in miso miso_mife mva eva de dc lap {
gen pacabt_method_`var'_12w=0 if post_abt_care_12w_1!=""  
forval y=1/`x' {
replace pacabt_method_`var'_12w=1 if post_abt_care_type_`y'=="`var'"
label val pacabt_method_`var'_12w yes_no_dnk_nr_list
}
}
capture drop post_abt_care_type_*
order pacabt_method_miso_12w-pacabt_method_lap_12w, after(post_abt_care_12w_1) 
}

capture {
split post_abt_care_12w_2, gen(abt_care_type_)
local x=r(nvars)
foreach var in miso miso_mife mva eva de dc lap {
gen abt_method_`var'_12w=0 if post_abt_care_12w_2!=""  
forval y=1/`x' {
replace abt_method_`var'_12w=1 if abt_care_type_`y'=="`var'"
label val abt_method_`var'_12w yes_no_dnk_nr_list
}
}
drop abt_care_type_*
order abt_method_miso_12w-abt_method_lap_12w, after(post_abt_care_12w_2) 
}

capture {
split post_abt_care_12w_3, gen(pac_care_type_)
local x=r(nvars)
foreach var in miso miso_mife mva eva de dc lap {
gen pac_method_`var'_12w=0 if post_abt_care_12w_3!=""  
forval y=1/`x' {
replace pac_method_`var'_12w=1 if pac_care_type_`y'=="`var'"
label val pac_method_`var'_12w yes_no_dnk_nr_list
}
}
drop pac_care_type_*
order pac_method_miso_12w-pac_method_lap_12w, after(post_abt_care_12w_3) 
}

}

else if "$CCRX"=="CIR2" {
capture {
split post_abt_care_0w_12w_1, gen(post_abt_care_type_)
local x=r(nvars)
foreach var in miso mva eva de dc cd laparotomy {
gen pacabt_method_`var'_0w_12w=0 if post_abt_care_0w_12w_1!=""  
forval y=1/`x' {
replace pacabt_method_`var'_0w_12w=1 if post_abt_care_type_`y'=="`var'"
label val pacabt_method_`var'_0w_12w yes_no_dnk_nr_list
}
}
drop post_abt_care_type_*
order pacabt_method_miso_0w_12w-pacabt_method_laparotomy_0w_12w, after(post_abt_care_0w_12w_1) 
}

capture {
split post_abt_care_0w_12w_2, gen(abt_care_type_)
local x=r(nvars)
foreach var in miso mva eva de dc cd laparotomy {
gen abt_method_`var'_0w_12w=0 if post_abt_care_0w_12w_2!=""  
forval y=1/`x' {
replace abt_method_`var'_0w_12w=1 if abt_care_type_`y'=="`var'"
label val abt_method_`var'_0w_12w yes_no_dnk_nr_list
}
}
drop abt_care_type_*
order abt_method_miso_0w_12w-abt_method_laparotomy_0w_12w, after(post_abt_care_0w_12w_2) 
}

capture {
split post_abt_care_0w_12w_3, gen(pac_care_type_)
local x=r(nvars)
foreach var in miso mva eva de dc cd laparotomy {
gen pac_method_`var'_0w_12w=0 if post_abt_care_0w_12w_3!=""  
forval y=1/`x' {
replace pac_method_`var'_0w_12w=1 if pac_care_type_`y'=="`var'"
label val pac_method_`var'_0w_12w yes_no_dnk_nr_list
}
}
drop pac_care_type_*
order pac_method_miso_0w_12w-pac_method_laparotomy_0w_12w, after(post_abt_care_0w_12w_3) 
}

capture {
split post_abt_care_12w_1, gen(post_abt_care_type_)
local x=r(nvars)
foreach var in miso mva eva de dc cd laparotomy {
gen pacabt_method_`var'_12w=0 if post_abt_care_12w_1!="" 
forval y=1/`x' {
replace pacabt_method_`var'_12w=1 if post_abt_care_type_`y'=="`var'"
label val pacabt_method_`var'_12w yes_no_dnk_nr_list
}
}
capture drop post_abt_care_type_*
order pacabt_method_miso_12w-pacabt_method_laparotomy_12w, after(post_abt_care_12w_1) 
}

capture {
split post_abt_care_12w_2, gen(abt_care_type_)
local x=r(nvars)
foreach var in miso mva eva de dc cd laparotomy {
gen abt_method_`var'_12w=0 if post_abt_care_12w_2!=""  
forval y=1/`x' {
replace abt_method_`var'_12w=1 if abt_care_type_`y'=="`var'"
label val abt_method_`var'_12w yes_no_dnk_nr_list
}
}
drop abt_care_type_*
order abt_method_miso_12w-abt_method_laparotomy_12w, after(post_abt_care_12w_2) 
}

capture {
split post_abt_care_12w_3, gen(pac_care_type_)
local x=r(nvars)
foreach var in miso mva eva de dc cd laparotomy {
gen pac_method_`var'_12w=0 if post_abt_care_12w_3!="" 
forval y=1/`x' {
replace pac_method_`var'_12w=1 if pac_care_type_`y'=="`var'"
label val pac_method_`var'_12w yes_no_dnk_nr_list
}
}
drop pac_care_type_*
order pac_method_miso_12w-pac_method_laparotomy_12w, after(post_abt_care_12w_3) 
}

}

capture {
split abt_services_provide, gen(abt_services_type_)
local x=r(nvars)
foreach var in antibiotics analgesics anasthesia_local iv_fluids oxytocics transfusion ///
laparotomy {
gen abt_services_`var'=0 if abt_services_provide!="" & abt_services_provide!="-88" & abt_services_provide!="-99" 
forval y=1/`x' {
replace abt_services_`var'=1 if abt_services_type_`y'=="`var'"
label val abt_services_`var' yes_no_dnk_nr_list
}
}
drop abt_services_type_*
order abt_services_antibiotics-abt_services_laparotomy, after(abt_services_provide) 
}


* Label new variables created 

capture label var pacabt_method_miso_0w_12w				"Misoprostol alone used for PAC or abortion for preg ≤12w"
capture label var pacabt_method_miso_mife_0w_12w		"Mifepristone and misoprostol alone used for PAC or abortion for preg ≤12w"
capture label var pacabt_method_mva_0w_12w				"Manual vacuum aspiration (MVA) used for PAC or abortion for preg ≤12w"
capture label var pacabt_method_eva_0w_12w				"Electric vacuum aspiration (EVA) used for PAC or abortion for preg ≤12w"
capture label var pacabt_method_de_0w_12w 				"Dilation and evacuation (D&E) used for PAC or abortion for preg ≤12w"
capture label var pacabt_method_dc_0w_12w 				"Dilation and curettage (D&C) used for PAC or abortion for preg ≤12w"
capture label var pacabt_method_cd_0w_12w 				"Digital curettage used for PAC or abortion for preg ≤12w"
capture label var pacabt_method_lap_0w_12				"Laparotomy used for PAC or abortion for preg ≤12w"
capture label var pacabt_method_laparotomy_0w_12		"Laparotomy used for PAC or abortion for preg ≤12w"


capture label var abt_method_miso_0w_12w				"Misoprostol alone used for abortion for preg ≤12w"
capture label var abt_method_miso_mife_0w_12w			"Mifepristone and misoprostol alone used for abortion for preg ≤12w"
capture label var abt_method_mva_0w_12w					"Manual vacuum aspiration (MVA) used for abortion for preg ≤12w"
capture label var abt_method_eva_0w_12w					"Electric vacuum aspiration (EVA) used for abortion for preg ≤12w"
capture label var abt_method_de_0w_12w 					"Dilation and evacuation (D&E) used for abortion for preg ≤12w"
capture label var abt_method_dc_0w_12w 					"Dilation and curettage (D&C) used for abortion for preg ≤12w"
capture label var abt_method_cd_0w_12w 					"Digital curettage used for abortion for preg ≤12w"
capture label var abt_method_lap_0w_12w					"Laparotomy used for abortion for preg ≤12w"
capture label var abt_method_laparotomy_0w_12w			"Laparotomy used for abortion for preg ≤12w"



capture label var pac_method_miso_0w_12w				"Misoprostol alone used for PAC for preg ≤12w"
capture label var pac_method_miso_mife_0w_12w			"Mifepristone and misoprostol alone used for PAC for preg ≤12w"
capture label var pac_method_mva_0w_12w					"Manual vacuum aspiration (MVA) used for PAC for preg ≤12w"
capture label var pac_method_eva_0w_12w					"Electric vacuum aspiration (EVA) used for PAC for preg ≤12w"
capture label var pac_method_de_0w_12w 					"Dilation and evacuation (D&E) used for PAC for preg ≤12w"
capture label var pac_method_dc_0w_12w 					"Dilation and curettage (D&C) used for PAC for preg ≤12w"
capture label var pac_method_cd_0w_12w 					"Digital curettage used for PAC for preg ≤12w"
capture label var pac_method_lap_0w_12w					"Laparotomy used for PAC for preg ≤12w"
capture label var pac_method_laparotomy_0w_12w			"Laparotomy used for PAC for preg ≤12w"


capture label var pacabt_method_miso_12w				"Misoprostol alone used for PAC or abortion for preg >12w"	
capture label var pacabt_method_miso_mife_12w			"Mifepristone and misoprostol alone used for PAC or abortion for preg >12w"	
capture label var pacabt_method_mva_12w					"Manual vacuum aspiration (MVA) used for PAC or abortion for preg >12w"	
capture label var pacabt_method_eva_12w					"Electric vacuum aspiration (EVA) used for PAC or abortion for preg >12w"	
capture label var pacabt_method_de_12w 					"Dilation and evacuation (D&E) used for PAC or abortion for preg >12w"	
capture label var pacabt_method_dc_12w 					"Dilation and curettage (D&C) used for PAC or abortion for preg >12w"	
capture label var pacabt_method_cd_12w 					"Digital curettage used for PAC or abortion for preg >12w"
capture label var pacabt_method_lap_12w					"Laparotomy used for PAC or abortion for preg >12w"
capture label var pacabt_method_laparotomy_12w			"Laparotomy used for PAC or abortion for preg >12w"


capture label var abt_method_miso_12w					"Misoprostol alone used for abortion for preg >12w"	
capture label var abt_method_miso_mife_12w				"Mifepristone and misoprostol alone used for abortion for preg >12w"	
capture label var abt_method_mva_12w					"Manual vacuum aspiration (MVA) used for abortion for preg >12w"	
capture label var abt_method_eva_12w					"Electric vacuum aspiration (EVA) used for abortion for preg >12w"	
capture label var abt_method_de_12w 					"Dilation and evacuation (D&E) used for abortion for preg >12w"	
capture label var abt_method_dc_12w 					"Dilation and curettage (D&C) used for abortion for preg >12w"	
capture label var abt_method_cd_12w 					"Digital curettage used for abortion for preg >12w"	
capture label var abt_method_lap_12w					"Laparotomy used for abortion for preg >12w"	
capture label var abt_method_laparotomy_12w				"Laparotomy used for abortion for preg >12w"


capture label var pac_method_miso_12w					"Misoprostol alone used for PAC for preg >12w"
capture label var pac_method_miso_mife_12w				"Mifepristone and misoprostol alone used for PAC for preg >12w"
capture label var pac_method_mva_12w					"Manual vacuum aspiration (MVA) used for PAC for preg >12w"
capture label var pac_method_eva_12w					"Electric vacuum aspiration (EVA) used for PAC for preg >12w"
capture label var pac_method_de_12w 					"Dilation and evacuation (D&E) used for PAC for preg >12w"
capture label var pac_method_dc_12w 					"Dilation and curettage (D&C) used for PAC for preg >12w"
capture label var pac_method_cd_12w 					"Digital curettage used for PAC for preg >12w"
capture label var pac_method_lap_12w					"Laparotomy used for PAC for preg >12w"
capture label var pac_method_laparotomy_12w				"Laparotomy used for PAC for preg >12w"

capture label var abt_services_antibiotics				"Antibiotics provided at this facility"
capture label var abt_services_analgesics				"Analgesics provided at this facility"
capture label var abt_services_anasthesia_local			"Local Anesthesia provided at this facility"
capture label var abt_services_iv_fluids				"Intravenous replacement fluids provided at this facility"
capture label var abt_services_oxytocics				"Oxytocics provided at this facility"
capture label var abt_services_transfusion				"Blood transfusion provided at this facility"
capture label var abt_services_laparotomy				"Laparatomy provided at this facility"


capture {
unab vars: *v2
local stubs: subinstr local vars "v2" "", all
foreach var in `stubs'{
rename `var' `var'QZ
order `var'v2, after(`var'QZ)
}
rename *v2 *
drop *QZ
}

*Drop useless variables
drop sect_abortion abt_resp abt_ans post_abt_care_0w_12w post_abt_care_12w memory_note ///
trt_note ind_note avg_note last_note post_abt_trained_99 abt_trained_99 outpatient_avg_99 ///
outpatient_last_99 inpatient_avg_99 inpatient_last_99 post_abt_ref_before_99 post_abt_ref_after_99 ///
post_abt_prob_99 post_abt_trt_99 abt_avg_month_99 abt_last_month_99 abt_last_month_12w_99 ///
sales_avg_99 sales_last_99 patient_avg_tot_confirm patient_avg_tot_confirm_1 ///
patient_avg_tot_confirm_2 patient_last_tot_confirm patient_last_tot_confirm_1 patient_last_tot_confirm_2 ///
trt_tot trt_offset trt_error ind_tot ind_offset ind_error

if "$CCRX"=="RJR4" | "$CCRX"=="NGR5" {
drop abt_induced_99
}

********************************************************************************
*
*  FILENAME:	UGR6_SDP_GGR_DataCleaning_v##_$date_initials.do
*  PURPOSE:		Label and encode SDP questions in Global Gag Rule study
*  CREATED:		Andrea Rowan - IC (arowan44@gmail.com)
*  DATA IN:		UGR6_SDP_Questionnaire_v#_results.csv
*  DATA OUT:	
*  UPDATES:		
*
********************************************************************************

*insheet using "~/Dropbox (Gates Institute)/PMA2020/GlobalGagRule/Data/UGR6_SDP_Questionnaire_v4_results_TEST.csv", comma case


********************************************************************************
* RENAME VARIABLES
********************************************************************************

rename hrr* *
rename hto* *
rename patient_tot_avg_m_disp pt_tot_avg_m
rename patient_tot_last_m_disp pt_tot_last_m

********************************************************************************
* LABEL VARIABLES
********************************************************************************

* Label variables 
label var ngo_support_yn			"Support: Received support/funding in last 12mo from NGO for FP services"
label var ngo_support				"Support: NGOs that provided support/funding for FP in last 12mo"
label var ngo_support_other			"Support: Other NGOs that provided support/funding for FP in last 12mo"

label var chv_ngo_yn				"CHV: Support/funding for CHVs from NGO"
label var chv_ngo					"CHV: NGOs that provided support/funding for CHVs"
label var chv_ngo_other				"CHV: Other NGOs that provided support/funding for CHVs"

label var mobile_methods_offered	"Mobile Outreach: FP methods offered in last 12mo"
label var mobile_fp_visits			"Mobile Outreach: # FP clients served in last 12mo"

label var pac_capable				"PAC: Facility offers PAC"
label var pac_patient_12m			"PAC: Facility treated at least 1 PAC patient in last 12mo"
label var pac_methods				"PAC: Methods used for PAC treatment at facility"
label var pac_methods_other			"PAC: Other PAC methods used for treatment at facility"
label var mva_obs					"PAC: Status of MVA equipment"
label var pac_meds					"PAC: Abortion meds provided by facility"
label var pac_meds_other			"PAC: Other abortion meds provided by facility"
label var mife_obs					"PAC: Status of mifepristone at facility"
label var miso_obs					"PAC: Status of misoprostol at facility"
label var miso_stock				"PAC: Current observable stock of misoprostol"
label var inpatient_outpatient		"PAC: PAC patients treated in OPD, IPD or both"
label var outpatient_avg_m			"PAC: # of OPD PAC pts treated in average mo"
label var outpatient_last_m			"PAC: # of OPD PAC pts treated in last full mo"
label var inpatient_avg_m			"PAC: # of IPD PAC pts treated in average mo"
label var inpatient_last_m			"PAC: # of IPD PAC pts treated in last full mo"
label var pt_tot_avg_m				"PAC: Total # of PAC pts treated in average mo"
label var pt_tot_last_m				"PAC: Total # of PAC pts treated in last full mo"
label var pt_tot_avg_m_confirm		"PAC: Confirm average monthly # of OPD & IPD PAC pts"
label var pt_tot_last_m_confirm		"PAC: Confirm last month # of OPD & IPD PAC pts"
label var pac_prob_last_m			"PAC: # of severe complications among last mo PAC pts"
label var pac_ref_before_last_m		"PAC: # of pts referred from another facility among last mo PAC pts"
label var pac_ref_after_last_m		"PAC: # of pts referred to another facility among last mo PAC pts"

label var abt_services_provide		"PAC: Abortion/PAC related drugs and services provided at facility"

********************************************************************************
* DESTRING/ENCODE VARIABLES
********************************************************************************

* Destring variables 
foreach var of varlist mobile_fp_visits outpatient_avg_m outpatient_last_m inpatient_avg_m	///
inpatient_last_m pac_prob_last_m pac_ref_before_last_m pac_ref_after_last_m  {
capture destring `var', replace
}

* Label yes/no/dnk/nr variables
label define yes_no_dnk_nr_list 0 "no" 1 "yes" -88 "-88" -99 "-99", replace

foreach var of varlist ngo_support_yn chv_ngo_yn pac_capable pac_patient_12m {
encode `var', gen(`var'v2) lab(yes_no_dnk_nr_list)
}

* Label yes/no/nr variables
label define yes_no_nr_list 0 no 1 yes -99 "-99", replace

* Generate binary variables for select-multiple FP methods on mobile outreach
gen mobile_methods_offeredv2=mobile_methods_offered
replace mobile_methods_offeredv2="none" if mobile_methods_offered=="-77"

split mobile_methods_offeredv2, gen(mobile_offered_opt_)
local x=r(nvars)
foreach var in fster mster impl iud injdp injsp pill ec mc fc dia foam beads none {
gen mobile_fp_offer_`var'=0 if mobile_methods_offered!="" & mobile_methods_offered!="-99" 
forval y=1/`x' {
replace mobile_fp_offer_`var'=1 if mobile_offered_opt_`y'=="`var'"
}
}
capture drop mobile_offered_opt_*
label val mobile_fp_offer_* yes_no_nr_list

label var mobile_fp_offer_fster		"Mobile: Female sterilization offered"
label var mobile_fp_offer_mster		"Mobile: Male sterilization offered"
label var mobile_fp_offer_impl		"Mobile: Implant offered"
label var mobile_fp_offer_iud		"Mobile: IUD offered"
label var mobile_fp_offer_injdp		"Mobile: Injectable (Depo) offered"
label var mobile_fp_offer_injsp		"Mobile: Injectable (Sayana) offered"
label var mobile_fp_offer_pill		"Mobile: Pills offered"
label var mobile_fp_offer_ec		"Mobile: EC offered"
label var mobile_fp_offer_mc		"Mobile: Male condoms offered"
label var mobile_fp_offer_fc		"Mobile: Female condoms offered"
label var mobile_fp_offer_dia		"Mobile: Diaphragm offered"
label var mobile_fp_offer_foam		"Mobile: Foam offered"
label var mobile_fp_offer_beads		"Mobile: Cycle beads offered"
label var mobile_fp_offer_none		"Mobile: No methods offered"

* Generate binary variables for PAC methods at facility
gen pac_methodsv2=pac_methods
replace pac_methodsv2="none" if pac_methods=="-77"

split pac_methodsv2, gen(pac_methods_opt_)
local x=r(nvars)
foreach var in miso miso_mife mva de dc laparotomy other none {
gen pac_methodsused_`var'=0 if pac_methodsv2!="" & pac_methodsv2!="-88" & pac_methodsv2!="-99" 
forval y=1/`x' {
replace pac_methodsused_`var'=1 if pac_methods_opt_`y'=="`var'"
}
}
capture drop pac_methods_opt_* pac_methodsv2
label val pac_methodsused_* yn_list

label var pac_methodsused_miso			"PAC methods used: Misoprostol"
label var pac_methodsused_miso_mife		"PAC methods used: Miso/Mife"
label var pac_methodsused_mva			"PAC methods used: MVA"
label var pac_methodsused_de			"PAC methods used: D&E"
label var pac_methodsused_dc			"PAC methods used: D&C"
label var pac_methodsused_laparotomy 	"PAC methods used: Laparotomy"
label var pac_methodsused_other			"PAC methods used: Other method"
label var pac_methodsused_none			"PAC methods used: None"
label var pac_methods 					"PAC: Methods used for PAC treatment at facility"

rename pac_methodsused_miso pac_miso
rename pac_methodsused_miso_mife pac_miso_mife
rename pac_methodsused_mva pac_mva
rename pac_methodsused_de pac_de
rename pac_methodsused_dc pac_dc
rename pac_methodsused_laparotomy pac_laparotomy
rename pac_methodsused_other pac_other
rename pac_methodsused_none pac_none

*  Label MVA obs
label define func_obs_list 1 func1_obs1 2 func1_obs0 3 func0_obs1 4 func0_obs0 -88 "-88" -99 "-99" , replace

encode mva_obs, gen(mva_obsv2) lab(func_obs_list)

label define func_obs_list 1 "Functional and observed" 2 "Functional and not observed" ///
3 "Not functional and observed" 4 "Not functional and not observed" -88 "-88" -99 "-99", replace

* Label miso and mife observation
label define stock_dnk_list 1 instock_obs 2 instock_unobs 3 outstock -88 "-88" -99 "-99", replace

foreach var of varlist mife_obs miso_obs {
capture encode `var', gen(`var'v2) lab(stock_dnk_list)
}
label define stock_dnk_list 1 "In stock and observed" 2 "In stock and not observed" ///
3 "Out of stock" -88 "-88" -99 "-99", replace

* Label misoprostol in stock to be shown
label define stock2_list 1 instock_obs 2 instock_unobs 3 outstock 4 donotstock -88 "-88" -99 "-99", replace

capture encode miso_stock, gen(miso_stockv2) lab(stock2_list)

label define stock2_list 1 "In stock and observed" 2 "In stock and not observed" ///
3 "Out of stock" 4 "Do not stock" -88 "-88" -99 "-99", replace

* Label PAC as IPD or OPD
label define inpatient_outpatient_list 1 in 2 out 3 both -88 "-88" -99 "-99", replace

encode inpatient_outpatient, gen(inpatient_outpatientv2) lab(inpatient_outpatient_list)

label define inpatient_outpatient_list 1 "Inpatient only" 2 "Outpatient only" ///
3 "Both" -88 "-88" -99 "-99", replace

* Label PAC patient confirmations
foreach var of varlist pt_tot_avg_m_confirm pt_tot_last_m_confirm {
encode `var', gen(`var'v2) lab(yn_list)
}

* Generate binary variables for abortion services at facility
split abt_services_provide, gen(abt_prov_opt_)
local x=r(nvars)
foreach var in antibiotics analgesics anasthesia_local iv_fluids oxytocics ///
transfusion laparotomy {
gen abt_`var'=0 if abt_services_provide!="" & abt_services_provide!="-99" 
forval y=1/`x' {
replace abt_`var'=1 if abt_prov_opt_`y'=="`var'"
label val abt_`var' yes_no_nr_list
}
}
capture drop abt_prov_opt_*

label var abt_antibiotics			"Services: Antibiotics provided"
label var abt_analgesics			"Services: Analgesics provided"
label var abt_anasthesia_local		"Services: Local anesthesia provided"
label var abt_iv_fluids				"Services: IV fluids provided"
label var abt_oxytocics				"Services: Oxytocics provided"
label var abt_transfusion			"Services: Blood transfusion provided"
label var abt_laparotomy			"Services: Laparotomy provided"

* Replace original variables with v2
unab vars: *v2
local stubs: subinstr local vars "v2" "", all
foreach var in `stubs'{
rename `var' `var'QZ
order `var'v2, after(`var'QZ)
}
rename *v2 *
drop *QZ

********************************************************************************
* COUNTRY SPECIFIC CLEANING
********************************************************************************

* Uganda country specific code
if "$CCRX"=="UGR6"  {

* Rename variables
rename hiv* hiv*
rename _check hiv_testing_rec_yn

* Label variables
label var hiv_written_record		"HIV clients: Have written record of FP referrals"
label var hiv_register_yn			"HIV clients: Can view HIV/FP referral register from last mo"
label var hiv_register_in			"HIV clients: # of intrafacility FP referrals in last full mo"
label var hiv_register_out			"HIV clients: # of interfacility FP referrals in last full mo"
label var hiv_register_in_est		"HIV clients: Estimated # of intrafacility FP referrals in last full mo"
label var hiv_register_out_est		"HIV clients: Estimated # of interfacility FP referrals in last full mo"

label var hiv_testing_yn			"HIV: Facility offers HIV testing on site or thru outreach"
label var hiv_testing_rec_yn 		"HIV: Facility records # of HIV tests provided"
label var hiv_testing_rec			"HIV: Recorded # of HIV tests in last full mo"
label var hiv_testing_est			"HIV: Estimated # of HIV tests in last full mo"

label var hiv_art					"HIV: Facility offers 1st or 2nd line ART"
label var hiv_art_stock				"HIV: Current ART stockout"
label var hiv_art_outstock_3mo		"HIV: Any ART stockout in last 3mo"
label var hiv_first_outstock_days	"HIV: # days 1L ART stocked out in last 3mo"
label var hiv_second_outstock_days	"HIV: # days 2L ART stocked out in last 3mo"
label var hiv_dnk_outstock_days		"HIV: # days ART (line unknown) stocked out in last 3mo"

* Destring variables
foreach var in hiv_register_in hiv_register_out hiv_register_in_est hiv_register_out_est	///
hiv_testing_rec hiv_testing_est hiv_first_outstock_days hiv_second_outstock_days hiv_dnk_outstock_days {
destring `var', replace
}

*  Label ART 1L/2L variables
capture label define hiv_art_list 0 none 1 first 2 second 3 both 4 art -88 "-88" -99 "-99" 

encode hiv_art, gen(hiv_artv2) lab(hiv_art_list)

label define hiv_art_list 0 "None" 1 "1st line" 2 "2nd line" 3 "Both" ///
4 "ART available but not sure of line" -88 "-88" -99 "-99", replace

* Generate binary variables for ARVs currently stocked out
split hiv_art_stock, gen(art_stock_opt_)
local x=r(nvars)
foreach var in first_stock second_stock either_stock no {
gen hiv_art_stock_`var'=0 if hiv_art_stock!="" & hiv_art_stock!="-88" & hiv_art_stock!="-99" 
forval y=1/`x' {
replace hiv_art_stock_`var'=1 if art_stock_opt_`y'=="`var'"
}
}
capture drop art_stock_opt_*
label val hiv_art_stock_* yes_no_nr_list

label var hiv_art_stock_first_stock		"1L currently out of stock"
label var hiv_art_stock_second_stock	"2L currently out of stock"
label var hiv_art_stock_either_stock	"1L or 2L currently out of stock"
label var hiv_art_stock_no				"No ART currently out of stock"

rename hiv_art_stock_first_stock hiv_art_first_stock
rename hiv_art_stock_second_stock hiv_art_second_stock
rename hiv_art_stock_either_stock hiv_art_either_stock

* Label yes/no/dnk/nr variables
foreach var in hiv_written_record hiv_testing_yn {
encode `var', gen(`var'v2) lab(yes_no_dnk_nr_list)
}
label define yes_no_dnk_nr_list 0 "No" 1 "Yes" -88 "-88" -99 "-99", replace

* Label yes/no/nr variables
foreach var of varlist hiv_register_yn {
capture encode `var', gen(`var'v2) lab(yes_no_nr_list)
}

* Generate binary variables for ARVs stocked out in last 3mo
capture {
split hiv_art_outstock_3mo, gen(art_outstock3m_opt_)
local x=r(nvars)
foreach var in first_stock second_stock either_stock none {
gen art_outstock3m_`var'=0 if hiv_art_outstock_3mo!="" & hiv_art_outstock_3mo!="-88" & hiv_art_outstock_3mo!="-99" 
forval y=1/`x' {
replace art_outstock3m_`var'=1 if art_outstock3m_opt_`y'=="`var'"
}
}
capture drop art_outstock3m_opt_*
label val art_outstock3m_* yn_list

label var art_outstock3m_first_stock	"1L out of stock in last 3mo"
label var art_outstock3m_second_stock	"2L out of stock in last 3mo"
label var art_outstock3m_either_stock	"1L or 2L out of stock in last 3mo"
label var art_outstock3m_no				"No ART out of stock in last 3mo"

rename art_outstock3m_first_stock art_outstock3m_first
rename art_outstock3m_second_stock art_outstock3m_second
rename art_outstock3m_either_stock art_outstock3m_either
}

* Generate binary variables for select-multiple Facility NGO support question
split ngo_support, gen(ngo_support_opt_)
local x=r(nvars)
foreach var in msi rhu path pathfinder eh jhpiego fhi sfh heps ihu cehurd other {
gen ngo_supportorg_`var'=0 if ngo_support!="" & ngo_support!="-88" & ngo_support!="-99" 
forval y=1/`x' {
replace ngo_supportorg_`var'=1 if ngo_support_opt_`y'=="`var'"
}
}
capture drop ngo_support_opt_*
label val ngo_supportorg_* yes_no_nr_list

label var ngo_supportorg_msi		"Support: NGO support from MSI"
label var ngo_supportorg_rhu		"Support: NGO support from RHU"
label var ngo_supportorg_path		"Support: NGO support from PATH"
label var ngo_supportorg_pathfinder	"Support: NGO support from Pathfinder"
label var ngo_supportorg_eh			"Support: NGO support from EH"
label var ngo_supportorg_jhpiego	"Support: NGO support from JHPIEGO"
label var ngo_supportorg_fhi		"Support: NGO support from FHI"
label var ngo_supportorg_sfh		"Support: NGO support from SFH"
label var ngo_supportorg_heps		"Support: NGO support from HEPS"
label var ngo_supportorg_ihu		"Support: NGO support from IHU"
label var ngo_supportorg_cehurd		"Support: NGO support from CEHURD"
label var ngo_supportorg_other		"Support: NGO support from Other org"

* Generate binary variables for select-multiple CHV NGO support question
capture {
split chv_ngo, gen(chv_ngo_opt_)
local x=r(nvars)
foreach var in msi rhu path pathfinder eh jhpiego fhi sfh heps ihu cehurd other {
gen chv_supportorg_`var'=0 if chv_ngo!="" & chv_ngo!="-88" & chv_ngo!="-99" 
forval y=1/`x' {
replace chv_supportorg_`var'=1 if chv_ngo_opt_`y'=="`var'"
}
}
capture drop chv_ngo_opt_*
label val chv_supportorg_* yes_no_nr_list

label var chv_supportorg_msi		"CHV: NGO support from MSI"
label var chv_supportorg_rhu		"CHV: NGO support from RHU"
label var chv_supportorg_path		"CHV: NGO support from PATH"
label var chv_supportorg_pathfinder	"CHV: NGO support from Pathfinder"
label var chv_supportorg_eh			"CHV: NGO support from EngenderHealth"
label var chv_supportorg_jhpiego	"CHV: NGO support from JHPIEGO"
label var chv_supportorg_fhi		"CHV: NGO support from FHI"
label var chv_supportorg_sfh		"CHV: NGO support from SFH"
label var chv_supportorg_heps		"CHV: NGO support from HEPS"
label var chv_supportorg_ihu		"CHV: NGO support from IHU"
label var chv_supportorg_cehurd		"CHV: NGO support from CEHURD"
label var chv_supportorg_other		"CHV: NGO support from Other org"
}

}

else if "$CCRX"="ETR6" {

* Rename variables
rename AWR* *
rename abt_whence_ref abt_ref_from
rename abt_whence_ref_non abt_ref_from_non
rename abt_whence_ref_non_other abt_ref_from_non_other
rename abt_whence_ref_ngo1 abt_ref_out_ngo1
rename abt_whence_ref_ngo2 abt_ref_out_ngo2
rename abt_whence_ref_other abt_ref_out_other
rename abt_ref_count_last_m abt_count_ref_out

* Label variables
label var abt_provide_yn			"Abortion: Facility offers abortion"

label var abt_count_avg_m			"Abortion: # of abortion pts in average mo"
label var abt_count_last_m			"Abortion: # of abortion pts in last full mo"
label var abt_count_last_m_12		"Abortion: # of abortion pts in last full mo >12 weeks"

label var abt_count_ref_public		"Abortion: # of abortion pts in last full mo referred"
label var abt_count_ref_private		"Abortion: # of abortion pts in last full mo referred"
label var abt_count_ref_ngo			"Abortion: # of abortion pts in last full mo referred"
label var abt_count_ref_faith		"Abortion: # of abortion pts in last full mo referred"
label var abt_ref_from				"Abortion: Where patients referred from"

label var abt_count_ref_non			"Abortion: # of abortion pts in last full mo referred from non-health org"
label var abt_ref_from_non			"Abortion: Where patients from non-health orgs referred from"
label var abt_ref_from_non_other	"Abortion: Where patients from non-health orgs referred from - Other"

label var abt_count_ref_out			"Abortion: # of abortion pts referred out in last full mo"
label var abt_ref_out_ngo1			"Abortion: Where abortion pts referred to in last full mo - NGO 1"
label var abt_ref_out_ngo2			"Abortion: Where abortion pts referred to in last full mo - NGO 2"
label var abt_ref_out_other 		"Abortion: Where abortion pts referred to in last full mo - Other" 

* Generate binary variables for select-multiple Facility NGO support question
split ngo_support, gen(ngo_support_opt_)
local x=r(nvars)
foreach var in fgae msi pathfinder eh ipas amref other {
gen ngo_supportorg_`var'=0 if ngo_support!="" & ngo_support!="-88" & ngo_support!="-99" 
forval y=1/`x' {
replace ngo_supportorg_`var'=1 if ngo_support_opt_`y'=="`var'"
}
}
capture drop ngo_support_opt_*
label val ngo_supportorg_* yes_no_nr_list

label var ngo_supportorg_fgae		"Support: NGO support from FGAE"
label var ngo_supportorg_msi		"Support: NGO support from MSI"
label var ngo_supportorg_pathfinder	"Support: NGO support from Pathfinder"
label var ngo_supportorg_eh			"Support: NGO support from EngenderHealth"
label var ngo_supportorg_ipas		"Support: NGO support from Ipas"
label var ngo_supportorg_amref		"Support: NGO support from Amref"
label var ngo_supportorg_other		"Support: NGO support from Other org"

* Generate binary variables for select-multiple CHV NGO support question
capture {
split chv_ngo, gen(chv_ngo_opt_)
local x=r(nvars)
foreach var in fgae msi pathfinder eh ipas amref other {
gen chv_supportorg_`var'=0 if chv_ngo!="" & chv_ngo!="-88" & chv_ngo!="-99" 
forval y=1/`x' {
replace chv_supportorg_`var'=1 if chv_ngo_opt_`y'=="`var'"
}
}
capture drop chv_ngo_opt_*
label val chv_supportorg_* yes_no_nr_list

label var chv_supportorg_fgae		"CHV: NGO support from FGAE"
label var chv_supportorg_msi		"CHV: NGO support from MSI"
label var chv_supportorg_pathfinder	"CHV: NGO support from Pathfinder"
label var chv_supportorg_eh			"CHV: NGO support from EngenderHealth"
label var chv_supportorg_ipas		"CHV: NGO support from Ipas"
label var chv_supportorg_amref		"CHV: NGO support from Amref"
label var chv_supportorg_other		"CHV: NGO support from Other org"
}

}

* Replace labels
label define yes_no_nr_list 0 "No" 1 "Yes" -99 "-99", replace

label define yes_no_dnk_nr_list 0 "No" 1 "Yes" -88 "-88" -99 "-99", replace

********************************************************************************
* DROP VARIABLES
********************************************************************************

* Drop variables
capture drop hrr_note hto_note caseload_note pac_resp pac_ans pac_patient_12m_warn	///
outpatient_avg_m_disp outpatient_last_m_disp inpatient_avg_m_disp inpatient_last_m_disp

capture drop sect_abortion

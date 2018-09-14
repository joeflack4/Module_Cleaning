********************************************************************************
*FILENAME: CCRX_PHC_V#_$DATE.do
*PURPOSE:  Label destring and enconde PHC questions
*DATA IN:  CCRX_Combined_$date.dta
*DATA OUT: CCRX_Combined_$date.dta
* 11/9 reconstruct the do file so that it can run independently
******************************************************************************* 

numlabel, add
* Set macros for country and round

local country Ghana
local round Round6
local CCRX GHR6
local csv1 "$csv1"

/* Set directory forcountry and round 
global datadir "C:\Users\Shulin\Dropbox (Gates Institute)\Monitor GHR6\test output"
global dofiledir "C:\Users\Shulin\Dropbox (Gates Institute)\PMADataManagement_Ghana\Round6\Cleaning_DoFiles\Current"
global csvfilesdir "C:\Users\Shulin\Dropbox (Gates Institute)\Monitor GHR6\test data"
*/
global csv1 "GHR6_PHC_Questionnaire_v4"
local csv1  "$csv1"

cd "$datadir"

* Set local/global macros for current date
local today=c(current_date)
local c_today= "`today'"
global date=subinstr("`c_today'", " ", "",.)
local todaystata=clock("`today'", "DMY")

* Create log
capture log using "`CCRX'_SDP_DataCleaning_$date.log", replace


* Append .csv files if more than one version of the form was used in data collection
	* Read in latest version of the .csv file (largest .csv file)
	insheet using "$csvfilesdir/`csv1'.csv", names clear
	save "`csv1'.dta", replace

*capture rename phc* *

*******************************************************************************
*Rename and encode single-select questions
*******************************************************************************

*Housekeeping commands
* Country/round identifying variables
gen country = "`country'"
gen round = "`round'_PHC" 
label var country "PMA2020 country" 
label var round "PMA2020 round"  
order country-round, first 

duplicates drop metainstanceid, force
rename metainstanceid metainstanceID
rename ea EA
* RE name
capture replace your_name=name_typed if your_name==""
rename your_name RE
label variable RE "RE"

rename date_groupsystem_date system_date
foreach x of varlist start end system_date {
capture confirm variable `x'
if _rc==0 {	
	gen double `x'SIF=clock(`x', "MDYhms")
	format `x'SIF %tc
	} 
}

* Today
gen double todaySIF=clock(today, "YMD")
format todaySIF %tc


foreach var of varlist _all{
capture replace `var'="No" if `var'=="no"
capture replace `var'="Yes" if `var'=="yes"
}

* Begin working, open year, fp begin: generate SIF variables
rename yoyear_open year_open
foreach x of varlist year_open {
capture confirm variable `x'
if _rc==0 {
	gen double `x'SIF=clock(`x', "YMD")
	format `x'SIF %tc
	}
}

* Order new *SIF variables to be next to string counterpart
unab vars: *SIF
local stubs: subinstr local vars "SIF" "", all
foreach var in `stubs'{
order `var'SIF, after(`var')
}

* Times visited
label define visits_list 1 "1st visit" 2 "2nd visit" 3 "3rd visit"
label values times_visited visits_list

* Region
label var level1 "Region"

* Create label for yes/no variables
label define yes_no_dnk_nr_list -77 "-77" -88 "-88" -99 "-99" 0 "No" 1 "Yes", replace



* Rename PHC staffing vars
* Staffing Group Variables
* UPDATE BY COUNTRY
rename doctor_grpdoctor_tot staffing_doctor_tot
rename doctor_grpdoctor_here staffing_doctor_here
rename nurse_grpnurse_tot staffing_nurse_tot
rename nurse_grpnurse_here staffing_nurse_here
rename ma_grpma_tot staffing_ma_tot
rename ma_grpma_here staffing_ma_here
rename ambulance_staff_grpambulance_sta staffing_ambulance_staff_tot
rename v48 staffing_ambulance_staff_here
rename pharmacist_grppharmacist_tot staffing_pharmacist_tot
rename pharmacist_grppharmacist_here staffing_pharmacist_here
rename mca_grpmca_tot staffing_mca_tot
rename mca_grpmca_here staffing_mca_here
rename staff_other_grpstaff_other_tot staffing_other_tot
rename staff_other_grpstaff_other_here staffing_other_here

* Label staff variables
* UPDATE BY COUNTRY
label variable staffing_doctor_tot "Total number of doctors"
label variable staffing_doctor_here "Number of doctors present today"
label variable staffing_nurse_tot "Total number of nurses / midwives"
label variable staffing_nurse_here "Number of nurses / midwives present today"
label variable staffing_ma_tot "Total number of medical assistants"
label variable staffing_ma_here "Number of medical assistants present today"
label variable staffing_ambulance_staff_tot "Total number of ambulance staffs"
label variable staffing_ambulance_staff_here "Number of ambulance staffs present today"
label variable staffing_pharmacist_tot "Total number of pharmacists"
label variable staffing_pharmacist_here "Number of pharmacists present today"
label variable staffing_mca_tot "Total number of medical counter assistants"
label variable staffing_mca_here "Number of medical counter assistants here today"
label variable staffing_other_tot "Total number of other medical staff"
label variable staffing_other_here "Number of other medical staff present today"

* Facility type
* UPDATE BY COUNTRY
label define facility_type_list 1 hospital 2 health_center 3 health_clinic 4 CHPS 5 pharmacy 6 chemist 7 retail
encode facility_type, gen(facility_typen2) lab(facility_type_list)
label var facility_type "Type of facility"

* Survey language 
* UPDATE BY COUNTRY
label define language_list 1 english 2 akan 3 ga 4 ewe 5 nzema 6 dagbani 7 other
encode survey_language, gen(survey_languagen2) lab(language_list)
label define language_list 1 "English" 2 "Akan" 3 "Ga" 4 "Ewe" 5 "Nzema" 6 "Dagbani" 7 "Other", replace

* Managing Authority
label define managing_list 1 government 2 NGO 3 faith_based 4 private 5 other
encode managing_authority, gen(managing_authorityn2) lab(managing_list)
label define managing_list 1 "Government" 2 "NGO" 3 "Faith-based Organization" 4 "Private" 5 "Other", replace

* Catchment area
label define catchment_list 1 no_catchment 2 yes_knows_size -88 "-88" -99 "-99"
capture encode knows_population_served, gen (knows_population_servedn2) lab(catchment_list)
label define catchment_list -88 "Doesn't know size of catchment area" ///
-99 "No response" 1 "No catchment area" 2 "Yes, knows size of catchment area", replace

* Supervisor visit
label define supervisor_list 0 "never" 1 "past_6mo" 2 "6mo_plus" -88 "-88" -99 "-99"
capture encode supervisor_visit, gen(supervisor_visitn2) lab(supervisor_list)
label define supervisor_list -88 "Don't know" -99 "No response" ///
0 "Never external supervision" 1 "Within the past 6 months" 2 "More than 6 months ago", replace

* Handwashing stations observation 
capture rename handwashing_observations handwashing_observations_staff
capture tostring handwashing_observations_staff, replace
gen soap_present=regexm(handwashing_observations_staff, "soap") if handwashing_observations_staff~=""
gen stored_water_present=regexm(handwashing_observations_staff, "stored_water") if handwashing_observations_staff~=""
gen running_water_present=regexm(handwashing_observations_staff, "tap_water") if handwashing_observations_staff~=""
gen near_sanitation=regexm(handwashing_observations_staff, "near_sanitation") if handwashing_observations_staff~=""
order soap_present-near_sanitation, after(handwashing_observations_staff)
foreach var in soap_present stored_water_present running_water_present near_sanitation {
label values `var' yes_no_dnk_nr_list
}

* SDP Result
rename sdp_result SDP_result
label define SDP_result_list 1 completed 2 not_at_facility 3 postponed 4 refused 5 partly_completed 6 other
encode SDP_result, gen(SDP_resultn2) lab(SDP_result_list)
label define SDP_result_list 1 "Completed" 2 "Not at facility" ///
3 "Postponed" 4 "Refused" 5 "Partly completed" 6 "Other", replace

* Position List
*UPDATE BY COUNTRY
label define positions_list 1 "owner" 2 "partner" 3 "admin" 4 "director" 5 "super" 6 "matron" ///
 8 "pa" 9 "nurse" 11 "chn" -99 "-99"
encode position, gen(positionn2) lab(positions_list)
label define positions_list 1 "Owner" 2 "Managing partner (private)" 3 "Administrator" 4 "Medical Director" 5 "Superintendent" 6 "Matron" ///
8 "Physician assistant in charge" 9 "Nurse/Midwife In-Charge" 11 "Community Health Nurse" -99 "-99", replace

foreach var in share_info statistics single_record community_health_workers trainings ///
formal_training quality_activities elec_cur elec_rec water_cur water_rec present_24hr available ///
begin_interview previously_participated sdp_goals sdp_improve sdp_improve_shared accreditation_yn ///
case_review_yn feedback_yn feedback_formal {
encode `var',gen(`var'n2) lab(yes_no_dnk_nr_list)
}

foreach var in criteria ambulance fuel cab_meet cab_follow separate_opd defined_pop measure_coverage ///
review_performance annual_budget tracking disease external_audit nhis_approved {
encode `var',gen(`var'n2) lab(yes_no_dnk_nr_list)
}

*register_permission uses a yes_no_dne_nr, but using yes_no_dnk_nr for now so number scheme won't mess up
encode register_permission, gen(register_permissionn2) lab(yes_no_dnk_nr_list)

label define chw_supervise_list 1 "cho" 2 "phn" 3 "mw" 4 "ha" 5 "pa" -99 "-99"
encode chw_supervise, gen(chw_supervisen2) lab(chw_supervise_list)
label define chw_supervise_list 1 "Community health officer" 2 "Public health nurse" 3 "Midwife" ///
4 "Health assistant" 5 "Physician assistant", replace

rename reimburse_grpreimburse_unit reimburse_unit
rename reimburse_grpreimburse_int reimburse_int

***time_unit_4_list is not coded in the paper questionnaire so far
label define time_unit_4_list 1 "days" 2 "weeks" 3 "months" 4 "years" -77 "-77" -99 "-99" 
encode reimburse_unit, gen(reimburse_unitn2) lab(time_unit_4_list)
encode chw_freq, gen(chw_freqn2) lab(time_unit_4_list)

label define supervision_list 1 "formal" 2 "requested" 3 "continuous" 4 "negative" 96 "other" -77 "-77" -99 "-99"
encode supervision, gen(supervisionn2) lab(supervision_list)

label define first_day_list 1 "approve" 2 "unacceptable" 3 "reduce" 4 "extra" -77 "-77" -99 "-99"
encode first_day, gen(first_dayn2) lab(first_day_list)

label define guidelines_list 1 "transfer" 2 "demand" 3 "allow" 4 "train" -77 "-77" -99 "-99"
encode guidelines, gen(guidelinesn2) lab(guidelines_list)

label define antibiotics_list 1 "purchase" 2 "instruct" 3 "request" 4 "inform" -77 "-77" -99 "-99"
encode antibiotics, gen(antibioticsn2) lab(antibiotics_list)

label define say_list 1 "ghana" 2 "director" 3 "committee" 4 "doctors" 5 "community" 96 "other" -99 "-99"
encode drugs_say, gen(drugs_sayn2) lab(say_list)

encode recruitment_say, gen(recruitment_sayn2) lab(say_list)
encode promoted_say, gen(promoted_sayn2) lab(say_list)
encode discipline_say, gen(discipline_sayn2) lab(say_list)
encode paint_say, gen(paint_sayn2) lab(say_list)
encode absence_say, gen(absence_sayn2) lab(say_list)
encode priorities_say, gen(priorities_sayn2) lab(say_list)
encode discretionary_say, gen(discretionary_sayn2) lab(say_list)

label define who_quality_list 1 "none" 2 "leader" 3 "specific" 4 "shared" 5 "external" 96 "other" -99 "-99"
encode who_quality, gen(who_qualityn2) lab(who_quality_list)

label define agree_4_down_list 1 "much_agree" 2 "agree" 4 "disagree" 5 "much_disagree" -99 "-99"
encode monitor_agree_cc, gen(monitor_agree_ccn2) lab(agree_4_down_list)
encode sdp_target_agree, gen(sdp_target_agreen2) lab(agree_4_down_list)
encode agree_ability_cc, gen(agree_ability_ccn2) lab(agree_4_down_list)
encode agree_ideas_cc, gen(agree_ideas_ccn2) lab(agree_4_down_list)

label define yn_not_held_list 0 "no" 1 "yes" -77 "-77" -99 "-99"
encode regular_attend, gen(regular_attendn2) lab(yn_not_held_list)

label define freq_5_down_list 1 "always" 2 "often" 3 "some" 4 "rare" 5 "never" -99 "-99"
encode opinion_drive, gen(opinion_driven2) lab(freq_5_down_list)

label define freq_6_down_list 1 "day" 2 "week" 3 "month" 4 "quarter" 5 "halfyear" 6 "year" -88 "-88" -99 "-99"
encode data_report_freq, gen(data_report_freqn2) lab(freq_6_down_list)
encode performance_fb_freq, gen(performance_fb_freqn2) lab(freq_6_down_list)

label define freq_5_up_list 1 "never" 2 "rare" 3 "quarter" 4 "month" 5 "week" -99 "-99"
encode data_freq, gen(data_freqn2) lab(freq_5_up_list)

label define time_unit_2_list 1 "months" 2 "years" -88 "-88" -99 "-99"
encode accreditation_units, gen(accreditation_unitsn2) lab(time_unit_2_list)

label define freq_5_down3_list 1 "week" 2 "month" 3 "quarter" 4 "rare" 5 "never" -88 "-88" -99 "-99"
encode case_review_freq, gen(case_review_freqn2) lab(freq_5_down3_list)

label define freq_5_up2_list 1 "never" 2 "rare" 3 "some" 4 "often" 5 "always" -88 "-88" -99 "-99"
encode late_payments, gen(late_paymentsn2) lab(freq_5_up2_list)

*Rename typical_day vars
rename typical_day_tot temp_typdaytot
rename typical_day* *
rename temp_typdaytot typical_day_tot
 
*Rename and encode equipment function vars
label define full_oruna_list 1 "observed" 2 "reported" -77 "na" -99 "-99" 
encode adult_scale, gen(adult_scalen2) lab(full_oruna_list)
encode sdp_goals_obs, gen(sdp_goals_obsn2) lab(full_oruna_list)
encode sdp_improve_obs, gen(sdp_improve_obsn2) lab(full_oruna_list)

label define yes_no_function_list 0 "no" 1 "yes" -77 "-77" -99 "-99"
encode adult_scale_func, gen(adult_scale_funcn2) lab(yes_no_function_list)

encode child_scale, gen(child_scalen2) lab(full_oruna_list)
encode child_scale_func, gen(child_scale_funcn2) lab(yes_no_function_list)

encode sphyg, gen(sphygn2) lab(full_oruna_list)
encode sphyg_func, gen(sphyg_funcn2) lab(yes_no_function_list)

encode thermom, gen(thermomn2) lab(full_oruna_list)
encode thermom_func, gen(thermom_funcn2) lab(yes_no_function_list)

encode steth, gen(stethn2) lab(full_oruna_list)
encode steth_func, gen(steth_funcn2) lab(yes_no_function_list)

encode fees_displayed, gen(fees_displayedn2) lab(full_oruna_list)

label define full_oruna_dnk_list 1 "observed" 2 "reported" -77 "na" -88 "-88" -99 "-99"
encode books_track, gen(books_trackn2) lab(full_oruna_dnk_list)

foreach var in data_admin dhims2_use dhims2_staff data_staff data_report performance_fb data_support {
encode `var',gen(`var'n2) lab(yes_no_dnk_nr_list)
}

label define time_unit_4_plain_list 1 "days" 2 "weeks" 3 "months" 4 "years" -99 "-99"
encode cab_meet_freq_units, gen(cab_meet_freq_unitsn2) lab(time_unit_4_plain_list)

label define review_list 0 "dne" 1 "exists" 2 "exists_review" -99 "-99"
foreach var in nurse doctor disease education nutrition lab pharm admin janitor manager chw midwife cmho other {
rename revreview_`var' review_`var'
encode review_`var', gen(review_`var'n2) lab(review_list)
}

*correct yes no coding of yes_no_function_list
foreach var in adult_scale_funcn2 child_scale_funcn2 sphyg_funcn2 thermom_funcn2 steth_funcn2 regular_attendn2 {
recode `var' 2=0
recode `var' 3=1
}

********************************************************************************
* Break down select-multiple questions to binaries (comment the whole section if necessary)
********************************************************************************
split pop_defined, gen(pop_defined_)
local y=r(nvars)
foreach var in enroll geography {
gen pop_defined_`var'=0 if pop_defined!="" & pop_defined!="-88" & pop_defined!="other"
forval x=1/`y'{
replace pop_defined_`var'=1 if pop_defined_`x'=="`var'"
label val pop_defined_`var' yes_no_dnk_nr_list
label var pop_defined_`var' "How you know who this population is: by `var'"
}
}
order pop_defined_enroll-pop_defined_geography, after(pop_defined)
forval x=1/`y'{
drop pop_defined_`x'
}


split methods_used, gen(methods_used_)
local y=r(nvars)
foreach var in chw registries review gov_surveys dhims surveys {
gen methods_used_`var'=0 if methods_used!="" & methods_used!="-99"
forval x=1/`y'{
replace methods_used_`var'=1 if methods_used_`x'=="`var'"
label val methods_used_`var' yes_no_dnk_nr_list
label var methods_used_`var' "Use `var' to gather information on health outcomes and new disease outbreaks"
}
}
order methods_used_chw-methods_used_surveys, after(methods_used)
forval x=1/`y'{
drop methods_used_`x'
}

split results_collected, gen(results_collected_)
local y=r(nvars)
foreach var in displayed staff individual {
capture gen results_collected_`var'=0 if results_collected!="" & results_collected!="-99" & results_collected!="-88" & results_collected!="-77"
forval x=1/`y'{
replace results_collected_`var'=1 if results_collected_`x'=="`var'"
label val results_collected_`var' yes_no_dnk_nr_list
label var results_collected_`var' "Results of health conditions and outcomes shared by `var'"
}
}
order results_collected_displayed-results_collected_individual, after(results_collected)
forval x=1/`y'{
drop results_collected_`x'
}

split chw_outreach, gen(chw_outreach_)
local y=r(nvars)
foreach var in anc imm fpc fpp pnc wash mhc ncd sur act dot iccm hed mob enr out {
gen chw_outreach_`var'=0 if chw_outreach!="" & chw_outreach!="-99" & chw_outreach!="-88" & chw_outreach!="-77"
forval x=1/`y'{
replace chw_outreach_`var'=1 if chw_outreach_`x'=="`var'"
label val chw_outreach_`var' yes_no_dnk_nr_list
label var chw_outreach_`var' "`var' done by community health workers is supported by this facility"
}
}
order chw_outreach_anc-chw_outreach_out, after(chw_outreach)
forval x=1/`y' {
drop chw_outreach_`x'
}

split criteria_detail, gen(criteria_detail_)
local y=r(nvars)
foreach var in supervision absent timeliness caseload satisfaction outcomes knowledge attitude investment adherence {
gen criteria_detail_`var'=0 if criteria_detail!="" 
forval x=1/`y'{
replace criteria_detail_`var'=1 if criteria_detail_`x'=="`var'"
label val criteria_detail_`var' yes_no_dnk_nr_list
label var criteria_detail_`var' "`var' is used as criteria to evaluate performance"
}
}
order criteria_detail_supervision-criteria_detail_adherence, after(criteria_detail)
forval x=1/`y' {
drop criteria_detail_`x'
}

split decide_training, gen(decide_training_)
local y=r(nvars)
foreach var in manager formal performance {
gen decide_training_`var'=0 if decide_training!="" & decide_training!="-99" & decide_training!="-77"
forval x=1/`y'{
replace decide_training_`var'=1 if decide_training_`x'=="`var'"
label val decide_training_`var' yes_no_dnk_nr_list
label var decide_training_`var' "`var' decides who should have access to training"
}
}
order decide_training_manager-decide_training_performance, after(decide_training)
forval x=1/`y' {
drop decide_training_`x'
}

capture {
split formal_type, gen(formal_type_)
local y=r(nvars)
foreach var in day week month degree diploma technical graduate postgraduate {
gen formal_type_`var'=0 if formal_type!="" & formal_type!="-99" & formal_type!="-77"
forval x=1/`y'{
replace formal_type_`var'=1 if formal_type_`x'=="`var'"
label val formal_type_`var' yes_no_dnk_nr_list
label var formal_type_`var' "Type of formal training: `var'"
}
}
order formal_type_day-formal_type_postgraduate, after(formal_type)
forval x=1/`y' {
drop formal_type_`x'
}
}

split how_share, gen(how_share_)
local y=r(nvars)
foreach var in chalk posters news events chw cab {
gen how_share_`var'=0 if how_share!="" & how_share!="-99" & how_share!="-88"
forval x=1/`y'{
replace how_share_`var'=1 if how_share_`x'=="`var'"
label val how_share_`var' yes_no_dnk_nr_list
label var how_share_`var' "Share information by `var'"
}
}
order how_share_chalk-how_share_cab, after(how_share)
forval x=1/`y' {
drop how_share_`x'
}

split sterilize_equip_cc, gen(sterilize_equip_cc_)
local y=r(nvars)
foreach var in clave boil dry burn non_elec {
gen sterilize_equip_cc_`var'=0 if sterilize_equip_cc!="" & sterilize_equip_cc!="-99" & sterilize_equip_cc!="-77"
forval x=1/`y'{
replace sterilize_equip_cc_`var'=1 if sterilize_equip_cc_`x'=="`var'"
label val sterilize_equip_cc_`var' yes_no_dnk_nr_list
label var sterilize_equip_cc_`var' "Facility has `var' available today"
}
}
order sterilize_equip_cc_clave-sterilize_equip_cc_non_elec, after(sterilize_equip_cc)
forval x=1/`y' {
drop sterilize_equip_cc_`x'
}

rename drugs_grpdrugs_avail drugs_avail
split drugs_avail, gen(drugs_avail_)
local y=r(nvars)
foreach var in ox mi na az ca mg amp bet ge ni me fe fo amo ors z ce act art ben va {
gen drugs_avail_`var'=0 if drugs_avail!="" & drugs_avail!="-99" & drugs_avail!="-77"
forval x=1/`y'{
replace drugs_avail_`var'=1 if drugs_avail_`x'=="`var'"
label val drugs_avail_`var' yes_no_dnk_nr_list
label var drugs_avail_`var' "Non-expired `var' available today"
}
}
order drugs_avail_ox-drugs_avail_va, after(drugs_avail)
forval x=1/`y' {
drop drugs_avail_`x'
}

split record_format, gen(record_format_)
local y=r(nvars)
foreach var in paper_facility paper_patient emr {
gen record_format_`var'=0 if record_format!="" & record_format!="-99" & record_format!="-77"
forval x=1/`y'{
replace record_format_`var'=1 if record_format_`x'=="`var'"
label val record_format_`var' yes_no_dnk_nr_list
label var record_format_`var' "Record format: `var'"
}
}
order record_format_paper_facility-record_format_emr, after(record_format)
forval x=1/`y' {
drop record_format_`x'
}

tostring record_describe, replace
split record_describe, gen(record_describe_)
local y=r(nvars)
foreach var in paper_facility paper_patient emr {
gen record_describe_`var'=0 if record_describe!="" & record_describe!="-99" & record_describe!="-88"
forval x=1/`y'{
replace record_describe_`var'=1 if record_describe_`x'=="`var'"
label val record_describe_`var' yes_no_dnk_nr_list
}
}
order record_describe_paper_facility-record_describe_emr, after(record_describe)
forval x=1/`y' {
drop record_describe_`x'
}
rename fees_grpfees_exempt fees_exempt
split fees_exempt, gen(fees_exempt_)
local y=r(nvars)
foreach var in chr eld poo sta rel man pol chi mat fp nhi {
gen fees_exempt_`var'=0 if fees_exempt!="" & fees_exempt!="-99" & fees_exempt!="-77"
forval x=1/`y'{
replace fees_exempt_`var'=1 if fees_exempt_`x'=="`var'"
label val fees_exempt_`var' yes_no_dnk_nr_list
label var fees_exempt_`var' "`var' are exempt from paying user fees"
}
}
order fees_exempt_chr-fees_exempt_nhi, after(fees_exempt)
forval x=1/`y' {
drop fees_exempt_`x'
}

rename funds_grpinternal_funds internal_funds
split internal_funds, gen(internal_funds_)
local y=r(nvars)
foreach var in meds supp equi mops work staf util bldg {
gen internal_funds_`var'=0 if internal_funds!="" & internal_funds!="-99" & internal_funds!="-88" & internal_funds!="-77"
forval x=1/`y'{
replace internal_funds_`var'=1 if internal_funds_`x'=="`var'"
label val internal_funds_`var' yes_no_dnk_nr_list
label var internal_funds_`var' "The internally generated funds were used to pay for `var'"
}
}
order internal_funds_meds-internal_funds_bldg, after(internal_funds)
forval x=1/`y' {
drop internal_funds_`x'
}

capture {
split performance_fb_day, gen(performance_fb_day_)
local y=r(nvars)
foreach var in summary targets compare gaps plans other {
gen performance_fb_day_`var'=0 if performance_fb_day!="" & performance_fb_day!="-99"
forval x=1/`y'{
replace performance_fb_day_`var'=1 if performance_fb_day_`x'=="`var'"
label val performance_fb_day_`var' yes_no_dnk_nr_list
label var performance_fb_day_`var' "Type of daily feedback given: `var'"
}
}
order performance_fb_day_summary-performance_fb_day_other, after(performance_fb_day)
forval x=1/`y' {
drop performance_fb_day_`x'
}
}

capture {
split performance_fb_week, gen(performance_fb_week_)
local y=r(nvars)
foreach var in summary targets compare gaps plans other {
gen performance_fb_week_`var'=0 if performance_fb_week!="" & performance_fb_week!="-99"
forval x=1/`y'{
replace performance_fb_week_`var'=1 if performance_fb_week_`x'=="`var'"
label val performance_fb_week_`var' yes_no_dnk_nr_list
label var performance_fb_week_`var' "Type of weekly feedback given: `var'"
}
}
order performance_fb_week_summary-performance_fb_week_other, after(performance_fb_week)
forval x=1/`y' {
drop performance_fb_week_`x'
}
}

capture {
split performance_fb_month, gen(performance_fb_month_)
local y=r(nvars)
foreach var in summary targets compare gaps plans other {
gen performance_fb_month_`var'=0 if performance_fb_month!="" & performance_fb_month!="-99"
forval x=1/`y'{
replace performance_fb_month_`var'=1 if performance_fb_month_`x'=="`var'"
label val performance_fb_month_`var' yes_no_dnk_nr_list
label var performance_fb_month_`var' "Type of monthly feedback given: `var'"
}
}
order performance_fb_month_summary-performance_fb_month_other, after(performance_fb_month)
forval x=1/`y' {
drop performance_fb_month_`x'
}
}

capture {
split performance_fb_quarter, gen(performance_fb_quarter_)
local y=r(nvars)
foreach var in summary targets compare gaps plans other {
gen performance_fb_quarter_`var'=0 if performance_fb_quarter!="" & performance_fb_quarter!="-99"
forval x=1/`y'{
replace performance_fb_quarter_`var'=1 if performance_fb_quarter_`x'=="`var'"
label val performance_fb_quarter_`var' yes_no_dnk_nr_list
label var performance_fb_quarter_`var' "Type of quarterly feedback given: `var'"
}
}
order performance_fb_quarter_summary-performance_fb_quarter_other, after(performance_fb_quarter)
forval x=1/`y' {
drop performance_fb_quarter_`x'
}
}

capture {
split performance_fb_halfyear, gen(performance_fb_halfyear_)
local y=r(nvars)
foreach var in summary targets compare gaps plans other {
gen performance_fb_halfyear_`var'=0 if performance_fb_halfyear!="" & performance_fb_halfyear!="-99"
forval x=1/`y'{
replace performance_fb_halfyear_`var'=1 if performance_fb_halfyear_`x'=="`var'"
label val performance_fb_halfyear_`var' yes_no_dnk_nr_list
label var performance_fb_halfyear_`var' "Type of semi-annual feedback given: `var'"
}
}
order performance_fb_halfyear_summary-performance_fb_halfyear_other, after(performance_fb_halfyear)
forval x=1/`y' {
drop performance_fb_halfyear_`x'
}
}

capture {
split performance_fb_year, gen(performance_fb_year_)
local y=r(nvars)
foreach var in summary targets compare gaps plans other {
gen performance_fb_year_`var'=0 if performance_fb_year!="" & performance_fb_year!="-99"
forval x=1/`y'{
replace performance_fb_year_`var'=1 if performance_fb_year_`x'=="`var'"
label val performance_fb_year_`var' yes_no_dnk_nr_list
label var performance_fb_year_`var' "Type of annual feedback given: `var'"
}
}
order performance_fb_year_summary-performance_fb_year_other, after(performance_fb_year)
forval x=1/`y' {
drop performance_fb_year_`x'
}
}

split sdp_goals_who, gen(sdp_goals_who_)
local y=r(nvars)
foreach var in higher leadership collective {
gen sdp_goals_who_`var'=0 if sdp_goals_who!="" & sdp_goals_who!="-99" & sdp_goals_who!="-88"
forval x=1/`y'{
replace sdp_goals_who_`var'=1 if sdp_goals_who_`x'=="`var'"
label val sdp_goals_who_`var' yes_no_dnk_nr_list
label var sdp_goals_who_`var' "Who determine the goals: `var'"
}
}
order sdp_goals_who_higher-sdp_goals_who_collective, after(sdp_goals_who)
forval x=1/`y' {
drop sdp_goals_who_`x'
}

split sdp_improve_how, gen(sdp_improve_how_)
local y=r(nvars)
foreach var in displayed staff individual {
gen sdp_improve_how_`var'=0 if sdp_improve_how!="" & sdp_improve_how!="-99" & sdp_improve_how!="-88" & sdp_improve_how!="-77"
forval x=1/`y'{
replace sdp_improve_how_`var'=1 if sdp_improve_how_`x'=="`var'"
label val sdp_improve_how_`var' yes_no_dnk_nr_list
label var sdp_improve_how_`var' "How targets are shared: `var'"
}
}
order sdp_improve_how_displayed-sdp_improve_how_individual, after(sdp_improve_how)
forval x=1/`y' {
drop sdp_improve_how_`x'
}

split feedback_which, gen(feedback_which_)
local y=r(nvars)
foreach var in survey dept box {
gen feedback_which_`var'=0 if feedback_which!="" & feedback_which!="-99"
forval x=1/`y'{
replace feedback_which_`var'=1 if feedback_which_`x'=="`var'"
label val feedback_which_`var' yes_no_dnk_nr_list
label var feedback_which_`var' "What mechanism in place: `var'"
}
}
order feedback_which_survey-feedback_which_box, after(feedback_which)
forval x=1/`y' {
drop feedback_which_`x'
}


********************************************************************************
* Label all PHC variables, additional cleaning
********************************************************************************
unab vars: *n2
local stubst: subinstr local vars "n2" "", all
foreach var in `stubst'{
rename `var' `var'HC
order `var'n2, after (`var'HC)
}
rename *n2 *

drop *HC


label var position "Position in this facility"
label var separate_opd "Facility has outpatient dept"
label var defined_pop "Facility accountable for certain population"
label var pop_count "How many people"
label var pop_defined "How you know who this population is"
label var measure_coverage "Measure coverage of key population indicators"
label var tracking "Facility track common conditions"
label var disease "Report new disease outbreaks"
label var methods_used "Methods used to get information on outcomes"
label var results_collected "Results of outcomes shared with staffs through any means"
label var community_health_workers "Facility provides support to CHWs"
label var num_health_workers "Number of CHWs supported by this facility"
label var chw_outreach "Types of community health outreach supported"
label var chw_freq "Frequency of supervising CHWs"
label var chw_freq_int "Frequency of supervising CHWs"
label var chw_supervise "Person in charge of CHWs"
label var provider_time "In your opinion, average time of a consultation (minutes)"
label var register_permission "Permission to see register for No. of patients yesterday"
label var register_count "No. of visits in the register yesterday"
label var register_estimate "Estimate of No. of patients yesterday"
label var review_performance "Supervisors review staff performance in last 12 months"
label var criteria "Have criteria to evaluate staff performance"
label var criteria_detail "Criteria used"
label var supervision "Main method of supervision"
label var trainings "Offer trainings to staffs"
label var decide_training "Methods to decide who have access to training"
label var left "No. of clinical staff left in last 6 months"
label var formal_training "Formal training you received in management"
capture label var formal_training_other "Please specify other"
label var typical_day_tot "Hours you worked at this facility yesterday"
label var patient_flow "Hours you spent to oversee patient flow"
label var supervise_staff "Hours you spent to supervise medical staffs"
label var manage_budget "Hours you spent to manage operational budget"
label var ensure_drugs "Hours you spent to ensure drugs/equipment available"
label var treat_patients "Hours you spent to treat patients yourself"
label var manage_relations "Hours you spent to manage relationships"
label var yest_other "Hours you spent on other activities"
label var first_day "Scenario 1"
label var guidelines "Scenario 2"
label var antibiotics "Scenario 3"
label var drugs_say "Who has the most say in ordering more drugs"
label var drugs_say "How much say do you have in ordering more drugs"
label var recruitment_say "Who has the most say on recruiting health workers"
label var recruitment_say "How much say do you have on recruiting health workers"
label var promoted_say "Who has the most say in health worker promotion"
label var promoted_say "How much say do you have in health worker promotion"
label var discipline_say "Who has the most say in taking disciplinary action"
label var discipline_say "How much say do you have in taking disciplinary action"
label var paint_say "Who has the most say in painting a wall"
label var paint_say "How much say do you have in painting a wall"
label var absence_say "Who has the most say in approving health worker absence"
label var absence_say "How much say do you have in approving health worker absence"
label var priorities_say "Who has the most say in setting service delivery priorities"
label var priorities_say "How much say do you have in setting service delivery priorities"
label var discretionary_say "Who has the most say in spending internally generated funds"
label var discretionary_say "How much say do you have in spending internally generated funds"
label var quality_activities "Facility has quality improvement activities"
label var who_quality "Who is responsible for quality improvement"
label var statistics "Discussed routine service statistics with staffs in the past 12 months"
label var monitor_agree_cc "Data improves service delivery"
label var cab_meet "Has a community advisory board that meets regularly"
label var cab_meet_freq_units "How often do committees meet"

label var cab_follow "Facility follows up on discussions in the last meeting"
label var regular_attend "Have a regular community member in staff meeting"
label var share_info "Shared performance with the community in the past 12 months"
label var how_share "How to share performance info"
label var opinion_drive "Patients’ opinions drive change"
label var ambulance "Ambulance available today"
label var fuel "Fuel available today"
label var adult_scale "Adult weighing scale available today"
label var adult_scale_func "Adult scale functioning properly"
label var child_scale "Children/infant weighing scale available today"
label var child_scale_func "Children/infant scale functioning properly"
label var sphyg "Sphygmonometer available today"
label var sphyg_func "Sphygmonometer functioning properly"
label var thermom "Thermometer available today"
label var thermom_func "Thermometer functioning properly"
label var steth "Stethoscope available today"
label var steth_func "Stethoscope functioning properly"
label var sterilize_equip_cc "Sterilization equipment available and functioning"
label var drugs_avail "The following non-expired drugs available today"
label var single_record "Patient has unique health record"
label var record_format "Format of health record" 
label var record_describe "Format of health record"
label var fees_displayed "User fees displayed"
label var fees_exempt "Who are exempt from paying users fees"
label var annual_budget "Has annual budget for running costs"
label var books_track "Maintains books to track spendings"
label var internal_funds_tot "Total internally generated funds last fiscal year"
label var internal_funds "Internally generated funds paid for:"
label var external_audit "Had an external financial audit in the past 12 months"
label var nhis_approved "Facility is NHIS approved"
label var reimburse_unit "Time length to receive reimbursements for NHIS claims"
label var record_describe "Describe the format of health records"

label var sdp_goals "Facility has goal for service delivery"
label var sdp_goals_who "Who determined facility goals"
label var sdp_goals_obs "Can I see documentation of goals" 
label var sdp_improve "Facility has improvement targets to achieve goals"
label var sdp_improve_obs "Can I see documentation of targets"
label var sdp_improve_shared "Targets shared with staffs"
label var sdp_improve_how "How are targets shared with staffs"
label var sdp_target_agree "Burden of achieving target is even for all in facility"
label var data_freq "How frequent data used for making decision"
label var accreditation_yn "Participate in accreditation program"
label var accreditation_units "When was most recent accreditation completed"
label var case_review_yn "Routinely carry out formal case reviews"
label var case_review_freq "How frequent are formal case reviews carried out"
label var feedback_yn "Mechanism to collect patient feedback"
label var feedback_which "What mechanisms to collect patient feedback"
label var feedback_formal "Mechanism to inform staffs about patient feedback"
label var staff_scheduled "No. of staffs scheduled to be in see patients yesterday"
label var staff_present "No. of staffs present and see patients yesterday"
label var agree_ability_cc "Staffs have ability to decide and carry out assignments"
label var agree_ideas_cc "Staffs are encouraged to bring new ideas"
label var data_support "Receive support from higher level to interpret performance data"
label var data_admin "Has someone to manage health data"
label var dhims2_use "Uses DHIMS2 to track data"
label var dhims2_staff "Has staff trained to use DHIMS2"
label var data_staff "Has staff trained on data analysis"
label var data_report "Report performance data to higher level"
label var data_report_freq "How frequent to report performance data"
label var performance_fb "Receive feedback of performance from higher level"
label var performance_fb_freq "How frequent to receive feedback"
label var late_payments "How often are staff salaries paid late"

foreach var in nurse doctor disease education nutrition lab pharm admin janitor manager chw midwife cmho other {
label var review_`var' "`var' received performance review"
}

foreach var in day week month quarter halfyear year {
label var performance_fb_`var' "For `var'ly feedback, type of feedback given"
}


***variables same as core
label var previously_participated "Previous participated in 2016 PHC survey"
label variable times_visited "Number of times visited facility"
label variable startSIF "SDP interview start time (SIF)"
label variable start "SDP interview start time (string)"
label variable endSIF "SDP interview end time (SIF)"
label variable end "SDP interview end time (string)"
label variable system_date "Current date & time (string)"
label variable system_dateSIF "Current date & time (SIF)"
label variable today "Date of interview (string)"
label variable todaySIF "Date of interview (SIF)"
label variable EA "EA number"
label variable facility_type "Type of facility"
label variable advanced_facility "Advanced facility"
label variable managing_authority "Managing authority"
label variable available "Competent respondent available for interview"
label variable consent_obtained "Consent obtained from interviewee"
label variable position "Interviewee position at facility"
label variable days_open "Number of days per week facility is open"
label variable present_24hr "Healthcare worker present 24 hours a day"
label variable knows_population_served "Know size of catchment area"
label variable population_served "Size of catchment population"
label variable beds "Number of beds"
label variable supervisor_visit "Recent supervisor visit"
label variable elec_cur "Facility has electricity at this time"
label variable elec_rec "Facility has electricity but out for two or more hours today"
label variable water_cur "Facility has water at this time"
label variable water_rec "Facility has water but out for two or more hours today"
label variable handwashing_stations "Number of handwashing facilities"
label variable handwashing_observations_staff "Hand washing facility observations used by staff"
label variable soap_present "Soap present at handwashing station"
label variable stored_water_present "Stored water present at handwashing station"
label variable running_water_present "Running water present at handwashing station"
label variable near_sanitation "Handwashing area is near a sanitation facility"



*Drop unnecessary vars
drop advanced_facility chw_freq_label sect_workload_note sect_fac_man_note sect_financing_note financing_begin_note ///
fees_grpfees_check reimburse_grpreimburse_label funds_grpfunds_check sect_phc_preamble ///
sect_prof_dev_note typical_day_note scenario_note hr_ack authority_note sect_monitor_quality ///
engagement_note supplies_note resources_note revreview_note sect_info_use_note yoyo_note drugs_grpdrugs_check phc_type sdp_photo ///
staffing_prompt participant_signaturesign services_info yo_future_error //phc_type is a calculation

*Drop calculate statements
drop scenario_3_opt_3 scenario_3_opt_4

*Drop date labs
drop accreditation_lab cab_meet_freq_lab

********************************************************************************
*export GPS data for monitoring first
replace facility_name=facility_name_other if facility_name=="other"
export excel round metainstanceID level1 level2 EA RE facility_name facility_type managing_authority locationlatitude locationlongitude locationaltitude locationaccuracy using "`CCRX'_SDPGPS_$date.xls", firstrow(variables) replace

* Drop all name variables and GPS for data release to Harvard
** Comment if necessarry
*drop RE EA facility_name facility_name_other district locationlatitude locationlongitude locationaltitude
* Drop check variables
*drop timeflag-duplicatename
********************************************************************************

save, replace

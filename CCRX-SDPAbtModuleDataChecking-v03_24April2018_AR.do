********************************************************************************
*
*  FILENAME:	CCRX-SDPAbtModuleDataChecking-v##_$date-initials.do
*  PURPOSE:		Data quality checks for the PMA2020 SDP abortion module 
*  CREATED:		Mridula Shankar (mshanka6@jhmi.edu)
*  DATA IN:		
*  DATA OUT:	
*  UPDATES:		
********************************************************************************
*Set directory
cd "$datadir"

*REVISION v2 AR 11Apr2018 add macros
local CCRX $CCRX

/* Call in dataset
use "Testdata/India/RJR4_Pilot_SDP_Questionnaire_v12_results_CLEAN.dta" 
*/

preserve
capture gen totalcompleted=1 if SDP_result==1
capture gen totalcompleted=1 if SDP_result=="completed"
*REVISION v3 AR 24Apr2018: Add total facilities with PAC services and total facilities that provide abortions
gen totalpac=1 if post_abt_0w_12w_yn==1 & SDP_result==1
gen totalabt=1 if provide_abt_0w_12w_yn==1 &SDP_result==1
gen NRDNKpac_0w_12w=1 if post_abt_0w_12w_yn==-88 | post_abt_0w_12w_yn==-99
gen NRDNKpac_12w=1 if post_abt_12w_yn==-88 | post_abt_12w_yn==-99
gen NRDNKabt_0w_12w=1 if provide_abt_0w_12w_yn==-88 | provide_abt_0w_12w_yn==-99
gen NRDNKabt_12w=1 if provide_abt_12w_yn==-88 | provide_abt_12w_yn==-99
gen NRDNKpac_outpat_av=1 if outpatient_avg==-88 | outpatient_avg==-99
gen NRDNKpac_outpat_lastmth=1 if outpatient_last_month==-88 | outpatient_last_month==-99
gen NRDNKpac_inpat_av=1 if inpatient_avg==-88 | inpatient_avg==-99
gen NRDNKpac_inpat_lastmth=1 if inpatient_last_month==-88 | inpatient_last_month==-99
gen NRDNKabt_av_month=1 if abt_avg_month==-88 | abt_avg_month==-99
gen NRDNKabt_last_month=1 if abt_last_month==-88 | abt_last_month==-99
*REVISION v2 AR 11Apr2018 collapsed by RE
*REVISION v3 AR 24Apr2018 added totalpac and totalabt
collapse (sum) NR* totalpac totalabt totalcompleted if totalcompleted==1, by(RE)
*REVISION v3 AR 24Apr2018: Make the checks percents rather than counts
foreach var in 0w_12w 12w outpat_av outpat_lastmth inpat_av inpat_lastmth {
gen NRDNKpac_`var'_per= NRDNKpac_`var'/totalpac *100
}
foreach var in 0w_12w 12w av_month last_month {
gen NRDNKabt_`var'_per= NRDNKabt_`var'/totalabt *100
}
*REVISION v2 AR 11Apr2018 saved to parent file's SDP check excel
*REVISION v3 AR 24Apr2018: export the percentages rather than the counts
export excel RE NRDNK*per total* using "`CCRX'_SDP_Checks_$date.xls", firstrow(variables) sh(AbortionChecks) sheetreplace
restore
















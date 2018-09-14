********************************************************************************
*
*  FILENAME:	CCRX_SDP_GGR_DataChecking_v##_$date_initials.do
*  PURPOSE:		Monitor key SDP variables in Global Gag Rule study
*  CREATED:		April 18, 2018 by Suzanne Bell (suzannebell@jhu.edu)
*  DATA IN:		UGR6_Female_Questionnaire_v#_results.csv
*  DATA OUT:	
*  UPDATES:		
*
********************************************************************************

local CCRX $CCRX

preserve
capture gen totalcompleted=1 if SDP_result==1
capture gen totalcompleted=1 if SDP_result=="completed"
gen total_advanced=1 if advanced_facility==1 & SDP_result==1
gen total_pac=1 if pac_capable==1 & SDP_result==1
gen total_inp=1 if inpatient_outpatient==1 | inpatient_outpatient==3
gen total_outp=1 if inpatient_outpatient==2 | inpatient_outpatient==3
capture gen total_abt=1 if abt_provide_yn=1

gen NRDNKngo_support=1 if ngo_support_yn==-88 | ngo_support_yn==-99
gen NRDNKpac_capable=1 if pac_capable==-88 | pac_capable==-99
gen NRDNKpac_outpat_av=1 if outpatient_avg_m==-88 | outpatient_avg_m==-99
gen NRDNKpac_outpat_lastmth=1 if outpatient_last_m==-88 | outpatient_last_m==-99
gen NRDNKpac_inpat_av=1 if inpatient_avg_m==-88 | inpatient_avg_m==-99
gen NRDNKpac_inpat_lastmth=1 if inpatient_last_m==-88 | inpatient_last_m==-99
capture NRDNKabt_provide=1 if abt_provide_yn==-88 | abt_provide_yn==-99
capture NRDNKabt_count_avg=1 if abt_count_avg_m=-88 | abt_count_avg_m=-99

collapse (sum) NR* totalcompleted total_advanced total_pac total_inp total_outp if totalcompleted==1, by(RE)

gen NRDNKngo_support_per=NRDNKngo_support/total_advanced*100
gen NRDNKpac_capable_per=NRDNKpac_capable/total_advanced*100
gen NRDNKpac_outp_av_per=NRDNKpac_outpat_av/total_outp*100
gen NRDNKpac_inp_av_per=NRDNKpac_inpat_av/total_inp*100
gen NRDNKpac_outp_lm_per=NRDNKpac_outpat_lastmth/total_outp*100
gen NRDNKpac_inp_lm_per=NRDNKpac_inpat_lastmth/total_inp*100
capture gen NRDNKabt_provide_per=NRDNKabt_provide/total_advanced*100
capture gen NRDNKabt_count_avg_per=NRDNKabt_count_avg/total_abt*100

* Uganda country specific code
if "$CCRX"=="UGR6"  {

export excel RE NRDNKngo_support_per NRDNKpac_capable_per total_advanced NRDNKpac_outp_av_per NRDNKpac_outp_lm_per total_outp NRDNKpac_inp_av_per NRDNKpac_inp_lm_per total_inp using "`CCRX'_SDP_Checks_$date.xls", firstrow(variables) sh(AbortionChecks) sheetreplace
}
 
else if "$CCRX"="ETR6" {

export excel RE NRDNKngo_support_per NRDNKpac_capable_per NRDNKabt_provide_per total_advanced NRDNKpac_outp_av_per NRDNKpac_outp_lm_per total_outp NRDNKpac_inp_av_per NRDNKpac_inp_lm_per total_inp NRDNKabt_count_avg_per total_abt using "`CCRX'_SDP_Checks_$date.xls", firstrow(variables) sh(AbortionChecks) sheetreplace
}

restore

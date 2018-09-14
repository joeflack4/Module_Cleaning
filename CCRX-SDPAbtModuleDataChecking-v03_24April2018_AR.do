********************************************************************************
*
*  FILENAME:	CCRX-SDPAbtModuleDataChecking-v##_$date-initials.do
*  PURPOSE:		Data quality checks for the PMA2020 SDP abortion module 
*  CREATED:		Mridula Shankar (mshanka6@jhmi.edu)
*  DATA IN:		
*  DATA OUT:	CCRX_SDP_Checks_$date.xlsx
*  UPDATES:		
********************************************************************************
*Set directory
cd "$datadir"

local CCRX $CCRX

*Generate checks for abortion module
preserve
capture gen totalcompleted=1 if SDP_result==1
capture gen totalcompleted=1 if SDP_result=="completed"
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

*Collapse by RE for data monitoring
collapse (sum) NR* totalpac totalabt totalcompleted if totalcompleted==1, by(RE)

*Make the checks percents rather than counts
foreach var in 0w_12w 12w outpat_av outpat_lastmth inpat_av inpat_lastmth {
gen NRDNKpac_`var'_per= NRDNKpac_`var'/totalpac *100
}
foreach var in 0w_12w 12w av_month last_month {
gen NRDNKabt_`var'_per= NRDNKabt_`var'/totalabt *100
}

export excel RE NRDNK*per total* using "`CCRX'_SDP_Checks_$date.xls", firstrow(variables) sh(AbortionChecks) sheetreplace
restore
















********************************************************************************
*
*  FILENAME:	CCRX_FRQ_GGR_DataChecking_v##_$date_initials.do
*  PURPOSE:		Monitor key female variables in Global Gag Rule study
*  CREATED:		Suzanne Bell (suzannebell@jhu.edu)
*  CREATED:		April 16, 2018 by Suzanne Bell (suzannebell@jhu.edu)
*  DATA OUT:	
*  UPDATES:		
*
********************************************************************************

local CCRX $CCRX

preserve
capture gen totalcompleted=1 if FRS_result==1
capture gen totalcompleted=1 if FRS_result=="completed"
gen total_friends=1 if friends!=. & FRS_result==1
gen total_f1=1 if friend1_abt_yn!=. & FRS_result==1
gen total_nsum=1 if nsum_prompt!=. & FRS_result==1
gen NRDNKfriends=1 if friends==-88 | friends==-99
gen NRDNKfriend1_abt=1 if friend1_abt_yn==-88 | friend1_abt_yn==-99
gen NRDNKnsum_prompt=1 if nsum_prompt==-88 | nsum_prompt==-99 | nsum_prompt==0
gen NRDNKnsum_abt=1 if nsum_abt==-88 | nsum_abt==-99 
gen NRself_abt=1 if self_abt_yn==-99
collapse (sum) NR* totalcompleted total_friend total_f1 total_nsum if totalcompleted==1, by (RE $GeoID) 

* REVISION v3 25Apr2018 SOB: Made abortion checks percents instead of counts
gen NRDNKfriends_per=NRDNKfriends/total_friends *100
gen NRDNKfriend1_abt_per= NRDNKfriend1_abt/total_f1 *100
gen NRDNKnsum_prompt_per= NRDNKnsum_prompt/total_nsum *100
gen NRDNKnsum_abt_per= NRDNKnsum_abt/total_nsum *100
gen NRself_abt_per=NRself_abt/totalcompleted *100

export excel RE $GeoID NRDNKfriends_per total_friends NRDNKfriend1_abt_per total_f1 NRDNKnsum_prompt_per NRDNKnsum_abt_per total_nsum NRself_abt_per totalcompleted using `CCRX'_HHQFQErrors_$date.xls, firstrow(variables) sh(AbortionChecks) sheetreplace
restore


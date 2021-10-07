*************************************************************************************************************************************
* Raghav Gupta																														
* November, 2020																													 																																	
* Data: Nigerian Manufacturing Enterprise Survey (NMES) Wave 2, 2004 - Centre for Study of African Economies, University of Oxford
* Note: This Do file was the first step in exploring this data to create a production function for Nigerian manufacturing firms	
*************************************************************************************************************************************

clear all

version 15.1

cap log close

set more off

cd "/Users/raghavgupta 1/Desktop/Projects/Nigeria Firm Level Data"


* Merging Sections 3, 4, and 5 of the dataset

use "/Users/raghavgupta 1/Desktop/Projects/Nigeria Firm Level Data/Firm_Data_Wave2/nm2_section3_public.dta", clear
sort firmid
save tempdata3, replace

use "/Users/raghavgupta 1/Desktop/Projects/Nigeria Firm Level DataFirm_Data_Wave2/nm2_section4_public.dta", clear
sort firmid
save tempdata4, replace

use "/Users/raghavgupta 1/Desktop/Projects/Nigeria Firm Level DataFirm_Data_Wave2/nm2_section5_public.dta", clear
sort firmid

merge 1:m firmid using tempdata3 tempdata4

* Generate a variable to help adjust for different reporting periods

gen multiple=1 if n3q2=="1 year"
replace multiple=12 if n3q2=="1 month"
replace multiple=52 if n3q2=="1 week"
replace multiple=26 if n3q2=="2 weeks"

* Generate variables using multiple

gen float rev01=n3q5_2001*multiple // revenue
gen float rev2=n3q5_2002*multiple
gen float rev3=n3q5_2003*multiple

gen float output01=n3q6_2001*multiple // output
gen float output02=n3q6_2002*multiple
gen float output03=n3q6_2003*multiple

gen float indcst01= n3q11n1*multiple // total indirect costs
gen float indcst02= n3q11n2*multiple
gen float indcst03= n3q11n3*multiple

gen float rawmat01=n3q12_2001*multiple // raw material cost
gen float rawmat02=n3q12_2002*multiple
gen float rawmat03=n3q12_2003*multiple

gen float vadd01=n3q15_2001*multiple // reported value added
gen float vadd02=n3q15_2002*multiple
gen float vadd03=n3q15_2003*multiple

gen float deprec01=n3q16_2001*multiple // depreciation
gen float deprec02=n3q16_2002*multiple
gen float deprec03=n3q16_2003*multiple

gen float labcost01=n3q19_2001*multiple // total labor costs
gen float labcost02=n3q19_2002*multiple
gen float labcost03=n3q19_2003*multiple

gen float profit01=n3q20_2001*multiple // reported profit
gen float profit02=n3q20_2002*multiple
gen float profit03=n3q20_2003*multiple

gen float capacity01=n3q24_2001 // capacity utilization
gen float capacity02=n3q24_2002
gen float capacity03=n3q24_2003

* Calculating Capital Stock

gen float cap01=n4q1_2001+n4q3_2001
gen float cap02=n4q1_2002+n4q3_2002
gen float cap03=n4q1_2003+n4q3_2003
sum cap*

* Calculating investment in each period

foreach var in n4q13a n4q13b n4q13c n4q13d n4q11a n4q11b n4q11c n4q11d n4q9a n4q9b n4q9c n4q9d{
	replace `var'=0 if `var'==.
}
 
gen float invest01=n4q13a+n4q13b+n4q13c+n4q13d
gen float invest02=n4q11a+n4q11b+n4q11c+n4q11d 
gen float invest03=n4q9a+n4q9b+n4q9c+n4q9d 
sum inv*

save "/Users/raghavgupta 1/Desktop/Projects/Nigeria Firm Level Data/Temp"
exit


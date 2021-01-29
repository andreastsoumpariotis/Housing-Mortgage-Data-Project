PROC FORMAT;
VALUE $msa_mdff '19124'='(19124) DALLAS-PLANO-IRVING, TX'
                '35644'='(35644) NEW YORK-WHITE PLAINS-WAYNE, NY-NJ'
				'49660'='(49660) YOUNGSTOWN-WARREN-BOARDMAN, OH-PA';
VALUE $purchasf 
                '0'='(0) Loan was not originated or was not sold in calendar year covered by register'
                '1'='(1) Fannie Mae (FNMA)' '2'='(2) Ginnie Mae (GNMA)' '3'='(3) Freddie Mac (FHLMC)'
                '4'='(4) Farmer Mac (FAMC)' '5'='(5) Private securitization'
                '6'='(6) Commercial bank, savings bank or savings association'
                '7'='(7) Life insurance company, credit union, mortgage bank, or finance company'
                '8'='(8) Affiliate institution' '9'='(9) Other type of purchaser';
VALUE $applica_1f  '1'='(1) American Indian or Alaska Native' '2'='(2) Asian'
                '3'='(3) Black or African American' '4'='(4) Native Hawaiian or Other Pacific Islander'
                '5'='(5) White'
                '6'='(6) Information not provided by applicant in mail, Internet, or telephone application'
                '7'='(7) Not applicable' '8'='(8) No co-applicant';
VALUE applica_3f  0='(0) Application Date >= 01-01-2004'
                1='(1) Application Date < 01-01-2004' 2='(2) Application Date = NA (Not Available)';
VALUE $agency_f  '1'='(1) Office of the Comptroller of the Currency (OCC)'
                '2'='(2) Federal Reserve System (FRS)'
                '3'='(3) Federal Deposit Insurance Corporation (FDIC)'
                '5'='(5) National Credit Union Administration (NCUA)'
                '7'='(7) Department of Housing and Urban Development (HUD)'
                '9'='(9) Consumer Financial Protection Bureau (CFPB)';
VALUE $edit_stf  '5'='(5) Validity edit failure only' '6'='(6) Quality edit failure only'
                '7'='(7) Validity and quality edit failures';
VALUE loan_tyf  1='(1) Conventional (any loan other than FHA, VA, FSA, or RHS loans)'
                2='(2) FHA-insured (Federal Housing Administration)'
                3='(3) VA-guaranteed (Veterans Administration)'
                4='(4) FSA/RHS (Farm Service Agency or Rural Housing Service)';
VALUE $preapprf  '1'='(1) Preapproval was requested'
                '2'='(2) Preapproval was not requested' '3'='(3) Not applicable';
VALUE $applicaf  '1'='(1) Hispanic or Latino' '2'='(2) Not Hispanic or Latino'
                '3'='(3) Information not provided by applicant in mail, Internet, or telephone application'
                '4'='(4) Not applicable' '5'='(5) No co-applicant';
VALUE applica_2f  1='(1) Male' 2='(2) Female'
                3='(3) Information not provided by applicant in mail, Internet, or telephone application'
                4='(4) Not applicable' 5='(5) No co-applicant';
VALUE $hoepa_sf  '1'='(1) HOEPA loan' '2'='(2) Not a HOEPA loan';
VALUE loan_puf  1='(1) Home purchase' 2='(2) Home improvement' 3='(3) Refinancing';
VALUE occupanf  1='(1) Owner-occupied as a principal dwelling' 2='(2) Not owner-occupied'
                3='(3) Not applicable';
VALUE $denial_f  '1'='(1) Debt-to-income ratio' '2'='(2) Employment history'
                '3'='(3) Credit history' '4'='(4) Collateral'
                '5'='(5) Insufficient cash (downpayment, closing costs)'
                '6'='(6) Unverifiable information' '7'='(7) Credit application incomplete'
                '8'='(8) Mortgage insurance denied' '9'='(9) Other';
VALUE $lien_stf  '1'='(1) Secured by a first lien' '2'='(2) Secured by a subordinate lien'
                '3'='(3) Not secured by a lien' '4'='(4) Not applicable (purchased loans)';
VALUE action_f  1='(1) Loan originated' 2='(2) Application approved but not accepted'
                3='(3) Application denied by financial institution'
                4='(4) Application withdrawn by applicant' 5='(5) File closed for incompleteness'
                6='(6) Loan purchased by the institution'
                7='(7) Preapproval request denied by financial institution'
                8='(8) Preapproval request approved but not accepted (optional reporting)';
VALUE $propertf  '1'='(1) One to four-family (other than manufactured housing)'
                '2'='(2) Manufactured housing' '3'='(3) Multifamily';
run;

*Path;
%let path=\\Client\H$\Documents\SMU\2020-21\Fall\STAT 6307\SASDATA\Macro Project - Fall 2020;

*Metros;
%LET Metro1 = DAL;
%LET Metro2 = NY;
%LET Metro3 = OH;

*Years;
%LET Year1 = 2006;
%LET Year2 = 2007;
%LET Year3 = 2010;
%LET Year4 = 2011;
%LET Year5 = 2012;

*Folders;
%LET Folder1 = 24611;
%LET Folder2 = 24612;
%LET Folder3 = 36171;
%LET Folder4 = 36172;
%LET Folder5 = 36173;

*DAL;
%LET DAL1 = 0099; 
%LET DAL2 = 0099;
%LET DAL3 = 0101; 
%LET DAL4 = 0101;
%LET DAL5 = 0100; 

*NY;
%LET NY1 = 0262; 
%LET NY2 = 0263;
%LET NY3 = 0265;
%LET NY4 = 0264;
%LET NY5 = 0262;

*OH;
%LET OH1 = 0399;
%LET OH2 = 0402;
%LET OH3 = 0404;
%LET OH4 = 0403;
%LET OH5 = 0401;

*Macro Variable;
%MACRO readit(Metro=);
%do i = 1 %to 5;

DATA hmda&metro&&year&i;
INFILE "&path\ICPSR-&&Folder&i\DS&&&Metro&i\&&Folder&i-&&&Metro&i-Data.csv" FIRSTOBS=1 DELIMITER="," DSD;
INPUT                                                             
       YEAR                      RESPONDENT_ID $                  
        AGENCY_CODE $            LOAN_TYPE                        PROPERTY_TYPE $
        LOAN_PURPOSE             OCCUPANCY                        LOAN_AMOUNT 
        PREAPPROVAL $            ACTION_TYPE                      MSA_MD $
        STATE_CODE $             COUNTY_CODE $                    CENSUS_TRACT_NUMBER $
        APPLICANT_ETHNICITY $    CO_APPLICANT_ETHNICITY $         APPLICANT_RACE_1 $
        APPLICANT_RACE_2 $       APPLICANT_RACE_3 $               APPLICANT_RACE_4 $
        APPLICANT_RACE_5 $       CO_APPLICANT_RACE_1 $            CO_APPLICANT_RACE_2 $
        CO_APPLICANT_RACE_3 $    CO_APPLICANT_RACE_4 $            CO_APPLICANT_RACE_5 $
        APPLICANT_SEX            CO_APPLICANT_SEX                 APPLICANT_INCOME $
        PURCHASER_TYPE $         DENIAL_REASON_1 $                DENIAL_REASON_2 $
        DENIAL_REASON_3 $        RATE_SPREAD $                    HOEPA_STATUS $
        LIEN_STATUS $            EDIT_STATUS $                    SEQUENCE_NUMBER $
        POPULATION $             MINORITY_POPULATION $            HUD_MEDIAN_FAMILY_INCOME $
        TRACT_TO_MSA_MD_INCOME $ NUMBER_OF_OWNER_OCCUPIED_UNITS $ NUMBER_OF_1_TO_4_FAMILY_UNITS $
        APPLICATION_DATE_INDICATOR  ;

* SAS LABEL STATEMENT;

LABEL 
   YEAR    = 'As of Year' 
   RESPONDENT_ID= 'Respondent ID: 10 Character Identifier' 
   AGENCY_CODE= 'Agency Code' 
   LOAN_TYPE= 'Loan Type' 
   PROPERTY_TYPE= 'Property Type' 
   LOAN_PURPOSE= 'Loan Purpose' 
   OCCUPANCY= 'Owner-Occupancy' 
   LOAN_AMOUNT= 'Loan Amount: in thousands of dollars' 
   PREAPPROVAL= 'Preapproval' 
   ACTION_TYPE= 'Action Taken' 
   MSA_MD  = 'MSA/MD: Metropolitan Statistical Area/Metropolitan Division' 
   STATE_CODE= 'Two-digit FIPS state identifier' 
   COUNTY_CODE= 'Three-digit FIPS county identifier' 
   CENSUS_TRACT_NUMBER= 'Census Tract Number' 
   APPLICANT_ETHNICITY= 'Applicant Ethnicity' 
   CO_APPLICANT_ETHNICITY= 'Co Applicant Ethnicity' 
   APPLICANT_RACE_1= 'Applicant Race 1' 
   APPLICANT_RACE_2= 'Applicant Race 2' 
   APPLICANT_RACE_3= 'Applicant Race 3' 
   APPLICANT_RACE_4= 'Applicant Race 4' 
   APPLICANT_RACE_5= 'Applicant Race 5' 
   CO_APPLICANT_RACE_1= 'Co Applicant Race 1' 
   CO_APPLICANT_RACE_2= 'Co Applicant Race 2' 
   CO_APPLICANT_RACE_3= 'Co Applicant Race 3' 
   CO_APPLICANT_RACE_4= 'Co Applicant Race 4' 
   CO_APPLICANT_RACE_5= 'Co Applicant Race 5' 
   APPLICANT_SEX= 'Applicant Sex' 
   CO_APPLICANT_SEX= 'Co Applicant Sex' 
   APPLICANT_INCOME= 'Applicant Gross Annual Income: in thousands of dollars' 
   PURCHASER_TYPE= 'Type of Purchaser' 
   DENIAL_REASON_1= 'Reasons for Denial 1' 
   DENIAL_REASON_2= 'Reasons for Denial 2' 
   DENIAL_REASON_3= 'Reasons for Denial 3' 
   RATE_SPREAD= 'Rate Spread' 
   HOEPA_STATUS= 'HOEPA Status (only for loans originated or purchased)' 
   LIEN_STATUS= 'Lien Status (only for applications and originations)' 
   EDIT_STATUS= 'Edit Status, Blank -- No edit failures' 
   SEQUENCE_NUMBER= 'Sequence Number: One-up number scheme for each respondent to make each loan unique' 
   POPULATION= 'Population: total population in tract' 
   MINORITY_POPULATION= 'Minority Population %: percentage of minority population to total population for tract. (Carried to 
two decimal places)' 
   HUD_MEDIAN_FAMILY_INCOME= 'HUD Median Family Income: HUD Median family income in dollars for the MSA/MD in which the tract is 
located (adjusted annually by HUD)' 
   TRACT_TO_MSA_MD_INCOME= 'Tract to MSA/MD Median Family Income Percentage: % of tract median family income compared to MSA/MD 
median family income. (Carried to two decimal places)' 
   NUMBER_OF_OWNER_OCCUPIED_UNITS= 'Number of Owner Occupied Units: Number of dwellings, including individual condominiums, that are 
lived in by the owner' 
   NUMBER_OF_1_TO_4_FAMILY_UNITS= 'Number of 1- to 4-Family units: Dwellings that are built to house fewer than 5 families' 
   APPLICATION_DATE_INDICATOR= 'Application Date Indicator' 
        ; 

* SAS FORMAT STATEMENT;

   FORMAT
         ACTION_TYPE action_f. AGENCY_CODE $agency_f. APPLICANT_ETHNICITY $applicaf.
         APPLICANT_RACE_1 $applica_1f. APPLICANT_RACE_2 $applica_1f. APPLICANT_RACE_3 $applica_1f.
         APPLICANT_RACE_4 $applica_1f. APPLICANT_RACE_5 $applica_1f. APPLICANT_SEX applica_2f.
         APPLICATION_DATE_INDICATOR applica_3f. CO_APPLICANT_ETHNICITY $applicaf. CO_APPLICANT_RACE_1 $applica_1f.
         CO_APPLICANT_RACE_2 $applica_1f. CO_APPLICANT_RACE_3 $applica_1f. CO_APPLICANT_RACE_4 $applica_1f.
         CO_APPLICANT_RACE_5 $applica_1f. CO_APPLICANT_SEX applica_2f. DENIAL_REASON_1 $denial_f.
         DENIAL_REASON_2 $denial_f. DENIAL_REASON_3 $denial_f. EDIT_STATUS $edit_stf.
         HOEPA_STATUS $hoepa_sf. LIEN_STATUS $lien_stf. LOAN_PURPOSE loan_puf.
         LOAN_TYPE loan_tyf. MSA_MD $msa_mdff. OCCUPANCY occupanf.
         PREAPPROVAL $preapprf. PROPERTY_TYPE $propertf. PURCHASER_TYPE $purchasf.
    ;

RUN ;
%end;
%MEND readit;

*DAL;
%readit(metro=&Metro1);
*NY;
%readit(metro=&Metro2);
*OH;
%readit(metro=&Metro3);

*Housing Mortgages;
%MACRO readit2(Metro=);
%do i=1 %to 5;

data project; 
set hmda&metro&&Year&i;
Call symputx('Year',YEAR);
Call symput('MSA',put(MSA_MD, $msa_mdff.));
INCOME = input(APPLICANT_INCOME, 4.);
format INCOME 4.;
if INCOME < 1000;
run;
Title "Housing Mortgages for &MSA &Year";

*Frequency Table;
proc freq data = project;
tables LOAN_TYPE PROPERTY_TYPE LOAN_PURPOSE OCCUPANCY PREAPPROVAL ACTION_TYPE;
run;
*Histogram;
proc univariate data = project noprint;
var INCOME LOAN_AMOUNT;
histogram / normal;
WHERE(LOAN_AMOUNT < 1000 & INCOME < 1000);
INSET MEAN MEDIAN STD / POS=NE;
HISTOGRAM LOAN_AMOUNT INCOME / KERNEL;
WHERE(LOAN_AMOUNT < 1000 & INCOME < 1000);
INSET MEAN MEDIAN STD / POS=NE;
run;
*Scatter plot of Loan Amount vs Income;
proc sgplot data = project;
 scatter x=INCOME y=LOAN_AMOUNT; WHERE(LOAN_AMOUNT < 5000 & INCOME < 10000);
 run;

title;
%end;
%MEND readit2;

ods word file="\\Client\H$\Documents\SMU\2020-21\Fall\STAT 6307\Homework\Homework 9 Macro Project\Final Output.doc";
%readit2(metro=&Metro1)
%readit2(metro=&Metro2)
%readit2(metro=&Metro3)
ods word close;

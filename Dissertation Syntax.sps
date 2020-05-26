* Encoding: UTF-8.
*K. McNamara Dissertation Analysis Syntax*

*Dissertation Data Set*

GET
  FILE='C:\Users\knmcn\Documents\Dissertation\Final Data Analysis\Dissertation Data Set.sav'.
DATASET NAME DataSet1 WINDOW=FRONT.

*Chapter 2: Cesarean Delivery*
*Analysis: Descpritive Statistics, Correlations, Crosstabulations, Logistic Regression Analysis*

*Dependent Variable: CesareanF (Cesarean Delivery Likelihood), CesareanPressure (Cesarean Delivery Pressure Likelihood), and
Cesarean Choice was recoded into four different variables (cesareanchoiceDR (respondent only choice dichotomized variable (1= Respondent Decision, 0=Doctor, Both, Don’t Know)), 
cesareanchoiceDD (doctor only choice dichotomized variable (1=Medical Professional decision, 0= Respondent, Both, Don’t Know)), 
cesareanchoiceDA (respondent agency dichotomized variable (1= Respondent or Both (Respondent Agency), 0= Medical professional, Don’t know)), 
and cesareanchoiceDDA (doctor dichotomized variable (1= Medical Professional or Both (Respondent Agency), 0= Respondent, Don’t know)).*

*Indepenedent Variables:
Sociodemographic& Individual Characteristics: RaceNew (Categorical Race Variable), White1 (White Dummy Variable), InsuranceStatus (Insurance Status), 
 HSorLess (High School Education or Less)
Organizational Characteristics: Ownership (For Profit or Not For Profit), CHospital (Catholic Hospital Affiliation), SystemMember (System Membership), TtlHsptlBds (Total Hospital Beds Scale Variable), 
opmarFive (Operating Margin Above or Below Five), dnparMED (Days in Net Patients Accounts Receivable Above or Below Median).
*Individual Control Variables: Preterm (Preterm Birth), Obesity, Diabetes (Type 1 or 2 Diabetes), ParityS (Parity Scale Variable), PrevCS (Previous Cesarean Delivery) Q105 (Age Scale Variable).*

*Cesarean Delivery Likelihood (Models 1-2)*
*Descriptive Statistics*

DESCRIPTIVES VARIABLES= CesareanF White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
/STATISTICS=MEAN STDDEV MIN MAX.

*Correlations:*

CORRELATIONS
  /VARIABLES=CesareanF White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

CORRELATIONS
  /VARIABLES=CesareanF Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
 
*Crosstabulations*

CROSSTABS
  /TABLES=CesareanF BY White1 InsuranceStatus HSorLess Obesity Diabetes Preterm PrevCS ParityS Q105
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=CesareanF BY Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

*Model 1: Cesarean Delivery Likelihood by Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES CesareanF
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Model 2: Cesarean Delivery Likelihood by Organizational Characteristics*
  
LOGISTIC REGRESSION VARIABLES CesareanF
  /METHOD=ENTER Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Model 2a: Cesarean Delivery Likelihood by Organizational Characteristics (controlling for individual & Sociodemographic)
  
  LOGISTIC REGRESSION VARIABLES CesareanF
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Model 2b: Cesarean Delivery Likelihood by Organizational Characteristics (controlling for select individual characteristics and all sociodemographic characteristics)

  LOGISTIC REGRESSION VARIABLES CesareanF
  /METHOD=ENTER White1 InsuranceStatus Preterm Diabetes HSorLess Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*Model 2c: Cesarean Delivery Likelihood by Organizational Characteristics (controlling only for sociodemographic characteristics)

 LOGISTIC REGRESSION VARIABLES CesareanF
  /METHOD=ENTER White1 InsuranceStatus HSorLess Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

 *Model 2d: Cesarean Delivery Likelihood by Organizational Characteristics (Interaction Effects)*
  
  LOGISTIC REGRESSION VARIABLES CesareanF
  /METHOD=ENTER CHospital*PrevCS CHospital dnparMED opmarFive RaceNew InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership  SystemMember TtlHsptlBds dnparMED 
  /CONTRAST (RaceNew)=Indicator(1)
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5). 

  LOGISTIC REGRESSION VARIABLES CesareanF
  /METHOD=ENTER Q105*CHospital RaceNew InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
  /CONTRAST (RaceNew)=Indicator(1)
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

  LOGISTIC REGRESSION VARIABLES CesareanF
  /METHOD=ENTER ParityS*CHospital RaceNew InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
  /CONTRAST (RaceNew)=Indicator(1)
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

  LOGISTIC REGRESSION VARIABLES CesareanF
  /METHOD=ENTER Obesity*CHospital RaceNew InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
  /CONTRAST (RaceNew)=Indicator(1)
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).



*Cesarean Delivery Pressure Likelihood (Models 3-4a)*
*Descriptive Statistics*

DESCRIPTIVES VARIABLES= CesareanPressure White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
/STATISTICS=MEAN STDDEV MIN MAX.

*Correlations:*

CORRELATIONS
  /VARIABLES=CesareanPressure White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

CORRELATIONS
  /VARIABLES=CesareanPressure Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
 
*Crosstabulations*

CROSSTABS
  /TABLES=CesareanPressure BY White1 InsuranceStatus HSorLess Obesity Diabetes Preterm PrevCS ParityS Q105
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=CesareanPressure BY Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.



*Model 3: Cesarean Delivery Pressure Likelihood by Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES CesareanPressure
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Model 4:Cesarean Delivery Pressure Likelihood by Organizational Characteristics*

LOGISTIC REGRESSION VARIABLES CesareanPressure
  /METHOD=ENTER Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Model 4a: Cesarean Delivery Pressure Likelihood by Organizational Characteristics (Controlling for Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES CesareanPressure
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).



*Cesarean Choice Likelihood*

Descriptive Statistics*

DESCRIPTIVES VARIABLES= CesareanF White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
/STATISTICS=MEAN STDDEV MIN MAX.

*Correlations:*

CORRELATIONS
  /VARIABLES=CesareanF White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

CORRELATIONS
  /VARIABLES=CesareanF Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
 
*Crosstabulations*

CROSSTABS
  /TABLES=CesareanF BY White1 InsuranceStatus HSorLess Obesity Diabetes Preterm PrevCS ParityS Q105
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=CesareanF BY Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.


*Cesarean Choice Patient Choice Likelihood by Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES cesareanchoiceDR
  /METHOD=ENTER RaceNew InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Cesarean  Doctor Choice Likelihood by Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES cesareanchoiceDD
  /METHOD=ENTER RaceNew InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Cesarean  Respondent Agency Choice Likelihood by Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES cesareanchoiceDA
  /METHOD=ENTER RaceNew InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Cesarean  Doctor or Both Choice Likelihood by Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES cesareanchoiceDDA
  /METHOD=ENTER RaceNew InsuranceStatus Preterm Obesity Diabetes  HSorLess ParityS PrevCS Q105 
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*Cesarean Individual Choice Likelihood by Organizational Characteristics (Contorlling for Individual & Sociodemographic Characteristics)*

LOGISTIC REGRESSION VARIABLES cesareanchoiceDR
  /METHOD=ENTER RaceNew InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Cesarean Choice Doctor Only Likelihood by Organizational Characteristics (Controlling for Individual & Sociodemographic Characteristics)*

LOGISTIC REGRESSION VARIABLES cesareanchoiceDD
  /METHOD=ENTER RaceNew InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Cesarean Choice Respondent Agency Likelihood by Organizational Characteristics (Controlling for Individual & Sociodemographic Characteristics)*

LOGISTIC REGRESSION VARIABLES cesareanchoiceDA
  /METHOD=ENTER RaceNew InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Cesarean Choice Doctor or Both Likelihood by Organizational Characteristics (Controlling for Individual & Sociodemographic Characteristics)*

LOGISTIC REGRESSION VARIABLES cesareanchoiceDDA
  /METHOD=ENTER RaceNew InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*Cesarean Choice Respondent Only Likelihood by Organizational Characteristics*


LOGISTIC REGRESSION VARIABLES cesareanchoiceDR
  /METHOD=ENTER Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Cesarean Choice Doctor Only Likelihood by Organizational Characteristics*

LOGISTIC REGRESSION VARIABLES cesareanchoiceDD
  /METHOD=ENTER Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Cesarean Choice Respondent Agency Likelihood by Organizational Characteristics*

LOGISTIC REGRESSION VARIABLES cesareanchoiceDA
  /METHOD=ENTER Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Cesarean Choice Doctor or Both Likelihood by Organizational Characteristics*

LOGISTIC REGRESSION VARIABLES cesareanchoiceDDA
  /METHOD=ENTER Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).



Chapter 3: Induction & EFM 
*Analysis: Descpritive Statistics, Correlations, Crosstabulations, Logistic Regression Analysis*

*Dependent Variable: Induce (Labor Induction), InducePressure (Pressure to be Induced)
EFMD (Dichotomous EFM Variable)*

*Indepenedent Variables:
Sociodemographic& Individual Characteristics: RaceNew (Categorical Race Variable), White1 (White Dummy Variable), InsuranceStatus (Insurance Status), 
 HSorLess (High School Education or Less)
Organizational Characteristics: Ownership (For Profit or Not For Profit), CHospital (Catholic Hospital Affiliation), SystemMember (System Membership), TtlHsptlBds (Total Hospital Beds Scale Variable), 
opmarFive (Operating Margin Above or Below Five), dnparMED (Days in Net Patients Accounts Receivable Above or Below Median).
*Individual Control Variables: Preterm (Preterm Birth), Obesity, Diabetes (Type 1 or 2 Diabetes), ParityS (Parity Scale Variable), PrevCS (Previous Cesarean Delivery) Q105 (Age Scale Variable).*

*Labor Induction Analysis*

GET
  FILE='C:\Users\knmcn\Documents\Dissertation\Final Data Analysis\Induction Data Set.sav'.
DATASET NAME DataSet4 WINDOW=FRONT.

*Descriptive Statistics*

DESCRIPTIVES VARIABLES= Induce White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
/STATISTICS=MEAN STDDEV MIN MAX.

*Correlations:*

CORRELATIONS
  /VARIABLES=Induce White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

CORRELATIONS
  /VARIABLES=Induce Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
 
*Crosstabulations*

CROSSTABS
  /TABLES=Induce BY White1 InsuranceStatus HSorLess Obesity Diabetes Preterm PrevCS ParityS Q105
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=Induce BY Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.


*Model 5: Labor Induction Likelihood by Individual Characteristics*

LOGISTIC REGRESSION VARIABLES Induce
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Labor Induction Likelihood by Organizational Characteristics*

LOGISTIC REGRESSION VARIABLES Induce
  /METHOD=ENTER Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Labor Induction Likelihood by Organizational Characteristics (controlling for individual & sociodemographic characteristics)

LOGISTIC REGRESSION VARIABLES Induce
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*Induction Pressure*

*Descriptive Statistics*

DESCRIPTIVES VARIABLES= InducePressure White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
/STATISTICS=MEAN STDDEV MIN MAX.

*Correlations:*

CORRELATIONS
  /VARIABLES=InducePressure White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

CORRELATIONS
  /VARIABLES=InducePressure Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
 
*Crosstabulations*

CROSSTABS
  /TABLES=InducePressure BY White1 InsuranceStatus HSorLess Obesity Diabetes Preterm PrevCS ParityS Q105
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=InducePressure BY Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.


*Model 6: Induction Pressure Likelihood by Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES InducePressure
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Induction Pressure Likelihood by Organizational Characteristics*

LOGISTIC REGRESSION VARIABLES InducePressure
  /METHOD=ENTER Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Induction Pressure Likelihood by Organizational Characteristics (Controlling for Individual & Sociodemographic Characteristics)

LOGISTIC REGRESSION VARIABLES InducePressure
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*Induction Choice*

GET
  FILE='C:\Users\knmcn\Documents\Dissertation\Final Data Analysis\Induction Choice Data Set.sav'.
DATASET NAME DataSet6 WINDOW=FRONT.


*Induction Repsondent Choice Likelihood by Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES inducechoiceDR
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Induce Doctor Choice Likelihood by Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES inducechoiceDD
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Induce Choice Respondent Agency Choice Likelihood by Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES inducechoiceDA
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Induce Choice Doctor or Both Choice Likelihood by Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES inducechoiceDDA
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Induction Individual Choice Likelihood by Organizational Characteristics*

LOGISTIC REGRESSION VARIABLES inducechoiceDR
  /METHOD=ENTER Ownership SystemMember CHospital TtlHsptlBds opmarFive dnparMED
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Induce Doctor Only Choice Likelihood by Organizational Characteristics*

LOGISTIC REGRESSION VARIABLES inducechoiceDD
  /METHOD=ENTER Ownership SystemMember CHospital TtlHsptlBds opmarFive dnparMED
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Induce Respondent Agency Choice Likelihood by Organizational Characteristics*

LOGISTIC REGRESSION VARIABLES inducechoiceDA
  /METHOD=ENTER Ownership SystemMember CHospital TtlHsptlBds opmarFive dnparMED
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Induce Choice Doctor or Both Choice Likelihood by Organizational Characteristics*

LOGISTIC REGRESSION VARIABLES inducechoiceDDA
  /METHOD=ENTER Ownership SystemMember CHospital TtlHsptlBds opmarFive dnparMED
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*Induction Individual Choice Likelihood by Organizational Characteristics (Controlling for Indiidual & Sociodemographic Characteristics)*


LOGISTIC REGRESSION VARIABLES inducechoiceDR
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership SystemMember CHospital TtlHsptlBds opmarFive dnparMED
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Induce Choice Doctor Only Likelihood by Organizational Characteristics (Controlling for Indiidual & Sociodemographic Characteristics)*

LOGISTIC REGRESSION VARIABLES inducechoiceDD
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership SystemMember CHospital TtlHsptlBds opmarFive dnparMED
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Induce Choice Respondent Agency Likelihood by Organizational Characteristics (Controlling for Indiidual & Sociodemographic Characteristics)*

LOGISTIC REGRESSION VARIABLES inducechoiceDA
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership SystemMember CHospital TtlHsptlBds opmarFive dnparMED
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Logistic Regression*
*Induce Choice Doctor or Both Likelihood by Organizational Characteristics (Controlling for Indiidual & Sociodemographic Characteristics)*

LOGISTIC REGRESSION VARIABLES inducechoiceDDA
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership SystemMember CHospital TtlHsptlBds opmarFive dnparMED
  /CONTRAST (InsuranceStatus)=Indicator(1)
  /CONTRAST (RaceNew)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).



*EFM Analysis*

GET
  FILE='C:\Users\knmcn\Documents\Dissertation\Final Data Analysis\EFM Data Set.sav'.
DATASET NAME DataSet7 WINDOW=FRONT.

*Descriptive Statistics*

DESCRIPTIVES VARIABLES= EFMD White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
/STATISTICS=MEAN STDDEV MIN MAX.

*Correlations:*

CORRELATIONS
  /VARIABLES=EFMD White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

CORRELATIONS
  /VARIABLES=EFMD Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
 
*Crosstabulations*

CROSSTABS
  /TABLES=EFMD BY White1 InsuranceStatus HSorLess Obesity Diabetes Preterm PrevCS ParityS Q105
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=EFMD BY Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.


*EFM Likelihood by Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES EFMD
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*EFM Likelihood by Individual Characteristics*

LOGISTIC REGRESSION VARIABLES EFMD
  /METHOD=ENTER Obesity Diabetes PrevCS ParityS Preterm Q105 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*EFM Likelihood by Organizational Characteristics*

LOGISTIC REGRESSION VARIABLES EFMD
  /METHOD=ENTER Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*EFM Likelihood by Organizational Characteristics (Controlling for Individual & Sociodemographic Characteristics)

LOGISTIC REGRESSION VARIABLES EFMD
  /METHOD=ENTER White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
    /CONTRAST (InsuranceStatus)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).



*Patient Discrimination*
*Analysis: Descpritive Statistics, Correlations, Crosstabulations, Logistic Regression Analysis*

*Dependent Variable: RaceTreat (Racial Discrimination, & InsTreat (Insurance Discrimination)
*Indepenedent Variables:
Sociodemographic& Individual Characteristics: RaceNew (Categorical Race Variable), White1 (White Dummy Variable), InsuranceStatus (Insurance Status), 
 HSorLess (High School Education or Less)
Organizational Characteristics: Ownership (For Profit or Not For Profit), CHospital (Catholic Hospital Affiliation), SystemMember (System Membership), TtlHsptlBds (Total Hospital Beds Scale Variable), 
opmarFive (Operating Margin Above or Below Five), dnparMED (Days in Net Patients Accounts Receivable Above or Below Median).
*Individual Control Variables: Preterm (Preterm Birth), Obesity, Diabetes (Type 1 or 2 Diabetes), ParityS (Parity Scale Variable), PrevCS (Previous Cesarean Delivery) Q105 (Age Scale Variable).*

GET
  FILE='C:\Users\knmcn\Documents\Dissertation\Final Data Analysis\Dissertation Data Set.sav'.
DATASET NAME DataSet8 WINDOW=FRONT.

*Racial Discrimination Analysis*
*Descriptive Statistics*

DESCRIPTIVES VARIABLES= RaceTreat White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
/STATISTICS=MEAN STDDEV MIN MAX.

*Correlations:*

CORRELATIONS
  /VARIABLES=RaceTreat White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

CORRELATIONS
  /VARIABLES=RaceTreat Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
 
*Crosstabulations*

CROSSTABS
  /TABLES=RaceTreat BY White1 InsuranceStatus HSorLess Obesity Diabetes Preterm PrevCS ParityS Q105
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=RaceTreat BY Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.


*Model 9: Racial Discrimination Likelihood by Individual and Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES RaceTreat
  /METHOD=ENTER RaceNew, InsuranceStatus, HSorLess, PrevCS, Preterm, Diabetes, Obesity, ParityS, Q105
 /CONTRAST (RaceNew)=Indicator(1)
    /CONTRAST (InsuranceStatus)=Indicator(1)
    /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Racial Discrimination Likelihood by Organizational Characteristics (Controlling for Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES RaceTreat
  /METHOD=ENTER RaceNew, InsuranceStatus, HSorLess, PrevCS, Preterm, Diabetes, Obesity, ParityS, Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
 /CONTRAST (RaceNew)=Indicator(1)
    /CONTRAST (InsuranceStatus)=Indicator(1)
    /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*Insurance Discrimination Analysis*
*Descriptive Statistics*

DESCRIPTIVES VARIABLES= InsTreat White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED 
/STATISTICS=MEAN STDDEV MIN MAX.

*Correlations:*

CORRELATIONS
  /VARIABLES=InsTreat White1 InsuranceStatus Preterm Obesity Diabetes HSorLess ParityS PrevCS Q105 
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

CORRELATIONS
  /VARIABLES=InsTreat Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
 
*Crosstabulations*

CROSSTABS
  /TABLES=InsTreat BY White1 InsuranceStatus HSorLess Obesity Diabetes Preterm PrevCS ParityS Q105
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=InsTreat BY Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

*Insurance Discrimination Likelihood by Individual & Sociodemographic Characteristics*

LOGISTIC REGRESSION VARIABLES InsTreat
  /METHOD=ENTER RaceNew, InsuranceStatus, HSorLess, PrevCS, Preterm, Diabetes, Obesity, ParityS, Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
 /CONTRAST (RaceNew)=Indicator(1)
    /CONTRAST (InsuranceStatus)=Indicator(1)
    /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Insurance Discrimination Likelihood by Organizational Characteristics (Controlling for Individual & Sociodemographic Characteristics)*

LOGISTIC REGRESSION VARIABLES InsTreat
  /METHOD=ENTER RaceNew, InsuranceStatus, HSorLess, PrevCS, Preterm, Diabetes, Obesity, ParityS, Q105 Ownership CHospital SystemMember TtlHsptlBds opmarFive dnparMED
 /CONTRAST (RaceNew)=Indicator(1)
    /CONTRAST (InsuranceStatus)=Indicator(1)
    /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).



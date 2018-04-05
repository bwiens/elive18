/*
 Collection of functions written by Messiah College to utilize Banner data
*/

CREATE OR REPLACE PACKAGE         "BANNER_UTIL"
AS
-- Private types
  type pidm_tab_type is table of saturn.spriden.spriden_pidm%TYPE index by binary_integer;
--  type xref_tab_type is table of alumni.aprxref.aprxref_xref_code%TYPE;
-- Functions are listed alphabetically 
-- (Some functions are overloaded and are alphabetical by FUNCTION name, first parameter)
---------------------------------------------------------------------------
FUNCTION F_GET_CNTY(zip_code IN VARCHAR2) 
  RETURN VARCHAR2; 
--  returns county code for a specified zip code
---------------------------------------------------------------------------
---------------------------------------------------------------------------
FUNCTION F_Get_File_Status (PlanType IN CHAR, PlanCode IN char)
  RETURN char;
---------------------------------------------------------------------------
---------------------------------------------------------------------------
FUNCTION F_Get_TI1_Amount (OptPlan IN char)
  RETURN Number;
---------------------------------------------------------------------------
---------------------------------------------------------------------------
FUNCTION F_Get_TI1_Plan (pidm IN NUMBER)
  RETURN varchar;
---------------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION f_validate_single (owner VARCHAR2,
                            tablename VARCHAR2,
                            column VARCHAR2,
							in_value VARCHAR2)
RETURN VARCHAR2; 
/*
	Powerful way to validate codes.  Pass in the owner, table, and column of the
	validation table, along with the value you are verifying.  The function will
	dynamically create a select statement based upon your parameters.  The function
	returns 'FALSE' if no errors (it found the entry), and 'TRUE' if no data is
	found for the value you are passing in.
*/
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION f_validate_single_null_ok (owner VARCHAR2,tablename VARCHAR2,
column VARCHAR2,in_value VARCHAR2)
RETURN VARCHAR2; 
/*
	Powerful way to validate codes.  Pass in the owner, table, and column of the
	validation table, along with the value you are verifying.  The function will
	dynamically create a select statement based upon your parameters.  The function
	returns 'FALSE' if no errors (it found the entry), and 'TRUE' if no data is
	found for the value you are passing in.
*/
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Address(in_pidm spriden.spriden_pidm%type, in_atyp_code spraddr.spraddr_atyp_code%type)
  RETURN VARCHAR2;
--   returns formatted active  address of specified type
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Address_Lines(in_pidm spriden.spriden_pidm%type, 
                           in_atyp_code spraddr.spraddr_atyp_code%type,
						   in_lines varchar2)
  RETURN VARCHAR2;
--   returns line(s) of active  address of specified type
--  in_lines parameter values:
--    1 = Line 1
--    2 = Line 2
--    3 = Line 3
--    C = City
--    S = State
--    Z = Zip Code
--    N = Nation Code
--    K = County Code
--    A = All   Line1(30) || Line2(30) || line3(30) || City(20) || state(3) || zip(10) || nation(5) || County(5)
--    F = Formatted mailing address (includes carriage Returns)  
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Alum_Pref_Year (in_pidm apbcons.apbcons_pidm%type)
  RETURN varchar2;
-- returns alumni preferred class year 
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Age(in_pidm spriden.spriden_pidm%type)
  RETURN NUMBER;
--  returns age in years  or null
-----------------------------------------------------------------------  
-----------------------------------------------------------------------
FUNCTION Get_Gender(in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2;
--  returns M, F, or U (unknown)
-----------------------------------------------------------------------  
-----------------------------------------------------------------------
FUNCTION Get_Birth_Name(in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2;
--  returns last name for name type 'BRTH'
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Birth_Date(in_pidm spriden.spriden_pidm%type)
  RETURN DATE;
--  returns birthdate or null
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Building_RD(in_bldg_code stvbldg.stvbldg_code%type)
  RETURN VARCHAR2;
--  written by Elizabeth  06/12/2006
--  FUNCTION returns ID for RD (resident director)
--  input:  building code
--  output: RD ID or null
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Campus_Address(in_pidm spriden.spriden_pidm%type default -1)
  RETURN VARCHAR2;
--  returns full campus address  
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Campus_Box(in_pidm spriden.spriden_pidm%type default -1)
  RETURN VARCHAR2;
--   returns spraddr_street_line1 for active 'CM' address
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Campus_Box_No(in_pidm spriden.spriden_pidm%type default -1)
  RETURN VARCHAR2;
--   returns numeric box number from spraddr_street_line1 for active 'CM' address
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_CERT_Desc
    (in_cert stvcert.stvcert_code%type)
  RETURN VARCHAR2;
--  FUNCTION returns ceremony description
--  input:  ceremony (cert) code
--  output: ceremony description or 'Invalid Ceremony'
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Class_Desc (in_crn ssbsect.ssbsect_crn%type,
                         in_style VARCHAR2 default null, 
				 in_term ssbsect.ssbsect_term_code%type default null)
  RETURN VARCHAR2;
--  returns course descriptive information based on crn, style, and term (defaults to current term)
--  style  values
--  SNTC  (subj num - title - crn)  
--  SNT    (subj num - title)  (default value)
--  SN      (subj num)
-- SNX   (subj num - section)
--  T        (title)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Class_Times (crn ssrmeet.ssrmeet_crn%type,
                          term_code ssrmeet.ssrmeet_term_code%type)
  RETURN VARCHAR2;
-- Returns class meeting time
-- sample output:  MWF  08:00am - 08:50am
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Current_Term
  RETURN VARCHAR2;
-- Returns current term = minimum term where term end date > today
-----------------------------------------------------------------------
---------------------------------------------------------------------------
FUNCTION Get_Dept_Description(in_orgn fimsmgr.ftvorgn.ftvorgn_orgn_code%type)
  RETURN VARCHAR2;
  -- Function to return department description for a given orgn(dept)        
---------------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Dependent_Pidm(p_pidm number default null)
  RETURN pidm_tab_type;
  -- Function to return dependent pidm(s) from aprchld for a given pidm        
---------------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Dorm(in_pidm spriden.spriden_pidm%type, 
                  in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2;
-- Returns  Dormitory Building code for pidm and term
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Dorm_Ext(in_pidm spriden.spriden_pidm%type default -1, 
                        in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2;
--  written by Elizabeth  06/12/2006
--  FUNCTION returns student dorm room extension
--  input:  student pidm, term
--  output: room extension  or NULL
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Dorm_Info(in_pidm number, in_term stvterm.stvterm_code%type, in_request VARCHAR2)
 RETURN VARCHAR2; 
-- Function returns dorm room information based on pidm, term, and request type parameters
--   PH  = Phone
--   EX  = Extension
--   D   = Dorm Building
--   DN = Dorm Name
--   DR  = Dorm Room
--   R    = Dorm Room Number
--   RD  = Room Desc
--   RR = Room Rate Type
--   RRD = Room Rate Description
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Dorm_Name(in_pidm spriden.spriden_pidm%type, 
                       in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2;
-- Returns  Dormitory Name for pidm and term
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Dorm_Phone(in_pidm spriden.spriden_pidm%type, 
                       in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2;
--  written by Elizabeth  06/12/2006
--  FUNCTION returns student dorm room phone number
--  input:  student pidm, term
--  output: formatted phone number (nnn-nnn-nnnn)  or NU
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Dorm_Room(in_pidm spriden.spriden_pidm%type,
                       in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2;
--  written by Elizabeth  06/12/2006
--  FUNCTION returns student dorm room number
--     or student location if the student is in an external program
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Dorm_Room_Number(in_pidm spriden.spriden_pidm%type,
                              in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2;
--  written by Elizabeth  06/12/2006
--  FUNCTION returns student dorm room number
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Dorm_Room_Desc(in_pidm spriden.spriden_pidm%type,
                            in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2;
-- Returns  Dormitory Room Description for pidm and term
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Earned_Credits(in_pidm spriden.spriden_pidm%type)
  RETURN number;
--  written by Elizabeth  10/06/2006
--  FUNCTION returns earned overall credits for a student
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Email(in_id spriden.spriden_id%type,
                   in_emal_code goremal.goremal_emal_code%type)
  RETURN VARCHAR2;
-- Returns an email address for specified ID and email type  
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Email(in_pidm spriden.spriden_pidm%type,
                   in_emal_code goremal.goremal_emal_code%type)
  RETURN VARCHAR2;
-- Returns an email address for specified PIDM and email type  
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Email_Link(in_id spriden.spriden_id%type,
                        in_emal_code goremal.goremal_emal_code%type
						)
  RETURN VARCHAR2;
--  returns url link for specified ID and email type
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Email_Link(in_pidm spriden.spriden_pidm%type,
                        in_emal_code goremal.goremal_emal_code%type
						)
  RETURN VARCHAR2;
--  RETURN url link for specified pidm and email type
-----------------------------------------------------------------------
---------------------------------------------------------------------------
FUNCTION Get_Employee_Dept (in_pidm spriden.spriden_pidm%type)
RETURN VARCHAR2; 
--  returns department code of first employee job record found
--  (note:  there could be additional jobs / departments that this function does not return)
---------------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Employee_Type (in_pidm pebempl.pebempl_pidm%type)
  RETURN VARCHAR2;
-- returns employee type code (or null if not an employee)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Employee_Type2 (in_pidm pebempl.pebempl_pidm%type)
  RETURN VARCHAR2;
--  same as Get_Employee_Type except includes additional 'TO' ecls_code
-- returns employee type code (or null if not an employee)
-----------------------------------------------------------------------
----------------------------------------------------------------------
FUNCTION Get_Enrollment_Begin_Date (in_pidm number)
  RETURN DATE;
--  written by Elizabeth  06/2/2006
--  FUNCTION returns start of enrollment date
--  if no term found, return NULL
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Enrollment_End_Date (in_pidm number)
  RETURN DATE;
--  written by Elizabeth  06/2/2006
--  FUNCTION returns end of enrollment date
--  if no end term found, RETURN null
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Enrollment_Status
    (in_pidm number, in_term stvterm.stvterm_code%type DEFAULT null)
  RETURN VARCHAR2;
--  written by Elizabeth  06/19/2006
--  FUNCTION returns latest enrollment status for a student
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Event_Desc (in_evnt_crn slbevnt.slbevnt_crn%type)
  RETURN VARCHAR2;
--  FUNCTION returns event description name based event_crn 
--  input:  event_crn
--  output: returns event_description
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_GPA (in_pidm shrlgpa.shrlgpa_pidm%type,
                  in_format varchar2 default 'N')
  RETURN VARCHAR2;
--  return GPA is specified format
-- in_format values:
--   N = original format (shrlgpa_gpa%type)
--  F1 = x.x (rounded)
--  F2 = x.xx (rounded)
--  F3 = x.xxx (rounded)
--  F4 = X.xxxx (rounded)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Housing_Term
  RETURN VARCHAR2;
--  written by Elizabeth  01/03/2007
--  FUNCTION returns current housing term based on GTVSDAX_INTERNAL_CODE = ZHOUSTERM
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_ID(in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2;
--  Gets ID number if PIDM is known
-----------------------------------------------------------------------
--
-----------------------------------------------------------------------
FUNCTION Get_ID_By_SSN(in_ssn VARCHAR2)
RETURN VARCHAR2;
--  Retrieve ID number from SSN
-----------------------------------------------------------------------
--
-----------------------------------------------------------------------
FUNCTION Get_Interest_Desc
    (interest_code stvints.stvints_code%type)
  RETURN VARCHAR2;
-----------------------------------------------------------------------
--  FUNCTION returns description of interest code 
--  returns interest code if no matching description found
-----------------------------------------------------------------------
FUNCTION Get_Last_Enrolled_Term(in_pidm spriden.spriden_pidm%type,
                                in_term stvterm.stvterm_code%type DEFAULT NULL)
  RETURN VARCHAR2;
--  Returns last enrolled term prior to in_term  or null
--  if in_term is null or greater than the current term, current term is used instead of in_term
-----------------------------------------------------------------------
--
--
-----------------------------------------------------------------------
FUNCTION Get_Major_Info(in_pidm    spriden.spriden_pidm%type,
					    in_request varchar2 DEFAULT 'M',
						in_lmod    VARCHAR2 DEFAULT NULL,
                        in_lfst    sorlfos.sorlfos_lfst_code%type DEFAULT 'MAJOR',
						in_levl    VARCHAR2 DEFAULT 'UG')
RETURN VARCHAR2;
-----------------------------------------------------------------------
--  written by Elizabeth  2/25/2014
--  FUNCTION returns information about the latest priority 1 
--           program, college, department, major, minor, or concentration of a student 
-----------------------------------------------------------------------
--  in_lmod -- if this is NULL, both ADMISSIONS and LEARNER curriculums will be checked
--             (LEARNER will take precedence over ADMISSIONS)
--          -- if in_lmod is supplied, the exact LMOD will be checked
--  lfst_code parameter corresponds to sorlfos_lfst_code ... contains values like MAJOR, MINOR, CONCENTRATION, and EMPHASIS
--
--
--  Information returned depends on in_request values 
--    M = Major, Minor, or Concentration Code
--    D = Department Code
--    C = College Code
--    P = Program Code
--    A = All (formatted as Major(4) || Minor(4) || College(2) || Program(12)
--
---------------------------------------------------------------------------------------
--
--
-----------------------------------------------------------------------
FUNCTION Get_Major
    (pidm number, term_code VARCHAR2, lfst_code VARCHAR2)
  RETURN VARCHAR2;
-- THIS FUNCTION IS OBSOLETE.    Use Get_Student_Major(pidm, term_code, lfst_code) instead.
--  written by Elizabeth  05/11/2006
--  FUNCTION returns first major, first  minor, or first concentration of a student 
--  lfst_code parameter corresponds to sorlfos_lfst_code ... contains values like MAJOR, MINOR, CONCENTRATION, and EMPHASIS
--  returns 4 character major code (stvmajr validates)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Major_Desc
    (major_code stvmajr.stvmajr_code%type)
  RETURN VARCHAR2;
--  FUNCTION returns description of major code 
--  returns major code if no matching description found
--  returns major code if no matching description found
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Mailing_Address(in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2;
--   returns spraddr_street_line1 for active 'MA' address
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Name(in_pidm spriden.spriden_pidm%type, 
                  in_format VARCHAR2)
  RETURN VARCHAR2;
--  Returns name based on pidm and format 
-- (returns null if invalid pidm)
--  formats:  
--    LF  = Last, First
--    LFM = Last, First Middle
--    FML = First || Middle || last
--   FL = First || Last
--   F = First only
--   L = Last only
--   FMLF = First (15) || Middle(15) || last(30)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_NATN_Desc(in_natn_code stvnatn.stvnatn_code%type)
         RETURN VARCHAR2;
--  FUNCTION returns nation name based on nation code (returns the original nation code if not found)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Next_Term(in_term_code stvterm.stvterm_code%type)
  RETURN VARCHAR2;
--  Returns term following the parameter term  
-----------------------------------------------------------------------
---------------------------------------------------------------------------
FUNCTION Get_Office_Ext(in_pidm spriden.spriden_pidm%type default -1) 
  RETURN VARCHAR2; 
   --  return office phone extension for specified pidm
---------------------------------------------------------------------------
---------------------------------------------------------------------------
FUNCTION Get_Office_Info(in_pidm spriden.spriden_pidm%type, 
                                 in_type varchar2) 
  RETURN VARCHAR2; 
--  Returns employee office information
--  Value returned is based on specified in_type parameter:
--   BNR = building name and room
--   BR  = building code and room
--   B   = building code
--   R   = room
--   BN  = building name
--   E = phone extension  
--   ALL = formatted output (building code(6) + building desc( 30) + room(6) + extension (4)  
---------------------------------------------------------------------------
---------------------------------------------------------------------------
FUNCTION Get_Parent_Pidm(p_pidm number default null) 
  RETURN pidm_tab_type;
  -- Function to return parent pidm(s) from APRXREF for a given student pidm        
---------------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Phone(in_pidm sprtele.sprtele_pidm%type,
                   in_atyp_code sprtele.sprtele_atyp_code%type,
                   in_format varchar2,
				   in_tele_code sprtele.sprtele_tele_code%type default 'MA')
  RETURN VARCHAR2;
--  returns telephone associated with a mailing address and telephone type
--  in_format values
--    A = Area Code Only
--    P = Phone Only
--    E = Extension Only
--   AP = area(3) || phone(7)
--    APE =   area(3) || phone(7) || extension(4)
--    FAP = Formatted area and phone only (xxx-xxx-xxxx)
--    FAPE = Formatted  with extension (xxx-xxx-xxxx  Ext. .xxxx)
-----------------------------------------------------------------------
----------------------------------------------------------------------
FUNCTION Get_Pidm(in_id spriden.spriden_id%type)
  RETURN VARCHAR2;
--  Returns PIDM if ID is known
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Pin(in_id spriden.spriden_id%type)
  RETURN VARCHAR2;
-- Returns SSB ID, Pin, and Name (one string)  if ID is known  
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Pidm_By_Login(in_external_user gobtpac.gobtpac_external_user%type)
  RETURN VARCHAR2;
--  FUNCTION returns pidm for corresponding external_user (network login)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Pidm_By_SSN(in_SSN IN VARCHAR2)
  RETURN VARCHAR2;
--  written by Elizabeth  6/20/2011
--  FUNCTION returns pidm for corresponding ssn
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Pin(in_last_name spriden.spriden_last_name%type,
                 in_first_name spriden.spriden_first_name%type)
  RETURN VARCHAR2;
-- Returns one or more SSB ID, Pin, and Name strings if last name or first name (or partial) are known  
-- NOTE:  You must enter both last name and first name parameters to distinguish this FUNCTION from
--              the Get_Pin(in_id spriden.spriden_id%type) function.   
-- Enter 'null'  as a para,eter for either  first or last name to get all values
--  Parial names can be entered ... they do not need to end with % but it won't hurt ... you must enter the starting character(s)
-- Output is limited to 2000 characters ... a warning message appears if the list might be incomplete
--  Examples:
--  select banner_util.get_pin('Hoov',null) from dual (gets list of all names starting with 'Hoov' which have a SSB pin)
--  select banner_util.get_pin(null, 'Elizabeth') from dual (gets list of all names staring with 'Elizabeth' which have a SSB pin)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Pin(in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2;
-- Returns SSB ID, Pin, and Name (one string)  if PIDM is known  
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Previous_Term(in_term_code stvterm.stvterm_code%type)
  RETURN VARCHAR2;
--  Returns term following the parameter term  
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Primary_Advisor(in_pidm sgradvr.sgradvr_pidm%type, 
                             in_term sgradvr.sgradvr_term_code_eff%type)
  RETURN VARCHAR2;
--  FUNCTION returns pidm of student's primary advisor
-----------------------------------------------------------------------
---------------------------------------------------------------------------
FUNCTION Get_Sport(in_pidm sgrsprt.sgrsprt_pidm%type,
                   in_term sgrsprt.sgrsprt_term_code%type,
				   in_return_type varchar2)
  RETURN varchar2; 
  -- Function returns sport team or description for a particular term
  -- in_return_type:   C = Team Code
  --                               D = Team Description  
---------------------------------------------------------------------------
---------------------------------------------------------------------------
FUNCTION Get_Spouse_Pidm(p_pidm number default null)
  RETURN number; 
  -- Function to return spouse's pidm from aprcsps for a given pidm        
---------------------------------------------------------------------------
--
-----------------------------------------------------------------------  
FUNCTION Get_SSN(in_pidm spbpers.spbpers_pidm%type,
                 in_format varchar2 default null)
  RETURN VARCHAR2;
--  returns SSN or null
-- in_format
--  null  or 'N' = non-edited SSN
-- 'F' = edited SSN (xxx-xxx-xxxx) 
-----------------------------------------------------------------------  
--
-----------------------------------------------------------------------  
FUNCTION Get_SSN_By_ID(in_id  VARCHAR2,
                       in_format varchar2 default null)
  RETURN VARCHAR2;
--  returns SSN or null
-- in_format
--  null  or 'N' = non-edited SSN
-- 'F' = edited SSN (xxx-xxx-xxxx) 
-----------------------------------------------------------------------  
-----------------------------------------------------------------------
FUNCTION Get_Student_Class(pidm number, term_code VARCHAR2 DEFAULT NULL)
  RETURN VARCHAR2;
--  FUNCTION returns student class level (FY, SO, JR, SR, etc.)
--  NOTE:  In order to compile this function, I had to grant execute access to user messiah
-- (grant execute on baninst1.soklibs to messiah)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Student_Class_Desc(pidm number, term_code VARCHAR2 DEFAULT NULL)
  RETURN VARCHAR2;
--  FUNCTION returns student class level description
--  NOTE:  In order to compile this function, I had to grant execute access to user messiah
-- (grant execute on baninst1.soklibs to messiah)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Student_Coll(in_pidm spriden.spriden_pidm%type,
                          in_term stvterm.stvterm_code%type, 
						  in_lfst sorlfos.sorlfos_lfst_code%type,
						  in_level  IN VARCHAR2 DEFAULT 'UG')
  RETURN VARCHAR2;
--  written by Elizabeth  1/31/2007
--  FUNCTION returns college code of first major, first  minor, or first concentration of a student 
--  lfst_code parameter corresponds to sorlfos_lfst_code ... contains values like MAJOR, MINOR, CONCENTRATION, and EMPHASIS
--  returns 4 character department code (stvdept validates)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Student_Dept(in_pidm spriden.spriden_pidm%type,
                          in_term stvterm.stvterm_code%type, 
						  in_lfst sorlfos.sorlfos_lfst_code%type,
						  in_level IN VARCHAR2 DEFAULT 'UG')
  RETURN VARCHAR2;
--  written by Elizabeth  1/31/2007
--  FUNCTION returns department code of first major, first  minor, or first concentration of a student 
--  lfst_code parameter corresponds to sorlfos_lfst_code ... contains values like MAJOR, MINOR, CONCENTRATION, and EMPHASIS
--  returns 4 character department code (stvdept validates)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Student_Level(pidm number, term_code VARCHAR2 DEFAULT NULL)
  RETURN VARCHAR2;
-----------------------------------------------------------------------
--  written by Elizabeth  04/19/2010
--  FUNCTION returns student level (i.e., UG, GR, etc.)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Student_Major
    (pidm number, term_code VARCHAR2, lfst_code VARCHAR2, in_level VARCHAR2 DEFAULT 'UG')
  RETURN VARCHAR2;
--  written by Elizabeth  01/24/2007
--  FUNCTION returns code of first major, first  minor, or first concentration of a student 
--  lfst_code parameter corresponds to sorlfos_lfst_code ... contains values like MAJOR, MINOR, CONCENTRATION, and EMPHASIS
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Student_Major_Desc
    (pidm number, term_code VARCHAR2, lfst_code VARCHAR2, in_level VARCHAR2 DEFAULT 'UG')
  RETURN VARCHAR2;
--  written by Elizabeth  01/24/2007
--  FUNCTION returns description first major, first  minor, or first concentration of a student 
--  lfst_code parameter corresponds to sorlfos_lfst_code ... contains values like MAJOR, MINOR, CONCENTRATION, and EMPHASIS
--  returns major code if no matching description found
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Student_Major_Info(in_pidm    spriden.spriden_pidm%type,
                                in_term    stvterm.stvterm_code%type, 
		                        in_lfst    sorlfos.sorlfos_lfst_code%type,
							    in_request varchar2,
								in_level   IN VARCHAR2 DEFAULT 'UG')
  RETURN VARCHAR2;
--  written by Elizabeth  1/30/2007
--  FUNCTION returns information about the first major, first  minor, or first concentration of a student 
--  lfst_code parameter corresponds to sorlfos_lfst_code ... contains values like MAJOR, MINOR, CONCENTRATION, and EMPHASIS
--  inforamtion returned depends on in_request values (codes returned depend on the in_lfst parameter also):
--    M = Major, Minor, or Concentration Code
--    D = Department Code
--    C = College Code
--    A = All (formatted as Major(4) || Minor(4) || College(2)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Term_Desc(in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2;
-- Returns stvterm description for the parameter term  
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Term_End(in_term stvterm.stvterm_code%type)
  RETURN DATE;
--  Returns term end date
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Term_Start(in_term stvterm.stvterm_code%type)
  RETURN DATE;
--  returns term starting date or null  
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_UserID(in_id spriden.spriden_id%type)
  RETURN VARCHAR2;
--  Gets External UserID if ID is known
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_UserID(in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2;
--  Gets External UserID if PIDM is known
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_business_fiscal_year(date_in in date default null) 
  RETURN VARCHAR2;
--  Gets current business fiscal year (as opposed to academic fiscal)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION File_Open(file_location VARCHAR2,
                   file_name VARCHAR2,
                   open_type VARCHAR2,
                   buffer_length binary_integer) 
  RETURN UTL_FILE.FILE_TYPE;
--  Opens a flat file
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION File_Read(input_handle UTL_FILE.FILE_TYPE)
  RETURN VARCHAR2;  
--  Reads a flat file
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_A_Student(in_pidm spriden.spriden_pidm%type,
                      in_term stvterm.stvterm_code%type DEFAULT null)
  RETURN VARCHAR2;
--  Returns 'Y' (if student) or 'N' (if not student)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Alumni (pidm IN NUMBER)
       RETURN VARCHAR2;
/* IS_ALUMNI
   DATE    : 19MAY06
   AUTHOR  : Jonathan Wheat (jwheat)
   PURPOSE : Determine whether a PIDM is a alumni.
   USAGE   : is_alumni(pidm)
   EXAMPLE : is_alumni(344450)
   ACTIONS : takes a PIDM and looks up the code from DWH - DWID table
             whether they are an alumni. 
   INPUT   : PIDM  (ie. 123456)
   OUTPUT  : No screen output
   RETURNS : Currently returns -
              Y - yes the pidm is an alumni
           NULL - no, the pidm is not an alumni
*/
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_An_Alum (in_pidm IN aprcatg.aprcatg_pidm%type)
  RETURN VARCHAR2;
--  Returns 'Y' if an alum or null
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_An_Employee (in_pidm pebempl.pebempl_pidm%type)
  RETURN VARCHAR2;
-- returns 'Y' if an employee or null
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_A_Parent (in_pidm IN aprcatg.aprcatg_pidm%type)
  RETURN VARCHAR2;
-----------------------------------------------------------------------
--  Returns 'Y' if an parent or null
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_A_Current_Parent (in_pidm IN aprcatg.aprcatg_pidm%type)
  RETURN VARCHAR2;
-----------------------------------------------------------------------
--  Returns 'Y' if a parent of a current student or null
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Chair_Advisee(fac_pidm sirdpcl.sirdpcl_pidm%type, 
                          stu_pidm sorlfos.sorlfos_pidm%type,
						  term_code sorlfos.sorlfos_term_code%type)
  RETURN VARCHAR2;
--  Returns 'Y' if  a student is a department chair's advisee for a specified term
-- (A department chair has advisee security privledges to all students in his departments).
-----------------------------------------------------------------------
-----------------------------------------------------------------------  
FUNCTION Is_Citizen(in_pidm spbpers.spbpers_pidm%type)
  RETURN VARCHAR2;
--  returns spbpers_citz_code value
-----------------------------------------------------------------------  
-----------------------------------------------------------------------  
FUNCTION Is_Deceased(in_pidm spbpers.spbpers_pidm%type)
  RETURN VARCHAR2;
-----------------------------------------------------------------------  
--  returns Y if deceased, NULL otherwise
-----------------------------------------------------------------------
FUNCTION Is_Dean(in_pidm sirattr.sirattr_pidm%type, 
                 in_term sirattr.sirattr_term_code_eff%type)
  RETURN VARCHAR2;
--  Returns 'Y' if  an attribute of 'DEAN'  or 'DEAS' is assigned to a faculty member 
--  or administrative assistant for the specified term; otherwise, returns 'N'
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Dean_Advisee(fac_pidm sirdpcl.sirdpcl_pidm%type, 
                          stu_pidm sorlcur.sorlcur_pidm%type,
						  term_code sorlcur.sorlcur_term_code%type)
  RETURN VARCHAR2;
--  Returns 'Y' if  a student is a dean's advisee for a specified term
-- (A dean has advisee security privledges to all students in his school.).
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Dept_Chair(pidm sirattr.sirattr_pidm%type, 
                       term_code sirattr.sirattr_term_code_eff%type)
  RETURN VARCHAR2;
--  Returns 'Y' if  an attribute of 'CHAI' , 'CHAS', or 'CHAA' is assigned to a faculty member 
--  or administrative assistant for the specified term; otherwise, returns 'N'
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Employee (pidm IN NUMBER)
  RETURN CHAR;
/* IS_EMPLOYEE
   DATE    : 19MAY06
   AUTHOR  : Jonathan Wheat (jwheat)
   PURPOSE : Determine whether a PIDM is an employee.
   USAGE   : is_employee(pism)
   EXAMPLE : is_employee(344450)
   ACTIONS : takes a PIDM and looks up the code from PEBEMPL to determine
             whether they are an employee. 
   VALUES  : Currently tests for 
             A - Adminsrative Employee
             S - Staff Employee
   INPUT   : PIDM  (ie. 123456)
   OUTPUT  : No screen output
   RETURNS : Currently returns -
              Y - yes the pidm is an employee
           NULL - no, the pidm is not an employee
*/
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Faculty (pidm IN NUMBER)
  RETURN CHAR;
/* IS_FACULTY
   DATE    : 19MAY06
   AUTHOR  : Jonathan Wheat (jwheat)
   PURPOSE : Determine whether a PIDM is an faculty.
   USAGE   : is_faculty(pism)
   EXAMPLE : is_faculty(344450)
   ACTIONS : takes a PIDM and looks up the code from PEBEMPL to determine
             whether they are faculty. 
   VALUES  : Currently tests for 
             F - Faculty
   INPUT   : PIDM  (ie. 123456)
   OUTPUT  : No screen output
   RETURNS : Currently returns -
              Y - yes the pidm is faculty
           NULL - no, the pidm is not faculty
*/
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Faculty_Advisee
    (fac_pidm number, stu_pidm number, term_code VARCHAR2)
  RETURN VARCHAR2;
--  FUNCTION checks whether a student is a faculty member's advisee.
--  used for security checking
--  inputs  faculty pidm, student pidm, term code
--  returns 'Y' if an advisee
--               'N' if not an advisee
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Faculty_Attribute(pidm sirattr.sirattr_pidm%type, 
                              term_code sirattr.sirattr_term_code_eff%type,
							  fatt_code sirattr.sirattr_fatt_code%type)
  RETURN VARCHAR2;
--  Returns 'Y' if  an attribute is assigned to a faculty member for the specified term; otherwise, returns 'N'
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Faculty_College(pidm sirdpcl.sirdpcl_pidm%type, 
                            term_code sirdpcl.sirdpcl_term_code_eff%type,
							coll_code sirdpcl.sirdpcl_coll_code%type)
  RETURN VARCHAR2;
--  Returns 'Y' if  a college code is assigned to a faculty member for the specified term; otherwise, returns 'N'
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Faculty_Dept(pidm sirdpcl.sirdpcl_pidm%type, 
                            term_code sirdpcl.sirdpcl_term_code_eff%type,
							dept_code sirdpcl.sirdpcl_dept_code%type)
  RETURN VARCHAR2;
--  Returns 'Y' if  a department code is assigned to a faculty member for the specified term; otherwise, returns 'N'
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION is_current_instructor (pidm_in IN NUMBER) RETURN VARCHAR2;
-- Returns 'Y' if employee is teaching this during current term
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_FATT_Relationship
    (fac_pidm number, stu_pidm number, term_code VARCHAR2, fatt_code VARCHAR2)
  RETURN VARCHAR2;
--  FUNCTION checks whether a faculty has an "attribute" relationship with a student   
--  i.e., the faculty has a faculty attribute (sirattr)  that matches one of the student's attributes ( sgrsatt) 
--  input:  pidm, student_pidm, attribute
--  output: returns 'Y' or 'N'
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Number(in_string VARCHAR2)
  RETURN VARCHAR2;
-- FUNCTION accepts a VARCHAR field
-- returns 'Y' if number, 'N' if not  
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Student (pidm IN NUMBER)
  RETURN VARCHAR2;
/* IS_STUDENT
   DATE    : 19MAY06
   AUTHOR  : Jonathan Wheat (jwheat)
   PURPOSE : Determine whether a PIDM is a student.
   USAGE   : is_student(pidm)
   EXAMPLE : is_student(344450)
   ACTIONS : takes a PIDM and looks up the code from DWH - DWID table
             whether they are a student. 
   INPUT   : PIDM  (ie. 123456)
   OUTPUT  : No screen output
   RETURNS : Currently returns -
              Y - yes the pidm is a student
           NULL - no, the pidm is not a student
*/
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION XXX_Is_Student (pidm IN NUMBER)
  RETURN CHAR;
/* IS_STUDENT
   DATE    : 19MAY06
   AUTHOR  : Jonathan Wheat (jwheat)
   PURPOSE : Determine whether a PIDM is a student.
   USAGE   : is_student(pidm)
   EXAMPLE : is_student(344450)
   ACTIONS : takes a PIDM and looks up the code from DWH - DWID table
             whether they are a student. 
   INPUT   : PIDM  (ie. 123456)
   OUTPUT  : No screen output
   RETURNS : Currently returns -
              Y - yes the pidm is a student
           NULL - no, the pidm is not a student
*/
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Student_Attribute(in_pidm sgrsatt.sgrsatt_pidm%type,
                              in_term sgrsatt.sgrsatt_term_code_eff%type,
							  in_atts_code sgrsatt.sgrsatt_atts_code%type)
  RETURN VARCHAR2;
--  FUNCTION returns 'Y' if an attribute is assigned to a  student for the desired term; otherwise returns 'N'
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Transcript_Student
    (fac_pidm number, stu_pidm number, term_code VARCHAR2)
  RETURN VARCHAR2;
--  FUNCTION checks whether a faculty member  has a relationship with a student 
--  which allows that person to view the student's transcript
--  used for security checking
--  inputs  faculty pidm, student pidm, term code
--  returns 'Y' if relationship exists
--               'N' if not
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Random_Value (start_nbr IN number, end_nbr IN number)
  RETURN VARCHAR2;
--  written by Bob Felix
--  returns a random value between a specified number range
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION urlencode (p_str in varchar2 ) 
  return varchar2;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
function get_pri_donr_cat(in_pidm aprcatg.aprcatg_pidm%type)
   return varchar2;
-----------------------------------------------------------------------
FUNCTION Is_A_Constituent (in_pidm IN aprcatg.aprcatg_pidm%type)
  RETURN VARCHAR2;
--  written by Bob Getty 2/29/2008
--  Returns 'Y' if a constituent or null
-----------------------------------------------------------------------
FUNCTION Get_Birth_City (in_pidm IN spriden.spriden_pidm%type)
  RETURN VARCHAR2;
--  written by Elizabeth 3/10/2008
--  Returns SPBPERS_BIRTH_CITY or null
-----------------------------------------------------------------------
FUNCTION Get_Birth_State (in_pidm IN spriden.spriden_pidm%type)
  RETURN VARCHAR2;
--  written by Elizabeth 3/10/2008
--  Returns SPBPERS_STAT_CODE_BIRTH or null
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION  Get_SZBWEBR_Value(in_webc_code    IN messiah.szbwebr.szbwebr_webc_code%type,
                            in_control_name IN messiah.szbwebr.szbwebr_control_name%type)
RETURN varchar2;
-----------------------------------------------------------------------
--  written by Elizabeth 8/20/2008
--  Returns value of SZBWEBR web control
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Employee_Time (in_pidm pebempl.pebempl_pidm%type)
  RETURN VARCHAR2;
--  written by Elizabeth 8/21/2008
-- returns employee time status (or null if not an employee)
--  F = Full Time, P = Part Time, O = On call
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Employee_Time2 (in_pidm pebempl.pebempl_pidm%type)
  RETURN VARCHAR2;
--  same as Get_Employee_Time except includes additional 'TO' ecls_code  
--  added by Elizabeth 4/9/2010
-- returns employee time status (or null if not an employee)
--  F = Full Time, P = Part Time, O = On call
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_GL_Org_Name (in_orgn_code ftvorgn.ftvorgn_orgn_code%type)
  RETURN VARCHAR2;
--  written by Greg / Elizabeth  8/25/2008
-- Returns GL organization name
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_GL_Org_Mgr (in_orgn_code ftvorgn.ftvorgn_orgn_code%type)
  RETURN NUMBER;
--  written by Greg / Elizabeth  8/25/2008
-- Returns GL organization manager pidm
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_GL_Acct_Name (in_acct ftvacct.ftvacct_acct_code%type)
  RETURN VARCHAR2;
--  written by Greg / Elizabeth  8/25/2008
-- Returns GL account name
-----------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Get_Info_By_Email (in_email goremal.goremal_email_address%type,
                            in_return_type varchar2 default 'AIF')
  RETURN VARCHAR2;
--  written by Elizabeth  9/5/2008
--  returns information based on in_email and in_return_type
--
--    in_return_type values:
--       P   - returns PIDM
--       I   - returns ID Number
--       N   - returns Name (last, first middle)
--       NI  - returns ID (first 10 characters) and Name 
--
-----------------------------------------------------------------------
--
--
-----------------------------------------------------------------------
FUNCTION is_valid_major
    (in_pidm      spriden.spriden_pidm%type,
	 in_major_code  sorlfos.sorlfos_majr_code%type,
	 in_lfst_code sorlfos.sorlfos_lfst_code%type,
	 in_lmod_code sorlcur.sorlcur_lmod_code%type,
	 in_term      stvterm.stvterm_code%type)
  RETURN varchar2;
--  written by Elizabeth  12/5/2008 (with Bob Felix's help)
--  returns 'Y' if valid major, minor, concentration etc.
--
--    in_lfst_code = MAJOR, MINOR, CONCENTRATION, etc.
--    in_lmod_code = LEARNER, ADMISSIONS, OUTCOME, etc.
---
-----------------------------------------------------------------------
--
--
-----------------------------------------------------------------------
FUNCTION is_valid_dept
    (in_pidm      spriden.spriden_pidm%type,
	 in_dept_code sorlfos.sorlfos_majr_code%type,
	 in_lfst_code sorlfos.sorlfos_lfst_code%type,
	 in_lmod_code sorlcur.sorlcur_lmod_code%type,
	 in_term      stvterm.stvterm_code%type)
  RETURN varchar2;
--  written by Elizabeth  12/5/2008 (with Bob Felix's help)
--  returns 'Y' if valid department for the student (based on major, minor, concentration)
--
--    in_lfst_code = MAJOR, MINOR, CONCENTRATION, etc.
--    in_lmod_code = LEARNER, ADMISSIONS, OUTCOME, etc.
-----------------------------------------------------------------------
--
--
-----------------------------------------------------------------------
FUNCTION is_valid_college
    (in_pidm      spriden.spriden_pidm%type,
	 in_coll_code sorlcur.sorlcur_coll_code%type,
	 in_lfst_code sorlfos.sorlfos_lfst_code%type,
	 in_lmod_code sorlcur.sorlcur_lmod_code%type,
	 in_term      stvterm.stvterm_code%type)
  RETURN varchar2;
--  written by Elizabeth  12/5/2008 (with Bob Felix's help)
--  returns 'Y' if valid college for the student (based on major, minor, concentration)
--
--    in_lfst_code = MAJOR, MINOR, CONCENTRATION, etc.
--    in_lmod_code = LEARNER, ADMISSIONS, OUTCOME, etc.
-----------------------------------------------------------------------
--
--
-----------------------------------------------------------------------
FUNCTION Get_Major_Advisor(in_pidm sgradvr.sgradvr_pidm%type, 
                           in_term sgradvr.sgradvr_term_code_eff%type,
						   in_majr sorlfos.sorlfos_majr_code%type)
  RETURN VARCHAR2;
--  written by Elizabeth  01/22/2009
--  FUNCTION returns pidm of student's advisor based on major code 
-----------------------------------------------------------------------
--
--
-------------------------------------------------------------
FUNCTION is_graduate_student(in_pidm     IN spriden.spriden_pidm%type,
                             in_term     IN stvterm.stvterm_code%type DEFAULT NULL,
							 in_appl_no  IN saradap.saradap_appl_no%type DEFAULT NULL)
  RETURN VARCHAR2;
-- revised by Elizabeth   4/26/2012
-- Returns 'Y' if the student has a recruit type of 'GR' or a studet level of 'GR'; otherwise, returns 'N'
-----------------------------------------------------------------------
--
--
-----------------------------------------------------------------------
FUNCTION get_deceased_date(in_pidm     IN spriden.spriden_pidm%type)
RETURN DATE;
--  written by Elizabeth   10/28/2009
--  Returns SPBPERS_DEAD_DATE for a pidm
-----------------------------------------------------------------------
--
--
-----------------------------------------------------------------------
FUNCTION get_admit_term(in_pidm     IN spriden.spriden_pidm%type)
RETURN VARCHAR2;
--  written by Elizabeth   10/6/2010
--  Returns maximum admissions term for a pidm
-----------------------------------------------------------------------
--
--
-----------------------------------------------------------------------
FUNCTION Has_Role(in_pidm IN spriden.spriden_pidm%type,
                  in_role IN twgrrole.twgrrole_role%type)
  RETURN BOOLEAN;
--  Returns true if a user has the specified web tailor role; otherwise, returns false
--------------------------------------------------------------
--
--
--------------------------------------------------------------
FUNCTION workflow_exists(event_code in varchar2,
                         param_name in varchar2,
                         param_value in varchar2)
  RETURN BOOLEAN;
--------------------------------------------------------------
--  Returns true if a workflow was already triggered a the specified condition
--
--
-- Bob Getty - 1/10/11
--
-- As an example, for me to test my new gift workflow on a particular gift id 
-- one of the parameters to the workflow):
--    if workflow_exists('NEWGIFT','GIFT_NO','0211274') then ...
-- The param_name and param_value uniquely identify a workflow
-- for a particular event_code (the workflow name).
--------------------------------------------------------------
--
--
-----------------------------------------------------------------------
FUNCTION Is_Accepted_Student(in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2;
--  written by Elizabeth  1/11/2011
--  Returns 'Y' (if this is an accepted student) or 'N' (if not)
-----------------------------------------------------------------------
--
-----------------------------------------------------------------------
FUNCTION Is_Accepted_Student(in_pidm spriden.spriden_pidm%type,
          in_term sarappd.sarappd_term_code_entry%type) 
  RETURN VARCHAR2 ;
--  written by Jonathan  10/25/2011
--  Returns 'Y' (if this is an accepted student for specific term) or 'N' (if not)
-----------------------------------------------------------------------
--
-----------------------------------------------------------------------
FUNCTION Is_A_Graduate (in_pidm IN aprcatg.aprcatg_pidm%type)
  RETURN VARCHAR2;
--  Returns 'Y' if a Messiah Grad or 'N' if not
-----------------------------------------------------------------------
--
-----------------------------------------------------------------------
FUNCTION Is_Rolled_GR_Student (in_pidm IN spriden.spriden_pidm%type)
  RETURN VARCHAR2;
-----------------------------------------------------------------------
--  Returns 'Y' if this is a graduate student with a decision code of 
--  GR = Graduate Rolled to Student or GP = Graduate Deposit Paid
-------------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Active_Employee (in_pidm pebempl.pebempl_pidm%type)
  RETURN VARCHAR2;
-----------------------------------------------------------------------
--  Returns 'Y' if this is a employee status = 'A' (pebempl_empl_status) 
--  Otherwise returns null
-------------------------------------------------------------------------
-----------------------------------------------------------------------
FUNCTION Is_Active_Org (in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2;
-----------------------------------------------------------------------
--  Returns 'Y' if this is a orgaznization is considered active
-- (not Donor Cat of 'UORG' and MA address is inactive)
--  Otherwise returns null
-------------------------------------------------------------------------
END banner_util;
--create public synonym banner_util for messiah.banner_util;
--grant execute on messiah.banner_util to public;
/


CREATE OR REPLACE PACKAGE BODY         BANNER_UTIL
AS
-- Functions are listed alphabetically
-- (Some functions are overloaded and are alphabetical by FUNCTION name, first parameter)
---------------------------------------------------------------------------------------------------------------------------------------------------
--  NOTE:   If a function needs to access a package under a different schema, you must grant access on that package to user messiah
---------------------------------------------------------------------------------------------------------------------------------------------------
--  Example:  Get_Student_Class_Desc
--  This function references package baninst1.SOKLIBS
--  I needed to do the following:  grant execute on baninst1.soklibs to messiah
--  Otherwise, banner_util would not compile
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------
FUNCTION F_GET_CNTY(zip_code IN VARCHAR2)
  RETURN VARCHAR2 IS
---------------------------------------------------------------------------
--  returns county code for a specified zip code
zip_lookup varchar2(5);
zip_county varchar2(5);
BEGIN
  zip_county:= NULL;
  zip_lookup:= substr(zip_code,1,5);
  if zip_lookup IS NOT NULL THEN
     SELECT GTVZIPC_CNTY_CODE INTO zip_county
       FROM GTVZIPC
      WHERE GTVZIPC_CODE = zip_lookup;
  END IF;
  RETURN zip_county;
EXCEPTION
  WHEN OTHERS THEN
    RETURN zip_county;
END F_GET_CNTY;
---------------------------------------------------------------------------
FUNCTION F_Get_File_Status (PlanType IN CHAR, PlanCode IN char)
  RETURN char IS
---------------------------------------------------------------------------
CURSOR lookup_code (PlanType IN Char, PlanCode IN char) IS
select pxrfsta_desc
from pxrfsta
where pxrfsta_txcd_code = PlanType
and pxrfsta_fil_stat = PlanCode;
return_value varchar2(30);
BEGIN
  OPEN lookup_code (PlanType, PlanCode);
  FETCH lookup_code INTO return_value;
  IF lookup_code%NOTFOUND
  THEN
      CLOSE lookup_code;
      RETURN 0;
  ELSE
      CLOSE lookup_code;
      RETURN return_value;
  END IF;
END F_Get_File_Status;
---------------------------------------------------------------------------
FUNCTION F_Get_TI1_Amount (OptPlan IN char)
  RETURN Number IS
---------------------------------------------------------------------------
CURSOR lookup_code (OptPlan IN char) IS
  select ptrbdpl_amt2
  from ptrbdpl P
  where ptrbdpl_effective_date =
  (select max(ptrbdpl_effective_date)
  from ptrbdpl P2
  where ptrbdpl_bdca_code = 'TI1')
  and ptrbdpl_code = OptPlan
  and ptrbdpl_bdca_code = 'TI1';
return_value number;
BEGIN
  OPEN lookup_code (OptPlan);
  FETCH lookup_code INTO return_value;
  IF lookup_code%NOTFOUND
  THEN
      CLOSE lookup_code;
      RETURN 0;
  ELSE
      CLOSE lookup_code;
      RETURN return_value;
  END IF;
END F_Get_TI1_Amount;
---------------------------------------------------------------------------
FUNCTION F_Get_TI1_Plan (pidm IN NUMBER)
  RETURN varchar IS
---------------------------------------------------------------------------
CURSOR lookup_plan (pidm IN number) IS
  select pdrdedn_opt_code1
  from pdrdedn P
  where pdrdedn_effective_date =
  (select max(pdrdedn_effective_date)
  from pdrdedn P2
  where P2.pdrdedn_pidm = P.pdrdedn_pidm
  and pdrdedn_bdca_code = 'TI1') and
  pdrdedn_pidm = pidm and
  pdrdedn_bdca_code = 'TI1';
return_value varchar2(2);
BEGIN
  OPEN lookup_plan (pidm);
  FETCH lookup_plan INTO return_value;
  IF lookup_plan%NOTFOUND
  THEN
      CLOSE lookup_plan;
      RETURN null;
  ELSE
      CLOSE lookup_plan;
      RETURN return_value;
  END IF;
END F_Get_TI1_Plan;
-----------------------------------------------------------------------
FUNCTION f_validate_single (owner VARCHAR2,
                            tablename VARCHAR2,
                            column VARCHAR2,
							in_value VARCHAR2)
RETURN VARCHAR2 IS
-----------------------------------------------------------------------
/*
	Powerful way to validate codes.  Pass in the owner, table, and column of the
	validation table, along with the value you are verifying.  The function will
	dynamically create a select statement based upon your parameters.  The function
	returns 'FALSE' if no errors (it found the entry), and 'TRUE' if no data is
	found for the value you are passing in.
*/
   my_statement VARCHAR2(300);
   ws_cursor INTEGER;
   ws_return INTEGER;
   row_count INTEGER;
BEGIN
   /* build dynamic SQL statement */
   my_statement := 'SELECT '||''''||'X'||''''||' FROM '||owner||
    '.'||tablename||' WHERE '||column||' = '||''''||in_value||'''';
   /* execute dynamic SQL */
   ws_cursor := dbms_sql.open_cursor;
   dbms_sql.parse(ws_cursor,my_statement,dbms_sql.v7);
   ws_return := dbms_sql.execute(ws_cursor);  --Execute the SQL Command
   row_count := DBMS_SQL.FETCH_ROWS (ws_cursor);
   dbms_sql.close_cursor(ws_cursor);
   /* check number of rows returned */
   IF row_count <> 0 THEN
      RETURN 'FALSE';
   ELSE
      RETURN 'TRUE';
   END IF;
EXCEPTION
   WHEN OTHERS THEN
   DECLARE
      err_msg VARCHAR2(207) := 'ERR- '||substr(SQLERRM,1,200);
   BEGIN
      RETURN err_msg;
   END;
END f_validate_single;
-----------------------------------------------------------------------
FUNCTION f_validate_single_null_ok (owner VARCHAR2,tablename VARCHAR2,
column VARCHAR2,in_value VARCHAR2)
RETURN VARCHAR2 IS
-----------------------------------------------------------------------
/*
	Powerful way to validate codes.  Pass in the owner, table, and column of the
	validation table, along with the value you are verifying.  The function will
	dynamically create a select statement based upon your parameters.  The function
	returns 'FALSE' if no errors (it found the entry), and 'TRUE' if no data is
	found for the value you are passing in.
*/
   my_statement VARCHAR2(300);
   ws_cursor INTEGER;
   ws_return INTEGER;
   row_count INTEGER;
BEGIN
  if in_value is null THEN
     RETURN 'FALSE';
  else
   /* build dynamic SQL statement */
   my_statement := 'SELECT '||''''||'X'||''''||' FROM '||owner||
    '.'||tablename||' WHERE '||column||' = '||''''||in_value||'''';
   /* execute dynamic SQL */
   ws_cursor := dbms_sql.open_cursor;
   dbms_sql.parse(ws_cursor,my_statement,dbms_sql.v7);
   ws_return := dbms_sql.execute(ws_cursor);  --Execute the SQL Command
   row_count := DBMS_SQL.FETCH_ROWS (ws_cursor);
   dbms_sql.close_cursor(ws_cursor);
   /* check number of rows returned */
   IF row_count <> 0 THEN
      RETURN 'FALSE';
   ELSE
      RETURN 'TRUE';
   END IF;
  END IF;
EXCEPTION
   WHEN OTHERS THEN
   DECLARE
      err_msg VARCHAR2(207) := 'ERR- '||substr(SQLERRM,1,200);
   BEGIN
      RETURN err_msg;
   END;
END f_validate_single_null_ok;
-----------------------------------------------------------------------
FUNCTION Get_Address(in_pidm spriden.spriden_pidm%type, in_atyp_code spraddr.spraddr_atyp_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--   returns active  address of specified type
  out_address    varchar2(200);
  spraddr_rec       spraddr%rowtype;
  crlf              VARCHAR2(2):=chr(13)||chr(10);
BEGIN
   out_address := Get_Address_Lines(in_pidm, in_atyp_code,'F');
   RETURN out_address;
END Get_Address;
-----------------------------------------------------------------------
FUNCTION Get_Address_Lines(in_pidm spriden.spriden_pidm%type,
                           in_atyp_code spraddr.spraddr_atyp_code%type,
						   in_lines varchar2)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--   returns line(s) of active  address of specified type
--  in_lines parameter values:
--    1 = Line 1
--    2 = Line 2
--    3 = Line 3
--    C = City
--    S = State
--    CS = City, State
--    Z = Zip Code
--    N = Nation Code
--    K = County Code
--    A = All (Short)  Line1(30) || Line2(30) || line3(30) || City(20) || state(3) || zip(10) || nation(5) || County(5)
--    AF = All (Full)  Line1(75) || Line2(75) || line3(75) || City(50) || state(3) || zip(30) || nation(5) || County(5)
--    F = Formatted mailing address (includes carriage Returns)
  out_address    varchar2(500);
  spraddr_rec       spraddr%rowtype;
  crlf              VARCHAR2(2):=chr(13)||chr(10);
BEGIN
   out_address := null;
   BEGIN
     SELECT *
	   INTO spraddr_rec
       FROM spraddr
      WHERE spraddr_pidm = in_pidm
        AND spraddr_atyp_code = in_atyp_code
        AND (spraddr_status_ind IS NULL
         OR (spraddr_From_date <= sysdate AND (spraddr_to_date IS NULL OR spraddr_to_date >= sysdate))
		    )
      ORDER BY nvl(spraddr_status_ind,'A');
	  EXCEPTION WHEN OTHERS THEN out_address := null;
   END;
   IF in_lines = '1' THEN
      RETURN spraddr_rec.spraddr_street_line1;
   END IF;
   IF in_lines = '2' THEN
      RETURN spraddr_rec.spraddr_street_line2;
   END IF;
   IF in_lines = '3' THEN
      RETURN spraddr_rec.spraddr_street_line3;
   END IF;
   IF upper(in_lines) = 'C' THEN
      RETURN spraddr_rec.spraddr_city;
   END IF;
   IF upper(in_lines) = 'S' THEN
      RETURN spraddr_rec.spraddr_stat_code;
   END IF;
   IF upper(in_lines) = 'CS' THEN
      RETURN trim(spraddr_rec.spraddr_city) || ', ' || spraddr_rec.spraddr_stat_code;
   END IF;
   IF upper(in_lines) = 'Z' THEN
      RETURN spraddr_rec.spraddr_zip;
   END IF;
   IF upper(in_lines) = 'N' THEN
      RETURN spraddr_rec.spraddr_natn_code;
   END IF;
   IF upper(in_lines) = 'K' THEN
      RETURN spraddr_rec.spraddr_cnty_code;
   END IF;
--    A = All   Line1(30) || Line2(30) || line3(30) || City(20) || state(3) || zip(10) || nation(5) || County(5)
   IF in_lines = 'A' THEN
      out_address := substr(trim(spraddr_rec.spraddr_street_line1)
	                   || '                              ',1,30)
				  || substr(trim(spraddr_rec.spraddr_street_line2)
	                   || '                              ',1,30)
				  || substr(trim(spraddr_rec.spraddr_street_line3)
	                   || '                              ',1,30)
				  || substr(trim(spraddr_rec.spraddr_city)
	                   || '                              ',1,20)
				  || substr(trim(spraddr_rec.spraddr_stat_code) || '   ',1,3)
				  || substr(trim(spraddr_rec.spraddr_zip) || '          ',1,10)
				  || substr(trim(spraddr_rec.spraddr_natn_code) || '     ',1,5)
				  || substr(trim(spraddr_rec.spraddr_cnty_code) || '     ',1,5);
	  RETURN out_address;
   END IF;
--    AF = All (Full)  Line1(75) || Line2(75) || line3(75) || City(50) || state(3) || zip(30) || nation(5) || County(5)
   IF in_lines = 'AF' THEN
--    note:  added the || ' ' and substr because if the items were null, the rpad did not seem to work
      out_address := substr(rpad(spraddr_rec.spraddr_street_line1 || ' ',75,' '),1,75)
				  || substr(rpad(spraddr_rec.spraddr_street_line2 || ' ',75,' '),1,75)
				  || substr(rpad(spraddr_rec.spraddr_street_line3 || ' ',75,' '),1,75)
				  || substr(rpad(spraddr_rec.spraddr_city || ' ',50,' '),1,50)
				  || substr(rpad(spraddr_rec.spraddr_stat_code || ' ',3,' '),1,50)
				  || substr(rpad(spraddr_rec.spraddr_zip || ' ',30,' '),1,50)
				  || substr(rpad(spraddr_rec.spraddr_natn_code || ' ',5,' '),1,50)
				  || substr(rpad(spraddr_rec.spraddr_cnty_code || ' ',5,' '),1,50);
	  RETURN out_address;
   END IF;
   IF in_lines = 'F' THEN
      IF spraddr_rec.spraddr_street_line1 IS NOT NULL THEN
         out_address := spraddr_rec.spraddr_street_line1 || crlf;
      END IF;
      IF spraddr_rec.spraddr_street_line2 IS NOT NULL THEN
         out_address := out_address || spraddr_rec.spraddr_street_line2 || crlf;
      END IF;
      IF spraddr_rec.spraddr_street_line3 IS NOT NULL THEN
         out_address := out_address || spraddr_rec.spraddr_street_line3 || crlf;
      END IF;
      IF spraddr_rec.spraddr_city IS NOT NULL THEN
         out_address := out_address || spraddr_rec.spraddr_city;
         IF spraddr_rec.spraddr_stat_code is not null THEN
	        out_address := out_address || ', ';
	     END IF;
      END IF;
      IF spraddr_rec.spraddr_stat_code IS NOT NULL THEN
         out_address := out_address || spraddr_rec.spraddr_stat_code;
      END IF;
      IF spraddr_rec.spraddr_stat_code IS NULL and spraddr_rec.spraddr_city IS NULL THEN
         out_address := out_address || spraddr_rec.spraddr_zip;
      ELSE
         out_address := out_address || ' ' || spraddr_rec.spraddr_zip;
      END IF;
      out_address := out_address || crlf;
      IF spraddr_rec.spraddr_natn_code IS NOT NULL AND spraddr_rec.spraddr_natn_code <> 'US' THEN
         out_address := out_address || spraddr_rec.spraddr_natn_code || crlf;
      END IF;
      RETURN out_address;
   END IF;
END Get_Address_Lines;
-----------------------------------------------------------------------
FUNCTION Get_Alum_Pref_Year (in_pidm apbcons.apbcons_pidm%type)
  RETURN varchar2 IS
-----------------------------------------------------------------------
-- returns alumni preferred class year
  pref_year        apbcons.apbcons_pref_clas%type;
BEGIN
   BEGIN
     SELECT max(apbcons_pref_clas)
	   INTO pref_year
	   FROM apbcons
	  WHERE apbcons_pidm = in_pidm;
      EXCEPTION WHEN OTHERS THEN pref_year := null;
   END;
   RETURN pref_year;
END Get_Alum_Pref_Year;
-----------------------------------------------------------------------
FUNCTION Get_Age(in_pidm spriden.spriden_pidm%type)
  RETURN NUMBER IS
-----------------------------------------------------------------------
--  returns age in years  or null
  age          number(3);
  birth_date     date;
  death_date     date;
BEGIN
  birth_date := null;
  BEGIN
    SELECT spbpers_birth_date, spbpers_dead_date
	  INTO birth_date, death_date
	  FROM spbpers
	 WHERE spbpers_pidm = in_pidm;
	 EXCEPTION WHEN OTHERS THEN birth_date := null;
  END;
  IF birth_date IS NULL THEN
     RETURN NULL;
  ELSE
    age :=  trunc(months_between(trunc(nvl(death_date,
                                           sysdate)),
                     trunc(birth_date)) / 12);
    return age;
  END IF;
END Get_Age;
-----------------------------------------------------------------------
FUNCTION Get_Gender(in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  returns spbpers_gender_code or null
  gender_code    varchar2(1) := null;
BEGIN
  BEGIN
    SELECT spbpers_sex
	  INTO gender_code
	  FROM spbpers
	 WHERE spbpers_pidm = in_pidm;
	 EXCEPTION WHEN OTHERS THEN gender_code := null;
  END;
  RETURN gender_code;
END Get_Gender;
-----------------------------------------------------------------------
FUNCTION Get_Birth_Date(in_pidm spriden.spriden_pidm%type)
  RETURN DATE IS
-----------------------------------------------------------------------
--  returns birthdate or null
  birth_date     date;
BEGIN
  birth_date := null;
  BEGIN
    SELECT spbpers_birth_date
	  INTO birth_date
	  FROM spbpers
	 WHERE spbpers_pidm = in_pidm;
	 EXCEPTION WHEN OTHERS THEN birth_date := null;
  END;
  return birth_date;
END Get_Birth_Date;
-----------------------------------------------------------------------
FUNCTION Get_Birth_Name(in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  returns last name for name type 'BRTH'
  current_name   spriden.spriden_last_name%type;
  birth_name     spriden.spriden_last_name%type;
BEGIN
  current_name := get_name(in_pidm,'L');
  BEGIN
    SELECT spriden_last_name
	  INTO birth_name
      FROM spriden
     WHERE spriden_pidm = in_pidm
	   AND spriden_ntyp_code = 'BRTH';
	 EXCEPTION WHEN OTHERS THEN birth_name := null;
  END;
  IF birth_name IS NULL THEN
     RETURN NULL;
  ELSIF current_name = birth_name THEN
     RETURN null;
  ELSE
     RETURN birth_name;
  END IF;
END Get_Birth_Name;
-----------------------------------------------------------------------
FUNCTION Get_Building_RD(in_bldg_code stvbldg.stvbldg_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/12/2006
--  FUNCTION returns ID for RD (resident director)
--  input:  building code
--  output: RD ID or NULL
resdir_id     spriden.spriden_id%type;
BEGIN
    resdir_id := NULL;
    BEGIN
	  SELECT szvresd_rd_id
        INTO resdir_id
	    FROM szvresd
	  WHERE szvresd_bldg_code = in_bldg_code;
	  EXCEPTION WHEN OTHERS THEN resdir_id :=  NULL;
    END;
    RETURN resdir_id;
END Get_Building_RD;
-----------------------------------------------------------------------
FUNCTION Get_Campus_Address(in_pidm spriden.spriden_pidm%type default -1)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--   returns spraddr_street_line1 for active 'CM' address
  campus_address    varchar2(200);
BEGIN
   campus_address := Get_Address(in_pidm,'CM');
   RETURN campus_address;
END Get_Campus_Address;
-----------------------------------------------------------------------
FUNCTION Get_Campus_Box(in_pidm spriden.spriden_pidm%type default -1)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--   returns spraddr_street_line2 for active 'CM' address
  campus_box    spraddr.spraddr_street_line2%type;
BEGIN
   BEGIN
     SELECT spraddr_street_line2
	   INTO campus_box
       FROM spraddr
      WHERE spraddr_pidm = in_pidm
        AND spraddr_atyp_code = 'CM'
        AND (spraddr_status_ind IS NULL
         OR (spraddr_From_date <= sysdate AND (spraddr_to_date IS NULL OR spraddr_to_date >= sysdate))
		    )
      ORDER BY nvl(spraddr_status_ind,'A') DESC;
	  EXCEPTION WHEN OTHERS THEN campus_box := null;
   END;
   RETURN campus_box;
END Get_Campus_Box;
-----------------------------------------------------------------------
FUNCTION Get_Campus_Box_No(in_pidm spriden.spriden_pidm%type default -1)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--   returns numeric suite or unit number from spraddr_street_line2 for active 'CM' address
  campus_box    spraddr.spraddr_street_line2%type;
   BEGIN
	 campus_box := Get_Campus_Box(in_pidm);
     campus_box := REPLACE(campus_box,'One College Avenue Suite ', '');
     campus_box := REPLACE(campus_box,'One College Avenue Unit ', '');
	 campus_box := ltrim(campus_box);
	 RETURN campus_box;
   END Get_Campus_Box_No;
-----------------------------------------------------------------------
FUNCTION Get_CERT_Desc
    (in_cert stvcert.stvcert_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  09/19/2006
--  FUNCTION returns ceremony description
--  input:  ceremony (cert) code
--  output: ceremony description or 'Invalid Ceremony'
ceremony_Desc    VARCHAR2(30);
BEGIN
    ceremony_Desc := NULL;
	BEGIN
        SELECT stvcert_Desc
		  INTO ceremony_Desc
          FROM stvcert
         WHERE stvcert_code = in_cert;
		EXCEPTION WHEN OTHERS THEN ceremony_Desc := 'Invalid Ceremony';
    END;
    RETURN ceremony_Desc;
END Get_CERT_Desc;
-----------------------------------------------------------------------
FUNCTION Get_Class_Desc (in_crn ssbsect.ssbsect_crn%type,
                         in_style VARCHAR2 default NULL,
						 in_term ssbsect.ssbsect_term_code%type default NULL)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  09/19/2006
--  returns course descriptive information based on crn, style, and term (defaults to current term)
--  style  values
--  SNTC  (subj num - title - crn)
--  SNT    (subj num - title)  (default value)
--  SN      (subj num)
-- SNX   (subj num - section)
--  T        (title)
crn_desc     VARCHAR2(100);
term_code    stvterm.stvterm_code%type;
BEGIN
    term_code := Get_Current_Term;
	If in_term is not NULL THEN
	   term_code := in_term;
	END IF;
    crn_desc := 'Course Number: ' || trim(to_char(in_crn));
    for crn in
       (
         SELECT ssbsect_subj_code, ssbsect_crse_numb, ssbsect_seq_numb,
		        ssbsect_crse_title, scbcrse_title
           FROM scbcrse, ssbsect
          WHERE ssbsect_crn = in_crn
		    AND ssbsect_term_code = term_code
            AND scbcrse_subj_code = ssbsect_subj_code
			AND scbcrse_crse_numb = ssbsect_crse_numb
        )
	loop
       IF in_style IS NULL or in_style = 'SNTC' THEN
	      crn_desc := crn.ssbsect_subj_code || ' ' || crn.ssbsect_crse_numb
	            || ' - ';
          IF crn.ssbsect_crse_title is not NULL THEN
  	         crn_desc := crn_desc || crn.ssbsect_crse_title;
          ELSE
  	         crn_desc := crn_desc || crn.scbcrse_title;
          END IF;
          crn_desc := crn_desc || ' - ' || trim(to_char(in_crn));
       END IF;
       IF in_style IS NULL or in_style = 'SNT' THEN
	      crn_desc := crn.ssbsect_subj_code || ' ' || crn.ssbsect_crse_numb
	            || ' - ';
          IF crn.ssbsect_crse_title is not NULL THEN
  	         crn_desc := crn_desc || crn.ssbsect_crse_title;
          ELSE
  	         crn_desc := crn_desc || crn.scbcrse_title;
          END IF;
       END IF;
       IF in_style = 'SNX' THEN
	      crn_desc := crn.ssbsect_subj_code || ' ' || crn.ssbsect_crse_numb
	            || ' - ' || crn.ssbsect_seq_numb;
       END IF;
       IF in_style = 'SN' THEN
	      crn_desc := crn.ssbsect_subj_code || ' ' || crn.ssbsect_crse_numb;
       END IF;
       IF in_style = 'T' THEN
          IF crn.ssbsect_crse_title is not NULL THEN
  	         crn_desc := crn.ssbsect_crse_title;
          ELSE
  	         crn_desc := crn.scbcrse_title;
          END IF;
       END IF;
	end loop;
    RETURN trim(crn_desc);
END Get_Class_Desc;
-----------------------------------------------------------------------
FUNCTION Get_Class_Times (crn ssrmeet.ssrmeet_crn%type,
                          term_code ssrmeet.ssrmeet_term_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  05/17/2006
--  FUNCTION returns class meeting time
-- sample output:  MWF  08:00am - 08:50am
meeting_times     VARCHAR2(50) := NULL;
cursor get_ssrmeet_c is
    SELECT nvl(ssrmeet_sun_day,' ') Sunday,
	       nvl(ssrmeet_mon_day,' ') Monday,
		   nvl(ssrmeet_tue_day,' ') Tuesday,
           nvl(ssrmeet_wed_day,' ') Wednesday,
 		   nvl(ssrmeet_thu_day,' ') Thursday,
		   nvl(ssrmeet_fri_day,' ') Friday,
		   nvl(ssrmeet_sat_day,' ') Saturday,
           nvl(ssrmeet_begin_time,'XXXX') Begin_time,
		   nvl(ssrmeet_end_time,'XXXX') End_time
      FROM ssrmeet
     WHERE ssrmeet_crn = crn
       and ssrmeet_term_code= term_code;
ssrmeet_rec      get_ssrmeet_c%ROWTYPE;
BEGIN
    open get_ssrmeet_c;
    fetch get_ssrmeet_c INTO ssrmeet_rec;
    close get_ssrmeet_c;
    meeting_times := trim(ssrmeet_rec.Sunday)
	              || trim(ssrmeet_rec.Monday)
	              || trim(ssrmeet_rec.Tuesday)
	              || trim(ssrmeet_rec.Wednesday)
	              || trim(ssrmeet_rec.Thursday)
	              || trim(ssrmeet_rec.Friday)
	              || trim(ssrmeet_rec.Saturday);
    IF ssrmeet_rec.Begin_time <> 'XXXX' THEN
	   meeting_times := trim(meeting_times)
	                 || '  '
					 || substr(ssrmeet_rec.Begin_time,1,2)
					 || ':'
					 || substr(ssrmeet_rec.Begin_time,3,2);
	   IF ssrmeet_rec.Begin_time = '1200' THEN
	      meeting_times := meeting_times || 'noon';
	   ELSE
	      IF ssrmeet_rec.Begin_time > '1200' THEN
		     meeting_times := meeting_times || 'pm';
		  ELSE
		     meeting_times := meeting_times || 'am';
		  END IF;
	   END IF;
	END IF;
    IF ssrmeet_rec.End_Time <> 'XXXX' THEN
	   meeting_times := trim(meeting_times)
	                 || ' - '
					 || substr(ssrmeet_rec.End_Time,1,2)
					 || ':'
					 || substr(ssrmeet_rec.End_Time,3,2);
	   IF ssrmeet_rec.End_Time = '1200' THEN
	      meeting_times := meeting_times || 'noon';
	   ELSE
	      IF ssrmeet_rec.End_Time > '1200' THEN
		     meeting_times := meeting_times || 'pm';
		  ELSE
		     meeting_times := meeting_times || 'am';
		  END IF;
	   END IF;
	END IF;
    RETURN meeting_times;
END Get_Class_Times;
-----------------------------------------------------------------------
FUNCTION Get_Current_Term
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  05/29/2006
--  FUNCTION returns current term = minimum term WHERE term end date > today
    current_term  stvterm.stvterm_code%type := NULL;
BEGIN
--    commented out 12/15/2006
--    code was causing 200620 to be SELECTed as current term rather than 200610
--    SELECT min(stvterm_code)
--      INTO current_term
--   	  FROM stvterm
--     WHERE stvterm_end_date > sysdate
--	   and substr(stvterm_code,5,1) <> '0';
    SELECT max(stvterm_code)
      INTO current_term
   	  FROM stvterm
     WHERE substr(stvterm_code,5,1) <> '0'
	   AND substr(stvterm_code,6,1) = '0'
	   AND stvterm_start_date <= sysdate;
	 RETURN current_term;
END Get_Current_Term;
---------------------------------------------------------------------------
FUNCTION Get_Dept_Description(in_orgn fimsmgr.ftvorgn.ftvorgn_orgn_code%type)
  RETURN VARCHAR2 IS
-- written by John Luft 06/05/2008
-- Function returns the orgn (dept) description
  orgn_description ftvorgn.ftvorgn_title%type := NULL;
BEGIN
  select ftvorgn_title
  into orgn_description
  from fimsmgr.ftvorgn t
  where ftvorgn_status_ind = 'A'
    and ftvorgn_eff_date < trunc(sysdate)
    and ftvorgn_nchg_date > trunc(sysdate)
    and ftvorgn_orgn_code = in_orgn;
  RETURN orgn_description;
END Get_Dept_Description;
---------------------------------------------------------------------------
---------------------------------------------------------------------------
FUNCTION Get_Dependent_Pidm(p_pidm number default null)
  RETURN pidm_tab_type IS
---------------------------------------------------------------------------
  -- Function to return dependent pidm(s) from aprchld for a given pidm
  cursor c_dep(p_pidm in number) is
    select aprchld.aprchld_chld_pidm pidm
      from alumni.aprchld
      --join saturn.spbpers on spbpers.spbpers_pidm = aprchld.aprchld_chld_pidm
      join saturn.spriden on spriden.spriden_pidm = aprchld.aprchld_chld_pidm
     where aprchld.aprchld_pidm = p_pidm
       and spriden_change_ind is null;                       -- current dependent record
    v_result pidm_tab_type;
BEGIN
    if p_pidm is not null then
      for deprec in c_dep(p_pidm) loop
        v_result(v_result.count) := deprec.pidm;
      end loop;
    end if;
    return(v_result);
END Get_Dependent_Pidm;
-----------------------------------------------------------------------
FUNCTION Get_Dorm(in_pidm spriden.spriden_pidm%type,
                  in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/12/2006
--  FUNCTION returns student dorm
--  input:  student pidm, term
--  output: dorm code or NULL
building_code    stvbldg.stvbldg_code%type;
BEGIN
    building_code := Get_Dorm_Info(in_pidm, in_term, 'D');
    RETURN building_code;
END Get_Dorm;
-----------------------------------------------------------------------
FUNCTION Get_Dorm_Ext(in_pidm spriden.spriden_pidm%type default -1,
                        in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/12/2006
--  FUNCTION returns student dorm room extension
--  input:  student pidm, term
--  output: room extension  or NULL
	dorm_extension   slbrdef.slbrdef_phone_extension%type := null;
BEGIN
    dorm_extension := Get_Dorm_Info(in_pidm, in_term, 'EX');
    RETURN dorm_extension;
END Get_Dorm_Ext;
-----------------------------------------------------------------------
FUNCTION Get_Dorm_Info(in_pidm number, in_term stvterm.stvterm_code%type, in_request VARCHAR2)
 RETURN VARCHAR2 IS
-----------------------------------------------------------------------
-- Function returns dorm room information based on pidm, term, and request type parameters
-- in_request values:
--   PH  = Phone
--   EX  = Extension
--   D   = Dorm Building
--   DN = Dorm Name
--   DR  = Dorm Room
--   R    = Dorm Room Number
--   RD  = Room Desc
--   RR = Room Rate Type
--   RRD = Room Rate Description
     dorm_room        varchar2(50) := null;
--     dorm_room        slrrasg.slrrasg_room_number%type := null;
	 dorm_bldg        slrrasg.slrrasg_bldg_code%type := null;
     dorm_phone       varchar2(100) := null;
	 dorm_extension   slbrdef.slbrdef_phone_extension%type := null;
	 dorm_room_desc   slbrdef.slbrdef_desc%type := null;
	 dorm_name        stvbldg.stvbldg_desc%type := null;
	 room_rate        slbrdef.SLBRDEF_RRCD_CODE%type;
	 room_rate_desc   stvrrcd.stvrrcd_desc%type;
BEGIN
    BEGIN
        SELECT slrrasg_bldg_code,
		       slrrasg_room_number,
		       slbrdef_phone_area || '-' || substr(trim(slbrdef_phone_number),1,3)
                                  || '-' || substr(trim(slbrdef_phone_number),4,4),
               slbrdef_phone_extension,
               slbrdef_desc,
               stvbldg_desc,
               slbrdef_rrcd_code
          INTO dorm_bldg, dorm_room, dorm_phone, dorm_extension, dorm_room_desc, dorm_name, room_rate
          FROM stvbldg, stvascd, slbrdef, slrrasg
	     WHERE slrrasg_pidm = in_pidm
--		   AND to_char(slrrasg_end_date, 'yyyymmdd') >= to_char(sysdate, 'yyyymmdd')
		   AND slrrasg_ascd_code = 'A'
		   AND slrrasg_bldg_code <> 'PO'
		   AND slrrasg_term_code = in_term
--		      (select min(slrrasg_term_code)
--			     from slrrasg
--				where slrrasg_term_code >= in_term)
           AND slbrdef_bldg_code = slrrasg_bldg_code
		   AND slbrdef_room_number = slrrasg_room_number
		   AND slbrdef_term_code_eff =
		      (select max(r.slbrdef_term_code_eff)
			     from slbrdef r
				where r.slbrdef_bldg_code = slrrasg_bldg_code
		          and r.slbrdef_room_number = slrrasg_room_number
				  and r.slbrdef_term_code_eff <= in_term)
		   AND stvascd_code = slrrasg_ascd_code
		   AND stvascd_count_in_usage = 'Y'
		   AND stvbldg_code = slrrasg_bldg_code;
          EXCEPTION
           WHEN OTHERS THEN dorm_phone := null;
    END;
    IF upper(in_request) = 'PH' THEN
	   RETURN dorm_phone;
	END IF;
    IF upper(in_request) = 'EX' THEN
	   RETURN dorm_extension;
	END IF;
    IF upper(in_request) = 'D' THEN
	   RETURN dorm_bldg;
	END IF;
    IF upper(in_request) = 'DN' THEN
	   RETURN dorm_name;
	END IF;
    IF upper(in_request) = 'R' THEN
	   RETURN dorm_room;
	END IF;
    IF upper(in_request) = 'RR' THEN
	   RETURN room_rate;
	END IF;
	IF upper(in_request) = 'RRD' THEN
	   room_rate_desc := NULL;
       BEGIN
	     select stvrrcd_desc
	       into room_rate_desc
		   from stvrrcd
		  where stvrrcd_code = room_rate;
	     EXCEPTION WHEN OTHERS THEN room_rate_desc := NULL;
	   END;
	   RETURN room_rate_desc;
	END IF;
    IF upper(in_request) = 'DR' THEN
       IF dorm_bldg = 'X' THEN
	      dorm_room := dorm_room_desc;
	   END IF;
	   RETURN dorm_room;
	END IF;
    IF upper(in_request) = 'RR' THEN
	   RETURN dorm_room_desc;
	END IF;
	RETURN null;
END Get_Dorm_Info;
-----------------------------------------------------------------------
FUNCTION Get_Dorm_Name(in_pidm spriden.spriden_pidm%type,
                       in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  07/27/2006
--  FUNCTION returns student dorm name
building_desc    stvbldg.stvbldg_desc%type;
BEGIN
    building_desc := Get_Dorm_Info(in_pidm, in_term, 'DN');
    RETURN building_desc;
END Get_Dorm_Name;
-----------------------------------------------------------------------
FUNCTION Get_Dorm_Phone(in_pidm spriden.spriden_pidm%type,
                        in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/12/2006
--  FUNCTION returns student dorm room phone number
--  input:  student pidm, term
--  output: formatted phone number (nnn-nnn-nnnn)  or NULL
   dorm_phone    varchar2(20);
BEGIN
    dorm_phone := Get_Dorm_Info(in_pidm, in_term, 'PH');
    RETURN dorm_phone;
END Get_Dorm_Phone;
-----------------------------------------------------------------------
FUNCTION Get_Dorm_Room(in_pidm spriden.spriden_pidm%type,
                       in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/12/2006
--  FUNCTION returns student dorm room number
--     or student location if the student is in an external program
room_number    VARCHAR2(50);
BEGIN
    room_number := Get_Dorm_Info(in_pidm, in_term, 'DR');
    RETURN room_number;
END Get_Dorm_Room;
-----------------------------------------------------------------------
FUNCTION Get_Dorm_Room_Number(in_pidm spriden.spriden_pidm%type,
                              in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/12/2006
--  FUNCTION returns student dorm room number
room_number    VARCHAR2(50);
BEGIN
    room_number := Get_Dorm_Info(in_pidm, in_term, 'R');
    RETURN room_number;
END Get_Dorm_Room_Number;
-----------------------------------------------------------------------
FUNCTION Get_Dorm_Room_Desc(in_pidm spriden.spriden_pidm%type,
                            in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/12/2006
--  FUNCTION returns student dorm room description
room_desc    VARCHAR2(50);
BEGIN
    room_desc := Get_Dorm_Info(in_pidm, in_term, 'RD');
    RETURN room_desc;
END Get_Dorm_Room_Desc;
-----------------------------------------------------------------------
FUNCTION Get_Earned_Credits(in_pidm spriden.spriden_pidm%type)
  RETURN number IS
-----------------------------------------------------------------------
--  written by Elizabeth  10/06/2006
--  FUNCTION returns earned overall credits for a student
    earned_credits     SHRLGPA.SHRLGPA_HOURS_EARNED%type;
BEGIN
    BEGIN
        SELECT shrlgpa_hours_earned
		  INTO earned_credits
          FROM shrlgpa
             WHERE shrlgpa_pidm = in_pidm
               and shrlgpa_levl_code = 'UG'
			   and shrlgpa_gpa_type_ind = 'O';
            EXCEPTION
              WHEN OTHERS THEN earned_credits := 0;
    END;
    RETURN earned_credits;
END Get_Earned_Credits;
-----------------------------------------------------------------------
FUNCTION Get_Email(in_id spriden.spriden_id%type,
                   in_emal_code goremal.goremal_emal_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/07/2006
--  FUNCTION returns active email address of specified type
--  input:  ID, email_code
--  output: returns email address or NULL
email_address      goremal.goremal_email_address%type;
email_pidm         spriden.spriden_pidm%type;
BEGIN
    email_address := NULL;
	email_pidm := Get_Pidm(in_id);
    email_address := Get_Email(email_pidm, in_emal_code);
    RETURN email_address;
END Get_Email;
-----------------------------------------------------------------------
FUNCTION Get_Email(in_pidm spriden.spriden_pidm%type,
                   in_emal_code goremal.goremal_emal_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/07/2006
--  FUNCTION returns active email address of specified type
--  input:  pidm, email_code
--  output: returns email address or NULL
email_address      goremal.goremal_email_address%type;
begin
    email_address := NULL;
    for emailaddr in
	   (SELECT goremal_email_address
	      FROM goremal
		 WHERE goremal_pidm = in_pidm
		   and goremal_emal_code = in_emal_code
		   and goremal_status_ind = 'A'
		 order by goremal_activity_date)
	loop
        email_address := emailaddr.goremal_email_address;
	end loop;
    RETURN email_address;
END Get_Email;
-----------------------------------------------------------------------
FUNCTION Get_Email_Link(in_id spriden.spriden_id%type,
                        in_emal_code goremal.goremal_emal_code%type
						)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  RETURN url link for specified ID and email type
email_address      goremal.goremal_email_address%type;
email_pidm         spriden.spriden_pidm%type;
BEGIN
    email_address := NULL;
	email_pidm := Get_Pidm(in_id);
    email_address := Get_Email_Link(email_pidm, in_emal_code);
    RETURN email_address;
END Get_Email_Link;
-----------------------------------------------------------------------
FUNCTION Get_Email_Link(in_pidm spriden.spriden_pidm%type,
                        in_emal_code goremal.goremal_emal_code%type
						)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  RETURN url link for specified pidm and email type
email_address      goremal.goremal_email_address%type;
BEGIN
    email_address := NULL;
    email_address := Get_Email(in_pidm, in_emal_code);
	IF email_address IS NULL THEN
	   RETURN NULL;
	ELSE
	   RETURN '<a href=mailto:' || email_address || '>' || email_address || '</a>';
	END IF;
END Get_Email_Link;
---------------------------------------------------------------------------
FUNCTION Get_Employee_Dept (in_pidm spriden.spriden_pidm%type)
RETURN VARCHAR2 IS
---------------------------------------------------------------------------
--  returns department code of first employee job record found
--  (note:  there could be additional jobs / departments that this function does not return)
  employee_department   NBRJOBS.NBRJOBS_ORGN_CODE_TS%type;
  BEGIN
    employee_department := null;
    FOR jobs IN
	   (SELECT distinct
			   NBRJOBS_ORGN_CODE_TS, -- department code
               decode(nbrbjob_contract_type,'P','0','1') contract_type,
			   nbrjobs_effective_date
	      FROM nbrjobs X, NBRBJOB
         WHERE NBRBJOB_PIDM = in_pidm
           AND x.NBRJOBS_PIDM = NBRBJOB_PIDM
           AND x.NBRJOBS_POSN = NBRBJOB_POSN
           AND x.NBRJOBS_SUFF = NBRBJOB_SUFF
           AND (SYSDATE >= NBRBJOB_BEGIN_DATE OR NBRBJOB_BEGIN_DATE IS NULL)
           AND (SYSDATE <= NBRBJOB_END_DATE OR NBRBJOB_END_DATE IS NULL)
           AND x.nbrjobs_status IN ('A', 'L')
--           AND x.NBRJOBS_STATUS != 'T'
           AND x.NBRJOBS_EFFECTIVE_DATE =
		      (SELECT MAX(NBRJOBS_EFFECTIVE_DATE)
                 FROM NBRJOBS
                WHERE NBRJOBS_PIDM = X.NBRJOBS_PIDM
                  AND NBRJOBS_POSN = X.NBRJOBS_POSN
                  AND NBRJOBS_SUFF = X.NBRJOBS_SUFF
                  AND NBRJOBS_EFFECTIVE_DATE <= SYSDATE)
	     ORDER BY decode(nbrbjob_contract_type,'P','0','1'), x.NBRJOBS_EFFECTIVE_DATE
		  )
    LOOP
	  IF employee_department IS NULL THEN
	     employee_department := jobs.nbrjobs_orgn_code_ts;
	  END IF;
    END LOOP;
	RETURN employee_department;
END Get_Employee_Dept;
-----------------------------------------------------------------------
FUNCTION Get_Employee_Type (in_pidm pebempl.pebempl_pidm%type)
  RETURN VARCHAR2 is
-----------------------------------------------------------------------
-- returns employee type code (or null if not an employee)
  employee_type    varchar2(1) := null;
BEGIN
  BEGIN
    SELECT pebempl_egrp_code
	  INTO employee_type
	  FROM pebempl
     WHERE pebempl_pidm = in_pidm
	   AND pebempl_empl_status <> 'T'
       AND pebempl_egrp_code <> 'ST'
	   AND pebempl_ecls_code in ('NE', 'FF', 'AP', 'FP', 'SF', 'SP', 'AF');
    EXCEPTION WHEN OTHERS THEN employee_type := null;
  END;
  RETURN employee_type;
END Get_Employee_Type;
-----------------------------------------------------------------------
FUNCTION Get_Employee_Type2 (in_pidm pebempl.pebempl_pidm%type)
  RETURN VARCHAR2 is
-----------------------------------------------------------------------
--  same as Get_Employee_Type except includes additional 'TO' ecls_code
-- returns employee type code (or null if not an employee)
  employee_type    varchar2(1) := null;
BEGIN
  BEGIN
    SELECT pebempl_egrp_code
	  INTO employee_type
	  FROM pebempl
     WHERE pebempl_pidm = in_pidm
	   AND pebempl_empl_status <> 'T'
       AND pebempl_egrp_code <> 'ST'
	   AND pebempl_ecls_code in ('NE', 'FF', 'AP', 'FP', 'SF', 'SP', 'AF','TO');
    EXCEPTION WHEN OTHERS THEN employee_type := null;
  END;
  RETURN employee_type;
END Get_Employee_Type2;
-----------------------------------------------------------------------
FUNCTION Get_Enrollment_Begin_Date (in_pidm number)
  RETURN DATE IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/2/2006
--  FUNCTION returns start of enrollment date
--  if no term found, RETURN NULL
--  NOTE:  FUNCTION is obsolete -- use banner_util.Get_Enrollment_Begin_date
    start_date         date;
	start_term         stvterm.stvterm_code%type;
BEGIN
    SELECT nvl(min(sgbstdn_term_code_eff), NULL)
      INTO start_term
	  FROM sgbstdn
	 WHERE sgbstdn_pidm = in_pidm;
    IF start_Term IS NULL THEN
	   start_date := NULL;
	ELSE
	   SELECT nvl(stvterm_start_date, NULL)
	     INTO start_date
	     FROM stvterm
		WHERE stvterm_code = start_term;
	END IF;
    RETURN start_date;
END Get_Enrollment_Begin_Date;
-----------------------------------------------------------------------
FUNCTION Get_Enrollment_End_Date (in_pidm number)
  RETURN DATE IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/2/2006
--  FUNCTION returns end of enrollment date
--  if no end term found, RETURN null
    end_date         date;
	end_term         stvterm.stvterm_code%type;
	current_term     stvterm.stvterm_code%type;
BEGIN
    /*
    SELECT nvl(max(sgbstdn_term_code_eff), null)
      INTO end_term
	  FROM sgbstdn
	 WHERE sgbstdn_pidm = in_pidm;
    IF end_Term IS NULL THEN
	   end_date := null;
	ELSE
	   SELECT nvl(stvterm_end_date, null)
	     INTO end_date
	     FROM stvterm
		WHERE stvterm_code = end_term;
	END IF;
	IF end_date IS NOT NULL AND end_date > sysdate THEN
	   end_date := sysdate;
	END IF;
    RETURN end_date;
*/
   return sysdate;
END Get_Enrollment_End_Date;
-----------------------------------------------------------------------
FUNCTION Get_Enrollment_Status
    (in_pidm number, in_term stvterm.stvterm_code%type DEFAULT null)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/19/2006
--  FUNCTION returns latest enrollment status for a student
    enrollment_status  VARCHAR2(25);
    status_term        stvterm.stvterm_code%type;
BEGIN
    IF in_term IS NULL THEN
	   status_term := Get_Current_Term;
	ELSE
       status_term := in_term;
    END IF;
	BEGIN
      select nvl(stvtmst_desc,'Unknown')
--	  SELECT DECODE(SFRTHST_TMST_CODE, 'FT', 'Full Time', 'HT', 'Half Time', 'PT', 'Part Time', 'Unknown')
        INTO enrollment_status
        FROM sfrthst, stvtmst
       WHERE sfrthst_term_code = status_term
         AND sfrthst_pidm = in_pidm
         AND sfrthst_tmst_code = stvtmst_code(+)
         AND sfrthst_activity_date =
           (SELECT max(a.sfrthst_activity_date)
              FROM sfrthst a
              WHERE a.sfrthst_term_code = status_term
                AND a.sfrthst_pidm = in_pidm);
           EXCEPTION
              WHEN OTHERS THEN enrollment_status := 'Not reported.';
    END;
/*  logic changed on 2/21/2008 (eh)
    BEGIN
        SELECT decode(sgbstdn_full_part_ind, 'F', 'Full Time', 'P', 'Part Time', 'Unknown')
          INTO enrollment_status
          FROM sgbstdn
         WHERE sgbstdn_pidm = in_pidm
           AND sgbstdn_term_code_Eff =
              (SELECT max(sgbstdn_term_code_Eff)
                 FROM sgbstdn
                WHERE sgbstdn_pidm = in_pidm
			      AND sgbstdn_term_code_eff <= status_term);
            EXCEPTION
              WHEN OTHERS THEN enrollment_status := 'Not reported.';
    END;
*/
    RETURN enrollment_status;
END Get_Enrollment_Status;
-----------------------------------------------------------------------
FUNCTION Get_Event_Desc (in_evnt_crn slbevnt.slbevnt_crn%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  10/16/2006
--  FUNCTION returns event description name based event_crn
--  input:  event_crn
--  output: returns event_description
  event_desc       slbevnt.slbevnt_desc%type;
BEGIN
    event_desc := NULL;
	BEGIN
	  SELECT slbevnt_desc
        INTO event_desc
	    FROM slbevnt
	   WHERE slbevnt_crn = in_evnt_crn;
      EXCEPTION
	    WHEN OTHERS THEN event_desc := 'Event Not found';
	END;
    RETURN event_desc;
END Get_Event_Desc;
-----------------------------------------------------------------------
FUNCTION Get_GPA (in_pidm shrlgpa.shrlgpa_pidm%type,
                  in_format varchar2 default 'N')
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  return GPA is specified format
-- in_format values:
--   N = original format (shrlgpa_gpa%type)
--  F1 = x.x (rounded)
--  F2 = x.xx (rounded)
--  F3 = x.xxx (rounded)
--  F4 = X.xxxx (rounded)
  gpa_num   shrlgpa.shrlgpa_gpa%type;
  gpa_char  varchar2(40);
BEGIN
  BEGIN
    SELECT shrlgpa_gpa
	  INTO gpa_num
	  FROM shrlgpa
     WHERE shrlgpa_pidm = in_Pidm
	   AND shrlgpa_levl_code = 'UG'
	   AND shrlgpa_gpa_type_ind = 'O';
	   EXCEPTION WHEN OTHERS THEN gpa_char := 'NO GPA';
  END;
  IF gpa_char = 'NO GPA' THEN
     RETURN NULL;
  END IF;
  IF gpa_num IS NULL or gpa_num = 0 THEN
     RETURN NULL;
  END IF;
  IF upper(in_format) = 'N' THEN
     RETURN gpa_num;
  END IF;
  IF upper(in_format) = 'F1' THEN
     gpa_num := gpa_num + .05;
     gpa_char := to_char(gpa_num,'0000000000000000000000.999999999');
     RETURN substr(gpa_char,23,1) || '.' || substr(gpa_char,25,1);
  END IF;
  IF upper(in_format) = 'F2' THEN
     gpa_num := gpa_num + .005;
     gpa_char := to_char(gpa_num,'0000000000000000000000.999999999');
     RETURN substr(gpa_char,23,1) || '.' || substr(gpa_char,25,2);
  END IF;
  IF upper(in_format) = 'F3' THEN
     gpa_num := gpa_num + .0005;
     gpa_char := to_char(gpa_num,'0000000000000000000000.999999999');
     RETURN substr(gpa_char,23,1) || '.' || substr(gpa_char,25,3);
  END IF;
  IF upper(in_format) = 'F4' THEN
     gpa_num := gpa_num + .00005;
     gpa_char := to_char(gpa_num,'0000000000000000000000.999999999');
     RETURN substr(gpa_char,23,1) || '.' || substr(gpa_char,25,4);
  END IF;
END Get_GPA;
-----------------------------------------------------------------------
FUNCTION Get_Housing_Term
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  01/03/2007
--  FUNCTION returns current housing term based on GTVSDAX_INTERNAL_CODE = ZHOUSTERM
    housing_term  stvterm.stvterm_code%type := NULL;
BEGIN
/*  changed 8/7/08 to use SZBWEBR control */
--    SELECT gtvsdax_external_code
--	  INTO housing_Term
--      FROM gtvsdax
--     WHERE gtvsdax_internal_code = 'ZHOUSTERM';
   SELECT trim(szbwebr_control_value)
     INTO housing_term
     FROM szbwebr
	WHERE szbwebr_control_name = 'DIRECTORY_TERM'
	  AND szbwebr_webc_code = 'HOUSING';
--	EXCEPTION WHEN OTHERS THEN housing_term := get_current_Term();
	 RETURN housing_term;
END Get_Housing_Term;
-----------------------------------------------------------------------
FUNCTION Get_ID(in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  09/-1/2006
--  FUNCTION returns id  number for corresponding pidm
--  input:  pidm
--  output: id number  or NULL
out_id     spriden.spriden_id%type;
BEGIN
    out_id := NULL;
    for pidms in
	   (SELECT spriden_id
	      FROM spriden
		 WHERE spriden_pidm = in_pidm
		   and spriden_change_ind IS NULL
		 order by spriden_activity_date)
	loop
        out_id := pidms.spriden_id;
	end loop;
    RETURN out_id;
END Get_ID;
-----------------------------------------------------------------------
--
-----------------------------------------------------------------------
FUNCTION Get_ID_By_SSN(in_ssn VARCHAR2)
RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  Retrieve ID number from SSN
  ssn_pidm       spriden.spriden_pidm%type;
  ssn_id         VARCHAR2(10);
BEGIN
  ssn_pidm := NULL;
  BEGIN
    SELECT spbpers_pidm
	  INTO ssn_pidm
	  FROM spbpers
	 WHERE spbpers_ssn = in_ssn;
	EXCEPTION WHEN OTHERS THEN ssn_pidm := NULL;
  END;
  IF ssn_pidm IS NULL THEN
     ssn_id := NULL;
  ELSE
     ssn_id := Get_ID(ssn_pidm);
  END IF;
  RETURN ssn_id;
END Get_ID_By_SSN;
-----------------------------------------------------------------------
--
-----------------------------------------------------------------------
FUNCTION Get_Interest_Desc
    (interest_code stvints.stvints_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/19/2007
--  FUNCTION returns description of interest code
--  returns interest code if no matching description found
    interest_desc   stvints.stvints_desc%type := NULL;
BEGIN
    BEGIN
	   SELECT stvints_desc
	     INTO interest_desc
		 FROM stvints
		WHERE stvints_code = interest_code;
	   EXCEPTION WHEN OTHERS THEN interest_desc := null;
	END;
    IF interest_Desc IS NULL THEN
       interest_desc := interest_code;
    END IF;
    RETURN interest_desc;
END Get_interest_Desc;
-----------------------------------------------------------------------
FUNCTION Get_Last_Enrolled_Term(in_pidm spriden.spriden_pidm%type,
                                in_term stvterm.stvterm_code%type DEFAULT NULL)
  RETURN VARCHAR2 IS
--  Returns last enrolled term prior to current term or null
-----------------------------------------------------------------------
--  written by Elizabeth  03/06/2007
  term1         stvterm.stvterm_code%type;
  term2         stvterm.stvterm_code%type;
  check_term    stvterm.stvterm_code%type;
  current_term  stvterm.stvterm_code%type;
BEGIN
    current_term := banner_util.get_current_Term;
    IF in_term is null THEN
	   check_term := current_term;
	ELSIF in_term > current_term THEN
	   check_term := current_term;
	ELSE
	   check_term := in_term;
	END IF;
    select
       nvl((select max(SFRSTCR_TERM_CODE)
              from sfrstcr
             where sfrstcr_pidm = in_pidm
			   and SFRSTCR_TERM_CODE < check_term),'000000'),
       nvl((select max(SHRTCKG_TERM_CODE)
              from shrtckg
			 where shrtckg_pidm = in_pidm
               and SHRTCKG_TERM_CODE < check_term),'000000')
	 into term1, term2
     from dual;
	 IF term1 = '000000' and term2 = '000000' THEN
	    RETURN NULL;
	 END IF;
	 IF term1 > term2 THEN
	    RETURN term1;
	 ELSE
	    RETURN term2;
	 END IF;
END Get_Last_Enrolled_Term;
-----------------------------------------------------------------------
FUNCTION Get_Mailing_Address(in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--   returns spraddr_street_line1 for active 'MA' address
  campus_address    varchar2(200);
BEGIN
   campus_address := Get_Address(in_pidm,'MA');
   RETURN campus_address;
END Get_Mailing_Address;
-----------------------------------------------------------------------
--
--
-----------------------------------------------------------------------
FUNCTION Get_Major_Info(in_pidm    spriden.spriden_pidm%type,
					    in_request varchar2 DEFAULT 'M',
						in_lmod    VARCHAR2 DEFAULT NULL,
                        in_lfst    sorlfos.sorlfos_lfst_code%type DEFAULT 'MAJOR',
						in_levl    VARCHAR2 DEFAULT 'UG')
RETURN VARCHAR2
-----------------------------------------------------------------------
--  written by Elizabeth  2/25/2014
--  FUNCTION returns information about the latest priority 1
--           program, college, department, major, minor, or concentration of a student
-----------------------------------------------------------------------
--  lfst_code parameter corresponds to sorlfos_lfst_code ... contains values like MAJOR, MINOR, CONCENTRATION, and EMPHASIS
--
--  in_lmod -- if this is NULL, both ADMISSIONS and LEARNER curriculums will be checked
--             (LEARNER will take precedence over ADMISSIONS)
--          -- if in_lmod is supplied, the exact LMOD will be checked
--
--  Information returned depends on in_request values
--    M = Major, Minor, or Concentration Code
--    D = Department Code
--    C = College Code
--    P = Program Code
--    A = All (formatted as Major(4) || Minor(4) || College(2) || Program(12)
--
-------------------------------------------------------------------------------------------------------------------
IS
    dept_code     sorlfos.sorlfos_dept_code%type;
	majr_code     sorlfos.sorlfos_majr_code%type;
	coll_code     sorlcur.sorlcur_coll_code%type;
	program_code  sorlcur.SORLCUR_PROGRAM%type;
-----------------------------------------------------------------------
BEGIN
    FOR major in
	   (
	    SELECT SOVLCUR_LMOD_CODE,
		       SOVLCUR_SEQNO,
			   sovlfos_majr_code,
			   sovlfos_dept_code,
			   sovlcur_coll_code,
			   SOVLCUR_PROGRAM
		  FROM sovlfos, sovlcur
		 WHERE sovlfos_active_ind = 'Y'
           AND sovlfos_current_ind = 'Y'
		   AND sovlfos_lfst_code = in_lfst
		   and sovlfos_LCUR_SEQNO = sovlcur_seqno
		   AND sovlfos_pidm = sovlcur_pidm
           AND sovlcur_current_ind = 'Y'
           AND sovlcur_active_ind = 'Y'
           AND sovlcur_levl_code = in_levl
		   and SOVLCUR_PRIORITY_NO = 1
		   AND ((in_lmod IS NULL AND SOVLCUR_LMOD_CODE IN ('ADMISSIONS', 'LEARNER'))
		    OR  (in_lmod IS NOT NULL AND SOVLCUR_LMOD_CODE = in_lmod)
			   )
		   AND sovlcur_pidm = in_pidm
	   ORDER BY SOVLCUR_LMOD_CODE DESC, SOVLCUR_SEQNO DESC   -- LEARNER takes priority over ADMISSIONS
	  )
	LOOP
	   program_code := major.SOVLCUR_PROGRAM;
       majr_code    := major.sovlfos_majr_code;
	   dept_code    := major.sovlfos_dept_code;
	   coll_code    := major.sovlcur_coll_code;
       IF upper(in_request) = 'M' THEN
	      RETURN majr_code;
	   END IF;
       IF upper(in_request) = 'D' THEN
          RETURN dept_code;
       END IF;
       IF upper(in_request) = 'C' THEN
          RETURN coll_code;
       END IF;
       IF upper(in_request) = 'P' THEN
          RETURN program_code;
       END IF;
	   IF upper(in_request) = 'A' THEN
	      RETURN rpad(majr_code,4,' ') || rpad(dept_code,4,' ') || rpad(coll_code,2,' ') || rpad(program_code,12,' ');
	   END IF;
    END LOOP;
	RETURN NULL;
END Get_Major_Info;
-----------------------------------------------------------------------
--
--
-----------------------------------------------------------------------
FUNCTION Get_Major
    (pidm number, term_code VARCHAR2, lfst_code VARCHAR2)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
-- THIS FUNCTION IS OBSOLETE.    Use Get_Student_Major(pidm, term_code, lfst_code) instead.
--  written by Elizabeth  05/11/2006
--  FUNCTION returns first major, first  minor, or first concentration of a student
--  lfst_code parameter corresponds to sorlfos_lfst_code ... contains values like MAJOR, MINOR, CONCENTRATION, and EMPHASIS
--  returns 4 character major code (stvmajr validates)
    major_code  sorlfos.sorlfos_majr_code%type := NULL;
BEGIN
    major_code := Get_Student_Major(pidm, term_code, lfst_code);
    RETURN major_code;
END Get_Major;
-----------------------------------------------------------------------
FUNCTION Get_Major_Desc
    (major_code stvmajr.stvmajr_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  01/24/2007
--  FUNCTION returns description of major code
--  returns major code if no matching description found
    major_desc   stvmajr.stvmajr_desc%type := NULL;
BEGIN
    BEGIN
	   SELECT stvmajr_desc
	     INTO major_desc
		 FROM stvmajr
		WHERE stvmajr_code = major_code;
	   EXCEPTION WHEN OTHERS THEN major_desc := null;
	END;
    IF major_Desc IS NULL THEN
       major_desc := major_code;
    END IF;
    RETURN major_desc;
END Get_Major_Desc;
-----------------------------------------------------------------------
FUNCTION Get_Name(in_pidm spriden.spriden_pidm%type,
                  in_format VARCHAR2)
         RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/07/2006
--  FUNCTION returns name based on pidm and format
--  input:  pidm, fomat code
--  output: returns formatted name or NULL
--  formats:
--    LF  = Last, First
--    LFM = Last, First Middle
--    FML = First || Middle || last
--   FL = First || Last
--   F = First only
--   L = Last only
--   M = Middle only
--   FIL = First Initial + Last (ex:  J. Doe)
--   FMLF = First (15) || Middle(15) || last(30)
--   P = Preferred first name
--   N = Nickname
--   IN1 = first initial
--   IN2 = initials (first and last)
--   IN3 = initials (first middle last)
--   PRFX = Name Prefix
--   SUFX = Name Suffix
--       following added by JPB 3/28/16
--   PL = Prefered First || Last
--   PML = Prefered first || Middle || Last
--   LPM = Last, Prefered First Middle
--   LP  = Last, Prefered
formatted_name        VARCHAR2(100);
save_formatted_name   VARCHAR2(100);
pref_name             VARCHAR2(100);
BEGIN
  formatted_name := NULL;
	IF (in_format = 'P' or
      in_format = 'PL' or
      in_format = 'LP' or
      in_format = 'PML' or
      in_format = 'LPM') THEN
	   BEGIN
	     SELECT spbpers_pref_first_name
		   INTO pref_name
		   FROM spbpers
		  WHERE spbpers_pidm = in_pidm;
		  EXCEPTION WHEN OTHERS THEN pref_name := null;
	   END;
  end if;

	IF in_format = 'PRFX' THEN
	   BEGIN
	     SELECT spbpers_name_prefix
		   INTO formatted_name
		   FROM spbpers
		  WHERE spbpers_pidm = in_pidm;
		  EXCEPTION WHEN OTHERS THEN formatted_name := null;
	   END;
	   RETURN formatted_name;
	END IF;
	IF in_format = 'SUFX' THEN
	   BEGIN
	     SELECT spbpers_name_suffix
		   INTO formatted_name
		   FROM spbpers
		  WHERE spbpers_pidm = in_pidm;
		  EXCEPTION WHEN OTHERS THEN formatted_name := null;
	   END;
	   RETURN formatted_name;
	END IF;
  for pidm in
	   (SELECT spriden_last_name,
	           spriden_first_name,
			   spriden_mi
	      FROM spriden
		 WHERE spriden_pidm = in_pidm
		   and spriden_change_ind IS NULL
		 order by spriden_activity_date)
	loop
     IF (in_format = 'P' or
          in_format = 'PL' or
          in_format = 'LP' or
          in_format = 'PML' or
          in_format = 'LPM') and
         (pref_name IS NULL) THEN
         pref_name := trim(pidm.spriden_first_name);
     end if;

     if in_format = 'LF' then
		   formatted_name := trim(pidm.spriden_last_name)
		                  || ', '
						  || trim(pidm.spriden_first_name);
     END IF;
     if in_format = 'LP' then
		   formatted_name := trim(pidm.spriden_last_name)
		                  || ', '
						  || pref_name;
     END IF;

     if in_format = 'LFM' then
		    formatted_name := trim(pidm.spriden_last_name)
		                  || ', '
						  || trim(pidm.spriden_first_name)
						  || ' '
						  || trim(pidm.spriden_mi);
     END IF;

     if in_format = 'LPM' then
		    formatted_name := trim(pidm.spriden_last_name)
		                  || ', '
						  || pref_name
						  || ' '
						  || trim(pidm.spriden_mi);
     END IF;

     if in_format = 'FML' then
		    formatted_name := trim(pidm.spriden_first_name)
		                  || ' '
						  || trim(pidm.spriden_mi)
						  || ' '
						  || trim(pidm.spriden_last_name);
     END IF;
     if in_format = 'PML' then
		    formatted_name := pref_name
		                  || ' '
						  || trim(pidm.spriden_mi)
						  || ' '
						  || trim(pidm.spriden_last_name);
     END IF;

     if in_format = 'FL' then
	      formatted_name := trim(pidm.spriden_first_name)
		                  || ' '
						  || trim(pidm.spriden_last_name);
     END IF;

     if in_format = 'PL' then
	      formatted_name := pref_name
		                  || ' '
						  || trim(pidm.spriden_last_name);
     END IF;

     if in_format = 'FIL' then
        formatted_name := substr(pidm.spriden_first_name,1,1)
		                  || '. '
						  || trim(pidm.spriden_last_name);
     END IF;
     if in_format = 'F'  then
		    formatted_name := trim(pidm.spriden_first_name);
     END IF;
     if in_format = 'P'  then
        formatted_name := pref_name;
--   		   save_formatted_name := trim(pidm.spriden_first_name);
     END IF;
     if in_format = 'L' then
		       formatted_name := trim(pidm.spriden_last_name);
     END IF;
     if in_format = 'M' then
		       formatted_name := trim(pidm.spriden_mi);
     END IF;
     if in_format = 'FMLF' then
	      formatted_name := substr(pidm.spriden_first_name || '               ',1,15)
		                  || substr(pidm.spriden_mi || '               ',1,15)
						  || substr(pidm.spriden_last_name
						  || '                              ',1,30);
     end if;
    IF in_format = 'IN1' then
		   formatted_name := substr(pidm.spriden_first_name,1,1);
		END IF;
        IF in_format = 'IN2' then
		   formatted_name := substr(pidm.spriden_first_name,1,1) || substr(pidm.spriden_mi,1,1);
		END IF;
    IF in_format = 'IN3' then
		   formatted_name := substr(pidm.spriden_first_name,1,1)
		                  || substr(pidm.spriden_mi,1,1)
						  || substr(pidm.spriden_last_name,1,1);
		END IF;
    end loop;
--    IF in_format <> 'N' and in_format <> 'P' THEN
    IF in_format <> 'N' THEN
       RETURN formatted_name;
    END IF;
/*	IF in_format = 'P' THEN
	   BEGIN
	     SELECT spbpers_pref_first_name
		   INTO formatted_name
		   FROM spbpers
		  WHERE spbpers_pidm = in_pidm;
		  EXCEPTION WHEN OTHERS THEN formatted_name := null;
	   END;
	   IF formatted_name is null THEN
          formatted_name := save_formatted_name;
	   END IF;
	   RETURN formatted_name;
	END IF;
*/
	IF in_format = 'N' THEN
	   formatted_name := null;
	   FOR nickname IN
	      (SELECT spriden_first_name
		     FROM spriden
            WHERE spriden_ntyp_code = 'NICK'
              AND spriden_pidm = in_pidm
            ORDER BY spriden_activity_date)
       LOOP
          formatted_name := nickname.spriden_first_name;
       END LOOP;
	   RETURN formatted_name;
	END IF;
END Get_Name;
-----------------------------------------------------------------------
FUNCTION Get_NATN_Desc(in_natn_code stvnatn.stvnatn_code%type)
         RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  09/19/2006
--  FUNCTION returns nation name based on nation code (returns the original nation code if not found)
nation_desc    VARCHAR2(30);
BEGIN
    nation_desc := in_natn_code;
    BEGIN
      SELECT stvnatn_nation
        INTO nation_desc
	    FROM stvnatn
	   WHERE stvnatn_code = in_natn_code;
	  EXCEPTION WHEN OTHERS THEN nation_desc := in_natn_code;
    END;
    RETURN nation_desc;
END Get_NATN_Desc;
-----------------------------------------------------------------------
FUNCTION Get_Next_Term(in_term_code stvterm.stvterm_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  05/29/2006
--  FUNCTION returns term following the parameter term
    next_term  stvterm.stvterm_code%type := NULL;
BEGIN
    SELECT min(stvterm_code)
      INTO next_term
   	  FROM stvterm
     WHERE stvterm_code > in_term_code
	   and substr(stvterm_code,5,1) <> '0';
	 RETURN next_term;
END Get_Next_Term;
---------------------------------------------------------------------------
FUNCTION Get_Office_Ext(in_pidm spriden.spriden_pidm%type default -1)
  RETURN VARCHAR2 IS
---------------------------------------------------------------------------
   --  return office phone extension for specified pidm
   office_ext            sprtele.sprtele_phone_ext%type;
BEGIN
  office_ext := null;
  FOR extensions in
     (SELECT sprtele_phone_ext,
	         decode(sprtele_status_ind, null, 'A', 'N') phone_status
	   FROM sprtele
      WHERE sprtele_pidm = in_pidm
	    AND sprtele_tele_code = 'CO'
	 ORDER BY phone_status desc)
  LOOP
     office_ext := extensions.sprtele_phone_ext;
  END LOOP;
  RETURN trim(office_ext);
END Get_Office_Ext;
---------------------------------------------------------------------------
FUNCTION Get_Office_Info(in_pidm spriden.spriden_pidm%type,
                                 in_type varchar2)
  RETURN VARCHAR2 IS
---------------------------------------------------------------------------
--  Returns employee office information
--  Value returned is based on specified in_type parameter:
--   BNR = building name and room
--   BR  = building code and room
--   B   = building code
--   R   = room
--   BN  = building name
--   E = phone extension
--   ALL = formatted output (building code(6) + building desc( 30) + room(6) + extension (4)
  office_location         spraddr.spraddr_street_line1%type;
  office_building         varchar2(4);
  office_room             varchar2(6);
  building_desc           stvbldg.stvbldg_desc%type;
  office_information      VARCHAR2(100);
BEGIN
   office_information := null;
   IF in_type = 'E' THEN
      office_information := banner_util.Get_Office_Ext(in_pidm);
	  RETURN office_information;
   END IF;
   FOR offices in
     (SELECT spraddr_street_line1,
	         decode(spraddr_status_ind, null, 'A', 'N') office_status
	    FROM stvbldg, spraddr
	   WHERE spraddr_pidm = in_pidm
	     AND spraddr_atyp_code = 'CO'
	     AND to_char(spraddr_from_date, 'yyyymmdd') <= to_char(sysdate, 'yyyymmdd')
   	     AND (spraddr_to_date is null
		  OR to_char(spraddr_to_date, 'yyyymmdd') >= to_char(sysdate, 'yyyymmdd'))
	    ORDER BY office_status desc)
   LOOP
	 office_location := offices.spraddr_street_line1;
	 office_building := null;
	 office_room     := null;
	 BEGIN
	   SELECT dwoffice_building, dwoffice_office, stvbldg_Desc
		 INTO office_building, office_room, building_desc
		 FROM stvbldg, messiah.dwoffice
	    WHERE trim(dwoffice_location) = trim(office_location)
		  AND stvbldg_code(+) = trim(dwoffice_building);
		 EXCEPTION
           WHEN OTHERS THEN
                office_building := null;
                office_room := null;
				building_desc := null;
        END;
      END LOOP;
   IF upper(in_type) = 'BNR' THEN   -- building name and room
      RETURN trim(building_desc) || ' ' || trim(office_room);
   END IF;
   IF upper(in_type) = 'BR' THEN    -- building code and room
      RETURN trim(office_building) || ' ' || trim(office_room);
   END IF;
   IF upper(in_type) = 'B' THEN     -- building code
      RETURN trim(office_building);
   END IF;
   IF upper(in_type) = 'R' THEN     -- room
      RETURN trim(office_room);
   END IF;
   IF upper(in_type) = 'BN' THEN    -- building name
      RETURN trim(building_desc);
   END IF;
   IF upper(in_type) = 'ALL' THEN    -- formatted output (building code(6) + building desc( 30) + room(6) + extension (4)
      RETURN substr(office_building ||'      ', 1,6)
        	  || substr(building_desc || '                              ', 1,30)
              || substr(office_room || '      ', 1,6)
			  || substr(banner_util.Get_Office_Ext(in_pidm) || '    ', 1,4);
   END IF;
END Get_Office_Info;
---------------------------------------------------------------------------
FUNCTION Get_Parent_Pidm(p_pidm number default null)
  RETURN pidm_tab_type IS
---------------------------------------------------------------------------
  -- Function to return parent pidm(s) from APRXREF for a given student pidm
  cursor c_par(p_pidm in number) is
    select aprchld.aprchld_pidm pidm
      from alumni.aprchld
      join saturn.spriden on spriden.spriden_pidm = aprchld.aprchld_pidm
     where aprchld.aprchld_chld_pidm = p_pidm
       and spriden_change_ind is null;                       -- current dependent record
    v_result pidm_tab_type;
BEGIN
    if p_pidm is not null then
      for parrec in c_par(p_pidm) loop
        v_result(v_result.count) := parrec.pidm;
      end loop;
    end if;
    return(v_result);
END Get_Parent_Pidm;
-----------------------------------------------------------------------
FUNCTION Get_Phone(in_pidm sprtele.sprtele_pidm%type,
                   in_atyp_code sprtele.sprtele_atyp_code%type,
                   in_format varchar2,
				           in_tele_code sprtele.sprtele_tele_code%type default 'MA')
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  returns telephone associated with a mailing address and telephone type
--  in_format values
--    A = Area Code Only
--    P = Phone Only
--    E = Extension Only
--   AP = area(3) || phone(7)
--    APE =   area(3) || phone(7) || extension(4)
--    IAPE =   intl(16) || area(3) || phone(7) || extension(4)
--    FAP = Formatted area and phone only (xxx-xxx-xxxx)
--    FAPE = Formatted  with extension (xxx-xxx-xxxx  Ext. .xxxx)
  out_phone         varchar2(50);
  sprtele_rec       sprtele%rowtype;
BEGIN
   out_phone := 'XXXX';
   BEGIN
     SELECT *
	   INTO sprtele_rec
       FROM sprtele
      WHERE sprtele_pidm = in_pidm
        AND (in_atyp_code is null or sprtele_atyp_code = in_atyp_code)
		AND sprtele_tele_code = in_tele_code
        AND sprtele_status_ind IS NULL
      ORDER BY nvl(sprtele_status_ind,'A'), decode(sprtele_tele_code, in_atyp_code, 0, 1);
	  EXCEPTION WHEN OTHERS THEN out_phone := null;
   END;
   sprtele_rec.sprtele_phone_number := replace(sprtele_rec.sprtele_phone_number,'-');
   IF out_phone is null THEN
      RETURN null;
   END IF;
   IF upper(in_format) = 'A' THEN
      RETURN sprtele_rec.sprtele_phone_area;
   END IF;
   IF upper(in_format) = 'P' THEN
      RETURN sprtele_rec.sprtele_phone_number;
   END IF;
   IF upper(in_format) = 'E' THEN
      RETURN sprtele_rec.sprtele_phone_ext;
   END IF;
   IF upper(in_format) = 'AP' THEN
      out_phone := substr(sprtele_rec.sprtele_phone_area || '   ',1,3)
	            || substr(sprtele_Rec.sprtele_phone_number || '          ',1,10);
      RETURN out_phone;
   END IF;
   IF upper(in_format) = 'APE' THEN
      out_phone := substr(sprtele_rec.sprtele_phone_area || '   ',1,3)
	            || substr(sprtele_Rec.sprtele_phone_number || '          ',1,10)
	            || substr(sprtele_Rec.sprtele_phone_ext || '    ',1,4);
      RETURN out_phone;
   END IF;
   IF upper(in_format) = 'IAPE' THEN
      out_phone := substr(sprtele_rec.sprtele_intl_access || '                ',1,16)
	            || substr(sprtele_rec.sprtele_phone_area || '   ',1,3)
	            || substr(sprtele_Rec.sprtele_phone_number || '          ',1,10)
	            || substr(sprtele_Rec.sprtele_phone_ext || '    ',1,4);
      RETURN out_phone;
   END IF;
   IF upper(in_format) = 'FAP' THEN
      out_phone := null;
      IF sprtele_rec.sprtele_phone_area IS NOT NULL THEN
         out_phone := trim(sprtele_rec.sprtele_phone_area) || '-';
	  END IF;
      out_phone := out_phone
	            || substr(sprtele_rec.sprtele_phone_number,1,3) || '-'
	            || substr(sprtele_Rec.sprtele_phone_number,4,4);
      RETURN out_phone;
   END IF;
   IF upper(in_format) = 'FAPE' THEN
      out_phone := null;
      IF sprtele_rec.sprtele_phone_area IS NOT NULL THEN
         out_phone := trim(sprtele_rec.sprtele_phone_area) || '-';
	  END IF;
      out_phone := out_phone
	            || substr(sprtele_rec.sprtele_phone_number,1,3) || '-'
	            || substr(sprtele_Rec.sprtele_phone_number,4,4);
	  IF sprtele_rec.sprtele_phone_ext IS NOT NULL THEN
         out_phone := out_phone || ' Ext. ' || sprtele_rec.sprtele_phone_ext;
      END IF;
      RETURN out_phone;
   END IF;
   RETURN null;
END Get_Phone;
-----------------------------------------------------------------------
FUNCTION Get_Pidm(in_id spriden.spriden_id%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/12/2006
--  FUNCTION returns pidm for corresponding id number
--  input:  id number
--  output: pidm or NULL
out_pidm     spriden.spriden_pidm%type;
BEGIN
    out_pidm := NULL;
    for pidms in
	   (SELECT spriden_pidm
	      FROM spriden
		 WHERE spriden_id = trim(in_id)
		   and spriden_change_ind IS NULL
		 order by spriden_activity_date)
	loop
        out_pidm := pidms.spriden_pidm;
	end loop;
    RETURN out_pidm;
END Get_Pidm;
-----------------------------------------------------------------------
FUNCTION Get_Pidm_By_Login(in_external_user gobtpac.gobtpac_external_user%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  2/5/2007
--  FUNCTION returns pidm for corresponding external_user (network login)
out_pidm     spriden.spriden_pidm%type;
BEGIN
    out_pidm := NULL;
	BEGIN
	   SELECT gobtpac_pidm
	     INTO out_pidm
	     FROM gobtpac
		WHERE upper(gobtpac_external_user) = upper(in_external_user);
         EXCEPTION WHEN OTHERS THEN out_pidm := null;
	END;
    RETURN out_pidm;
END Get_Pidm_By_Login;
-----------------------------------------------------------------------
FUNCTION Get_Pidm_By_SSN(in_SSN IN VARCHAR2)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  6/20/2011
--  FUNCTION returns pidm for corresponding ssn
out_pidm     spriden.spriden_pidm%type;
BEGIN
    out_pidm := NULL;
	BEGIN
	   SELECT spbpers_pidm
	     INTO out_pidm
	     FROM spbpers
		WHERE spbpers_ssn = in_ssn;
         EXCEPTION WHEN OTHERS THEN out_pidm := null;
	END;
    RETURN out_pidm;
END Get_Pidm_By_SSN;
-----------------------------------------------------------------------
FUNCTION Get_Pin(in_id spriden.spriden_id%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  11/02/2006
--  get ssb id / pin based on an ID number
    out_string          VARCHAR2(2000);
	in_pidm             spriden.spriden_pidm%type;
BEGIN
    in_pidm := Get_Pidm(in_id);
    out_string := Get_Pin(in_pidm);
	RETURN out_string;
END Get_Pin;
-----------------------------------------------------------------------
FUNCTION Get_Pin(in_last_name spriden.spriden_last_name%type,
                 in_first_name spriden.spriden_first_name%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  11/02/2006
-- Returns a list of one or more SSB ID, Pin, and Name strings if last name or first name (or partial) are known
-- NOTE:  You must enter both last name and first name parameters to distinguish this FUNCTION from
--              the Get_Pin(in_id spriden.spriden_id%type) function.
--  Enter NULL as a parameter for either last or first name if they are unknown
--  Parial names can be entered ... they do not need to end with % but it won't hurt ... you must enter the starting character(s)
--  Examples:
--  SELECT banner_util.get_pin('Hoov',NULL) FROM dual (gets list of all names starting with 'Hoov' which have a SSB pin)
--  SELECT banner_util.get_pin(NULL, 'Elizabeth') FROM dual (gets list of all names staring with 'Elizabeth' which have a SSB pin)
    out_string          VARCHAR2(2000);
BEGIN
    IF in_last_name IS NULL and in_first_name IS NULL THEN
       RETURN 'You must enter a full or partial last name or first name (last, first)';
	ELSE
       FOR ids in
		   (
     	   SELECT spriden_id || ' ' || trim(to_char(gobtpac_pin)) || ' ('
	             || trim(spriden_last_name) || ', ' || trim(spriden_first_name)
				 || ' ' || trim(spriden_mi) || ')'  id_info
	         FROM gobtpac, spriden
            WHERE LOWER (spriden_last_name) LIKE LOWER(trim(in_last_name)) || '%'
              AND (in_first_name IS NULL
 		       OR LOWER (spriden_first_name) LIKE LOWER(trim(in_first_name)) || '%')
		      AND spriden_change_ind IS NULL
              AND gobtpac_pidm = spriden_pidm
			ORDER BY spriden_last_name, spriden_first_name, spriden_id
		    )
       LOOP
	      out_string := out_string || ids.id_info || chr(10);
		  IF length(out_string) > 1800 THEN
	         out_string := out_string || '** Output limit reached -- list may not be complete. **' || chr(10);
		     EXIT;
		  END IF;
	   END LOOP;
    END IF;
   RETURN out_string;
END Get_Pin;
-----------------------------------------------------------------------
FUNCTION Get_Pin(in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  11/02/2006
--  get ssb id / pin based on an PIDM
    out_string          VARCHAR2(2000);
BEGIN
      BEGIN
	       SELECT max(spriden_id || ' ' || trim(to_char(gobtpac_pin)) || ' ('
	             || trim(spriden_last_name) || ', ' || trim(spriden_first_name)
				 || ' ' || trim(spriden_mi) || ')')
             INTO out_string
	         FROM gobtpac, spriden
            WHERE spriden_pidm = in_pidm
			  AND spriden_change_ind IS NULL
			  AND gobtpac_pidm = spriden_pidm;
	        EXCEPTION WHEN OTHERS THEN RETURN 'No matching ID/pin information found';
       END;
	RETURN out_string;
END Get_Pin;
-----------------------------------------------------------------------
FUNCTION Get_Previous_Term(in_term_code stvterm.stvterm_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  05/29/2006
--  FUNCTION returns term previous to the parameter term
    previous_term  stvterm.stvterm_code%type := NULL;
BEGIN
    SELECT max(stvterm_code)
      INTO previous_term
   	  FROM stvterm
     WHERE stvterm_code < in_term_code
      and substr(stvterm_code,5,1) <> '0';
	 RETURN previous_term;
END Get_Previous_Term;
-----------------------------------------------------------------------
FUNCTION Get_Primary_Advisor(in_pidm sgradvr.sgradvr_pidm%type,
                             in_term sgradvr.sgradvr_term_code_eff%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/12/2006
--  FUNCTION returns pidm of student's primary advisor
advisor_pidm         number;
BEGIN
    advisor_pidm := NULL;
    FOR advisor in
	   (
        SELECT sgradvr_advr_pidm
     	  FROM sgradvr
         WHERE sgradvr_pidm = in_pidm
		   AND sgradvr_prim_ind = 'Y'
           AND sgradvr_term_code_eff =
              (SELECT MAX (sgradvr_term_code_eff)
                 FROM sgradvr b
                WHERE b.sgradvr_pidm = in_pidm
                  AND b.sgradvr_term_code_eff <= in_term)
       )
    LOOP
	    advisor_pidm := advisor.sgradvr_advr_pidm;
    END LOOP;
	RETURN advisor_pidm;
END Get_Primary_Advisor;
---------------------------------------------------------------------------
FUNCTION Get_Sport(in_pidm sgrsprt.sgrsprt_pidm%type,
                   in_term sgrsprt.sgrsprt_term_code%type,
				   in_return_type varchar2)
  RETURN varchar2 IS
  -- Function returns sport team or description for a particular term
  -- in_return_type:   C = Team Code
  --                               D = Team Description
  CURSOR c_sport(in_pidm sgrsprt.sgrsprt_pidm%type,
                 in_term sgrsprt.sgrsprt_term_code%type) is
    SELECT sgrsprt_actc_code, stvactc_desc
      FROM stvactc, sgrsprt
     WHERE sgrsprt_pidm = in_pidm
	   AND sgrsprt_term_code = in_term
       AND stvactc_code(+) = sgrsprt_actc_code
	 ORDER BY decode(SGRSPRT_ELIG_CODE,null,'EL','EL','EL','IN');
  c_sport_rec   c_sport%rowtype;
BEGIN
    OPEN c_sport(in_pidm, in_term);
    FETCH c_sport into c_sport_rec;
    IF c_sport%NOTFOUND
  THEN
    CLOSE c_sport;
    RETURN null;
  ELSE
    CLOSE c_sport;
	IF in_return_type = 'C' THEN
       RETURN c_sport_rec.sgrsprt_actc_code;
	ELSE
       IF c_sport_rec.stvactc_desc IS NOT NULL THEN
          RETURN c_sport_rec.stvactc_desc;
       ELSE
          RETURN c_sport_rec.sgrsprt_actc_code;
	   END IF;
    END IF;
  END IF;
END Get_Sport;
---------------------------------------------------------------------------
---------------------------------------------------------------------------
FUNCTION Get_Spouse_Pidm(p_pidm number default null)
  RETURN number IS
---------------------------------------------------------------------------
  -- Function to return spouse's pidm from aprcsps for a given pidm
  cursor c_spouse(p_pidm in number) is
    select aprcsps.aprcsps_sps_pidm pidm
      from alumni.aprcsps
      join saturn.spbpers on spbpers.spbpers_pidm = aprcsps.aprcsps_sps_pidm
      join saturn.spriden on spriden.spriden_pidm = aprcsps.aprcsps_sps_pidm
     where aprcsps.aprcsps_pidm = p_pidm
       and spriden_change_ind is null                       -- current spouse record
       and alumni.aprcsps.aprcsps_mars_ind = 'A';
    v_result number := null;
BEGIN
    if p_pidm is not null then
      open c_spouse(p_pidm);
      fetch c_spouse into v_result;
      close c_spouse;
    end if;
    return(v_result);
END Get_Spouse_Pidm;
-----------------------------------------------------------------------
FUNCTION Get_Student_Class(pidm number, term_code VARCHAR2 DEFAULT NULL)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  05/23/2006
--  FUNCTION returns student class level
--  NOTE:  In order to compile this function, I had to grant execute access to user messiah
-- (grant execute on baninst1.soklibs to messiah)
    stu_class_code     stvclas.stvclas_code%type;
    clas_desc          stvclas.stvclas_desc%type;
    class_term         stvterm.stvterm_code%type;
    class_level        SGBSTDN.SGBSTDN_LEVL_CODE%type;
BEGIN
    class_level := get_student_level(pidm,term_code);
    IF term_code IS NULL THEN
	   class_term := Get_Current_Term;
	ELSE
       class_term := term_code;
    END IF;
     soklibs.p_class_calc(pidm,
                          class_level, --'UG',
                          class_term,
                          '',
                          stu_class_code,
                          clas_desc);
	 RETURN stu_class_code;
END Get_Student_Class;
-----------------------------------------------------------------------
FUNCTION Get_Student_Class_Desc(pidm number, term_code VARCHAR2 DEFAULT NULL)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  05/23/2006
--  FUNCTION returns student class level
--  NOTE:  In order to compile this function, I had to grant execute access to user messiah
-- (grant execute on baninst1.soklibs to messiah)
    stu_class_code     stvclas.stvclas_code%type;
    clas_desc          stvclas.stvclas_desc%type;
    class_term         stvterm.stvterm_code%type;
    class_level        SGBSTDN.SGBSTDN_LEVL_CODE%type;
BEGIN
    class_level := get_student_level(pidm,term_code);
    IF term_code IS NULL THEN
	   class_term := Get_Current_Term;
	ELSE
       class_term := term_code;
    END IF;
     soklibs.p_class_calc(pidm,
                          class_level,   --'UG',
                          class_term,
                          '',
                          stu_class_code,
                          clas_desc);
	 RETURN clas_desc;
END Get_Student_Class_Desc;
-----------------------------------------------------------------------
FUNCTION Get_Student_Coll(in_pidm spriden.spriden_pidm%type,
                          in_term stvterm.stvterm_code%type,
						  in_lfst sorlfos.sorlfos_lfst_code%type,
						  in_level  IN VARCHAR2 DEFAULT 'UG')
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  1/31/2007
--  FUNCTION returns college code of first major, first  minor, or first concentration of a student
--  lfst_code parameter corresponds to sorlfos_lfst_code ... contains values like MAJOR, MINOR, CONCENTRATION, and EMPHASIS
--  returns 4 character department code (stvdept validates)
    coll_code  sorlcur.sorlcur_coll_code%type := NULL;
BEGIN
    coll_code := banner_util.Get_Student_Major_Info(in_pidm, in_term, in_lfst, 'C', in_level);
    RETURN coll_code;
END Get_Student_Coll;
-----------------------------------------------------------------------
FUNCTION Get_Student_Dept(in_pidm spriden.spriden_pidm%type,
                          in_term stvterm.stvterm_code%type,
						  in_lfst sorlfos.sorlfos_lfst_code%type,
						  in_level IN VARCHAR2 DEFAULT 'UG')
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  1/31/2007
--  FUNCTION returns department code of first major, first  minor, or first concentration of a student
--  lfst_code parameter corresponds to sorlfos_lfst_code ... contains values like MAJOR, MINOR, CONCENTRATION, and EMPHASIS
--  returns 4 character department code (stvdept validates)
    dept_code  sorlfos.sorlfos_dept_code%type := NULL;
BEGIN
    dept_code := banner_util.Get_Student_Major_Info(in_pidm, in_term, in_lfst, 'D', in_level);
    RETURN dept_code;
END Get_Student_Dept;
-----------------------------------------------------------------------
FUNCTION Get_Student_Level(pidm number, term_code VARCHAR2 DEFAULT NULL)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  04/19/2010
--  FUNCTION returns student level (i.e., UG, GR, etc.)
    level_term    VARCHAR2(6);
	level_code    SGBSTDN.SGBSTDN_LEVL_CODE%type := 'UG';
BEGIN
    IF term_code IS NULL THEN
	   level_term  := Get_Current_Term;
	ELSE
       level_term  := term_code;
    END IF;
	BEGIN
	   SELECT SGBSTDN_LEVL_CODE
	     INTO level_code
		 FROM SGBSTDN
		WHERE SGBSTDN_TERM_CODE_EFF =
		     (SELECT max(SGBSTDN_TERM_CODE_EFF)
			    FROM SGBSTDN
			   WHERE SGBSTDN_PIDM = pidm
			     AND SGBSTDN_TERM_CODE_EFF <= level_term)
		  AND SGBSTDN_PIDM = pidm;
	   EXCEPTION WHEN OTHERS THEN level_code := 'UG';
	END;
	IF level_code IS NULL THEN
	   level_code := 'UG';
	END IF;

	RETURN level_code;
END Get_Student_Level;
-----------------------------------------------------------------------
FUNCTION Get_Student_Major
    (pidm number, term_code VARCHAR2, lfst_code VARCHAR2, in_level VARCHAR2 DEFAULT 'UG')
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  01/24/2007
--  FUNCTION returns code of first major, first  minor, or first concentration of a student
--  lfst_code parameter corresponds to sorlfos_lfst_code ... contains values like MAJOR, MINOR, CONCENTRATION, and EMPHASIS
    major_code  sorlfos.sorlfos_majr_code%type := NULL;
BEGIN
    major_code := Get_Student_Major_Info(pidm, term_code, lfst_code, 'M', in_level);
	RETURN major_code;
END Get_Student_Major;
-----------------------------------------------------------------------
FUNCTION Get_Student_Major_Desc
    (pidm number, term_code VARCHAR2, lfst_code VARCHAR2, in_level VARCHAR2 DEFAULT 'UG')
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  01/24/2007
--  FUNCTION returns description first major, first  minor, or first concentration of a student
--  lfst_code parameter corresponds to sorlfos_lfst_code ... contains values like MAJOR, MINOR, CONCENTRATION, and EMPHASIS
    major_code  sorlfos.sorlfos_majr_code%type := NULL;
    major_desc  stvmajr.stvmajr_desc%type := NULL;
BEGIN
    major_code := Get_Student_Major_Info(pidm, term_code, lfst_code, 'M', in_level);
    major_desc := Get_Major_Desc(major_code);
	RETURN major_desc;
END Get_Student_Major_Desc;
-----------------------------------------------------------------------
FUNCTION Get_Student_Major_Info(in_pidm spriden.spriden_pidm%type,
                                in_term stvterm.stvterm_code%type,
		                        in_lfst sorlfos.sorlfos_lfst_code%type,
							    in_request varchar2,
								in_level   IN VARCHAR2 DEFAULT 'UG')
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  1/30/2007
--  FUNCTION returns information about the first major, first  minor, or first concentration of a student
--  lfst_code parameter corresponds to sorlfos_lfst_code ... contains values like MAJOR, MINOR, CONCENTRATION, and EMPHASIS
--  inforamtion returned depends on in_request values (codes returned depend on the in_lfst parameter also):
--    M = Major, Minor, or Concentration Code
--    D = Department Code
--    C = College Code
--    A = All (formatted as Major(4) || Minor(4) || College(2)
    dept_code  sorlfos.sorlfos_dept_code%type;
	majr_code  sorlfos.sorlfos_majr_code%type;
	coll_code  sorlcur.sorlcur_coll_code%type;
  in_req varchar2(1);
--- code was modified on 1/16/2008 by Elizabeth to always return the latest major, minor, or concentration
--  term parameter is ignored
  cursor major_cur is
	    SELECT sovlfos_majr_code, sovlfos_dept_code, sovlcur_coll_code
      FROM sovlfos, sovlcur
		  WHERE sovlcur_pidm = in_pidm
           AND sovlcur_levl_code = in_level
           and SOVLCUR_LMOD_CODE in ('LEARNER','ADMISSIONS')
           AND sovlcur_current_ind = 'Y'
           AND sovlcur_active_ind = 'Y'
     		   and SOVLCUR_PRIORITY_NO = 1
		       and sovlfos_pidm = sovlcur_pidm
		       and sovlfos_LCUR_SEQNO = sovlcur_seqno
		       AND sovlfos_lfst_code = 'MAJOR'
           AND sovlfos_active_ind = 'Y'
           AND sovlfos_current_ind = 'Y'
	   ORDER BY sovlcur_lmod_code desc, sovlcur_seqno desc;
     major_rec major_cur%rowtype;
BEGIN
   in_req := substr(upper(in_request),1,1);
--  code prior to 1/16/2008
/*
    FOR major in
	   (
	    SELECT sorlfos_majr_code, sorlfos_dept_code, sovlcur_coll_code
		  FROM sorlfos, sovlcur a
		 WHERE a.sovlcur_pidm = in_pidm
		   and a.SOVLCUR_LMOD_CODE = 'LEARNER'
		   and a.SOVLCUR_CACT_CODE = 'ACTIVE'
		   and a.SOVLCUR_PRIORITY_NO = 1
		   AND a.sovlcur_term_code >=
		      (SELECT max(sovlcur_term_code)
			     FROM sovlcur
				WHERE sovlcur_pidm = in_pidm
                  AND sovlcur_term_code <= in_term
                  AND SOVLCUR_LMOD_CODE = 'LEARNER'
                  AND SOVLCUR_CACT_CODE = 'ACTIVE'
				  AND SOVLCUR_PRIORITY_NO = 1)
		   and sorlfos_pidm = a.sovlcur_pidm
		   and SORLFOS_LCUR_SEQNO = sovlcur_seqno
		   AND sorlfos_lfst_code = in_lfst
		   AND sorlfos_cact_code = 'ACTIVE'
       ORDER BY a.sovlcur_seqno desc
	    )
*/
--  end of code prior to 1/16/2008
    OPEN major_cur;
    FETCH major_cur INTO major_rec;
    IF major_cur%NOTFOUND
    THEN
        major_rec := NULL;
    end if;
    CLOSE major_cur;
/*    FOR major in
	   (
	    SELECT sovlfos_majr_code, sovlfos_dept_code, sovlcur_coll_code
		  FROM sovlfos, sovlcur
		 WHERE sovlcur_pidm = in_pidm
           AND sovlcur_levl_code = in_level
		   and (SOVLCUR_LMOD_CODE = 'LEARNER' or SOVLCUR_LMOD_CODE = 'ADMISSIONS')
           AND sovlcur_current_ind = 'Y'
           AND sovlcur_active_ind = 'Y'
		   and SOVLCUR_PRIORITY_NO = 1
		   and sovlfos_pidm = sovlcur_pidm
		   and sovlfos_LCUR_SEQNO = sovlcur_seqno
		   AND sovlfos_lfst_code = 'MAJOR'
           AND sovlfos_active_ind = 'Y'
           AND sovlfos_current_ind = 'Y'
	   ORDER BY sovlcur_seqno desc
	  )
		LOOP
       majr_code := major.sovlfos_majr_code;
	   dept_code := major.sovlfos_dept_code;
	   coll_code := major.sovlcur_coll_code;
    END LOOP;
*/
    IF in_req = 'M' THEN
	   RETURN major_rec.sovlfos_majr_code;
	  elsif in_req = 'D' THEN
       RETURN major_rec.sovlfos_dept_code;
    elsif in_req = 'C' then
       RETURN major_rec.sovlcur_coll_COde;
    elsif in_req = 'A' THEN
       RETURN rpad(major_rec.sovlfos_majr_code,4,' ') ||
              rpad(major_rec.sovlfos_dept_code,4,' ') ||
              rpad(major_rec.sovlcur_coll_COde,2,' ');
    else
       return NULL;
    END IF;
END Get_Student_Major_Info;
-----------------------------------------------------------------------
FUNCTION Get_Term_Desc(in_term stvterm.stvterm_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  09/19/2006
--  FUNCTION returns term description
--  input:  term code
--  output: term code description or 'Invalid Term'
term_desc    VARCHAR2(30);
BEGIN
    term_desc := 'Invalid Term';
    for term in
       (
        SELECT stvterm_desc
          FROM stvterm
		 WHERE stvterm_code = in_term
        )
	loop
 	    term_desc := term.stvterm_desc;
	end loop;
    RETURN term_desc;
END Get_Term_Desc;
-----------------------------------------------------------------------
FUNCTION Get_Term_End(in_term stvterm.stvterm_code%type)
  RETURN DATE IS
-----------------------------------------------------------------------
--  written by Elizabeth  03/6/2007
--  FUNCTION returns term end date
--  input:  term code
--  output: term ending date or null
term_end    date;
BEGIN
    term_end := NULL;
	BEGIN
        SELECT STVTERM_END_DATE
          INTO term_end
          FROM stvterm
		 WHERE stvterm_code = in_term;
		 EXCEPTION WHEN OTHERS THEN term_end := null;
	END;
    RETURN term_end;
END Get_Term_End;
-----------------------------------------------------------------------
FUNCTION Get_Term_Start(in_term stvterm.stvterm_code%type)
  RETURN DATE IS
-----------------------------------------------------------------------
--  written by Elizabeth  03/6/2007
--  FUNCTION returns term starting date
--  input:  term code
--  output: term code description or null
term_start    date;
BEGIN
    term_start := NULL;
	BEGIN
        SELECT STVTERM_START_DATE
          INTO term_start
          FROM stvterm
		 WHERE stvterm_code = in_term;
		 EXCEPTION WHEN OTHERS THEN term_start := null;
	END;
    RETURN term_start;
END Get_Term_Start;
-----------------------------------------------------------------------
FUNCTION Get_UserID(in_id spriden.spriden_id%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth 10/27/2006
--  FUNCTION returns external userid for corresponding ID number
out_id     gobtpac.GOBTPAC_EXTERNAL_USER%type;
in_pidm    spriden.spriden_pidm%type;
begin
    out_id := NULL;
	in_pidm := Get_Pidm(in_id);
	out_id := Get_UserID(in_pidm);
    RETURN out_id;
END Get_UserID;
-----------------------------------------------------------------------
FUNCTION Get_UserID(in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth 10/27/2006
--  FUNCTION returns external userid for corresponding pidm
out_id     gobtpac.GOBTPAC_EXTERNAL_USER%type;
BEGIN
    out_id := NULL;
	BEGIN
      SELECT gobtpac_external_user
	    INTO out_id
        FROM gobtpac
	   WHERE gobtpac_pidm = in_pidm;
	   EXCEPTION WHEN OTHERS THEN out_id := NULL;
	END;
    RETURN out_id;
END Get_UserID;
-----------------------------------------------------------------------
FUNCTION Get_business_fiscal_year(date_in in date default null)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Robert Getty 08/16/2007
--  updated: added date_in parameter
--  FUNCTION returns business fiscal year for date passed in or current (as opposed to academic fiscal)
  bus_fiscal_year varchar2(4);
begin
  select case when to_char(trunc(nvl(date_in,sysdate)),'MM') > 6 -- last month of fiscal year
              then to_char(to_char(trunc(nvl(date_in,sysdate)),'YYYY') + 1)
              else to_char(trunc(nvl(date_in,sysdate)),'YYYY')
              end
    into bus_fiscal_year
    from dual;
  return bus_fiscal_year;
end Get_business_fiscal_year;
-----------------------------------------------------------------------
FUNCTION File_Open(file_location VARCHAR2,
                   file_name VARCHAR2,
                   open_type VARCHAR2,
                   buffer_length binary_integer)
   RETURN UTL_FILE.FILE_TYPE IS
-----------------------------------------------------------------------
  BEGIN
  --  Open_type:  'r' = read, 'w' = write
    RETURN UTL_FILE.FOPEN(file_location,
                          file_name,
						  open_type,
						  buffer_length);
    EXCEPTION
       WHEN utl_file.invalid_path THEN
            RAISE_APPLICATION_ERROR(-20001, 'INVALID PATH');
       WHEN utl_file.invalid_mode THEN
            RAISE_APPLICATION_ERROR(-20001, 'INVALID MODE');
       WHEN utl_file.invalid_filehandle THEN
            RAISE_APPLICATION_ERROR(-20001, 'INVALID HANDLE');
       WHEN utl_file.invalid_operation THEN
            RAISE_APPLICATION_ERROR(-20001, 'INVALID OPERATION');
       WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, 'OTHER ERROR');
  END File_Open;
-----------------------------------------------------------------------
FUNCTION File_Read(input_handle UTL_FILE.FILE_TYPE)
         RETURN VARCHAR2 IS
-----------------------------------------------------------------------
  data_buffer    VARCHAR2(32000);
  BEGIN
    BEGIN
       UTL_FILE.GET_LINE(input_handle, data_buffer);
       EXCEPTION
          WHEN NO_DATA_FOUND THEN
               RETURN 'EOF';
          WHEN OTHERS THEN
               RAISE_APPLICATION_ERROR(-20001, 'OTHER UTL_FILE ERROR');
               RETURN 'READ ERROR';
    END;
	RETURN data_buffer;
  END File_Read;
-----------------------------------------------------------------------
FUNCTION Is_An_Employee (in_pidm pebempl.pebempl_pidm%type)
  RETURN VARCHAR2 is
-----------------------------------------------------------------------
-- returns 'Y' (if employee) or null
  employee_flag    varchar2(1) := 'N';
BEGIN
  BEGIN
    SELECT MAX('Y')
	  INTO employee_flag
	  FROM pebempl
     WHERE pebempl_pidm = in_pidm
--	   AND pebempl_empl_status = 'A'
	   AND pebempl_empl_status <> 'T'   -- changed 11/5/10 by EAH to match dwemployee check
       AND pebempl_egrp_code <> 'ST'
	   AND pebempl_ecls_code in ('NE', 'FF', 'AP', 'FP', 'SF', 'SP', 'AF', 'TL', 'FE' );
    EXCEPTION WHEN OTHERS THEN employee_flag := 'N';
  END;
  RETURN employee_Flag;
END Is_An_Employee;
-----------------------------------------------------------------------
FUNCTION Is_Alumni (pidm IN NUMBER)
    RETURN VARCHAR2 IS
------------------------------------------------------------------------
  s_ctr number(8);
BEGIN
  BEGIN
    SELECT count(*) INTO s_ctr
    FROM atvdonr, aprcatg
    WHERE atvdonr_alum_ind = 'Y'
      AND atvdonr_code = aprcatg_donr_code
      AND aprcatg_pidm = pidm;
    EXCEPTION
       WHEN OTHERS THEN s_ctr:= null;
    END;
--
    IF s_ctr > 0 then
       RETURN 'Y';
    ELSE
       RETURN null;
    END IF;
  END Is_Alumni;
-----------------------------------------------------------------------
/* IS_ALUMNI
   DATE    : 19MAY06
   AUTHOR  : Jonathan Wheat (jwheat)
   PURPOSE : Determine whether a PIDM is a alumni.
   USAGE   : is_alumni(pidm)
   EXAMPLE : is_alumni(344450)
   ACTIONS : takes a PIDM and looks up the code from DWH - DWID table
             whether they are an alumni.
   INPUT   : PIDM  (ie. 123456)
   OUTPUT  : No screen output
   RETURNS : Currently returns -
              Y - yes the pidm is an alumni
           NULL - no, the pidm is not an alumni

OLD VERSION 
CURSOR chk_alu (pidm IN number) IS
  select 'Y'
  from dwID@dwh
  where dwid_pidm = pidm
  and dwid_alumni_flag = 'Y';
return_value CHAR;
BEGIN
  OPEN chk_alu (pidm);
  FETCH chk_alu INTO return_value;
  IF chk_alu%NOTFOUND
  THEN
      CLOSE chk_alu;
      RETURN NULL;
  ELSE
      CLOSE chk_alu;
      RETURN return_value;
  END IF;
END Is_Alumni; */
-----------------------------------------------------------------------
FUNCTION Is_An_Alum (in_pidm IN aprcatg.aprcatg_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  Returns 'Y' if an alum or null
-----------------------------------------------------------------------
--  written by Elizabeth 2/07/2007
    alumni_flag   varchar2(1) := 'N';
BEGIN
  BEGIN
    SELECT max('Y')
	  INTO alumni_flag
	  FROM aprcatg
	 WHERE aprcatg_pidm = in_pidm
	   AND aprcatg_donr_code IN ('ALUM', 'ALND', 'ALGR');
    EXCEPTION WHEN OTHERS THEN alumni_flag := 'N';
  END;
  RETURN alumni_flag;
END Is_An_Alum;
-----------------------------------------------------------------------
FUNCTION Is_A_Current_Parent (in_pidm IN aprcatg.aprcatg_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  Returns 'Y' if an parent or null
-----------------------------------------------------------------------
--  written by John.... copied from Elizabeth 11/11/2010
    current_parent_flag   varchar2(1) := 'N';
BEGIN
  BEGIN
    SELECT max('Y')
	  INTO current_parent_flag
	  FROM aprcatg
	 WHERE aprcatg_pidm = in_pidm
	   AND aprcatg_donr_code = 'PRNT';
    EXCEPTION WHEN OTHERS THEN current_parent_flag := 'N';
  END;
  RETURN current_parent_flag;
END Is_A_Current_Parent;
-----------------------------------------------------------------------
FUNCTION Is_A_Parent (in_pidm IN aprcatg.aprcatg_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  Returns 'Y' if an parent or null
-----------------------------------------------------------------------
--  written by Elizabeth 7/17/2007
    parent_flag   varchar2(1) := 'N';
BEGIN
  BEGIN
    SELECT max('Y')
	  INTO parent_flag
	  FROM aprcatg
	 WHERE aprcatg_pidm = in_pidm
	   AND aprcatg_donr_code IN (select atvdonr_code
                                   from atvdonr
                                  where upper(atvdonr_desc) like '%PARENT%');
    EXCEPTION WHEN OTHERS THEN parent_flag := 'N';
  END;
  RETURN parent_flag;
END Is_A_Parent;
-----------------------------------------------------------------------
FUNCTION Is_A_Student(in_pidm spriden.spriden_pidm%type,
                      in_term stvterm.stvterm_code%type DEFAULT NULL)
  RETURN VARCHAR2 IS
--  Returns 'Y' (if student) or 'N' (if not student)
-----------------------------------------------------------------------
--  written by Elizabeth  09/01/2006
    student_count       integer;
	student_term        stvterm.stvterm_code%type;
	max_student_term    stvterm.stvterm_code%type;
	current_term        stvterm.stvterm_code%type;
BEGIN
    current_term := Get_Current_Term;
    IF in_term IS NULL THEN
	   student_term := current_term;
	ELSE
       student_term := in_term;
    END IF;
	BEGIN
      SELECT MAX (sgbstdn_term_code_eff)
	    INTO max_student_term
        FROM sgbstdn
       WHERE sgbstdn_pidm = in_pidm
         AND sgbstdn_term_code_eff <= student_term;
	  EXCEPTION WHEN OTHERS THEN RETURN 'N';
    END;
	student_count := 0;
    BEGIN
	   SELECT count(*)
         INTO student_count
	     FROM sgbstdn
        WHERE sgbstdn_pidm = in_pidm
          AND (
		      (sgbstdn_stst_code IN
		           (SELECT stvstst_code
				      FROM stvstst
					 WHERE stvstst_reg_ind = 'Y')
          AND sgbstdn_term_code_eff = max_student_term)
		   OR (sgbstdn_stst_code = 'GR'
		  AND sgbstdn_term_code_eff = student_term)
		      );
    END;
    IF student_count > 0 THEN
	   RETURN 'Y';
	ELSE
       RETURN 'N';
    END IF;
END Is_A_Student;
-----------------------------------------------------------------------
FUNCTION Is_Chair_Advisee(fac_pidm sirdpcl.sirdpcl_pidm%type,
                          stu_pidm sorlfos.sorlfos_pidm%type,
						  term_code sorlfos.sorlfos_term_code%type)
  RETURN VARCHAR2 IS
--  Returns 'Y' if  a student is a department chair's advisee for a specified term
-- (A department chair has advisee security privledges to all students in his departments).
-----------------------------------------------------------------------
--  written by Elizabeth  05/17/2006
--  used for security checking
student_count         number;
BEGIN
--        check to see if the student has a major in the department
    student_count := 0;
        SELECT	count(*)
	      INTO  student_count
		  FROM	sorlfos, sovlcur
		 WHERE	Is_Dept_Chair(fac_pidm, term_code) = 'Y'
		   AND  sovlcur_pidm =  stu_pidm
		   AND	sovlcur_LMOD_CODE = 'LEARNER'
		   AND	sovlcur_CACT_CODE = 'ACTIVE'
		   AND  sovlcur_term_code <= term_code
--		   AND  sovlcur_current_ind = 'Y'
		   AND sorlfos_pidm = sovlcur_pidm
		   AND sorlfos_lcur_seqno = sovlcur_seqno
		   AND (sorlfos_lfst_code = 'MAJOR' or sorlfos_lfst_code = 'MINOR')
		   AND sorlfos_csts_code = 'INPROGRESS'
		   AND sorlfos_cact_code = 'ACTIVE'
           AND sorlfos_dept_code IN
           (SELECT sirdpcl_dept_code
              FROM sirdpcl
             WHERE sirdpcl_pidm = fac_pidm
               and Is_Faculty_Dept(fac_pidm,term_code,sirdpcl_dept_code) = 'Y');
    IF student_count > 0 THEN
	   RETURN 'Y';
    END IF;
	RETURN 'N';
END Is_Chair_Advisee;
-----------------------------------------------------------------------
FUNCTION Is_Dean(in_pidm sirattr.sirattr_pidm%type,
                 in_term sirattr.sirattr_term_code_eff%type)
  RETURN VARCHAR2 IS
--  written by Elizabeth  08/21/2006
--  Returns 'Y' if  an attribute of 'DEAN'  or 'DEAS' is assigned to a faculty member
--  or administrative assistant for the specified term; otherwise, returns 'N'
-----------------------------------------------------------------------
begin_term   VARCHAR2(6) := NULL;
check_count  INTEGER := 0;
BEGIN
	BEGIN
      SELECT max(sirattr_term_code_eff)
	    INTO begin_term
        FROM sirattr
       WHERE sirattr_pidm = in_pidm
         and sirattr_term_code_eff <= in_term;
      EXCEPTION WHEN OTHERS THEN begin_term := NULL;
    END;
    IF begin_term IS NULL then
      RETURN 'N';
	END IF;
	BEGIN
      SELECT count(*)
	    INTO check_count
        FROM sirattr
       WHERE sirattr_pidm = in_pidm
         and sirattr_term_code_eff = begin_term
         and sirattr_fatt_code in ('DEAN', 'DEAS');
      EXCEPTION WHEN OTHERS THEN check_count := 0;
    END;
    IF check_count > 0 THEN
       RETURN 'Y';
    ELSE
       RETURN 'N';
    END IF;
END Is_Dean;
-----------------------------------------------------------------------
FUNCTION Is_Dean_Advisee(fac_pidm sirdpcl.sirdpcl_pidm%type,
                          stu_pidm sorlcur.sorlcur_pidm%type,
						  term_code sorlcur.sorlcur_term_code%type)
  RETURN VARCHAR2 IS
--  Returns 'Y' if  a student is a dean's advisee for a specified term
-- (A dean has advisee security privledges to all students in his school.).
-----------------------------------------------------------------------
--  written by Elizabeth  05/17/2006
--  used for security checking
student_count         number;
BEGIN
--        check to see if the student has a major in the college
    student_count := 0;
    SELECT COUNT(*)
	  INTO student_count
      FROM sovlcur
     WHERE (SELECT Is_Dean(fac_pidm, term_code) FROM dual) = 'Y'
       AND sovlcur_pidm = stu_pidm
	   AND sovlcur_current_ind = 'Y'
	   AND sovlcur_active_ind = 'Y'
       AND sovlcur_LMOD_CODE = 'LEARNER'
	   AND sovlcur_CACT_CODE = 'ACTIVE'
	   AND sovlcur_term_code <= term_code
       AND sovlcur_coll_code IN
           (SELECT sirdpcl_coll_code
              FROM sirdpcl
             WHERE sirdpcl_pidm = fac_pidm
               and Is_Faculty_College(fac_pidm,term_code,sirdpcl_coll_code) = 'Y');
    IF student_count > 0 THEN
	   RETURN 'Y';
    END IF;
	RETURN 'N';
END Is_Dean_Advisee;
-----------------------------------------------------------------------
FUNCTION Is_Dept_Chair(pidm sirattr.sirattr_pidm%type,
                       term_code sirattr.sirattr_term_code_eff%type)
  RETURN VARCHAR2 IS
--  Returns 'Y' if  an attribute of 'CHAI' , 'CHAS', or 'CHAA' is assigned to a faculty member
--  or administrative assistant for the specified term; otherwise, returns 'N'
-----------------------------------------------------------------------
--  written by Elizabeth  08/21/2006
begin_term   VARCHAR2(6) := NULL;
check_count  INTEGER := 0;
BEGIN
	BEGIN
      SELECT max(sirattr_term_code_eff)
	    INTO begin_term
        FROM sirattr
       WHERE sirattr_pidm = pidm
         and sirattr_term_code_eff <= term_code;
      EXCEPTION WHEN OTHERS THEN begin_term := NULL;
    END;
    IF begin_term IS NULL then
      RETURN 'N';
	END IF;
	BEGIN
      SELECT count(*)
	    INTO check_count
        FROM sirattr
       WHERE sirattr_pidm = pidm
         and sirattr_term_code_eff = begin_term
         and sirattr_fatt_code in ('CHAI', 'CHAS', 'CHAA');
      EXCEPTION WHEN OTHERS THEN check_count := 0;
    END;
    IF check_count > 0 THEN
       RETURN 'Y';
    ELSE
       RETURN 'N';
    END IF;
END Is_Dept_Chair;
-----------------------------------------------------------------------
FUNCTION Is_Employee (pidm IN NUMBER)
  RETURN CHAR IS
-----------------------------------------------------------------------
/* IS_EMPLOYEE
   DATE    : 19MAY06
   AUTHOR  : Jonathan Wheat (jwheat)
   PURPOSE : Determine whether a PIDM is an employee.
   USAGE   : is_employee(pism)
   EXAMPLE : is_employee(344450)
   ACTIONS : takes a PIDM and looks up the code from PEBEMPL to determine
             whether they are an employee.
   VALUES  : Currently tests for
             A - Adminsrative Employee
             S - Staff Employee
   INPUT   : PIDM  (ie. 123456)
   OUTPUT  : No screen output
   RETURNS : Currently returns -
              Y - yes the pidm is an employee
           NULL - no, the pidm is not an employee
*/
CURSOR chk_emp (pidm IN number) IS
  select 'Y'
  from pebempl
  where pebempl_pidm = pidm
  and (pebempl_egrp_code = 'A' or pebempl_egrp_code = 'S');
return_value CHAR;
BEGIN
  OPEN chk_emp (pidm);
  FETCH chk_emp INTO return_value;
  IF chk_emp%NOTFOUND
  THEN
      CLOSE chk_emp;
      RETURN NULL;
  ELSE
      CLOSE chk_emp;
      RETURN return_value;
  END IF;
END Is_Employee;
-----------------------------------------------------------------------
FUNCTION Is_Faculty (pidm IN NUMBER)
  RETURN CHAR IS
-----------------------------------------------------------------------
/* IS_FACULTY
   DATE    : 19MAY06
   AUTHOR  : Jonathan Wheat (jwheat)
   PURPOSE : Determine whether a PIDM is an faculty.
   USAGE   : is_faculty(pism)
   EXAMPLE : is_faculty(344450)
   ACTIONS : takes a PIDM and looks up the code from PEBEMPL to determine
             whether they are faculty.
   VALUES  : Currently tests for
             F - Faculty
   INPUT   : PIDM  (ie. 123456)
   OUTPUT  : No screen output
   RETURNS : Currently returns -
              Y - yes the pidm is faculty
           NULL - no, the pidm is not faculty
*/
CURSOR chk_fac (pidm IN number) IS
  select 'Y'
  from pebempl
  where pebempl_pidm = pidm
  and (pebempl_egrp_code = 'F');
return_value CHAR;
BEGIN
  OPEN chk_fac (pidm);
  FETCH chk_fac INTO return_value;
  IF chk_fac%NOTFOUND
  THEN
      CLOSE chk_fac;
      RETURN NULL;
  ELSE
      CLOSE chk_fac;
      RETURN return_value;
  END IF;
END Is_Faculty;
-----------------------------------------------------------------------
FUNCTION Is_Faculty_Advisee
    (fac_pidm number, stu_pidm number, term_code VARCHAR2)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  05/17/2006
--  FUNCTION checks whether a student is a faculty member's advisee.
--  used for security checking
--  inputs  faculty pidm, student pidm, term code
--  returns 'Y' if an advisee
--               'N' if not an advisee
student_count         number;
BEGIN
--        check to see if the student is an advisee
    student_count := 0;
    SELECT count(*)
      INTO student_count
   	  FROM sgradvr a
     WHERE a.sgradvr_pidm = stu_pidm
	   AND a.sgradvr_advr_pidm = fac_pidm
       AND a.sgradvr_term_code_eff =
          (SELECT MAX (b.sgradvr_term_code_eff)
                 FROM sgradvr b
                WHERE b.sgradvr_pidm = a.sgradvr_pidm
                  AND b.sgradvr_term_code_eff <= term_code);
    IF student_count > 0 THEN
	   RETURN 'Y';
    END IF;
	RETURN 'N';
END Is_Faculty_Advisee;
-----------------------------------------------------------------------
FUNCTION Is_Faculty_Attribute(pidm sirattr.sirattr_pidm%type,
                              term_code sirattr.sirattr_term_code_eff%type,
							  fatt_code sirattr.sirattr_fatt_code%type)
  RETURN VARCHAR2 IS
--  Returns 'Y' if  an attribute is assigned to a faculty member for the specified term; otherwise, returns 'N'
-----------------------------------------------------------------------
--  written by Elizabeth  03/29/2006
begin_term   VARCHAR2(6) := NULL;
check_count  INTEGER := 0;
BEGIN
	BEGIN
      SELECT max(sirattr_term_code_eff)
	    INTO begin_term
        FROM sirattr
       WHERE sirattr_pidm = pidm
         and sirattr_term_code_eff <= term_code;
      EXCEPTION WHEN OTHERS THEN begin_term := NULL;
    END;
    IF begin_term IS NULL then
      RETURN 'N';
	END IF;
	BEGIN
      SELECT count(*)
	    INTO check_count
        FROM sirattr
       WHERE sirattr_pidm = pidm
         and sirattr_term_code_eff = begin_term
         and sirattr_fatt_code = fatt_code;
      EXCEPTION WHEN OTHERS THEN check_count := 0;
    END;
    IF check_count > 0 THEN
       RETURN 'Y';
    ELSE
       RETURN 'N';
    END IF;
END Is_Faculty_Attribute;
-----------------------------------------------------------------------
FUNCTION Is_Faculty_College(pidm sirdpcl.sirdpcl_pidm%type,
                            term_code sirdpcl.sirdpcl_term_code_eff%type,
							coll_code sirdpcl.sirdpcl_coll_code%type)
  RETURN VARCHAR2 IS
--  Returns 'Y' if  a college code is assigned to a faculty member for the specified term; otherwise, returns 'N'
-----------------------------------------------------------------------
--  written by Elizabeth  03/29/2006
begin_term   VARCHAR2(6) := NULL;
check_count  INTEGER := 0;
BEGIN
	BEGIN
      SELECT max(sirdpcl_term_code_eff)
	    INTO begin_term
        FROM sirdpcl
       WHERE sirdpcl_pidm = pidm
         and sirdpcl_term_code_eff <= term_code;
      EXCEPTION WHEN OTHERS THEN begin_term := NULL;
    END;
    IF begin_term IS NULL then
      RETURN 'N';
	END IF;
	BEGIN
      SELECT count(*)
	    INTO check_count
        FROM sirdpcl
       WHERE sirdpcl_pidm = pidm
         and sirdpcl_term_code_eff = begin_term
         and sirdpcl_coll_code = coll_code;
      EXCEPTION WHEN OTHERS THEN check_count := 0;
    END;
    IF check_count > 0 THEN
       RETURN 'Y';
    ELSE
       RETURN 'N';
    END IF;
END Is_Faculty_College;
-----------------------------------------------------------------------
FUNCTION Is_Faculty_Dept(pidm sirdpcl.sirdpcl_pidm%type,
                            term_code sirdpcl.sirdpcl_term_code_eff%type,
							dept_code sirdpcl.sirdpcl_dept_code%type)
  RETURN VARCHAR2 IS
--  Returns 'Y' if  a department code is assigned to a faculty member for the specified term; otherwise, returns 'N'
-----------------------------------------------------------------------
--  written by Elizabeth  03/29/2006
begin_term   VARCHAR2(6) := NULL;
check_count  INTEGER := 0;
BEGIN
	BEGIN
      SELECT max(sirdpcl_term_code_eff)
	    INTO begin_term
        FROM sirdpcl
       WHERE sirdpcl_pidm = pidm
         and sirdpcl_term_code_eff <= term_code;
      EXCEPTION WHEN OTHERS THEN begin_term := NULL;
    END;
    IF begin_term IS NULL then
      RETURN 'N';
	END IF;
	BEGIN
      SELECT count(*)
	    INTO check_count
        FROM sirdpcl
       WHERE sirdpcl_pidm = pidm
         and sirdpcl_term_code_eff = begin_term
         and sirdpcl_dept_code = dept_code;
      EXCEPTION WHEN OTHERS THEN check_count := 0;
    END;
    IF check_count > 0 THEN
       RETURN 'Y';
    ELSE
       RETURN 'N';
    END IF;
END Is_Faculty_Dept;
-----------------------------------------------------------------------
FUNCTION is_current_instructor (pidm_in IN NUMBER) RETURN VARCHAR2 IS
-- written by Bob Felix 10/9/2015
  ecls_code pebempl.pebempl_ecls_code%type;
  cls_ctr number(8);
BEGIN
--
 ecls_code:= null;
--
 BEGIN
   SELECT max(pebempl_ecls_code)
     INTO ecls_code
     FROM pebempl
    WHERE pebempl_pidm = pidm_in
      AND pebempl_empl_status <> 'T';
 EXCEPTION
    WHEN OTHERS THEN ecls_code:= null;
 END;
--
 IF ecls_code is null then
    RETURN 'N';
 ELSIF ecls_code like 'F%' then
    RETURN 'Y';
 END IF;
--
 cls_ctr:= 0;
--
 BEGIN
   SELECT count(*)
     INTO cls_ctr
     FROM stvterm, sirasgn
    WHERE stvterm_end_date >= sysdate - 60
      AND stvterm_code = sirasgn_term_code
      AND sirasgn_pidm = pidm_in
      AND (sirasgn_primary_ind = 'Y'
       OR  sirasgn_percent_response > 0);
 EXCEPTION
    WHEN OTHERS THEN cls_ctr:= 0;
 END;
--
 IF cls_ctr > 0 then
    RETURN 'Y';
 ELSE
    RETURN 'N';
 END IF;
--
END is_current_instructor;
-----------------------------------------------------------------------
FUNCTION Is_FATT_Relationship
    (fac_pidm number, stu_pidm number, term_code VARCHAR2, fatt_code VARCHAR2)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/28/2006.
--  FUNCTION checks whether a faculty has an "attribute" relationship with a student
--  i.e., the faculty has a faculty attribute (sirattr)  that matches one of the student's attributes ( sgrsatt)
--  input:  pidm, student_pidm, attribute
--  output: returns 'Y' or 'N'
assigned_attribute VARCHAR2(1);
BEGIN
--        check first to see if the attribute code is currently assigned to the faculty member
    assigned_attribute := Is_Faculty_Attribute(fac_pidm, term_code, fatt_code);
	IF assigned_attribute = 'N' THEN
	   RETURN 'N';
	END IF;
--        check now to see if the attribute code is currently assigned to the student
    assigned_attribute := Is_Student_Attribute(stu_pidm, term_code, fatt_code);
	IF assigned_attribute = 'N' THEN
	   RETURN 'N';
	END IF;
    RETURN 'Y';
END;
-----------------------------------------------------------------------
FUNCTION Is_Number(in_string VARCHAR2)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
  checknum number;
-- FUNCTION accepts a varchar field
-- returns 'Y' if number, 'N' if not
BEGIN
   IF in_string IS NULL THEN
      RETURN 'N';
   END IF;
   checknum := to_number(in_string);
   RETURN 'Y';
   EXCEPTION
      WHEN OTHERS then RETURN 'N';
END Is_Number;

-----------------------------------------------------------------------
FUNCTION Is_Student (pidm IN NUMBER) 
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
/*  the CORRECT method */
stud_ctr number(8);
BEGIN
  BEGIN
     SELECT count(*)
        INTO stud_ctr
        FROM szvclas
       WHERE szvclas_reg_ind = 'Y'
         AND szvclas_leve_code in ('GR','UG')
         AND szvclas_pidm = pidm;
    EXCEPTION
       WHEN OTHERS THEN stud_ctr:= 0;
  END;
  IF stud_ctr > 0 then
       RETURN 'Y';
  ELSE
       RETURN null;
  END IF;
END is_student;

-----------------------------------------------------------------------
FUNCTION XXX_Is_Student (pidm IN NUMBER)
  RETURN CHAR IS
-----------------------------------------------------------------------
/* IS_STUDENT
   DATE    : 19MAY06
   AUTHOR  : Jonathan Wheat (jwheat)
   PURPOSE : Determine whether a PIDM is a student.
   USAGE   : is_student(pidm)
   EXAMPLE : is_student(344450)
   ACTIONS : takes a PIDM and looks up the code from DWH - DWID table
             whether they are a student.
   INPUT   : PIDM  (ie. 123456)
   OUTPUT  : No screen output
   RETURNS : Currently returns -
              Y - yes the pidm is a student
           NULL - no, the pidm is not a student
*/
CURSOR chk_stu (pidm IN number) IS
  select 'Y'
  from dwID@dwh
  where dwid_pidm = pidm
  and dwid_student_flag = 'Y';
return_value CHAR;
BEGIN
  OPEN chk_stu (pidm);
  FETCH chk_stu INTO return_value;
  IF chk_stu%NOTFOUND
  THEN
      CLOSE chk_stu;
      RETURN NULL;
  ELSE
      CLOSE chk_stu;
      RETURN return_value;
  END IF;
END XXX_Is_Student;
-----------------------------------------------------------------------
FUNCTION Is_Student_Attribute(in_pidm sgrsatt.sgrsatt_pidm%type,
                              in_term sgrsatt.sgrsatt_term_code_eff%type,
							  in_atts_code sgrsatt.sgrsatt_atts_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/28/2006
--  FUNCTION returns 'Y' if an attribute is assigned to a  student for the desired term; otherwise returns 'N'
begin_term   VARCHAR2(6) := NULL;
end_term     VARCHAR2(6) := NULL;
max_term     VARCHAR2(6) := NULL;
cursor get_begin_sgrsatt is
    SELECT nvl(max(sgrsatt_term_code_eff), '999999')
      FROM sgrsatt
     WHERE sgrsatt_pidm = in_pidm
       and sgrsatt_term_code_eff <= in_term
       and sgrsatt_atts_code = in_atts_code;
cursor get_end_sgrsatt is
    SELECT nvl(max(sgrsatt_term_code_eff), '999999')
      FROM sgrsatt
     WHERE sgrsatt_pidm = in_pidm
       and sgrsatt_term_code_eff >= begin_term
       and sgrsatt_atts_code = in_atts_code;
cursor get_end_non_fatt_sgrsatt is
    SELECT nvl(min(sgrsatt_term_code_eff), '999999')
      FROM sgrsatt
     WHERE sgrsatt_pidm = in_pidm
       and sgrsatt_term_code_eff > begin_term
       and (sgrsatt_atts_code IS NULL OR sgrsatt_atts_code <> in_atts_code );
BEGIN
    open get_begin_sgrsatt;
    fetch get_begin_sgrsatt INTO begin_term;
    close get_begin_sgrsatt;
    if begin_term = '999999' then
	   end_term := '000000';  -- attribute not found
	ELSE
       open get_end_sgrsatt;
       fetch get_end_sgrsatt INTO end_term;
       close get_end_sgrsatt;
	   open get_end_non_fatt_sgrsatt;
	   fetch get_end_non_fatt_sgrsatt INTO max_term;
	   close get_end_non_fatt_sgrsatt;
       if end_term = max_term then
	      end_term := '999999';
	   ELSE
          end_term := max_term;
       END IF;
    END IF;
	if in_term >= begin_term and in_term < end_term then
	   RETURN 'Y';
	ELSE
	   RETURN 'N';
	END IF;
END Is_Student_Attribute;
-----------------------------------------------------------------------
FUNCTION Is_Transcript_Student
    (fac_pidm number, stu_pidm number, term_code VARCHAR2)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  06/28/2006
--  FUNCTION checks whether a faculty member  has a relationship with a student
--  which allows that person to view the student's transcript
--  used for security checking
--  inputs  faculty pidm, student pidm, term code
--  returns 'Y' if relationship exists
--               'N' if not
check_relationship    VARCHAR2(1);
BEGIN
--       department chairs can see transcripts for students with majors in their departments
    check_relationship := Is_Chair_Advisee(fac_pidm, stu_pidm, term_code);
	IF check_relationship = 'Y' THEN
	   RETURN 'Y';
	END IF;
--       deans can see transcripts for students with majors in their college
	check_relationship := Is_Dean_Advisee(fac_pidm, stu_pidm, term_code);
	IF check_relationship = 'Y' THEN
	   RETURN 'Y';
	END IF;
--       faculty with REGR attribute can see transcripts for all students
    check_relationship := Is_Faculty_Attribute(fac_pidm, term_code, 'REGR');
	IF check_relationship = 'Y' THEN
	   RETURN 'Y';
	END IF;
--       disability students
    check_relationship := Is_FATT_Relationship(fac_pidm, stu_pidm, term_code, 'DISA');
	IF check_relationship = 'Y' THEN
	   RETURN 'Y';
	END IF;
--        Teacher Education Program students
    check_relationship := Is_FATT_Relationship(fac_pidm, stu_pidm, term_code, 'TEP');
	IF check_relationship = 'Y' THEN
	   RETURN 'Y';
	END IF;
--        Honor students
    check_relationship := Is_FATT_Relationship(fac_pidm, stu_pidm, term_code, 'HONR');
	IF check_relationship = 'Y' THEN
	   RETURN 'Y';
	END IF;
--        Veteran Benefit Eligible students
    check_relationship := Is_FATT_Relationship(fac_pidm, stu_pidm, term_code, 'VETB');
	IF check_relationship = 'Y' THEN
	   RETURN 'Y';
	END IF;
--        International students
    check_relationship := Is_FATT_Relationship(fac_pidm, stu_pidm, term_code, 'INTL');
	IF check_relationship = 'Y' THEN
	   RETURN 'Y';
	END IF;
--       additional faculty / student attribute checks can be added here
--      check_relationship := Is_FATT_Relationship(fac_pidm, stu_pidm, term_code, 'xxxx');
--	IF check_relationship = 'Y' THEN
--	   RETURN 'Y';
--	END IF;
	RETURN 'N';
END Is_Transcript_Student;
-----------------------------------------------------------------------
FUNCTION Random_Value (start_nbr IN number, end_nbr IN number)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Bob Felix
--  returns a random value between a specified number range
r_nbr varchar2(10);
BEGIN
   r_nbr:= trim(to_char(trunc(dbms_random.value(start_nbr,end_nbr))));
   RETURN r_nbr;
END random_value;
/*
--
-- Generate anchor attribute to display onfocus text
---------------------------------------------------------------------------
   FUNCTION f_anchor_focus (text_in IN VARCHAR)
      RETURN VARCHAR2
   IS
---------------------------------------------------------------------------
   BEGIN
      RETURN 'onMouseOver="window.status=''' || text_in || '''; ' ||
                ' RETURN true" ' ||
                'onFocus="window.status=''' ||
                text_in ||
                '''; ' ||
                ' RETURN true" ' ||
                'onMouseOut="window.status=''''; ' ||
                ' RETURN true"' ||
                'onBlur="window.status=''''; ' ||
                ' RETURN true"';
   END f_anchor_focus;
---------------------------------------------------------------------------
---------------------------------------------------------------------------
   PROCEDURE Display_Back_Anchor(link_name IN VARCHAR2)
   IS
---------------------------------------------------------------------------
--
-- Display Return/Back Anchor
--
-- same FUNCTION as bwckfrmt.p_disp_back_anchor except that link name is supplied as a parameter
--  (in bwckfrmt.p_disp_back_anchor, the link is always "Return to Previous")
   BEGIN
      twbkfrmt.p_printanchor (
         curl          => '#',
         ctext         => link_name,
         cattributes   => 'onClick="history.go(-1);" ' || f_anchor_focus (link_name)
      );
   END Display_Back_Anchor;
*/
-----------------------------------------------------------------------
FUNCTION Get_SSN(in_pidm spbpers.spbpers_pidm%type,
                 in_format varchar2 default null)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
-- in_format
--  null  or 'N' = non-edited SSN
-- 'F' = edited SSN (xxx-xxx-xxxx)
  ssn_value      spbpers.spbpers_ssn%type;
BEGIN
  BEGIN
    SELECT spbpers_ssn
	  INTO ssn_value
	  FROM spbpers
	 WHERE spbpers_pidm = in_pidm;
	EXCEPTION WHEN OTHERS THEN ssn_value := NULL;
  END;
  IF ssn_value = NULL THEN
     RETURN null;
  END IF;
  IF upper(in_format) = 'F' THEN
     RETURN substr(ssn_value,1,3) || '-' || substr(ssn_value,4,2) || '-' || substr(ssn_value,6,4);
  END IF;
  RETURN ssn_value;
END Get_SSN;
-----------------------------------------------------------------------
FUNCTION Get_SSN_By_ID(in_id  VARCHAR2,
                       in_format varchar2 default null)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
-- in_format
--  null  or 'N' = non-edited SSN
-- 'F' = edited SSN (xxx-xxx-xxxx)
  ssn_value      varchar2(30);
  ssn_pidm       spriden.spriden_pidm%type;
BEGIN
    ssn_value := NULL;
	ssn_pidm := Get_Pidm(in_id);
    ssn_value := Get_SSN(ssn_pidm, in_format);
    RETURN ssn_value;
END Get_SSN_By_ID;
-----------------------------------------------------------------------
FUNCTION Is_Citizen(in_pidm spbpers.spbpers_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  returns spbpers_citz_code value
  citizen_flag     spbpers.spbpers_citz_code%type;
BEGIN
  citizen_flag := NULL;
  BEGIN
    SELECT spbpers_citz_code
	  INTO citizen_flag
	  FROM spbpers
	 WHERE spbpers_pidm = in_pidm;
	EXCEPTION WHEN OTHERS THEN citizen_flag := NULL;
  END;
  RETURN citizen_flag;
END Is_Citizen;
-----------------------------------------------------------------------
FUNCTION Is_Deceased(in_pidm spbpers.spbpers_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  returns Y if deceased, NULL otherwise
  dead_flag     spbpers.spbpers_dead_ind%type;
BEGIN
  dead_flag := NULL;
  BEGIN
    SELECT spbpers_dead_ind
	  INTO dead_flag
	  FROM spbpers
	 WHERE spbpers_pidm = in_pidm;
	EXCEPTION WHEN OTHERS THEN dead_flag := null;
  END;
  RETURN dead_flag;
END Is_Deceased;
-----------------------------------------------------------------------
FUNCTION urlencode( p_str in varchar2 )
  return varchar2 IS
-----------------------------------------------------------------------
    l_tmp   varchar2(6000);
    l_bad   varchar2(100) default ' >%}\~];?@&<#{|^[`/:=$+''"';
    l_char  char(1);
begin
    for i in 1 .. nvl(length(p_str),0) loop
        l_char :=  substr(p_str,i,1);
        if ( instr( l_bad, l_char ) > 0 )
        then
            l_tmp := l_tmp || '%' ||
                            to_char( ascii(l_char), 'fmXX' );
        else
            l_tmp := l_tmp || l_char;
        end if;
    end loop;
    return l_tmp;
end;
-----------------------------------------------------------------------
function get_pri_donr_cat(in_pidm aprcatg.aprcatg_pidm%type)
   return varchar2 is
-----------------------------------------------------------------------
   donr_cat aprcatg.aprcatg_donr_code%TYPE := NULL;
begin
   SELECT ATVDONR_CODE
     INTO donr_cat
     FROM APRCATG B, ATVDONR Y
    WHERE APRCATG_PIDM = in_pidm
      AND APRCATG_DONR_CODE = Y.ATVDONR_CODE
      AND ATVDONR_RPT_SEQ_IND =
          (SELECT MIN(X.ATVDONR_RPT_SEQ_IND)
             FROM ATVDONR X
            WHERE EXISTS (SELECT 'X'
                            FROM APRCATG
                           WHERE APRCATG_PIDM = in_pidm
                             AND APRCATG_DONR_CODE = X.ATVDONR_CODE));
    return donr_cat;
end get_pri_donr_cat;
-----------------------------------------------------------------------
FUNCTION Is_A_Constituent (in_pidm IN aprcatg.aprcatg_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Bob Getty 2/29/2008
--  Returns 'Y' if a constituent or null
-----------------------------------------------------------------------
    cons_flag   varchar2(1) := 'N';
BEGIN
  BEGIN
    SELECT 'Y'
	  INTO cons_flag
	  FROM aprcatg
	 WHERE aprcatg_pidm = in_pidm;
    EXCEPTION WHEN OTHERS THEN cons_flag := 'N';
  END;
  RETURN cons_flag;
END Is_A_Constituent;
-----------------------------------------------------------------------
FUNCTION Get_Birth_City (in_pidm IN spriden.spriden_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth 3/10/2008
--  Returns SPBPERS_BIRTH_CITY or null
-----------------------------------------------------------------------
  birth_city      spbpers.spbpers_city_birth%type := null;
BEGIN
  BEGIN
    SELECT spbpers_city_birth
	  INTO birth_city
	  FROM spbpers
	 WHERE spbpers_pidm = in_pidm;
	 EXCEPTION WHEN OTHERS THEN birth_city := null;
  END;
  RETURN birth_city;
END Get_Birth_City;
-----------------------------------------------------------------------
FUNCTION Get_Birth_State (in_pidm IN spriden.spriden_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth 3/10/2008
--  Returns SPBPERS_STAT_CODE_BIRTH or null
-----------------------------------------------------------------------
  birth_state     spbpers.spbpers_stat_code_birth%type := null;
BEGIN
  BEGIN
    SELECT spbpers_stat_code_birth
	  INTO birth_state
	  FROM spbpers
	 WHERE spbpers_pidm = in_pidm;
	 EXCEPTION WHEN OTHERS THEN birth_state := null;
  END;
  RETURN birth_state;
END Get_Birth_State;
-----------------------------------------------------------------------
FUNCTION  Get_SZBWEBR_Value(in_webc_code    IN messiah.szbwebr.szbwebr_webc_code%type,
                            in_control_name IN messiah.szbwebr.szbwebr_control_name%type)
RETURN varchar2
-----------------------------------------------------------------------
--  written by Elizabeth 8/20/2008
--  Returns value of SZBWEBR web control
-----------------------------------------------------------------------
IS
  control_value   messiah.szbwebr.szbwebr_control_value%type;
BEGIN
  control_value := null;
  BEGIN
	  SELECT trim(SZBWEBR_CONTROL_VALUE)
	    INTO control_value
  	    FROM SZBWEBR
       WHERE SZBWEBR_WEBC_CODE = in_webc_code
   	     AND SZBWEBR_CONTROL_NAME = in_control_name;
       EXCEPTION WHEN OTHERS THEN control_value := null;
  END;
  RETURN control_value;
END get_szbwebr_value;
-----------------------------------------------------------------------
FUNCTION Get_Employee_Time (in_pidm pebempl.pebempl_pidm%type)
  RETURN VARCHAR2
--  written by Elizabeth 8/21/2008
-- returns employee time status (or null if not an employee)
--  F = Full Time, P = Part Time, O = On call
-----------------------------------------------------------------------
IS
  internal_ft_pt_ind    pebempl.PEBEMPL_INTERNAL_FT_PT_IND%type := null;
BEGIN
  BEGIN
    SELECT PEBEMPL_INTERNAL_FT_PT_IND
	  INTO internal_ft_pt_ind
	  FROM pebempl
     WHERE pebempl_pidm = in_pidm
	   AND pebempl_empl_status <> 'T'
       AND pebempl_egrp_code <> 'ST'
	   AND pebempl_ecls_code in ('NE', 'FF', 'AP', 'FP', 'SF', 'SP', 'AF');
    EXCEPTION WHEN OTHERS THEN internal_ft_pt_ind := null;
  END;
  RETURN internal_ft_pt_ind;
END Get_Employee_Time;
-----------------------------------------------------------------------
FUNCTION Get_Employee_Time2 (in_pidm pebempl.pebempl_pidm%type)
  RETURN VARCHAR2
--  same as Get_Employee_Time except includes additional 'TO' ecls_code
--  written by Elizabeth 8/21/2008
-- returns employee time status (or null if not an employee)
--  F = Full Time, P = Part Time, O = On call
-----------------------------------------------------------------------
IS
  internal_ft_pt_ind    pebempl.PEBEMPL_INTERNAL_FT_PT_IND%type := null;
BEGIN
  BEGIN
    SELECT PEBEMPL_INTERNAL_FT_PT_IND
	  INTO internal_ft_pt_ind
	  FROM pebempl
     WHERE pebempl_pidm = in_pidm
	   AND pebempl_empl_status <> 'T'
       AND pebempl_egrp_code <> 'ST'
	   AND pebempl_ecls_code in ('NE', 'FF', 'AP', 'FP', 'SF', 'SP', 'AF', 'TO');
    EXCEPTION WHEN OTHERS THEN internal_ft_pt_ind := null;
  END;
  RETURN internal_ft_pt_ind;
END Get_Employee_Time2;
-----------------------------------------------------------------------
FUNCTION Get_GL_Org_Name (in_orgn_code ftvorgn.ftvorgn_orgn_code%type)
  RETURN VARCHAR2
--  written by Greg / Elizabeth  8/25/2008
-- Returns GL organization name
-----------------------------------------------------------------------
IS
  out_org_name    ftvorgn.ftvorgn_title%type := null;
BEGIN
  BEGIN
    select max(ftvorgn_title)
	  into out_org_name
      from ftvorgn
     where ftvorgn_coas_code = '1' and
           ftvorgn_orgn_code = in_orgn_code and
           ftvorgn_eff_date <= sysdate and
           ftvorgn_nchg_date >= sysdate;
	exception when others then out_org_name := null;
  END;
  RETURN out_org_name;
END Get_GL_Org_Name;
-----------------------------------------------------------------------
FUNCTION Get_GL_Org_Mgr (in_orgn_code ftvorgn.ftvorgn_orgn_code%type)
  RETURN NUMBER
--  written by Greg / Elizabeth  8/25/2008
-- Returns GL organization manager pidm
-----------------------------------------------------------------------
IS
  out_fmgr_code_pidm    ftvorgn.ftvorgn_fmgr_code_pidm%type := null;
BEGIN
  BEGIN
    select max(ftvorgn_fmgr_code_pidm)
	  into out_fmgr_code_pidm
      from ftvorgn
     where ftvorgn_coas_code = '1' and
           ftvorgn_orgn_code = in_orgn_code and
           ftvorgn_eff_date <= sysdate and
           ftvorgn_nchg_date >= sysdate;
	exception when others then out_fmgr_code_pidm := null;
  END;
  RETURN out_fmgr_code_pidm;
END Get_GL_Org_Mgr;
-----------------------------------------------------------------------
FUNCTION Get_GL_Acct_Name (in_acct ftvacct.ftvacct_acct_code%type)
  RETURN VARCHAR2
--  written by Greg / Elizabeth  8/25/2008
-- Returns GL account name
-----------------------------------------------------------------------
IS
  out_acct_title    ftvacct.ftvacct_title%type := null;
BEGIN
  BEGIN
    select max(ftvacct_title)
	  into out_acct_title
      from ftvacct
     where ftvacct_coas_code = '1' and
       ftvacct_acct_code = in_acct and
       ftvacct_eff_date <= sysdate and
       ftvacct_nchg_date >= sysdate;
	exception when others then  out_acct_title := null;
  END;
  return  out_acct_title;
END Get_GL_Acct_Name;
-----------------------------------------------------------------------
FUNCTION Get_Info_By_Email (in_email goremal.goremal_email_address%type,
                            in_return_type varchar2 default 'AIF')
  RETURN VARCHAR2
--  written by Elizabeth  9/5/2008
--  returns information based on in_email and in_return_type
--  can return multiple lines
--
--    in_return_type values:
--       P   - returns PIDM
--       I   - returns ID Number
--       N   - returns Name (last, first middle)
--       NI   - returns Name (last, first middle)
--       ALL  - returns ID (first 10 characters) , email type(6), email status(3), and Name
--
-----------------------------------------------------------------------
IS
  out_info          varchar2(2000) := null;
  crlf              VARCHAR2(2):=chr(13)||chr(10);
  email_count       integer := 0;
BEGIN
  out_info := '';
  FOR email_addr IN
    (SELECT goremal_pidm, goremal_emal_code, goremal_status_ind, goremal_preferred_ind
       FROM goremal
      WHERE upper(goremal_email_address)  = upper(in_email)
    )
  LOOP
    email_count := email_count + 1;
	if email_count > 1 then
	   out_info := out_info || crlf;
	end if;
	IF in_return_type = 'P' THEN
	   out_info := out_info ||  trim(to_char(email_addr.goremal_pidm));
	END IF;
	IF in_return_type = 'I' THEN
	   out_info := out_info ||  get_id(email_addr.goremal_pidm);
    END IF;
	IF in_return_type = 'N' THEN
	   out_info := out_info ||  get_name(email_addr.goremal_pidm, 'LFM');
    END IF;
	IF in_return_type = 'NI' THEN
	   out_info := out_info
  	            ||  rpad(get_id(email_addr.goremal_pidm),10,' ')
				||  get_name(email_addr.goremal_pidm, 'LFM');
    END IF;
	IF in_return_type = 'ALL' THEN
	   out_info := out_info
  	            ||  rpad(get_id(email_addr.goremal_pidm),10,' ')
  	            ||  rpad(email_addr.goremal_emal_code,6,' ')
  	            ||  rpad(email_addr.goremal_status_ind,4,' ')
				||  substr(rpad(get_name(email_addr.goremal_pidm, 'LFM'),50,' '),1,50);
    END IF;
  END LOOP;
  return  out_info;
END Get_Info_By_Email;
--
--
-----------------------------------------------------------------------
FUNCTION is_valid_major
    (in_pidm        spriden.spriden_pidm%type,
	 in_major_code  sorlfos.sorlfos_majr_code%type,
	 in_lfst_code   sorlfos.sorlfos_lfst_code%type,
	 in_lmod_code   sorlcur.sorlcur_lmod_code%type,
	 in_term        stvterm.stvterm_code%type)
  RETURN varchar2
--  written by Elizabeth  12/5/2008 (with Bob Felix's help)
--  returns 'Y' if valid major, minor, concentration etc.
--
--    in_lfst_code = MAJOR, MINOR, CONCENTRATION, etc.
--    in_lmod_code = LEARNER, ADMISSIONS, OUTCOME, etc.
---
-----------------------------------------------------------------------
IS
   major_count    integer := 0;
BEGIN
  SELECT count(*)
    INTO major_count
    FROM sorlfos c, sorlcur f
   WHERE c.sorlfos_seqno =
     (SELECT max(d.sorlfos_seqno)
        FROM sorlfos d
       WHERE d.sorlfos_lcur_seqno = f.sorlcur_seqno
         AND d.sorlfos_priority_no = c.sorlfos_priority_no
         AND d.sorlfos_pidm = c.sorlfos_pidm)
     AND c.sorlfos_lcur_seqno = f.sorlcur_seqno
     AND c.sorlfos_cact_code = 'ACTIVE'
	 AND c.sorlfos_lfst_code = in_lfst_code
	 AND c.sorlfos_majr_code = in_major_code
     AND c.sorlfos_pidm = f.sorlcur_pidm
     AND f.sorlcur_seqno =
     (SELECT max(g.sorlcur_seqno)
        FROM sorlcur g
       WHERE g.sorlcur_lmod_code = 'LEARNER'
         AND g.sorlcur_priority_no = f.sorlcur_priority_no
         AND g.sorlcur_term_code <= in_term
         AND g.sorlcur_pidm = f.sorlcur_pidm)
     AND f.sorlcur_cact_code = 'ACTIVE'
     AND f.sorlcur_lmod_code = in_lmod_code
     AND f.sorlcur_pidm = in_pidm;
   IF major_count > 0 THEN
      RETURN 'Y';
   ELSE
      RETURN 'N';
   END IF;
END is_valid_major;
--
--
-----------------------------------------------------------------------
FUNCTION is_valid_dept
    (in_pidm      spriden.spriden_pidm%type,
	 in_dept_code sorlfos.sorlfos_majr_code%type,
	 in_lfst_code sorlfos.sorlfos_lfst_code%type,
	 in_lmod_code sorlcur.sorlcur_lmod_code%type,
	 in_term      stvterm.stvterm_code%type)
  RETURN varchar2
--  written by Elizabeth  12/5/2008 (with Bob Felix's help)
--  returns 'Y' if valid department for the student (based on major, minor, concentration)
--
--    in_lfst_code = MAJOR, MINOR, CONCENTRATION, etc.
--    in_lmod_code = LEARNER, ADMISSIONS, OUTCOME, etc.
-----------------------------------------------------------------------
IS
   dept_count    integer := 0;
BEGIN
  SELECT count(*)
    INTO dept_count
    FROM sorlfos c, sorlcur f
   WHERE c.sorlfos_seqno =
     (SELECT max(d.sorlfos_seqno)
        FROM sorlfos d
       WHERE d.sorlfos_lcur_seqno = f.sorlcur_seqno
         AND d.sorlfos_priority_no = c.sorlfos_priority_no
         AND d.sorlfos_pidm = c.sorlfos_pidm)
     AND c.sorlfos_lcur_seqno = f.sorlcur_seqno
     AND c.sorlfos_cact_code = 'ACTIVE'
	 AND c.sorlfos_lfst_code = in_lfst_code
	 AND c.sorlfos_dept_code = in_dept_code
     AND c.sorlfos_pidm = f.sorlcur_pidm
     AND f.sorlcur_seqno =
     (SELECT max(g.sorlcur_seqno)
        FROM sorlcur g
       WHERE g.sorlcur_lmod_code = 'LEARNER'
         AND g.sorlcur_priority_no = f.sorlcur_priority_no
         AND g.sorlcur_term_code <= in_term
         AND g.sorlcur_pidm = f.sorlcur_pidm)
     AND f.sorlcur_cact_code = 'ACTIVE'
     AND f.sorlcur_lmod_code = in_lmod_code
     AND f.sorlcur_pidm = in_pidm;
   IF dept_count > 0 THEN
      RETURN 'Y';
   ELSE
      RETURN 'N';
   END IF;
END is_valid_dept;
--
--
-----------------------------------------------------------------------
FUNCTION is_valid_college
    (in_pidm      spriden.spriden_pidm%type,
	 in_coll_code sorlcur.sorlcur_coll_code%type,
	 in_lfst_code sorlfos.sorlfos_lfst_code%type,
	 in_lmod_code sorlcur.sorlcur_lmod_code%type,
	 in_term      stvterm.stvterm_code%type)
  RETURN varchar2
--  written by Elizabeth  12/5/2008 (with Bob Felix's help)
--  returns 'Y' if valid department for the student (based on major, minor, concentration)
--
--    in_lfst_code = MAJOR, MINOR, CONCENTRATION, etc.
--    in_lmod_code = LEARNER, ADMISSIONS, OUTCOME, etc.
-----------------------------------------------------------------------
IS
   coll_count    integer := 0;
BEGIN
  IF in_lfst_code <> 'MINOR' THEN
    BEGIN
      SELECT count(*)
        INTO coll_count
        FROM sorlfos c, sorlcur f
       WHERE c.sorlfos_seqno =
         (SELECT max(d.sorlfos_seqno)
            FROM sorlfos d
           WHERE d.sorlfos_lcur_seqno = f.sorlcur_seqno
             AND d.sorlfos_priority_no = c.sorlfos_priority_no
             AND d.sorlfos_pidm = c.sorlfos_pidm)
         AND c.sorlfos_lcur_seqno = f.sorlcur_seqno
         AND c.sorlfos_cact_code = 'ACTIVE'
	     AND c.sorlfos_lfst_code = in_lfst_code
         AND c.sorlfos_pidm = f.sorlcur_pidm
         AND f.sorlcur_seqno =
         (SELECT max(g.sorlcur_seqno)
            FROM sorlcur g
           WHERE g.sorlcur_lmod_code = 'LEARNER'
             AND g.sorlcur_priority_no = f.sorlcur_priority_no
             AND g.sorlcur_term_code <= in_term
             AND g.sorlcur_pidm = f.sorlcur_pidm)
	     AND f.sorlcur_coll_code = in_coll_code
         AND f.sorlcur_cact_code = 'ACTIVE'
         AND f.sorlcur_lmod_code = in_lmod_code
         AND f.sorlcur_pidm = in_pidm;
    END;
  ELSE
--
--  for minors, we need to check szvmajr because there is no way in standard Banner tables to
--  tie a minor to a college code
--
    BEGIN
      SELECT count(*)
        INTO coll_count
        FROM szvmajr, sorlfos c, sorlcur f
       WHERE szvmajr_code = sorlfos_majr_code
         AND c.sorlfos_seqno =
         (SELECT max(d.sorlfos_seqno)
            FROM sorlfos d
           WHERE d.sorlfos_lcur_seqno = f.sorlcur_seqno
             AND d.sorlfos_priority_no = c.sorlfos_priority_no
             AND d.sorlfos_pidm = c.sorlfos_pidm)
         AND c.sorlfos_lcur_seqno = f.sorlcur_seqno
         AND c.sorlfos_cact_code = 'ACTIVE'
	     AND c.sorlfos_lfst_code = in_lfst_code
         AND c.sorlfos_pidm = f.sorlcur_pidm
         AND f.sorlcur_seqno =
         (SELECT max(g.sorlcur_seqno)
            FROM sorlcur g
           WHERE g.sorlcur_lmod_code = 'LEARNER'
             AND g.sorlcur_priority_no = f.sorlcur_priority_no
             AND g.sorlcur_term_code <= in_term
             AND g.sorlcur_pidm = f.sorlcur_pidm)
	     AND f.sorlcur_coll_code = in_coll_code
         AND f.sorlcur_cact_code = 'ACTIVE'
         AND f.sorlcur_lmod_code = in_lmod_code
         AND f.sorlcur_pidm = in_pidm;
    END;
  END IF;
  IF coll_count > 0 THEN
     RETURN 'Y';
  ELSE
     RETURN 'N';
  END IF;
END is_valid_college;
--
--
-----------------------------------------------------------------------
FUNCTION Get_Major_Advisor(in_pidm sgradvr.sgradvr_pidm%type,
                             in_term sgradvr.sgradvr_term_code_eff%type,
							 in_majr sorlfos.sorlfos_majr_code%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  written by Elizabeth  01/22/2009
--  FUNCTION returns pidm of student's advisor based on major code
advisor_pidm         number;
BEGIN
    advisor_pidm := NULL;
	IF in_majr IS NULL or in_majr IN ('UND', '0000') THEN
	   advisor_pidm := NULL;
	ELSE
       FOR advisor in
	   (
        SELECT sirdpcl_pidm, sirdpcl_term_code_eff, sirdpcl_coll_code, sirdpcl_dept_code, sgradvr_advr_pidm, sorlfos_majr_code, sorlfos_dept_code, sorlcur_coll_code
     	  FROM sirdpcl, sorlfos, sorlcur, sgradvr
         WHERE sirdpcl_term_code_eff =
		         (SELECT MAX(c.sirdpcl_term_code_eff)
		            FROM sirdpcl c
			       WHERE c.sirdpcl_term_code_eff <= in_term
			         AND c.sirdpcl_dept_code = sorlfos_dept_code
--		          and c.sirdpcl_coll_code = sorlcur_coll_code --- can't use this because coll code doesn't always match up
                     AND c.sirdpcl_pidm = sgradvr_advr_pidm)
	       AND sirdpcl_dept_code = sorlfos_dept_code
--	   and sirdpcl_coll_code = sorlcur_coll_code --- can't use this because coll code doesn't always match up
	       AND sirdpcl_pidm = sgradvr_advr_pidm
           AND sgradvr_term_code_eff =
              (SELECT MAX (sgradvr_term_code_eff)
                 FROM sgradvr b
                WHERE b.sgradvr_pidm = in_pidm
                  AND b.sgradvr_term_code_eff <= in_term)
           AND sgradvr_pidm = sorlcur_pidm
           AND sorlfos_majr_code = in_majr
           AND sorlfos_lcur_seqno = sorlcur_seqno
           AND sorlfos_term_code = sorlcur_term_code
           AND sorlfos_pidm = sorlcur_pidm
           AND sorlcur_term_code =
              (SELECT max(b.sorlcur_term_code)
                 FROM sorlcur b
                WHERE b.sorlcur_cact_code = 'ACTIVE'
                  AND b.sorlcur_lmod_code = 'LEARNER'
                  AND b.sorlcur_pidm = in_pidm
                  AND b.sorlcur_term_code <= in_term)
           AND sorlcur_cact_code = 'ACTIVE'
           AND sorlcur_lmod_code = 'LEARNER'
           AND sorlcur_pidm = in_pidm
       )
       LOOP
	     advisor_pidm := advisor.sirdpcl_pidm;
       END LOOP;
	END IF;
    IF advisor_pidm IS NULL THEN
       advisor_pidm := banner_util.Get_Primary_Advisor(in_pidm, in_term);
	END IF;
	RETURN advisor_pidm;
END Get_Major_Advisor;
--
--
-----------------------------------------------------------------------
FUNCTION is_graduate_student(in_pidm     IN spriden.spriden_pidm%type,
                             in_term     IN stvterm.stvterm_code%type DEFAULT NULL,
							 in_appl_no  IN saradap.saradap_appl_no%type DEFAULT NULL)
RETURN VARCHAR2
-- revised by Elizabeth   4/26/2012
-- Returns 'Y' if the student has a recruit type of 'GR' or a studet level of 'GR'; otherwise, returns 'N'
-- in_appl_no parameter is now ignored but maintained for backward compatability
-----------------------------------------------------------------------
IS
    GRADUATE_FLAG  VARCHAR2(1);
	term_code      VARCHAR2(6);
BEGIN
    IF in_term IS NOT NULL THEN
	   term_code := in_term;
	ELSE
	   term_code := get_current_term;
	END IF;
    GRADUATE_FLAG := 'N';
	BEGIN
	  SELECT 'Y'
	    INTO GRADUATE_FLAG
	    FROM SARADAP
	   WHERE saradap_pidm = in_pidm
	     AND saradap_term_code_entry = term_code
	     AND saradap_appl_no =
		    (SELECT max(b.saradap_appl_no)
			   FROM saradap b
			  WHERE b.saradap_pidm = in_pidm
			    AND b.saradap_term_code_entry = term_code);
	  EXCEPTION WHEN OTHERS THEN GRADUATE_FLAG := 'N';
	END;
	IF GRADUATE_FLAG = 'Y' or get_student_level(in_pidm,term_code) = 'GR' THEN
  	   RETURN 'Y';
	ELSE
       RETURN 'N';
    END IF;
END is_graduate_student;
-----------------------------------------------------------------------
FUNCTION get_deceased_date(in_pidm     IN spriden.spriden_pidm%type)
RETURN DATE
--  written by Elizabeth   10/28/2009
--  Returns SPBPERS_DEAD_DATE for a pidm
-----------------------------------------------------------------------
IS
   deceased_date   DATE := NULL;
BEGIN
   SELECT SPBPERS_DEAD_DATE
     INTO deceased_date
	 FROM SPBPERS
	WHERE SPBPERS_PIDM = in_pidm;
   RETURN deceased_date;
END get_deceased_date;
--
--
-----------------------------------------------------------------------
FUNCTION get_admit_term(in_pidm     IN spriden.spriden_pidm%type)
RETURN VARCHAR2
--  written by Elizabeth   10/6/2010
--  Returns maximum admissions term for a pidm
-----------------------------------------------------------------------
IS
   term_code_entry    saturn.saradap.saradap_term_code_entry%type;
BEGIN
   SELECT max(saradap_term_code_entry)
     INTO term_code_entry
	 FROM SARADAP
	WHERE SARADAP_PIDM = in_pidm;
   RETURN term_code_entry;
END get_admit_term;
--
--
---------------------------------------------------------------------------
FUNCTION Has_Role(in_pidm IN spriden.spriden_pidm%type,
                     in_role IN twgrrole.twgrrole_role%type)
  RETURN BOOLEAN IS
--  Returns true if a user has the specified web tailor role; otherwise, returns false
  check_count     integer := 0;
BEGIN
  SELECT count(*)
    INTO check_count
    FROM twgrrole
   WHERE twgrrole_pidm = in_pidm
     AND upper(twgrrole_role) = upper(in_role);
   IF check_count = 0 THEN
      RETURN false;
   ELSE
      RETURN true;
   END IF;
END Has_Role;
--------------------------------------------------------------
--
--
--------------------------------------------------------------
FUNCTION workflow_exists(event_code in varchar2,
                         param_name in varchar2,
                         param_value in varchar2)
  RETURN BOOLEAN IS
--------------------------------------------------------------
--  Returns true if a workflow was already triggered a the specified condition
--
--
-- Bob Getty - 1/10/11
--
-- As an example, for me to test my new gift workflow on a particular gift id
-- one of the parameters to the workflow):
--    if workflow_exists('NEWGIFT','GIFT_NO','0211274') then ...
-- The param_name and param_value uniquely identify a workflow
-- for a particular event_code (the workflow name).
--------------------------------------------------------------
there varchar2(1);
begin
  select 'Y' into there
    from general.gobeqrc b
    join general.goreqrc r on r.goreqrc_seqno = b.gobeqrc_seqno
    where b.gobeqrc_eqnm_code = event_code
     and r.goreqrc_parm_name = param_name
      and r.goreqrc_parm_value = param_value;
  return(true);
exception
  when no_data_found then
    return(false);
end workflow_exists;
--------------------------------------------------------------
--
--
-----------------------------------------------------------------------
FUNCTION Is_Accepted_Student(in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2 IS
--  Returns 'Y' (if this is an accepted student) or 'N' (if not)
-----------------------------------------------------------------------
--  written by Elizabeth  1/11/2011
    accept_count      integer;
	current_term      varchar2(6);
BEGIN
    current_term := get_current_term;
	accept_count := 0;
    BEGIN
	   SELECT count(*)
         INTO accept_count
         FROM sarappd
        WHERE Is_A_Student(in_pidm, current_term) = 'N'
		  AND ((sarappd_term_code_entry in
                 (select stvterm_code
                    from stvterm
                   where to_char(stvterm_start_date, 'yyyymmdd')
                      >=  to_char(sysdate, 'yyyymmdd')
			      )
			   )
           OR sarappd_term_code_entry = current_term)
          AND (sarappd_apdc_code = 'RD'
		   OR  sarappd_apdc_code in ('GA','GC','GP','GR', 'GV')
           OR  sarappd_apdc_code like 'A%'
           OR  sarappd_apdc_code = 'RS')
		   AND sarappd_pidm = in_pidm;
    END;
    IF accept_count > 0 THEN
	   RETURN 'Y';
	ELSE
       RETURN 'N';
    END IF;
END Is_Accepted_Student;
-----------------------------------------------------------------------
--
-----------------------------------------------------------------------
FUNCTION Is_Accepted_Student(in_pidm spriden.spriden_pidm%type,
          in_term sarappd.sarappd_term_code_entry%type)
  RETURN VARCHAR2
IS
--  Returns 'Y' (if this is an accepted student for specific term) or 'N' (if not)
-----------------------------------------------------------------------
--  written by Jonathan  10/25/2011
  accept_count      integer;
BEGIN
	accept_count := 0;
    BEGIN
	   SELECT count(*)
         INTO accept_count
         FROM sarappd
        WHERE Is_A_Student(in_pidm, in_term) = 'N'
		  AND sarappd_term_code_entry = in_term
      AND (sarappd_apdc_code = 'RD'
	   OR  sarappd_apdc_code in ('GA','GC','GP','GR', 'GV')
       OR  sarappd_apdc_code like 'A%'
       OR  sarappd_apdc_code = 'RS')
		   AND sarappd_pidm = in_pidm;
    END;
    IF accept_count > 0 THEN
	   RETURN 'Y';
	ELSE
       RETURN 'N';
    END IF;
end Is_Accepted_Student;
-----------------------------------------------------------------------
--
-----------------------------------------------------------------------
FUNCTION Is_A_Graduate (in_pidm IN aprcatg.aprcatg_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  Returns 'Y' if a Messiah Grad or 'N' if not
-----------------------------------------------------------------------
--  written by Elizabeth 10/4/2011
    grad_flag   varchar2(1) := 'N';
BEGIN
  BEGIN
    SELECT max('Y')
	  INTO grad_flag
	  FROM aprcatg
	 WHERE aprcatg_pidm = in_pidm
	   AND aprcatg_donr_code IN ('ALUM', 'ALGR');
    EXCEPTION WHEN OTHERS THEN grad_flag := 'N';
  END;
  IF grad_flag IS NULL THEN
     grad_flag := 'N';
  END IF;
  RETURN grad_flag;
END Is_A_Graduate;
--
-----------------------------------------------------------------------
FUNCTION Is_Rolled_GR_Student (in_pidm IN spriden.spriden_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  Returns 'Y' if this is a graduate student with a decision code of
--  GR = Graduate Rolled to Student or GP = Graduate Deposit Paid
-----------------------------------------------------------------------
--  written by Elizabeth 10/4/2011
    grad_flag   varchar2(1) := 'N';
BEGIN
  BEGIN
    SELECT max('Y')
	  INTO grad_flag
	  FROM sarappd
	 WHERE sarappd_pidm = in_pidm
	   AND sarappd_apdc_code IN ('GR', 'GP');
    EXCEPTION WHEN OTHERS THEN grad_flag := 'N';
  END;
  IF grad_flag IS NULL THEN
     grad_flag := 'N';
  END IF;
  RETURN grad_flag;
END Is_Rolled_GR_Student;
--
-----------------------------------------------------------------------
FUNCTION Is_Active_Employee (in_pidm pebempl.pebempl_pidm%type)
  RETURN VARCHAR2 is
-----------------------------------------------------------------------
-- returns 'Y' (if employee) or null
  employee_flag    varchar2(1) := 'N';
BEGIN
  BEGIN
    SELECT MAX('Y')
	  INTO employee_flag
	  FROM pebempl
     WHERE pebempl_pidm = in_pidm
	   AND pebempl_empl_status = 'A';
    EXCEPTION WHEN OTHERS THEN employee_flag := 'N';
  END;
  RETURN employee_Flag;
END Is_Active_Employee;
-----------------------------------------------------------------------
FUNCTION Is_Active_Org (in_pidm spriden.spriden_pidm%type)
  RETURN VARCHAR2 IS
-----------------------------------------------------------------------
--  Returns 'Y' if this is a orgaznization is considered active
-- (not Donor Cat of 'UORG' and MA address is inactive)
--  Otherwise returns null
-- rgetty
-- Removed address check - too inconsistent.
-------------------------------------------------------------------------
  ret_val varchar2(1);
BEGIN
  select distinct 'Y' into ret_val
    from spriden s
    join aprcatg c on c.APRCATG_PIDM = s.SPRIDEN_PIDM
   where s.spriden_pidm = in_pidm
     and s.spriden_last_name is not null
     and s.spriden_change_ind is null
--     and (banner_util.Get_Address_Lines(in_pidm,'MA','1') is not null and
     and c.aprcatg_donr_code != 'UORG';
  return ret_val;
END Is_Active_Org;
-------------------------------------------------------------------------
END banner_util;
/

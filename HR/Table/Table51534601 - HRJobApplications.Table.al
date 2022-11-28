table 51534601 "HR Job Applications"
{
    Caption = 'HR Job Applications';
    DrillDownPageID = "HR Job Applications List";
    LookupPageID = "HR Job Applications List";

    fields
    {
        field(1; "Application No"; Code[20])
        { //jj170222 Added th no series function 
            NotBlank = false;

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if "Application No" <> xRec."Application No" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Job Application Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "First Name"; Text[100])
        {
        }
        field(3; "Middle Name"; Text[50])
        {
        }
        field(4; "Last Name"; Text[50])
        {

            trigger OnValidate()
            var
                Reason: Text[30];
            begin
            end;
        }
        field(5; Initials; Text[15])
        {
        }
        field(7; "Search Name"; Code[50])
        {
        }
        field(8; "Postal Address"; Text[80])
        {
        }
        field(9; "Residential Address"; Text[80])
        {
        }
        field(10; City; Text[30])
        {
        }
        field(11; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(12; County; Text[30])
        {
        }
        field(13; "Home Phone Number"; Text[30])
        {
        }
        field(14; "Cell Phone Number"; Text[30])
        {
        }
        field(15; "Work Phone Number"; Text[30])
        {
        }
        field(16; "Ext."; Text[7])
        {
        }
        field(17; "E-Mail"; Text[80])
        {
        }
        field(19; Picture; BLOB)
        {
            SubType = Bitmap;
        }
        field(20; "ID Number"; Text[30])
        {

            trigger OnValidate()
            begin
                HRJobApp.Reset;
                HRJobApp.SetRange(HRJobApp."ID Number", "ID Number");
                if HRJobApp.Find('-') then begin
                    Error('This ID Number has been used in a prior Job Application.');
                end;
            end;
        }
        field(21; Gender; Option)
        {
            OptionCaption = 'Female,Male';
            OptionMembers = Female,Male,Both;
        }
        field(22; "Country Code"; Code[20])
        {
            TableRelation = "Country/Region";
        }
        field(23; Status; Option)
        {
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;
        }
        field(24; Comment; Boolean)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(25; "Fax Number"; Text[30])
        {
        }
        field(26; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(27; "Ethnic Origin"; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(28; "First Language (R/W/S)"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER(Language));
        }
        field(29; "Driving Licence"; Code[20])
        {
        }
        field(30; Disabled; Option)
        {
            OptionMembers = No,Yes," ";
        }
        field(31; "Health Assesment?"; Boolean)
        {
        }
        field(32; "Health Assesment Date"; Date)
        {
        }
        field(33; "Date Of Birth"; Date)
        {

            trigger OnValidate()
            begin
                if "Date Of Birth" >= Today then begin
                    Error('Date of Birth cannot be after %1', Today);
                end;
            end;
        }
        field(34; Age; Text[80])
        {
        }
        field(35; "Second Language (R/W/S)"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER(Language));
        }
        field(36; "Additional Language"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER(Language));
        }
        field(37; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(38; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(39; "Termination Category"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
            end;
        }
        field(40; "Postal Address2"; Text[30])
        {
        }
        field(41; "Postal Address3"; Text[20])
        {
        }
        field(42; "Residential Address2"; Text[30])
        {
        }
        field(43; "Residential Address3"; Text[20])
        {
        }
        field(44; "Post Code2"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(45; Citizenship; Code[20])
        {
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            begin
                Country.Reset;
                Country.SetRange(Country.Code, Citizenship);
                if Country.Find('-') then begin
                    "Citizenship Details" := Country.Name;
                end;
            end;
        }
        field(46; "Disabling Details"; Text[50])
        {
        }
        field(47; "Disability Grade"; Text[30])
        {
        }
        field(48; "Passport Number"; Text[30])
        {
        }
        field(49; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(51; Region; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(52; "First Language Read"; Boolean)
        {
        }
        field(53; "First Language Write"; Boolean)
        {
        }
        field(54; "First Language Speak"; Boolean)
        {
        }
        field(55; "Second Language Read"; Boolean)
        {
        }
        field(56; "Second Language Write"; Boolean)
        {
        }
        field(57; "Second Language Speak"; Boolean)
        {
        }
        field(58; "PIN Number"; Code[20])
        {
        }
        field(59; "Job Applied For"; Text[30])
        {
            Editable = false;
        }
        field(60; "Employee Requisition No"; Code[20])
        {
            TableRelation = "HR Employee Requisitions"."Requisition No." WHERE(Closed = CONST(false),
                                                                                Status = CONST(Approved));

            trigger OnValidate()
            begin

                HREmpReq.Reset;
                HREmpReq.SetRange(HREmpReq."Requisition No.", "Employee Requisition No");
                if HREmpReq.Find('-') then
                    "Job Applied For" := HREmpReq."Job ID";
                Score := HREmpReq.Score;
            end;
        }
        field(61; "Total Score"; Decimal)
        {
            FieldClass = Normal;
        }
        field(62; Shortlist; Boolean)
        {
        }
        field(63; Qualified; Boolean)
        {
            Editable = false;
        }
        field(64; Stage; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(65; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(66; "Employee No"; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                //COPY EMPLOYEE DETAILS FROM EMPLOYEE TABLE
                Employee.Reset;
                if Employee.Get("Employee No") then begin
                    "First Name" := Employee."First Name";
                    "Middle Name" := Employee."Middle Name";
                    "Last Name" := Employee."Last Name";
                    "Search Name" := Employee."Search Name";
                    "Postal Address" := Employee."Postal Address";
                    "Residential Address" := Employee."Residential Address";
                    City := Employee.City;
                    "Post Code" := Employee."Post Code";
                    County := Employee.County;
                    "Home Phone Number" := Employee."Home Phone Number";
                    "Cell Phone Number" := Employee."Cell Phone Number";
                    "Work Phone Number" := Employee."Work Phone Number";
                    "Ext." := Employee."Ext.";
                    "E-Mail" := Employee."Personal E-Mail";
                    "ID Number" := Employee."ID Number";
                    Gender := Employee.Gender;
                    "Country Code" := Employee.Citizenship;
                    "Fax Number" := Employee."Fax Number";
                    "Marital Status" := Employee."Marital Status";
                    "Ethnic Origin" := Employee."Ethnic Origin";
                    "First Language (R/W/S)" := Employee."First Language (R/W/S)";
                    //"Driving Licence":=Employee."Has Driving Licence";
                    Disabled := Employee.Disabled;
                    "Health Assesment?" := Employee."Health Assesment?";
                    "Health Assesment Date" := Employee."-";
                    "Date Of Birth" := Employee."Date Of Birth";
                    Age := Employee.Age;
                    "Second Language (R/W/S)" := Employee."Second Language (R/W/S)";
                    "Additional Language" := Employee."Additional Language";
                    "Postal Address2" := Employee."Postal Address 2";
                    "Postal Address3" := Employee."Postal Address 3";
                    "Residential Address2" := Employee."Residential Address 2";
                    "Residential Address3" := Employee."Residential Address 3";
                    "Post Code2" := Employee."Post Code 2";
                    Citizenship := Employee.Citizenship;
                    "Passport Number" := Employee."Passport Number";
                    "First Language Read" := Employee."First Language Read";
                    "First Language Write" := Employee."First Language Write";
                    "First Language Speak" := Employee."First Language Speak";
                    "Second Language Read" := Employee."Second Language Read";
                    "Second Language Write" := Employee."Second Language Write";
                    "Second Language Speak" := Employee."Second Language Speak";
                    "PIN Number" := Employee."PIN Number";

                    "Applicant Type" := "Applicant Type"::Internal;
                    Modify;

                    //DELETE QUALIFICATIONS PREVIOUSLY COPIED
                    AppQualifications.Reset;
                    AppQualifications.SetRange(AppQualifications."Application No", "Application No");
                    if AppQualifications.Find('-') then
                        AppQualifications.DeleteAll;

                    //GET EMPL0YEE QUALIFICATIONS
                    EmpQualifications.Reset;
                    EmpQualifications.SetRange(EmpQualifications."Employee No.", Employee."No.");
                    if EmpQualifications.Find('-') then
                        EmpQualifications.FindFirst;
                    begin
                        AppQualifications.Reset;

                        repeat
                            AppQualifications.Init;
                            AppQualifications."Application No" := "Application No";
                            AppQualifications."Employee No." := "Employee No";
                            AppQualifications."Qualification Type" := EmpQualifications."Qualification Type";
                            AppQualifications."Qualification Code" := EmpQualifications."Qualification Code";
                            AppQualifications."Qualification Description" := EmpQualifications."Qualification Description";
                            AppQualifications."From Date" := EmpQualifications."From Date";
                            AppQualifications."To Date" := EmpQualifications."To Date";
                            AppQualifications.Type := EmpQualifications.Type;
                            AppQualifications."Institution/Company" := EmpQualifications."Institution/Company";
                            AppQualifications.Insert();

                        until EmpQualifications.Next = 0;
                    end;
                    //add the persons employement history
                    EmpHistory.Reset;
                    EmpHistory.SetRange(EmpHistory.Status, EmpHistory.Status::Applicant);
                    EmpHistory.SetRange(EmpHistory."Employee No.", "Application No");
                    if EmpHistory.FindSet then EmpHistory.DeleteAll;

                    EmpHistory.Reset;
                    EmpHistory.SetRange(EmpHistory.Status, EmpHistory.Status::Employee);
                    EmpHistory.SetRange(EmpHistory."Employee No.", "Employee No");
                    if EmpHistory.FindSet then
                        repeat
                            EmpHistory2.Init;
                            EmpHistory2.TransferFields(EmpHistory);
                            EmpHistory2."Employee No." := "Application No";
                            EmpHistory2.Status := EmpHistory2.Status::Applicant;
                        until EmpHistory.Next = 0;


                end;

                /*
                END ELSE BEGIN
                "First Name":='';
                "Middle Name":='';
                "Last Name":='';
                "Search Name":='';
                "Postal Address":='';
                "Residential Address":='';
                City:=Employee.City;
                "Post Code":='';
                County:='';
                "Home Phone Number":='';
                "Cell Phone Number":='';
                "Work Phone Number":='';
                "Ext.":='';
                "E-Mail":='';
                "ID Number":='';
                
                "Country Code":='';
                "Fax Number":='';
                
                "First Language (R/W/S)":='';
                //"Driving Licence":=Employee."Has Driving Licence";
                
                "Health Assesment Date":=0D;
                "Date Of Birth":=0D;
                Age:='';
                "Second Language (R/W/S)":='';
                "Additional Language":='';
                "Postal Address2":='';
                "Postal Address3":='';
                "Residential Address2":='';
                "Residential Address3":='';
                "Post Code2":='';
                Citizenship:='';
                "Passport Number":='';
                "First Language Read":=FALSE;
                "First Language Write":=FALSE;
                "First Language Speak":=FALSE;
                "Second Language Read":=FALSE;
                "Second Language Write":=FALSE;
                "Second Language Speak":=FALSE;
                "PIN Number":='';
                
                "Applicant Type":="Applicant Type"::External;
                MODIFY;
                
                //DELETE QUALIFICATIONS PREVIOUSLY COPIED
                AppQualifications.RESET;
                AppQualifications.SETRANGE(AppQualifications."Application No","Application No");
                IF AppQualifications.FIND('-') THEN
                AppQualifications.DELETEALL;
                
                //DELETE APPLICANT REFEREES
                AppRefferees.RESET;
                AppRefferees.SETRANGE(AppRefferees."Job Application No","Application No");
                IF AppRefferees.FIND('-') THEN
                AppRefferees.DELETEALL;
                
                //DELETE APPLICANT HOBBIES
                AppHobbies.RESET;
                AppHobbies.SETRANGE(AppHobbies."Job Application No","Application No");
                IF AppHobbies.FIND('-') THEN
                AppHobbies.DELETEALL;
                
                END;
                */

            end;
        }
        field(67; "Applicant Type"; Option)
        {
            Editable = false;
            OptionCaption = 'External,Internal';
            OptionMembers = External,Internal;
        }
        field(68; "Interview Invitation Sent"; Boolean)
        {
            Editable = false;
        }
        field(69; "Date Applied"; Date)
        {
        }
        field(70; "Citizenship Details"; Text[60])
        {
        }
        field(71; Expatriate; Boolean)
        {
        }
        field(72; "Interview Date"; Date)
        {
        }
        field(73; Time; Date)
        {
        }
        field(74; "Supervisor/Manager"; Code[50])
        {
            TableRelation = "HR Jobs"."Job ID";
        }
        field(75; "Supervisor's Job Title"; Text[250])
        {
        }
        field(76; "Current Job Role"; Text[40])
        {
        }
        field(77; "Current Employer"; Text[30])
        {
        }
        field(78; "Last Offer Date"; Date)
        {
        }
        field(79; "Current Gross Salary (P/A)"; Decimal)
        {
        }
        field(80; "Current Net Salary (P/A)"; Decimal)
        {
        }
        field(81; "Employee Creation Date"; Date)
        {
        }
        field(82; "Current Salary"; Decimal)
        {
        }
        field(83; "Expected Salary"; Decimal)
        {
        }
        field(84; "Sent to HR"; Boolean)
        {
        }
        field(85; Score; Decimal)
        {
        }
        field(86; "Qualified (Interview)"; Boolean)
        {
        }
        field(87; "Test Invitation Sent"; Boolean)
        {
        }
        field(88; "Qualified (Test)"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Application No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Application No", "First Name", "Middle Name", "Last Name")
        {
        }
    }

    trigger OnInsert()
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Application No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Job Application Nos");
            NoSeriesMgt.InitSeries(HRSetup."Job Application Nos", xRec."No. Series", 0D, "Application No", "No. Series");
        end;

        "Date Applied" := Today;
    end;

    var
        HREmpReq: Record "HR Employee Requisitions";
        Employee: Record "HR Employees";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmpQualifications: Record "HR Employee Qualifications";
        AppQualifications: Record "HR Applicant Qualifications";
        AppRefferees: Record "HR Applicant Referees";
        HRJobApp: Record "HR Job Applications";
        Country: Record "Country/Region";
        EmpHistory: Record "HR Employment History";
        EmpHistory2: Record "HR Employment History";

    [Scope('OnPrem')]
    procedure FullName(): Text[100]
    begin
        if "Middle Name" = '' then
            exit("First Name" + ' ' + "Last Name")
        else
            exit("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;
}


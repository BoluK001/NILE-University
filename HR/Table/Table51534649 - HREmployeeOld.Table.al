table 51534649 "HR Employee Old"
{
    //Caption = 'Employee';
    DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name", "Job Title", "Search Name";
    DrillDownPageID = "HR Appraisal Development Plan";
    LookupPageID = "HR Appraisal Development Plan";

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;
        }
        field(2; "First Name"; Text[80])
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
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(12; County; Text[30])
        {
        }
        field(13; "Home Phone Number"; Text[30])
        {
        }
        field(14; "Cellular Phone Number"; Text[30])
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
        field(21; "ID Number"; Text[30])
        {
        }
        field(22; "Union Code"; Code[20])
        {
            TableRelation = Union;
        }
        field(23; "UIF Number"; Text[30])
        {
        }
        field(24; Gender; Option)
        {
            OptionMembers = Female,Male;
        }
        field(31; Status; Option)
        {
            OptionMembers = Active,Inactive;
        }
        field(36; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(38; "Resource No."; Code[20])
        {
            TableRelation = Resource;
        }
        field(39; Comment; Boolean)
        {
            Editable = false;
        }
        field(40; "Last Date Modified"; Date)
        {
            Editable = false;
        }
        field(41; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(42; "Department Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(49; "Fax Number"; Text[30])
        {
        }
        field(50; "Company E-Mail"; Text[80])
        {
        }
        field(51; Title; Option)
        {
            OptionMembers = MR,MRS,MISS,MS,DR,PROF,CC;
        }
        field(52; "Salespers./Purch. Code"; Code[20])
        {
        }
        field(53; "No. Series"; Code[20])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(54; "Known As"; Text[30])
        {
        }
        field(57; "Full / Part Time"; Option)
        {
            OptionMembers = "Full Time"," Part Time";
        }
        field(58; "Contract Type"; Code[20])
        {
        }
        field(59; "Contract End Date"; Date)
        {
        }
        field(60; "Notice Period"; Code[20])
        {
        }
        field(61; "Union Member?"; Boolean)
        {
        }
        field(62; "Shift Worker?"; Boolean)
        {
        }
        field(63; "Contracted Hours"; Decimal)
        {
        }
        field(64; "Pay Period"; Option)
        {
            OptionMembers = Weekly,"2 Weekly","4 Weekly",Monthly," ";
        }
        field(65; "Pay Per Period"; Decimal)
        {
        }
        field(66; "Cost Code"; Code[20])
        {
        }
        field(68; "PAYE Number"; Text[30])
        {
        }
        field(73; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(74; "Ethnic Origin"; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(75; "First Language (R/W/S)"; Code[20])
        {
        }
        field(76; "Has Driving Licence"; Option)
        {
            OptionMembers = Yes,No;
        }
        field(77; "Vehicle Registration Number"; Code[20])
        {
        }
        field(78; Disabled; Option)
        {
            OptionMembers = No,Yes," ";
        }
        field(79; "Health Assesment?"; Boolean)
        {
        }
        field(80; "Health Assesment Date"; Date)
        {
        }
        field(81; "Date Of Birth"; Date)
        {
        }
        field(82; Age; Text[80])
        {
        }
        field(83; "Date Of Join"; Date)
        {
        }
        field(84; "Length Of Service"; Text[80])
        {
        }
        field(85; "End Of Probation Date"; Date)
        {
        }
        field(86; "Pension Scheme Join"; Date)
        {
        }
        field(87; "Time Pension Scheme"; Text[80])
        {
        }
        field(88; "Medical Scheme Join"; Date)
        {
        }
        field(89; "Time Medical Scheme"; Text[80])
        {
            //This property is currently not supported
            //TestTableRelation = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;
        }
        field(90; "Date Of Leaving"; Date)
        {
        }
        field(91; Paterson; Code[20])
        {
        }
        field(92; Peromnes; Code[20])
        {
        }
        field(93; Hay; Code[20])
        {
        }
        field(94; Castellion; Code[20])
        {
        }
        field(95; "Per Annum"; Decimal)
        {
        }
        field(96; "Allow Overtime"; Option)
        {
            OptionMembers = Yes,No," ";
        }
        field(97; "Medical Scheme No."; Text[30])
        {
        }
        field(98; "Medical Scheme Head Member"; Text[60])
        {
        }
        field(99; "Number Of Dependants"; Integer)
        {
        }
        field(100; "Medical Scheme Name"; Text[150])
        {
        }
        field(101; "Amount Paid By Employee"; Decimal)
        {
        }
        field(102; "Amount Paid By Company"; Decimal)
        {
        }
        field(103; "Receiving Car Allowance ?"; Boolean)
        {
        }
        field(104; "Second Language (R/W/S)"; Code[20])
        {
        }
        field(105; "Additional Language"; Code[20])
        {
        }
        field(106; "Cell Phone Reimbursement?"; Boolean)
        {
        }
        field(107; "Amount Reimbursed"; Decimal)
        {
        }
        field(108; "UIF Country"; Code[20])
        {
            TableRelation = "Country/Region".Code;
        }
        field(109; "Direct/Indirect"; Option)
        {
            OptionMembers = Direct,Indirect;
        }
        field(110; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(111; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(112; "Termination Category"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
            end;
        }
        field(113; "Job Specification"; Code[30])
        {
        }
        field(116; "Postal Address2"; Text[30])
        {
        }
        field(117; "Postal Address3"; Text[20])
        {
        }
        field(118; "Residential Address2"; Text[30])
        {
        }
        field(119; "Residential Address3"; Text[20])
        {
        }
        field(120; "Post Code2"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(121; Citizenship; Code[20])
        {
            TableRelation = "Country/Region".Code;
        }
        field(122; "Name Of Manager"; Text[45])
        {
        }
        field(123; "User ID"; Code[50])
        {
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = true;
        }
        field(124; "Disabling Details"; Text[50])
        {
        }
        field(126; "Passport Number"; Text[30])
        {
        }
        field(127; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(128; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(129; PensionJoin; Text[8])
        {
        }
        field(133; Temp; Text[200])
        {
        }
        field(134; "Employee Qty"; Integer)
        {
            CalcFormula = Count("HR Employee Old");
            FieldClass = FlowField;
        }
        field(135; "Employee Act. Qty"; Integer)
        {
            CalcFormula = Count("HR Employee Old" WHERE("Termination Category" = FILTER(= " ")));
            FieldClass = FlowField;
        }
        field(136; "Employee Arc. Qty"; Integer)
        {
            CalcFormula = Count("HR Employee Old" WHERE("Termination Category" = FILTER(<> " ")));
            FieldClass = FlowField;
        }
        field(137; "Contract Location"; Text[20])
        {
            Description = 'Location where contract was closed';
        }
        field(138; "First Language Read"; Boolean)
        {
        }
        field(139; "First Language Write"; Boolean)
        {
        }
        field(140; "First Language Speak"; Boolean)
        {
        }
        field(141; "Second Language Read"; Boolean)
        {
        }
        field(142; "Second Language Write"; Boolean)
        {
        }
        field(143; "Second Language Speak"; Boolean)
        {
        }
        field(144; "Custom Grading"; Code[20])
        {
        }
        field(145; "PIN Number"; Code[20])
        {
        }
        field(146; "NSSF No."; Code[20])
        {
        }
        field(147; "NHIF No."; Code[20])
        {
        }
        field(148; "Cause of Inactivity Code"; Code[20])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(150; "PAYROLL NO"; Code[20])
        {
        }
        field(151; "Period Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(152; "HELB No"; Text[30])
        {
        }
        field(153; "Co-Operative No"; Text[30])
        {
        }
        field(154; "Wedding Anniversary"; Date)
        {
        }
        field(155; "KPA Code"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(156; "Competency Area"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(158; "Position To Succeed"; Code[20])
        {
        }
        field(159; "Succesion Date"; Date)
        {
        }
        field(160; "Send Alert to"; Code[20])
        {
            TableRelation = "HR Employee Old"."No.";
        }
        field(161; Tribe; Code[20])
        {
        }
        field(162; Religion; Code[20])
        {
        }
        field(163; "Job Title"; Text[50])
        {
        }
        field(165; "Posting Group"; Code[50])
        {
            NotBlank = false;
        }
        field(166; "Payroll Posting Group"; Code[20])
        {
        }
        field(167; "Served Notice Period"; Boolean)
        {
        }
        field(168; "Exit Interview Date"; Date)
        {
        }
        field(169; "Exit Interview Done by"; Code[20])
        {
            TableRelation = "HR Employee Old"."No.";
        }
        field(170; "Allow Re-Employment In Future"; Boolean)
        {
        }
        field(171; "Medical Scheme Name #2"; Text[150])
        {
        }
        field(172; "BOSA No."; Code[20])
        {
        }
        field(173; "Trips Status"; Option)
        {
            OptionMembers = Available,"Scheduled for Trip","On Trip";
        }
        field(174; "Resource Type"; Option)
        {
            OptionMembers = " ",Driver,Mechanic,Administrative;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "First Name")
        {
        }
        key(Key3; "Last Name")
        {
        }
        key(Key4; "ID Number")
        {
        }
        key(Key5; "Known As")
        {
        }
        key(Key6; "User ID")
        {
        }
        key(Key7; "Cost Code")
        {
        }
        key(Key8; "Date Of Join", "Date Of Leaving")
        {
        }
        key(Key9; "Termination Category")
        {
        }
        key(Key10; "Department Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "First Name", "Middle Name", "Last Name", "Job Title", Status)
        {
        }
    }

    var
        PMEmployee: Record "HR Employee Old";
        Res: Record Resource;
        PostCode: Record "Post Code";
        // //NoSeriesMgt: Codeunit NoSeriesManagement;
        OK: Boolean;
        User: Record User;
        ERROR1: Label 'Employee Career History Starting Information already exist.';
        MSG1: Label 'Employee Career History Starting Information successfully created.';
        ReasonDiaglog: Dialog;
        EmpQualification: Record "Employee Qualification";
        PayStartDate: Date;
        PayPeriodText: Text[30];

    [Scope('OnPrem')]
    procedure AssistEdit(OldEmployee: Record "HR Employee Old"): Boolean
    begin
    end;

    [Scope('OnPrem')]
    procedure FullName(): Text[100]
    begin
    end;

    [Scope('OnPrem')]
    procedure CurrentPayDetails()
    begin
    end;

    [Scope('OnPrem')]
    procedure UpdtResUsersetp(var HREmpl: Record "HR Employee Old")
    var
        Res: Record Resource;
        Usersetup: Record "User Setup";
    begin
    end;

    [Scope('OnPrem')]
    procedure GetPayPeriod()
    begin
    end;
}


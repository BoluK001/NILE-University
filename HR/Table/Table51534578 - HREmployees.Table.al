table 51534578 "HR Employees"
{
    //Caption = 'Employee';
    DataCaptionFields = "No.", "Job Title", "First Name", "Middle Name", "Last Name";
    //DrillDownPageID = "HR Employee List Self1";
    //LookupPageID = "HR Employee List Self1";

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if "No." <> xRec."No." then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Employee Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "First Name"; Text[50])
        {

            trigger OnValidate()
            begin
                "Full Name" := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";

                /*                if CustomerRec.Get("No.") then begin
                                    CustomerRec.Validate(CustomerRec.Name, UpperCase("Full Name"));
                                    CustomerRec.Modify;
                                end
                                */
            end;
        }
        field(3; "Middle Name"; Text[50])
        {

            trigger OnValidate()
            begin
                "Full Name" := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
                /*
                                if CustomerRec.Get("No.") then begin
                                    CustomerRec.Validate(CustomerRec.Name, UpperCase("Full Name"));
                                    CustomerRec.Modify;
                                end
                                */ //Dennis
            end;
        }
        field(4; "Last Name"; Text[50])
        {

            trigger OnValidate()
            var
                Reason: Text[30];
            begin
                "Full Name" := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
                /*
                                if CustomerRec.Get("No.") then begin
                                    CustomerRec.Validate(CustomerRec.Name, UpperCase("Full Name"));
                                    CustomerRec.Modify;
                                end
                                */
            end;
        }
        field(5; Designation; Text[50])
        {
        }
        field(7; "Search Name"; Code[50])
        {
        }
        field(8; "Postal Address"; Text[80])
        {
        }
        field(9; "Residential Address"; Text[150])
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

            trigger OnValidate()
            begin
                /*
                IF PostCodes.GET("Post Code") THEN
                City:=PostCodes.City;
                */
                //PostCode.ValidatePostCode(City,"Post Code");

            end;
        }
        field(12; County; Text[30])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST(Country));
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
        field(16; "Ext."; Text[20])
        {
        }
        field(17; "Personal E-Mail"; Text[60])
        {
        }
        field(18; "ID Number"; Code[20])
        {
            Description = 'Stores the id number of the applicant in the database';
        }
        field(19; Picture; BLOB)
        {
            SubType = Bitmap;
        }

        field(22; "Union Code"; Code[50])
        {
        }
        field(23; "UIF Number"; Text[30])
        {
        }
        field(24; Gender; Option)
        {
            OptionCaption = 'Female,Male';
            OptionMembers = Female,Male,Both;
        }
        field(26; "new relationshipmanager"; Text[100])
        {

        }
        field(27; "Old Employee No."; Code[20])
        {

        }
        field(31; Status; Option)
        {
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active,Inactive;

            trigger OnValidate()
            begin
                /*
               IF Rec.  Status <> xRec.  Status THEN BEGIN
                 ValueChangeManagement.ManageHRFieldChange("No.",4,FORMAT(xRec.Status),FORMAT(Rec.  Status),Text016+' '+'Status')
               END;
               */

                HREmpp.SetRange(HREmpp."No.", "No.");
                if HREmpp.FindFirst then begin
                    HREmpp.Validate(Status, Status);
                    HREmpp.Modify;
                end
            end;
        }
        field(36; "Department Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));//, "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin
                /*IF (xRec."Department Code" <> '') AND (xRec."Department Code" <> Rec."Department Code") THEN BEGIN
                  Confm := DIALOG.CONFIRM(text001,FALSE);
                  IF Confm THEN BEGIN
                    CareerEvent.INIT;
                    CareerEvent."Document No.":=0;
                    CareerEvent."Event Type":=CareerEvent."Event Type"::Transfer;
                    CareerEvent."Date Modified":=TODAY;
                    CareerEvent."User Id":=USERID;
                    CareerEvent."Old Status":=xRec."Department Code";
                    CareerEvent."New Value":=Rec."Department Code";
                    CareerEvent."Employee No.":="No.";
                    CareerEvent.INSERT;
                  END;
                END;
                */
                //Validate("Shortcut Dimension 2 Code", "Department Code");
            end;
        }
        field(38; "Resource No."; Code[50])
        {
        }
        field(39; Comment; Boolean)
        {
            Editable = false;
            FieldClass = Normal;
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
        }
        field(43; "Coupled to CRM"; Boolean)
        {

        }
        field(49; "Fax Number"; Text[30])
        {
        }
        field(50; "Company E-Mail"; Text[60])
        {
        }
        field(51; Title; Option)
        {
            OptionCaption = 'MR,MRS,MISS,MS,DR,CC,ASSCOC.PROF,PROF';
            OptionMembers = MR,MRS,MISS,MS,DR,CC,"ASSCOC.PROF",PROF;
        }
        field(52; "Salespers./Purch. Code"; Code[20])
        {
        }
        field(53; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(54; "Also Known As"; Text[30])
        {
        }
        field(57; "Full / Part Time"; Option)
        {
            OptionMembers = "Full Time","Part Time",Contract;
        }
        field(58; "Contract Type"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER("Contract Type"));

            trigger OnValidate()
            begin
                /*TESTFIELD("Date Of Joining the Company");
                
                IF Rec.  "Contract Type" <> xRec.  "Contract Type" THEN BEGIN
                  ValueChangeManagement.ManageHRFieldChange("No.",14,FORMAT(xRec."Contract Type"),FORMAT(Rec.  "Contract Type"),Text016+' '+
                  'Contract Type')
                END;
                
                
                HRLookupValues.RESET;
                HRLookupValues.SETRANGE(HRLookupValues.Type,HRLookupValues.Type::"Contract Type");
                HRLookupValues.SETRANGE(HRLookupValues.Code,"Contract Type");
                IF HRLookupValues.FIND('-') THEN BEGIN
                 EVALUATE(CLen,(FORMAT(HRLookupValues."Contract Length")+'M'));
                 CDate := CALCDATE(CLen,"Date Of Joining the Company");
                 "Contract End Date":= CDate;
                END;
                 */

            end;
        }
        field(59; "Contract End Date"; Date)
        {
            // Editable = false;
        }
        field(60; "Notice Period"; Code[20])
        {
        }
        field(61; "Is Union Member"; Boolean)
        {
        }
        field(62; "Is Shift Worker"; Boolean)
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
        field(67; "Contract Start Date"; Date)
        {
        }
        field(68; "PAYE Number"; Text[30])
        {
        }
        field(73; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,Widowed,Other;

            trigger OnValidate()
            begin
                /*
                //VALUE CHANGE MANAGEMENT
                IF Rec.  "Marital Status" <> xRec.  "Marital Status" THEN BEGIN
                  ValueChangeManagement.ManageHRFieldChange("No.",13,FORMAT(xRec."Marital Status"),FORMAT(Rec.  "Marital Status"),Text016+' '+
                  'Marital Status');
                END;
                */

            end;
        }
        field(74; "Ethnic Origin"; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(75; "First Language (R/W/S)"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER(Language));
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
        field(80; "-"; Date)
        {
        }
        field(81; "Date Of Birth"; Date)
        {

            trigger OnValidate()
            begin

                BirthDay := Format("Date Of Birth", 0, '<Month Text> <Day>');
            end;
        }
        field(82; Age; Text[50])
        {
        }
        field(83; "Date Of Joining the Company"; Date)
        {

            trigger OnValidate()
            begin
                if HREmployee.Get("No.") then begin
                    HREmployee."Date Of Join" := "Date Of Joining the Company";
                    HREmployee.Modify;
                end;
                if Format("Date Of Joining the Company") <> '' then begin
                    "Probation Date 3mnths" := CalcDate('3M', "Date Of Joining the Company");
                    "Confirmation Date" := CalcDate('6M', "Date Of Joining the Company");
                end;
            end;
        }
        field(84; "Length Of Service"; Text[50])
        {
        }
        field(85; "End of Probation Date"; Date)
        {
        }
        field(86; "Pension Scheme Join Date"; Date)
        {
        }
        field(87; "Time on Pension Scheme"; Text[50])
        {
        }
        field(88; "Medical Scheme Join Date"; Date)
        {
        }
        field(89; "Time on Medical Scheme"; Text[50])
        {
            //This property is currently not supported
            //TestTableRelation = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;
        }
        field(90; "Date Of Leaving the Company"; Date)
        {
            Description = 'Used for Separation Purposes';
        }
        field(91; Paterson; Code[20])
        {
            Enabled = false;
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
        field(98; "Medical Scheme Plan"; Option)
        {
            OptionCaption = '  ,High Light, High Value';
            OptionMembers = "  ","High Light","High Value";
        }
        field(99; "Number Of Dependants"; Integer)
        {
        }
        field(100; "Medical Scheme Hospital"; Text[80])
        {
        }
        field(101; "Amount Paid By Employee"; Decimal)
        {
        }
        field(102; "Amount Paid By Company"; Decimal)
        {
        }
        field(103; "Pension Cleared"; Boolean)
        {
        }
        field(104; "Second Language (R/W/S)"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER(Language));
        }
        field(105; "Additional Language"; Code[20])
        {
        }
        field(106; Cleared; Boolean)
        {
            Description = 'Used for Separation Purposes';
        }
        field(107; "Notice Period Days Served"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(108; "UIF Country"; Code[20])
        {
            TableRelation = "Country/Region".Code;
        }
        field(109; "Notice Period Served"; Option)
        {
            OptionCaption = ' ,Fully,Partially';
            OptionMembers = " ",Fully,Partially;
        }
        field(110; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(111; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7","Level 8",AS,"SNR-AS",OUTS;
        }
        field(112; "Termination Grounds"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Deceased,Termination,"Contract Ended",Abscondment,"Appt. Revoked","Contract Termination",Retrenchment,Other;

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
            end;
        }
        field(113; "Job Title"; Code[30])
        {
            TableRelation = "HR Jobs"."Job ID" WHERE(Status = CONST(Approved));

            trigger OnValidate()
            begin
                /*IF (xRec."Job Title" <> '') AND (xRec."Job Title" <> Rec."Job Title") THEN BEGIN
                  Confm := DIALOG.CONFIRM(text001,FALSE);
                  IF Confm THEN BEGIN
                    CareerEvent.INIT;
                    CareerEvent."Document No.":=0;
                    CareerEvent."Event Type":=CareerEvent."Event Type"::Transfer;
                    CareerEvent."Date Modified":=TODAY;
                    CareerEvent."User Id":=USERID;
                    CareerEvent."Old Status":=xRec."Job Title";
                    CareerEvent."New Value":=Rec."Job Title";
                    CareerEvent."Employee No.":="No.";
                    CareerEvent.INSERT;
                  END;
                END;
                 */

                if HRJobs.Get("Job Title") then begin
                    "Job Description" := HRJobs."Job Title";
                    "Job Level" := HRJobs."Job Level";
                    "Department Code" := HRJobs."Shortcut Dimension 3 Code";
                    "Department Level 2" := HRJobs."Department Level 2";
                    Unit := HRJobs.Unit;

                    HRJobs.Validate(HRJobs."Vacant Positions");
                end else begin
                    "Job Description" := '';
                    "Job Level" := '';
                    "Department Code" := '';
                    "Department Level 2" := '';
                    Unit := '';

                end;



                /*
                //VALUE CHANGE MANAGEMENT
                IF Rec.  "Job Title" <> xRec.  "Job Title" THEN BEGIN
                  ValueChangeManagement.ManageHRFieldChange("No.",17,FORMAT(xRec."Job Title"),FORMAT(Rec.  "Job Title"),Text016+' '+'Job Title');
                END;
                */

            end;
        }
        field(114; "Department Level 2"; Code[20])
        {
            TableRelation = Department.Code where("Dim. Code" = field("Department Code"));
        }
        field(115; Unit; Code[20])
        {
            TableRelation = "Sub. Department".Code where("Dept. Code" = field("Department Level 2"));
        }

        field(116; "Postal Address 2"; Text[30])
        {
        }
        field(117; "Postal Address 3"; Text[20])
        {
        }
        field(118; "Residential Address 2"; Text[30])
        {
        }
        field(119; "Residential Address 3"; Text[20])
        {
        }
        field(120; "Post Code 2"; Code[20])
        {
        }
        field(121; Citizenship; Code[20])
        {
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                CIT.Reset;
                CIT.SetRange(CIT.Code, Citizenship);
                if CIT.Find('-') then begin
                    "Citizenship Text" := CIT.Name;
                end;
            end;
        }
        field(122; "Name Of Manager"; Text[45])
        {
        }
        field(123; "User ID"; Code[50])
        {
            // TableRelation = "User Setup"."User ID";
            // //This property is currently not supported
            // //TestTableRelation = true;

            // trigger OnValidate()
            // begin
            //     if Rec."User ID" <> xRec."User ID" then
            //         if "User ID" <> '' then begin
            //             UserSetup.Reset;
            //             UserSetup.Get("User ID");
            //             UserSetup."Assigned to Employee" := true;
            //             UserSetup.Modify;
            //         end else begin
            //             UserSetup.Reset;
            //             UserSetup.Get(xRec."User ID");
            //             UserSetup."Assigned to Employee" := false;
            //             UserSetup.Modify;
            //         end;
            // end;
        }
        field(124; "Disability Details"; Text[50])
        {
        }
        field(126; "Passport Number"; Text[50])
        {

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."Passport Number", "Passport Number");
                if HREmp.Find('-') then begin
                    Error('This Passport Number has been used in a prior Employee Registration');
                end;
            end;
        }
        field(127; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(128; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(129; "Pension Fund Administrator"; Text[25])
        {
            TableRelation = "prInstitutional Membership"."Institution No";
        }
        field(133; Temp; Text[170])
        {
        }
        field(134; "Employee Qty"; Integer)
        {
            FieldClass = Normal;
        }
        field(135; "Employee Act. Qty"; Integer)
        {
            FieldClass = Normal;
        }
        field(136; "Employee Arc. Qty"; Integer)
        {
            FieldClass = Normal;
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
        }
        field(150; "Payroll No"; Code[20])
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
        field(155; Grade; Code[20])
        {
            FieldClass = Normal;
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST(Grade));

            trigger OnValidate()
            begin
                /*
                //VALUE CHANGE MANAGEMENT
                IF Rec.  Grade <> xRec.  Grade THEN BEGIN
                  ValueChangeManagement.ManageHRFieldChange("No.",15,FORMAT(xRec.Grade),FORMAT(Rec.  Grade),Text016+' '+'Job Grade')
                END;
                */

            end;
        }
        field(156; "Competency Area"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(158; "Position To Succeed"; Code[20])
        {
            TableRelation = "HR Lookup Values".Remarks;
        }
        field(159; "Succesion Date"; Date)
        {
        }
        field(160; "Send Alert to"; Code[50])
        {
        }
        field(161; Tribe; Code[20])
        {
        }
        field(162; Religion; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER(Religion));
        }
        field(163; "Job Description"; Text[50])
        {
            Editable = false;
        }
        field(165; "Posting Group"; Code[50])
        {
            NotBlank = true;
            TableRelation = "prEmployee Posting Group".Code;
        }
        field(166; "Payroll Posting Group"; Code[20])
        {
            TableRelation = "Payroll Posting Group Header"."Group Code";
        }
        field(167; "Served Notice Period"; Boolean)
        {
        }
        field(168; "Exit Interview Date"; Date)
        {
        }
        field(169; "Exit Interview Done by"; Code[20])
        {
        }
        field(170; "Allow Re-Employment In Future"; Boolean)
        {
        }
        field(171; "Medical Scheme Name #2"; Text[100])
        {
        }
        field(173; "Trips Status"; Option)
        {
            OptionMembers = Available,"Scheduled for Trip","On Trip";
        }
        field(174; "Resource Type"; Option)
        {
            OptionMembers = " ",Driver,Mechanic,Administrative,Operations;
        }
        field(181; "Payroll Departments"; Code[20])
        {
        }
        field(187; Password; Text[50])
        {
        }
        field(188; "Salary Grade"; Code[20])
        {
            TableRelation = "Salary Grades"."Salary Grade";

            trigger OnValidate()
            begin
                if not Confirm('Changing the Grade will affect the Basic Salary', false) then
                    Error('You have opted to abort the process');


                "Salary Step" := '';

                if SalCard.Get("No.") then begin
                    SalCard."Salary Grade" := "Salary Grade";
                    SalCard.Modify;
                end;

                if HREmployee.Get("No.") then begin
                    HREmployee."Salary Grade" := "Salary Grade";
                    HREmployee.Modify;
                end;
                /*

               IF SalGrade.GET("Salary Grade") THEN BEGIN
                   IF SalGrade."Salary Amount"<>0 THEN BEGIN
                      IF SalCard.GET("No.") THEN BEGIN
                         SalCard."Basic Pay":=SalGrade."Salary Amount";
                         SalCard.MODIFY;
                      END;
                   END;
               END;
               */

                if (xRec."Salary Grade" <> Rec."Salary Grade") and (xRec."Salary Grade" <> '') then begin
                    CareerEvent.Init;
                    CareerEvent."Line No." := 0;
                    CareerEvent."Event Type" := CareerEvent."Event Type"::Promotion;
                    CareerEvent."Date Modified" := Today;
                    CareerEvent."User Id" := UserId;
                    CareerEvent."New Value" := Rec."Salary Grade";
                    CareerEvent."First Name" := "First Name";
                    CareerEvent."Last Name" := "Last Name";
                    CareerEvent."Middle Name" := "Middle Name";
                    CareerEvent."Field Modified" := 'Salary Grade';
                    CareerEvent."Employee No." := "No.";
                    CareerEvent."Old Value" := xRec."Salary Grade";
                    CareerEvent.Insert;
                end;

            end;
        }
        field(189; "Portal Password"; Text[50])
        {
        }
        field(190; "Changed Password"; Boolean)
        {
            Editable = false;
            Enabled = false;
        }
        field(191; "Leave Balance"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(192; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            //Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            //Enabled = false;


            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(193; "Social Security No."; Code[30])
        {
        }
        field(195; "Payroll Code"; Code[20])
        {
            TableRelation = "Dimension Value";
        }
        field(198; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,FOSA;
        }
        field(326; "Payroll Filter Group"; Code[20])
        {
            TableRelation = "Payroll Classification";
        }
        field(2003; "Total Leave Taken"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("No."),
                                                                             "Leave Entry Type" = CONST(Negative),
                                                                             "Leave Type" = FIELD("Leave Type Filter"),
                                                                             "Leave Type" = FILTER('ANNUAL' | 'INTERMITENT'),
                                                                             "Leave Period Closed" = CONST(false),
                                                                             "Leave Period" = FIELD("Current Leave Period")));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(2006; "Total (Leave Days)"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(2007; "Cash - Leave Earned"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(2008; "Reimbursed Leave Days"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("No."),
                                                                             "Posting Date" = FIELD("Date Filter"),
                                                                             "Leave Entry Type" = CONST(Reimbursement),
                                                                             "Leave Type" = FIELD("Leave Type Filter"),
                                                                             Closed = CONST(false)));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                Validate("Allocated Leave Days");
            end;
        }
        field(2009; "Cash per Leave Day"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(2023; "Allocated Leave Days"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("No."),
                                                                             "Posting Date" = FIELD("Date Filter"),
                                                                             "Leave Entry Type" = CONST(Positive),
                                                                             "Leave Type" = FIELD("Leave Type Filter"),
                                                                             Closed = CONST(false)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                /*CALCFIELDS("Total Leave Taken");
                "Total (Leave Days)" := "Allocated Leave Days" + "Reimbursed Leave Days";
                //SUM UP LEAVE LEDGER ENTRIES
                //"//Leave Balance" := "Total (Leave Days)" - "Total Leave Taken";
                //TotalDaysVal := Rec."Total Leave Taken";
                 */

            end;
        }
        field(2024; "End of Contract Date"; Date)
        {
        }
        field(2025; "Main Bank"; Code[20])
        {
            TableRelation = "prBank Structure"."Bank Code";

            trigger OnValidate()
            begin
                if CustomerRec.Get("No.") then begin
                    CustomerRec.Validate(CustomerRec."Address 2", "Main Bank");
                    CustomerRec.Modify;

                end
            end;
        }
        field(2026; "Branch Bank"; Code[20])
        {
            TableRelation = "prBank Structure"."Branch Code" WHERE("Bank Code" = FIELD("Main Bank"));

            trigger OnValidate()
            begin
                PrBankStructure.SetRange(PrBankStructure."Branch Code", "Branch Bank");
                if PrBankStructure.Find('-') then
                    "Main Bank" := PrBankStructure."Bank Code";
            end;
        }
        field(2028; "Alt. Address Start Date"; Date)
        {
            Caption = 'Alt. Address Start Date';
        }
        field(2029; "Alt. Address End Date"; Date)
        {
            Caption = 'Alt. Address End Date';
        }
        field(2030; "Alt. Address Code"; Code[20])
        {
            Caption = 'Alt. Address Code';
            TableRelation = "Alternative Address".Code WHERE("Employee No." = FIELD("No."));
        }
        field(2034; "Bank Account Number"; Code[20])
        {

            trigger OnValidate()
            begin
                if CustomerRec.Get("No.") then begin
                    CustomerRec.Validate(CustomerRec."Bank Account Number", "Bank Account Number");
                    CustomerRec.Modify;

                end
            end;
        }
        field(2035; "Total Absence (Base)"; Decimal)
        {
            CalcFormula = Sum("Employee Absence"."Quantity (Base)" WHERE("Employee No." = FIELD("No."),
                                                                          "Cause of Absence Code" = FIELD("Cause of Absence Filter"),
                                                                          "From Date" = FIELD("Date Filter")));
            Caption = 'Total Absence (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(2036; "Cause of Absence Filter"; Code[20])
        {
            Caption = 'Cause of Absence Filter';
            FieldClass = FlowFilter;
            TableRelation = "Cause of Absence";
        }
        field(2037; "Leave Status"; Option)
        {
            OptionMembers = " ","On Leave",Resumed;
        }
        field(2038; "Leave Type Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HR Leave Types".Code;
        }
        field(2039; "Acrued Leave Days"; Decimal)
        {
        }
        field(2040; "Leave Period Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HR Leave Periods"."Starting Date" WHERE("New Fiscal Year" = CONST(false));
        }
        field(50000; "Citizenship Text"; Text[30])
        {
        }
        field(50001; "Full Name"; Text[60])
        {
        }
        field(50002; Supervisor; Boolean)
        {
        }
        field(50003; "Trip Contract No."; Code[20])
        {
            TableRelation = "Payroll Classification".Code;
        }
        field(50004; "Application No."; Code[20])
        {
        }
        field(50054; "Salary Step"; Code[25])
        {
            TableRelation = "Salary Notch"."Salary Notch" WHERE("Salary Grade" = FIELD("Salary Grade"));

            trigger OnValidate()
            begin
                /*IF (xRec."Salary Step" <> '') AND (xRec."Salary Step" <> Rec."Salary Step") THEN BEGIN
                  Confm := DIALOG.CONFIRM(text001,FALSE);
                  IF Confm THEN BEGIN
                    CareerEvent.INIT;
                    CareerEvent."Document No.":=0;
                    CareerEvent."Event Type":=CareerEvent."Event Type"::Promotion;
                    CareerEvent."Date Modified":=TODAY;
                    CareerEvent."User Id":=USERID;
                    CareerEvent."Old Status":=xRec."Salary Step";
                    CareerEvent."New Value":=Rec."Salary Step";
                    CareerEvent."Employee No.":="No.";
                    CareerEvent.INSERT;
                  END;
                END;
                 */

                if (xRec."Salary Step" <> Rec."Salary Step") /*AND (xRec."Salary Step" <> '')*/ then begin
                    CareerEvent.Init;
                    CareerEvent."Line No." := 0;
                    CareerEvent."Event Type" := CareerEvent."Event Type"::Promotion;
                    CareerEvent."Date Modified" := Today;
                    CareerEvent."User Id" := UserId;
                    CareerEvent."New Value" := Rec."Salary Step";
                    CareerEvent."First Name" := "First Name";
                    CareerEvent."Last Name" := "Last Name";
                    CareerEvent."Middle Name" := "Middle Name";
                    CareerEvent."Field Modified" := 'Salary Notch';
                    CareerEvent."Employee No." := "No.";
                    CareerEvent."Old Value" := xRec."Salary Step";
                    CareerEvent.Insert;
                end;

                if HREmployee.Get("No.") then begin
                    HREmployee."Salary Notch/Step" := "Salary Step";
                    HREmployee.Modify;
                end;


                if SalCard.Get("No.") then begin
                    if SalGrade.Get("Salary Grade") then
                        SalaryGrades."Pays NHF" := SalGrade."Pays NHF";
                    SalCard."Salary Notch" := "Salary Step";

                    SalNotch.Reset;
                    SalNotch.SetRange(SalNotch."Salary Grade", "Salary Grade");
                    SalNotch.SetRange(SalNotch."Salary Notch", "Salary Step");
                    if SalNotch.Find('-') then begin
                        if SalNotch."Basic  Pay" <> 0 then begin
                            if SalCard.Get("No.") then begin
                                SalCard."Basic Pay" := SalNotch."Basic  Pay";
                            end;
                        end;
                    end;

                    SalCard.Modify;
                end else begin
                    SalCard.Init;
                    SalCard."Employee Code" := "No.";
                    SalCard."Pays PAYE" := true;
                    //SalCard."Location/Division":="Location/Division Code";
                    SalCard.Department := "Department Code";
                    //SalCard."Cost Centre":="Cost Center Code";
                    SalCard."Salary Grade" := "Salary Grade";
                    SalCard."Salary Notch" := "Salary Step";
                    if SalGrade.Get("Salary Grade") then
                        SalaryGrades."Pays NHF" := SalGrade."Pays NHF";

                    SalNotch.Reset;
                    SalNotch.SetRange(SalNotch."Salary Grade", "Salary Grade");
                    SalNotch.SetRange(SalNotch."Salary Notch", "Salary Step");
                    if SalNotch.Find('-') then begin
                        if SalNotch."Basic  Pay" <> 0 then begin
                            SalCard."Basic Pay" := SalNotch."Basic  Pay";
                        end;
                    end;
                    SalCard.Insert;

                end;


                objPayrollPeriod.Reset;
                objPayrollPeriod.SetRange(objPayrollPeriod.Closed, false);
                if objPayrollPeriod.Find('-') then begin
                    NotchTrans.Reset;
                    NotchTrans.SetRange(NotchTrans."Salary Grade", "Salary Grade");
                    NotchTrans.SetRange(NotchTrans."Salary Step/Notch", "Salary Step");
                    NotchTrans.SetRange(NotchTrans.Frequency, NotchTrans.Frequency::Fixed);
                    if NotchTrans.Find('-') then begin
                        repeat
                            EmpTrans.Reset;
                            EmpTrans.SetCurrentKey(EmpTrans."Employee Code", EmpTrans."Transaction Code");
                            EmpTrans.SetRange(EmpTrans."Employee Code", "No.");
                            EmpTrans.SetRange(EmpTrans."Transaction Code", NotchTrans."Transaction Code");
                            EmpTrans.SetRange(EmpTrans."Payroll Period", objPayrollPeriod."Date Opened");
                            if EmpTrans.Find('-') then begin
                                EmpTrans.Amount := NotchTrans.Amount;
                                EmpTrans.Modify;
                            end else begin
                                EmpTransR.Init;
                                EmpTransR."Employee Code" := "No.";
                                EmpTransR."Transaction Code" := NotchTrans."Transaction Code";
                                EmpTransR."Period Month" := objPayrollPeriod."Period Month";
                                EmpTransR."Period Year" := objPayrollPeriod."Period Year";
                                EmpTransR."Payroll Period" := objPayrollPeriod."Date Opened";
                                EmpTransR."Transaction Name" := NotchTrans."Transaction Name";
                                EmpTransR.Amount := NotchTrans.Amount;
                                EmpTransR.Insert;

                            end;


                        until NotchTrans.Next = 0;
                    end;

                end;

            end;
        }
        field(50060; "Supervisor/Manager"; Code[50])
        {
            TableRelation = "HR Employees"."No." where(Supervisor = const(true)); //"Department Code" = field("Department Code"));       


            trigger OnValidate()
            var
                HRJobs: Record "HR Jobs";
                EmpRec: Record "HR Employees";
            begin

                if HRJobs.Get("Supervisor/Manager") then begin
                    TestField("Job Title");
                    if Emprec.Get("No.") then
                        if "No." = EmpRec."Supervisor/Manager" then
                            error('Employee cannot be his/her own supervisor');

                end;
            end;

        }
        field(50061; "Supervisor's Job Title"; Text[50])
        {
        }
        field(51033; "Assigned to Employee"; Boolean)
        {
        }
        field(51034; "User Signature"; BLOB)
        {
        }
        field(51035; "Job Level"; Code[30])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST("Job Level"));

            trigger OnValidate()
            var
                HRLookupValues: Record "HR Lookup Values";
            begin
                HRLookupValues.SetRange(HRLookupValues.Type, HRLookupValues.Type::"Job Level");
                HRLookupValues.SetRange(HRLookupValues.Code, "Job Level");
                if HRLookupValues.FindFirst then
                    "Total (Leave Days)" := HRLookupValues."Annual Leave Days";
            end;
        }
        field(51036; "Annual Leave Group"; Code[20])
        {
            TableRelation = "Leave Group" WHERE("Leave Type" = CONST('ANNUAL'));
        }
        field(51037; "Exam Leave Group"; Code[20])
        {
            TableRelation = "Leave Group" WHERE("Leave Type" = CONST('EXAM'));
        }
        field(51038; "Employment Type"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST("Employment Type"));
        }
        field(51039; "Nos Series"; Code[20])
        {
        }
        field(51040; Available; Boolean)
        {
        }
        field(51041; "Annual Exam Leave"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("No."),
                                                                             "Posting Date" = FIELD("Date Filter"),
                                                                             "Leave Entry Type" = CONST(Negative),
                                                                             "Leave Type" = FIELD("Leave Type Filter"),
                                                                             Closed = CONST(false),
                                                                             "Leave Type" = CONST('EXAM')));
            FieldClass = FlowField;
        }
        field(51042; "Employee Classification"; Code[20])
        {
            TableRelation = "Employee Class";
        }
        field(51043; "Probation Date 3mnths"; Date)
        {
        }
        field(51044; "Confirmation Date"; Date)
        {
        }
        field(51045; "Probation Form Filled"; Boolean)
        {
        }
        field(51046; "Confirmation Form Filled"; Boolean)
        {
        }
        field(51047; "Second Line Supervisor ID"; Code[50])
        {
            Caption = 'Second Line Supervisor';
            //TableRelation = "User Setup";    //jj110222 I remmed 

            trigger OnValidate()
            begin
                if "Second Line Supervisor ID" = UserId then Error('you cannot assign self as the supervisor');
            end;
        }
        field(51048; "Shortcut Dimension 5 Code"; Code[20])
        {

            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(51049; "Approval Status"; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(51050; "Medical Sch. Hospital Code"; Code[20])
        {
            TableRelation = "HR HMO Hospital";

            trigger OnValidate()
            begin
                if HRHMOHospital.Get("Medical Sch. Hospital Code") then begin
                    "Medical Scheme Hospital" := HRHMOHospital.Name;
                    "Hospital Address" := HRHMOHospital.Address;
                end;
            end;
        }
        field(51051; "Hospital Address"; Text[50])
        {
        }
        field(51052; LastLeaveCode; Code[20])
        {

            trigger OnValidate()
            begin
                //HRLeaveApp.SetRange(HRLeaveApp."Application Code", LastLeaveCode);
                // if HRLeaveApp.Find('-') 
                //ApprovalMgt.SendLeaveAppApprovalReq(HRLeaveApp);

            end;
        }
        field(51053; BirthDay; Text[30])
        {
        }
        field(51054; "Current Leave Period"; Text[30])
        {
            CalcFormula = Lookup("HR Leave Periods"."Period Code" WHERE("New Fiscal Year" = CONST(true)));
            FieldClass = FlowField;
        }
        field(51055; "Current Appraisal Period"; Text[70])
        {
            CalcFormula = Lookup("HR Lookup Values".Code WHERE(Type = CONST("Appraisal Period"),
                                                                Closed = CONST(false),
                                                                "Current Appraisal Period" = CONST(true)));
            FieldClass = FlowField;
        }
        field(51056; "Work Schedule"; Code[50])   //deji 01/04/2022
        {
            // TableRelation = "Employee Work Schedule".Code;
        }
        field(60000; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(60001; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Enabled = false;

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(60002; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(60003; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }

        field(60005; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(60006; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(60007; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }




        /*  field(8000; Id; Guid)
          {
              Caption = 'Id';
              ObsoleteState = Pending;
              ObsoleteReason = 'This functionality will be replaced by the systemID field';
              ObsoleteTag = '15.0';
          }
          */
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
        key(Key4; "User ID")
        {
        }
        key(Key5; "Cost Code")
        {
        }
        key(Key6; "Date Of Joining the Company", "Date Of Leaving the Company")
        {
        }
        key(Key7; "Termination Grounds")
        {
        }
        key(Key8; "Also Known As")
        {
        }
        key(Key9; "ID Number")
        {
        }
        key(Key10; "Job Title")
        {
        }
        key(Key11; "Global Dimension 2 Code", "Department Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "First Name", "Middle Name", "Last Name", "Job Title")
        {
        }
    }

    trigger OnDelete()
    var
        HRCommentLine: Record "Human Resource Comment Line";
    begin

        if Confirm(Text017, true) = false then Error('Employee deletion aborted');

        HRAE.SetRange(HRAE."Employee No", "No.");
        HRAE.DeleteAll;

        HRDC.SetRange(HRDC."Case Number", "No.");
        HRDC.DeleteAll;

        /*HRTR.SETRANGE(HRTR."Requested By","No.");
        HRTR.DELETEALL;
        */
        HRTRA.SetRange(HRTRA."Application No", "No.");
        HRTRA.DeleteAll;

        HRLLE.SetRange(HRLLE."Staff No.", "No.");
        HRLLE.DeleteAll;

        HREK.SetRange(HREK."Employee Code", "No.");
        HREK.DeleteAll;

        HRJO.SetRange(HRJO."Employee No.", "No.");
        HRJO.DeleteAll;

        HRD.SetRange(HRD.Code, "No.");
        HRD.DeleteAll;
        //DELETE ALL EMPLOYEE PR ENTRIES APPPLICATIONS PERTAINING TO THIS EMPLOYEE
        HREPR.SetRange(HREPR."No.", "No.");
        HREPR.DeleteAll;
        //DELETE ALL ACTIVITY PARTICIPANTS ENTRIES APPPLICATIONS PERTAINING TO THIS EMPLOYEE
        HRAP.SetRange(HRAP.Participant, "No.");
        HRAP.DeleteAll;
        //DELETE ALL EMPLOYEE HISTORY ENTRIES APPPLICATIONS PERTAINING TO THIS EMPLOYEE
        HREH.SetRange(HREH."Employee No.", "No.");
        HREH.DeleteAll;
        //DELETE ALL EMPLOYEE QUALIFICATION ENTRIES APPPLICATIONS PERTAINING TO THIS EMPLOYEE
        HREQ.SetRange(HREQ."Employee No.", "No.");
        HREQ.DeleteAll;
        //DELETE ALL EMPLOYEE EXIT INTERVIEWS ENTRIES APPPLICATIONS PERTAINING TO THIS EMPLOYEE
        HREEI.SetRange(HREEI."Employee No.", "No.");
        HREEI.DeleteAll;
        //DELETE ALL EMPLOYEE ATTACHMENTS ENTRIES APPPLICATIONS PERTAINING TO THIS EMPLOYEE
        HREA.SetRange(HREA."Employee No", "No.");
        HREA.DeleteAll;
        //DELETE ALL JOB APPLICATION ENTRIES APPPLICATIONS PERTAINING TO THIS EMPLOYEE
        HRJA.SetRange(HRJA."Employee No", "No.");
        HRJA.DeleteAll;
        //DELETE ALL APPLICANT QUALIFICATION ENTRIES APPPLICATIONS PERTAINING TO THIS EMPLOYEE
        HRAQ.SetRange(HRAQ."Employee No.", "No.");
        HRAQ.DeleteAll;
        //DELETE ALL APPRAISAL GOAL SETTING H ENTRIES APPPLICATIONS PERTAINING TO THIS EMPLOYEE
        HRAGSH.SetRange(HRAGSH."Employee No", "No.");
        HRAGSH.DeleteAll;

        HRAGSL.SetRange(HRAGSL."Employee No", "No.");
        HRAGSL.DeleteAll;

        HRCM.SetRange(HRCM."Member No.", "No.");
        HRCM.DeleteAll;

        MISC.SetRange(MISC."Employee No.", "No.");
        MISC.DeleteAll;

        //COMMENTS
        HRCommentLine.SetRange("Table Name", HRCommentLine."Table Name"::Employee);
        HRCommentLine.SetRange("No.", "No.");
        HRCommentLine.DeleteAll;

    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Employee Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Employee Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        /*IF "ID Number" = '' THEN BEGIN
          HRSetup.GET;
          HRSetup.TESTFIELD("Employee ID Nos");
          NoSeriesMgt.InitSeries(HRSetup."Employee ID Nos",xRec."Nos Series",0D,"ID Number","Nos Series");
        END;
         */
        //****************Added by Peace O.Philips 10/04/2018*******************/
        //****************To Create Customer Record for Newly Created Employees**/
        /*
                CustomerRec."No." := "No.";
                CustomerRec."Customer Posting Group" := 'S-ADV';
                CustomerRec."Account Type" := CustomerRec."Account Type"::"Staff Advance";
                CustomerRec.Insert;
        */ //REM By Dennis Not part of the requirement
    end;

    trigger OnModify()
    begin

        "Last Date Modified" := Today;
        /*IF Res.READPERMISSION THEN
        EmployeeResUpdate.HumanResToRes(xRec,Rec);
        IF SalespersonPurchaser.READPERMISSION THEN
        EmployeeSalespersonUpdate.HumanResToSalesPerson(xRec,Rec);
         */

    end;

    var
        ERROR1: Label 'Employee Career History Starting Information already exist.';
        MSG1: Label 'Employee Career History Starting Information successfully created.';
        CIT: Record "Country/Region";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRJobs: Record "HR Jobs";
        PostCodes: Record "Post Code";
        HRLookupValues: Record "HR Lookup Values";
        Text016: Label 'Change of Employee''s';
        CLen: DateFormula;
        UserSetup: Record "User Setup";
        CDate: Date;
        Res: Record Employee;
        EmployeeResUpdate: Codeunit "Employee/Resource Update";
        EmployeeSalespersonUpdate: Codeunit "Employee/Salesperson Update";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        HREmp: Record "HR Employees";
        Country: Record "Country/Region";
        Cnt: Integer;
        HRAE: Record "HR Appraisal Evaluations";
        HRDC: Record "HR Disciplinary Cases";
        HRTR: Record "HR Transport Allocations H";
        HRTRA: Record "HR Training Applications";
        HRLLE: Record "HR Leave Ledger Entries";
        HREK: Record "HR Employee Kin";
        HRJO: Record "HR Job Occupations";
        HRD: Record "HR Drivers";
        HREPR: Record "HR Employee PR";
        HRAP: Record "HR Activity Participants";
        HREH: Record "HR Employment History";
        HREQ: Record "HR Employee Qualifications";
        HREEI: Record "HR Employee Exit Interviews";
        HREA: Record "HR Employee Attachments";
        HRJA: Record "HR Job Applications";
        HRAQ: Record "HR Applicant Qualifications";
        HRAGSH: Record "HR Appraisal Goal Setting H";
        HRAGSL: Record "HR Appraisal Goal Setting L";
        HRCM: Record "HR Commitee Members";
        Text017: Label 'Warning! this will result in the deletion of all records accosiated with this employee. Proceed?';
        PostCode: Record "Post Code";
        PrBankStructure: Record "prBank Structure";
        MISC: Record "Misc. Article Information";
        HREmpp: Record "HR-Employee";
        CareerEvent: Record "HR Career Event";
        text001: Label 'Do you want to update employee details?';
        Confm: Boolean;
        SalCard: Record "prSalary Card";
        SalGrade: Record "Salary Grades";
        SalNotch: Record "Salary Notch";
        objPayrollPeriod: Record "prPayroll Periods";
        EmpTrans: Record "prEmployee Transactions";
        EmpTransR: Record "prEmployee Transactions";
        NotchTrans: Record "Salary Step/Notch Transactions";
        SalaryGrades: Record "Salary Grades";
        prSalaryCard: Record "prSalary Card";
        HREmployee: Record "HR-Employee";
        HRHMOHospital: Record "HR HMO Hospital";
        CustomerRec: Record Customer;
        HRLeaveApp: Record "HR Leave Application";

    [Scope('OnPrem')]
    procedure FullName(): Text[100]
    begin
        if "Middle Name" = '' then
            exit("First Name" + ' ' + "Last Name")
        else
            exit("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;

    [Scope('OnPrem')]
    procedure AssistEdit(OldCust: Record "HR Employees"): Boolean
    var
        Cust: Record "HR Employees";
    begin
        with Cust do begin
            Cust := Rec;
            HRSetup.Get;
            HRSetup.TestField("Employee ID Nos");
            if NoSeriesMgt.SelectSeries(HRSetup."Employee ID Nos", OldCust."Nos Series", "Nos Series") then begin
                NoSeriesMgt.SetSeries("ID Number");
                Rec := Cust;
                exit(true);
            end;
        end;
    end;
}


table 51534548 "HR-Employee"
{
    //Caption = 'Employee';
    DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name", "Job Title", "Search Name";

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;

            trigger OnValidate()
            var
            //NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                if "No." <> xRec."No." then begin
                    HrSetup.Get;
                    NoSeriesMgt.TestManual(HrSetup."Employee Nos.");
                    "No. Series" := '';
                end;

                /*
                //This is for staff to Library Dataport don't Delete!
                IF "No." <> '' THEN
                   Category:='STAFF';
                 */

            end;
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

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '') then
                    "Search Name" := Initials;
            end;
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
        field(25; "Country Code"; Code[20])
        {
            TableRelation = "Country/Region";
        }
        field(26; "new relationshipmanager"; Text[100])
        {

        }
        field(28; "Statistics Group Code"; Code[20])
        {
            TableRelation = "Employee Statistics Group";
        }
        field(31; Status; Option)
        {
            OptionCaption = 'Active,Resigned,Discharged,Retrenched,Pension,Disabled';
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;

            trigger OnValidate()
            begin
                "Status Change Date" := Today;
            end;
        }
        field(35; "Location/Division Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin
                if SalCard.Get("No.") then begin
                    SalCard."Location/Division" := "Location/Division Code";
                    SalCard.Modify;
                end;
            end;
        }
        field(36; "Department Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin
                if SalCard.Get("No.") then begin
                    SalCard.Department := "Department Code";

                    SalCard.Modify;
                end;

                //Validate("Shortcut Dimension 5 Code", "Department Code");
            end;
        }
        field(37; Office; Code[20])
        {
            CaptionClass = '1,1,1';
            Description = 'Dimension 1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
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
        field(42; "Department Filter 1"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(43; "Office Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            CaptionClass = '1,2,2';
        }
        field(47; "Employee No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(49; "Fax Number"; Text[30])
        {
        }
        field(50; "Company E-Mail"; Text[80])
        {
        }
        field(51; Title; Option)
        {
            OptionMembers = MR,MRS,MISS,MS,DR," ENG. ","DR.",CC;
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
        field(55; Position; Text[30])
        {

            trigger OnValidate()
            begin
                /*
                    IF ((Position <> xRec.Position) AND (xRec.Position <> '')) THEN BEGIN
                      Jobs.RESET;
                      Jobs.SETRANGE(Jobs."Job ID",Position);
                      IF Jobs.FIND('-') THEN BEGIN
                          Payroll.RESET;
                          Payroll.SETRANGE(Payroll.Code,"No.");
                          IF Payroll.FIND('-') THEN BEGIN
                              Payroll."Salary Scheme Category":=Jobs.Category;
                              Payroll."Salary Steps":=Jobs.Grade;
                              Payroll.VALIDATE(Payroll."Salary Steps");
                              Payroll.MODIFY;
                          END
                      END



                        {
                      CareerEvent.SetMessage('Job Title Changed');
                     CareerEvent.RUNMODAL;
                     OK:= CareerEvent.ReturnResult;
                      IF OK THEN BEGIN
                         CareerHistory.INIT;
                         IF NOT CareerHistory.FIND('-') THEN
                          CareerHistory."Line No.":=1
                        ELSE BEGIN
                          CareerHistory.FIND('+');
                          CareerHistory."Line No.":=CareerHistory."Line No."+1;
                        END;

                         CareerHistory."Employee No.":= "No.";
                         CareerHistory."Date Of Event":= WORKDATE;
                         CareerHistory."Career Event":= 'Job Title Changed';
                         CareerHistory."Job Title":= "Position Title";
                         CareerHistory."Employee First Name":= "Known As";
                         CareerHistory."Employee Last Name":= "Last Name";
                         CareerHistory.INSERT;
                      END;
                      }

                  END;
               */

            end;
        }
        field(57; "Full / Part Time"; Option)
        {
            OptionMembers = "Full Time"," Part Time",Contract;
        }
        field(58; "Contract Type"; Option)
        {
            Caption = 'Contract Status';
            OptionMembers = Permanent,"Temporary",Voluntary,Probation,Contract;
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
        field(69; "UIF Contributor?"; Boolean)
        {
        }
        field(70; "Budget Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
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
        field(76; "Driving Licence"; Code[20])
        {
        }
        field(77; "Vehicle Registration Number"; Code[20])
        {
        }
        field(78; Disabled; Option)
        {
            OptionMembers = No,Yes," ";

            trigger OnValidate()
            begin
                if (Disabled = Disabled::Yes) then
                    Status := Status::Disabled;
            end;
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

            trigger OnValidate()
            begin
                //MedicalAidBenefit.SETRANGE("Employee No.","No.");
            end;
        }
        field(98; "Medical Scheme Plan"; Option)
        {
            OptionMembers = "  ","Standard Plan","Silver +",Gold,Platinum,Family,Pension;

            trigger OnValidate()
            begin
                //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //   OK := MedicalAidBenefit.FIND('+');
                //  IF OK THEN BEGIN
                //  REPEAT
                //   MedicalAidBenefit."Medical Aid Head Member":= "Medical Aid Head Member";
                //    MedicalAidBenefit.MODIFY;
                //  UNTIL MedicalAidBenefit.NEXT = 0;
                // END;
            end;
        }
        field(99; "Number Of Dependants"; Integer)
        {

            trigger OnValidate()
            begin
                // MedicalAidBenefit.SETRANGE("Employee No.","No.");
                // OK := MedicalAidBenefit.FIND('+');
                // IF OK THEN BEGIN
                //REPEAT
                //  MedicalAidBenefit."Number Of Dependants":= "Number Of Dependants";
                //  MedicalAidBenefit.MODIFY;
                //UNTIL MedicalAidBenefit.NEXT = 0;
                // END;
            end;
        }
        field(100; "Medical Scheme Name"; Text[150])
        {

            trigger OnValidate()
            begin
                //MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //OK := MedicalAidBenefit.FIND('+');
                //IF OK THEN BEGIN
                // REPEAT
                // MedicalAidBenefit."Medical Aid Name":= "Medical Aid Name";
                //  MedicalAidBenefit.MODIFY;
                // UNTIL MedicalAidBenefit.NEXT = 0;
                // END;
            end;
        }
        field(101; "Amount Paid By Employee"; Decimal)
        {

            trigger OnValidate()
            begin
                //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //  OK := MedicalAidBenefit.FIND('+');
                //   IF OK THEN BEGIN
                //     REPEAT
                //      MedicalAidBenefit."Amount Paid By Employee":= "Amount Paid By Employee";
                //       MedicalAidBenefit.MODIFY;
                //     UNTIL MedicalAidBenefit.NEXT = 0;
                //    END;
            end;
        }
        field(102; "Amount Paid By Company"; Decimal)
        {

            trigger OnValidate()
            begin
                //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //   OK := MedicalAidBenefit.FIND('+');
                //  IF OK THEN BEGIN
                // REPEAT
                //      MedicalAidBenefit."Amount Paid By Company":= "Amount Paid By Company";
                //      MedicalAidBenefit.MODIFY;
                // UNTIL MedicalAidBenefit.NEXT = 0;
                //   END;
            end;
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
        field(113; "Job Specification"; Code[50])
        {
        }
        field(114; DateOfBirth; Text[8])
        {
        }
        field(115; DateEngaged; Text[8])
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
            TableRelation = User.State;
            //This property is currently not supported
            //TestTableRelation = true;
        }
        field(124; "Disabling Details"; Text[50])
        {
        }
        field(125; "Disability Grade"; Text[30])
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
        field(130; DateLeaving; Text[30])
        {
        }
        field(131; Region; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('REGION'));
        }
        field(132; "Manager Emp No"; Code[30])
        {
        }
        field(133; Temp; Text[200])
        {
        }
        field(134; "Employee Qty"; Integer)
        {
            CalcFormula = Count("HR-Employee");
            FieldClass = FlowField;
        }
        field(135; "Employee Act. Qty"; Integer)
        {
            CalcFormula = Count("HR-Employee");
            FieldClass = FlowField;
        }
        field(136; "Employee Arc. Qty"; Integer)
        {
            CalcFormula = Count("HR-Employee");
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
        field(145; "PIN No."; Code[20])
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
        field(149; "Grounds for Term. Code"; Code[20])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(150; "Sacco Staff No"; Code[20])
        {
        }
        field(151; "Period Filter"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
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
        field(157; "Cost Center Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin
                if SalCard.Get("No.") then begin
                    SalCard."Cost Centre" := "Cost Center Code";
                    SalCard.Modify;
                end;
            end;
        }
        field(158; "Position To Succeed"; Code[20])
        {
        }
        field(159; "Succesion Date"; Date)
        {
        }
        field(160; "Send Alert to"; Code[20])
        {
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
        field(164; "Post Office No"; Text[50])
        {
        }
        field(165; "Posting Group"; Code[50])
        {
            NotBlank = true;
            TableRelation = "prEmployee Posting Group".Code;
        }
        field(166; "Payroll Posting Group"; Code[20])
        {
            //TableRelation = "prEmployee Posting Group";
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
            TableRelation = "HR-Employee"."No.";
        }
        field(170; "Allow Re-Employment In Future"; Boolean)
        {
        }
        field(171; "Medical Scheme Name #2"; Text[50])
        {

            trigger OnValidate()
            begin
                //MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //OK := MedicalAidBenefit.FIND('+');
                //IF OK THEN BEGIN
                // REPEAT
                // MedicalAidBenefit."Medical Aid Name":= "Medical Aid Name";
                //  MedicalAidBenefit.MODIFY;
                // UNTIL MedicalAidBenefit.NEXT = 0;
                // END;
            end;
        }
        field(172; "Resignation Date"; Date)
        {
        }
        field(173; "Suspension Date"; Date)
        {
        }
        field(174; "Demised Date"; Date)
        {
        }
        field(175; "Retirement date"; Date)
        {
        }
        field(176; "Retrenchment date"; Date)
        {
        }
        field(177; Campus; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CAMPUS'));
        }
        field(178; Permanent; Boolean)
        {
        }
        field(179; "Library Category"; Option)
        {
            OptionMembers = "ADMIN STAFF","TEACHING STAFF",DIRECTORS;
        }
        field(180; Category; Code[20])
        {
        }
        field(181; "Payroll Departments"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(188; "Salary Grade"; Code[20])
        {
            TableRelation = "Salary Grades"."Salary Grade";

            trigger OnValidate()
            begin
                if not Confirm('Changing the Grade will affect the Basic Salary', false) then
                    Error('You have opted to abort the process');


                "Salary Notch/Step" := '';

                if SalCard.Get("No.") then begin
                    SalCard."Salary Grade" := "Salary Grade";
                    SalCard.Modify;
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

            end;
        }
        field(189; "Company Type"; Option)
        {
            OptionCaption = 'KRC Staff,RTI Staff';
            OptionMembers = "KRC Staff","RTI Staff";
        }
        field(190; "Main Bank"; Code[20])
        {
            TableRelation = "prBank Structure"."Bank Code";
        }
        field(191; "Branch Bank"; Code[20])
        {
            TableRelation = "prBank Structure"."Branch Code";
        }
        field(192; "Lock Bank Details"; Boolean)
        {
        }
        field(193; "Bank Account Number"; Code[20])
        {
        }
        field(195; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(196; "Holiday Days Entitlement"; Decimal)
        {
        }
        field(197; "Holiday Days Used"; Decimal)
        {
        }
        field(198; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,FOSA;
        }
        field(199; "Hourly Rate"; Decimal)
        {
        }
        field(200; "Daily Rate"; Decimal)
        {
        }
        field(250; "Department Level 2"; Code[20])
        {
            TableRelation = Department.Code where("Dim. Code" = field("Department Code"));
        }
        field(251; Unit; Code[20])
        {
            TableRelation = "Sub. Department".Code where("Dept. Code" = field("Department Level 2"));
        }

        field(300; "Social Security No."; Code[20])
        {
        }
        field(301; "Pension House"; Code[20])
        {
            TableRelation = "prInstitutional Membership"."Institution No" WHERE("Group No" = CONST('PENSION'));
        }
        field(302; "Salary Notch/Step"; Code[20])
        {
            TableRelation = "Salary Notch"."Salary Notch" WHERE("Salary Grade" = FIELD("Salary Grade"));

            trigger OnValidate()
            begin

                if SalCard.Get("No.") then begin
                    if SalGrade.Get("Salary Grade") then
                        //SalaryGrades."Pays NHF" := SalGrade."Pays NHF";   //jj150522

                        SalCard."Salary Notch" := "Salary Notch/Step";

                    SalNotch.Reset;
                    SalNotch.SetRange(SalNotch."Salary Grade", "Salary Grade");
                    SalNotch.SetRange(SalNotch."Salary Notch", "Salary Notch/Step");
                    if SalNotch.Find('-') then begin
                        if SalNotch."Basic  Pay" <> 0 then begin
                            if SalCard.Get("No.") then begin
                                SalCard."Basic Pay" := SalNotch."Basic  Pay";
                                SalCard."Pays NHF" := SalGrade."Pays NHF";  //jj150522
                                SalCard."Pays PAYE" := SalGrade."Pays PAYE"  //jj210622 I added to update sal card from salary grade
                            end;
                        end;
                    end;

                    SalCard.Modify;
                end else begin
                    SalCard.Init;
                    SalCard."Employee Code" := "No.";
                    SalCard."Pays PAYE" := true;
                    SalCard."Location/Division" := "Location/Division Code";
                    SalCard.Department := "Department Code";
                    SalCard."Cost Centre" := "Cost Center Code";
                    SalCard."Salary Grade" := "Salary Grade";
                    SalCard."Salary Notch" := "Salary Notch/Step";
                    if SalGrade.Get("Salary Grade") then
                        SalaryGrades."Pays NHF" := SalGrade."Pays NHF";

                    SalNotch.Reset;
                    SalNotch.SetRange(SalNotch."Salary Grade", "Salary Grade");
                    SalNotch.SetRange(SalNotch."Salary Notch", "Salary Notch/Step");
                    if SalNotch.Find('-') then begin
                        if SalNotch."Basic  Pay" <> 0 then begin
                            SalCard."Basic Pay" := SalNotch."Basic  Pay";
                            SalCard."Pays NHF" := SalGrade."Pays NHF";  //jj150522
                            SalCard."Pays PAYE" := SalGrade."Pays PAYE"  //jj210622 I added to update sal card from salary grade
                        end;
                    end;
                    SalCard.Insert;

                end;


                objPayrollPeriod.Reset;
                objPayrollPeriod.SetRange(objPayrollPeriod.Closed, false);
                if objPayrollPeriod.Find('-') then begin
                    NotchTrans.Reset;
                    NotchTrans.SetRange(NotchTrans."Salary Grade", "Salary Grade");
                    NotchTrans.SetRange(NotchTrans."Salary Step/Notch", "Salary Notch/Step");
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
                            end
                        until NotchTrans.Next = 0;
                    end;

                end;
            end;
        }
        field(303; "Status Change Date"; Date)
        {
        }
        field(304; "Previous Month Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(305; "Current Month Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(306; "Prev. Basic Pay"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Employee Code" = FIELD("No."),
                                                                    "Transaction Code" = CONST('BPAY'),
                                                                    "Payroll Period" = FIELD("Previous Month Filter")));
            FieldClass = FlowField;
        }
        field(307; "Curr. Basic Pay"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Employee Code" = FIELD("No."),
                                                                    "Transaction Code" = CONST('BPAY'),
                                                                    "Payroll Period" = FIELD("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(308; "Prev. Gross Pay"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Employee Code" = FIELD("No."),
                                                                    "Transaction Code" = CONST('GPAY'),
                                                                    "Payroll Period" = FIELD("Previous Month Filter")));
            FieldClass = FlowField;
        }
        field(309; "Curr. Gross Pay"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Employee Code" = FIELD("No."),
                                                                    "Transaction Code" = CONST('GPAY'),
                                                                    "Payroll Period" = FIELD("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(310; "Gross Income Variation"; Decimal)
        {
            //  CalcFormula = Sum("Monthly Reconcilliation".Difference WHERE(Employee = FIELD("No."),
            //   "Group Order" = FILTER(1 | 3)));
            // FieldClass = FlowField;
        }
        field(311; "Basic Pay"; Decimal)
        {
            CalcFormula = Sum("prSalary Card"."Basic Pay" WHERE("Employee Code" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(312; "Net Pay"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Employee Code" = FIELD("No."),
                                                                    "Transaction Code" = CONST('NPAY'),
                                                                    "Payroll Period" = FIELD("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(313; "Transaction Amount"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Employee Code" = FIELD("No."),
                                                                    "Transaction Code" = FIELD("Transaction Code Filter"),
                                                                    "Payroll Period" = FIELD("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(314; "Transaction Code Filter"; Text[30])
        {
            FieldClass = FlowFilter;
            TableRelation = "prTransaction Codes"."Transaction Code";
        }
        field(315; "NHF No."; Code[20])
        {
        }
        field(316; "NSITF No."; Code[20])
        {
        }
        field(317; "Account Type"; Option)
        {
            OptionCaption = ' ,Savings,Current';
            OptionMembers = " ",Savings,Current;
        }
        field(318; "Location/Division Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('LOC/DIV'));
        }
        field(319; "Department Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(320; "Cost Centre Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('COSTCENTRE'));
        }
        field(321; "Salary Grade Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Salary Grades"."Salary Grade";
        }
        field(322; "Salary Notch Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Salary Notch"."Salary Notch" WHERE("Salary Grade" = FIELD("Salary Grade Filter"));
        }
        field(323; "Payroll Type"; Option)
        {
            OptionCaption = 'General,Directors';
            OptionMembers = General,Directors;
        }
        field(324; "Payroll Class"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(325; "Employee Classification"; Code[20])
        {
        }
        field(326; "Payroll Filter Group"; Code[20])
        {
            TableRelation = "Payroll Classification";
        }
        field(50000; "Special Allowance"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Employee Code" = FIELD("No."),
                                                                    "Special Allowances" = FILTER(true),
                                                                    "Payroll Period" = FIELD("Current Month Filter")));
            Description = 'Sum up Special Allowances';
            FieldClass = FlowField;
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
        key(Key11; "Salary Grade", "Salary Notch/Step")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "First Name", "Last Name")
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HrSetup.Get;
            HrSetup.TestField("Employee Nos.");
            NoSeriesMgt.InitSeries(HrSetup."Employee Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        /*
        IF "No." <> xRec."No." THEN BEGIN
          HrSetup.GET;
          HrSetup.TESTFIELD("Employee Nos.");
          HrSetup.TestManual(HrSetup."Employee Nos.");
          "No. Series" := '';
        END;
        */


        //CurrentPayDetails;
        prSalaryCard.Init;
        prSalaryCard."Employee Code" := "No.";
        prSalaryCard.Insert;

    end;

    trigger OnModify()
    begin
        //"Last Date Modified" := TODAY;
    end;

    trigger OnRename()
    begin
        //"Last Date Modified" := TODAY;
    end;

    var
        Res: Record Resource;
        PostCode: Record "Post Code";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        OK: Boolean;
        User: Record "User Setup";
        ERROR1: Label 'Employee Career History Starting Information already exist.';
        MSG1: Label 'Employee Career History Starting Information successfully created.';
        ReasonDiaglog: Dialog;
        EmpQualification: Record "Employee Qualification";
        PayStartDate: Date;
        PayPeriodText: Text[30];
        ToD: Date;
        CurrentMonth: Date;
        HrSetup: Record "Human Resources Setup";
        SalCard: Record "prSalary Card";
        SalGrade: Record "Salary Grades";
        SalNotch: Record "Salary Notch";
        objPayrollPeriod: Record "prPayroll Periods";
        EmpTrans: Record "prEmployee Transactions";
        EmpTransR: Record "prEmployee Transactions";
        NotchTrans: Record "Salary Step/Notch Transactions";
        SalaryGrades: Record "Salary Grades";
        prSalaryCard: Record "prSalary Card";

    [Scope('OnPrem')]
    procedure AssistEdit(OldEmployee: Record "HR-Employee"): Boolean
    begin
    end;

    [Scope('OnPrem')]
    procedure FullName(): Text[100]
    begin
        if "Middle Name" = '' then
            exit("Known As" + ' ' + "Last Name")
        else
            exit("Known As" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;

    [Scope('OnPrem')]
    procedure CurrentPayDetails()
    begin
    end;

    [Scope('OnPrem')]
    procedure UpdtResUsersetp(var HREmpl: Record "HR-Employee")
    var
        Res: Record Resource;
        Usersetup: Record "User Setup";
    begin
        /*
        ContMgtSetup.GET;
        IF ContMgtSetup."Customer Integration" =
           ContMgtSetup."Customer Integration"::"No Integration"
        THEN
          EXIT;
        */
        /*
        Res.SETCURRENTKEY("No.");
        Res.SETRANGE("No.",HREmpl."Resource No.");
        IF Res.FIND('-') THEN BEGIN
          Res."Global Dimension 1 Code" := HREmpl."Department Code";
          Res."Global Dimension 2 Code" := HREmpl.Office;
          Res.MODIFY;
        END;
        
        IF Usersetup.GET(HREmpl."User ID") THEN BEGIN
          Usersetup.Department := HREmpl."Department Code";
          Usersetup.Office := HREmpl.Office;
          Usersetup.MODIFY;
        END;
        */

    end;

    [Scope('OnPrem')]
    procedure SetEmployeeHistory()
    begin
    end;

    [Scope('OnPrem')]
    procedure GetPayPeriod()
    begin
    end;
}


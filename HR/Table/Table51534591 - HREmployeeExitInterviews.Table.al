table 51534591 "HR Employee Exit Interviews"
{
    LookupPageID = "HR Exit Interview List";

    fields
    {
        field(1; "Exit Interview No"; Code[20])
        {
        }
        field(2; "Date Of Interview"; Date)
        {

            trigger OnValidate()
            begin

                /* IF ("Date Of Interview" <> 0D) AND ("Date Of Interview" <> xRec."Date Of Interview") THEN BEGIN
                   CareerEvent.SetMessage('Exit Interview Conducted');
                   CareerEvent.RUNMODAL;
                   OK:= CareerEvent.ReturnResult;
                   IF OK THEN BEGIN
                       CareerHistory.INIT;
                       CareerHistory."Employee No.":= "Employee No.";
                       CareerHistory."Date Of Event":= "Date Of Interview";
                       CareerHistory."Career Event":= 'Exit Interview Conducted';
                       CareerHistory."Exit Interview":= TRUE;
                        OK:= Employee.GET("Employee No.");
                        IF OK THEN BEGIN
                         CareerHistory."Employee First Name":= Employee."Known As";
                         CareerHistory."Employee Last Name":= Employee."Last Name";
                        END;
                       CareerHistory.INSERT;
                    END;
                 END;
                   */

            end;
        }
        field(3; "Interview Done By"; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Interview Done By");
                if HREmp.Find('-') then begin
                    IntFullName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Interviewer Name" := IntFullName;
                end;
            end;
        }
        field(4; "Re Employ In Future"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(5; "Reason For Leaving"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Deceased,Termination,"Contract Ended",Abscondment,"Appt. Revoked","Contract Termination",Retrenchment,Other;
        }
        field(6; "Reason For Leaving (Other)"; Text[150])
        {
        }
        field(7; "Date Of Leaving"; Date)
        {
        }
        field(8; "Notice Period"; Integer)
        {
        }
        field(10; Comment; Boolean)
        {
            CalcFormula = Exist("HR Human Resource Comments" WHERE("Table Name" = CONST("Exit Interviews"),
                                                                    "No." = FIELD("Employee No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Employee No."; Code[30])
        {
            TableRelation = "HR Employees"."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Employee No.");
                if HREmp.Find('-') then begin
                    EmpFullName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Employee Name" := EmpFullName;
                    "Date of Join" := HREmp."Date Of Joining the Company";
                    Supervisor := HREmp."Supervisor/Manager";
                    HREmp.CalcFields("Total Leave Taken");
                    "Annual Leave Owed" := HREmp."Total (Leave Days)" - HREmp."Total Leave Taken";

                    prPeriodTransactions.Reset;
                    prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", "Employee No.");
                    prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", Date2DMY(Today, 3));
                    if prPeriodTransactions.FindFirst then begin
                        repeat
                            if prTransactionCodes.Get(prPeriodTransactions."Transaction Code") then begin
                                if prTransactionCodes."Leave Allowance" = true then begin
                                    "Leave Allowance Paid" := true;
                                    "Leave Allowance" := prPeriodTransactions.Amount;
                                end;
                            end
                        until prPeriodTransactions.Next = 0;
                    end;

                end;

                UpdateLines;
            end;
        }
        field(12; "No Series"; Code[20])
        {
        }
        field(13; "Form Submitted"; Boolean)
        {

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange("No.", "Employee No.");
                OK := HREmp.Find('-');

                if "Form Submitted" = true then begin

                    if OK then begin
                        HREmp.Status := HREmp.Status::Inactive;
                        HREmp."Date Of Leaving the Company" := "Date Of Leaving";
                        HREmp."Termination Grounds" := "Reason For Leaving";
                        HREmp."Exit Interview Done by" := "Interview Done By";
                        HREmp.Modify;
                    end
                end;

                if "Form Submitted" = false then begin
                    if OK then begin
                        HREmp.Status := HREmp.Status::Active;
                        HREmp."Date Of Leaving the Company" := 0D;
                        HREmp."Termination Grounds" := HREmp."Termination Grounds"::" ";
                        HREmp."Exit Interview Done by" := '';
                        HREmp.Modify;
                    end;
                end;
            end;
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(15; "Employee Name"; Text[50])
        {
        }
        field(16; "Interviewer Name"; Text[50])
        {
        }
        field(17; "Worked more than 1 position"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(18; "Recommendations/Comments"; Text[250])
        {
        }
        field(19; "If Yes,in what areas?"; Text[250])
        {
        }
        field(20; "Nature of Separation"; Option)
        {
            OptionMembers = Voluntary,Involuntary;
        }
        field(21; "Disciplinary Details"; Text[250])
        {
        }
        field(22; "Notice Period Served"; Integer)
        {
            BlankZero = true;
        }
        field(23; Duration; Option)
        {
            OptionCaption = ' ,Days,Weeks';
            OptionMembers = " ",Days,Weeks;
        }
        field(24; "Annual Leave Owed"; Integer)
        {
            Description = 'Days';
        }
        field(25; Status; Option)
        {
            OptionMembers = New,"Pending Approval",Released;
        }
        field(26; "User Id"; Code[50])
        {
        }
        field(27; "Leave Allowance Paid"; Boolean)
        {
        }
        field(28; "Leave Allowance"; Decimal)
        {
        }
        field(29; "Date of Join"; Date)
        {
            Caption = 'Date of Joining the Company';
        }
        field(30; "Mode of Exit"; Option)
        {
            OptionMembers = " ","Voluntary Resignation","Involuntary Resignation","Involuntary Disengagement",Termination," Summary Dismissal ";
        }
        field(31; Supervisor; Text[100])
        {
        }
        field(32; "No. of Days Worked"; Integer)
        {
            BlankZero = true;
        }
        field(33; "Months Spent"; Integer)
        {
            BlankZero = true;
        }
        field(34; "Pay NHF/PAYE"; Boolean)
        {
        }
        field(35; "No Notice Period"; Boolean)
        {
        }
        field(36; "No. of Leave Days to Deduct"; Integer)
        {
        }
        field(37; "Monthly Take Home"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Exit Interview No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Exit Interview No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Exit Interview Nos");
            //NoSeriesMgt.InitSeries(HRSetup."Exit Interview Nos", xRec."No Series", 0D, "Exit Interview No", "No Series");
        end;

        HREntTemplate.SetRange(HREntTemplate."Line No.");
        if HREntTemplate.FindFirst then begin
            repeat
                HREntitlementLines.Init;
                HREntitlementLines."Application No." := "Exit Interview No";
                HREntitlementLines."Line No." := 0;
                HREntitlementLines.Question := HREntTemplate.Question;
                HREntitlementLines.Insert;
            until HREntTemplate.Next = 0;
        end;
        GetLines;
    end;

    var
        OK: Boolean;
        HREmp: Record "HR Employees";
        HRSetup: Record "HR Setup";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        EmpFullName: Text;
        IntFullName: Text;
        HREntitlementLines: Record "HR Entitlement Lines";
        HREntTemplate: Record "HR Entitlement Template";
        prTransactionCodes: Record "prTransaction Codes";
        prPeriodTransactions: Record "prPeriod Transactions";
        HRExitInterviewTemplate: Record "HR Exit Interview Template";
        HREmpExitInterviewLine: Record "HR Emp. Exit Interview Line";

    local procedure GetLines()
    begin
        HRExitInterviewTemplate.Reset;
        HRExitInterviewTemplate.SetRange(HRExitInterviewTemplate."Entry No.");
        if HRExitInterviewTemplate.FindFirst then begin
            repeat
                HREmpExitInterviewLine.Init;
                HREmpExitInterviewLine."Entry No." := 0;
                HREmpExitInterviewLine.Question := HRExitInterviewTemplate.Question;
                HREmpExitInterviewLine.Segment := HRExitInterviewTemplate.Segment;
                HREmpExitInterviewLine."Employee No." := "Employee No.";
                HREmpExitInterviewLine."Exit No." := "Exit Interview No";
                HREmpExitInterviewLine.Insert;
            until HRExitInterviewTemplate.Next = 0;
        end;
    end;

    local procedure UpdateLines()
    begin
        HREmpExitInterviewLine.SetRange(HREmpExitInterviewLine."Exit No.", "Exit Interview No");
        if HREmpExitInterviewLine.FindFirst then begin
            repeat
                HREmpExitInterviewLine."Employee No." := "Employee No.";
                HREmpExitInterviewLine.Modify;
            until HREmpExitInterviewLine.Next = 0;
        end;
    end;
}


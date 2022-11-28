table 51534574 "HR Leave Application"
{
    DrillDownPageID = "HR Leave Applications List";
    LookupPageID = "HR Leave Applications List";

    fields
    {
        field(1; "Application Code"; Code[20])
        {

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if "Application Code" <> xRec."Application Code" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Leave Application Nos.");
                    "No series" := '';
                end;
            end;
        }
        field(3; "Leave Type"; Code[20])
        {
            TableRelation = "HR Leave Types".Code;

            trigger OnValidate()
            var
                EmpRec: Record "HR Employees";
                LookUpValues: Record "HR Lookup Values";
            begin
                HRLeaveTypes.Get("Leave Type");
                EmpRec.Get("Employee No");
                if (HRLeaveTypes.Gender <> EmpRec.Gender) and (HRLeaveTypes.Gender <> HRLeaveTypes.Gender::Both) then
                    Error('you can not apply for this leave type based on the gender');

                HRLeaveTypes.Get("Leave Type");
                if HRLeaveTypes.Exception = false then
                    CheckLeaveQualification;

                /*HRLeaveTypes.GET("Leave Type");
                "Maximum Leave Days":=0;
                "Days Applied":=0;
                */
                if HRLeaveTypes.Recurring then
                    CheckLengthOfServ
                else
                    if HRLeaveTypes.Exam then begin
                        EmpRec.Get("Employee No");
                        LookUpValues.SetRange(LookUpValues.Type, LookUpValues.Type::"Employment Type");
                        LookUpValues.SetRange(LookUpValues.Code, EmpRec."Employment Type");
                        if LookUpValues.FindFirst then
                            "Maximum Leave Days" := LookUpValues."Exam Leave Days";
                        "Days Applied" := HRLeaveTypes.Days;

                    end else begin
                        "Maximum Leave Days" := HRLeaveTypes.Days;
                        "Days Applied" := HRLeaveTypes.Days;
                    end;

                //VALIDATE("Days Applied");

            end;
        }
        field(4; "Days Applied"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;

            trigger OnValidate()
            begin
                TestField("Leave Type");
                //CALCULATE THE END DATE AND RETURN DAT

                ReturnDate := "Start Date";
                for i := 1 to "Days Applied" do begin
                    ReturnDate := CalcDate('1D', ReturnDate);
                    if DetermineIfIsNonWorking(ReturnDate) = false then
                        "Return Date" := ReturnDate
                    else begin
                        while DetermineIfIsNonWorking(ReturnDate) = true do begin
                            ReturnDate := CalcDate('1D', ReturnDate);
                        end;
                        "Return Date" := ReturnDate;
                    end;
                end;

                /*
                BEGIN
                IF ("Days Applied" <> 0) AND ("Start Date" <> 0D) THEN
                "Return Date" := DetermineLeaveReturnDate("Start Date","Days Applied");
                "End Date" := DeterminethisLeaveEndDate("Return Date");
                MODIFY;
                END;
                 */

            end;
        }
        field(5; "Start Date"; Date)
        {

            trigger OnValidate()
            begin
                "Payroll Period" := DMY2Date(1, Date2DMY("Start Date", 2), Date2DMY("Start Date", 3));
                if "Start Date" = 0D then begin
                    "Return Date" := 0D;
                    exit;
                end else begin
                    if DetermineIfIsNonWorking("Start Date") = true then begin
                        ;
                        Error('Start date must be a working day');
                    end;
                    Validate("Days Applied");
                end;
            end;
        }
        field(6; "Return Date"; Date)
        {
            Caption = 'Return Date';
            Editable = false;
        }
        field(7; "Application Date"; Date)
        {
            Editable = true;
        }
        field(12; Status; Option)
        {
            Editable = true;
            OptionCaption = 'New,Pending Approval,HOD Approval,HR Approval,Final Approval,Rejected,Canceled,Approved,On leave,Resumed,Posted';
            OptionMembers = New,"Pending Approval","HOD Approval","HR Approval",MDApproval,Rejected,Canceled,Approved,"On leave",Resumed,Posted;
        }
        field(15; "Applicant Comments"; Text[250])
        {
        }
        field(17; "No series"; Code[30])
        {
        }
        field(28; Selected; Boolean)
        {
        }
        field(31; "Current Balance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(3900; "End Date"; Date)
        {
            Caption = 'Return Date';
            Editable = false;
        }
        field(3901; "Total Taken"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(3921; "E-mail Address"; Text[30])
        {
            Editable = false;
        }
        field(3924; "Entry No"; Integer)
        {
        }
        field(3929; "Start Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(3936; "Cell Phone Number"; Text[50])
        {
        }
        field(3937; "Request Leave Allowance"; Boolean)
        {
            Editable = true;
        }
        field(3939; Picture; BLOB)
        {
        }
        field(3940; Names; Text[100])
        {
        }
        field(3942; "Leave Allowance Entittlement"; Boolean)
        {
        }
        field(3943; "Leave Allowance Amount"; Decimal)
        {
        }
        field(3945; "Details of Examination"; Text[200])
        {
        }
        field(3947; "Date of Exam"; Date)
        {
        }
        field(3949; Reliever; Code[50])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                if "Employee No" = Reliever then
                    Error('Employee cannnot relieve him/herself');
                //DISPLAY RELEIVERS NAME
                if HREmp.Get(Reliever) then
                    "Reliever Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            end;
        }
        field(3950; "Reliever Name"; Text[100])
        {
        }
        field(3952; Description; Text[36])
        {
        }
        field(3955; "Supervisor Email"; Text[50])
        {
        }
        field(3956; "Number of Previous Attempts"; Text[200])
        {
        }
        field(3958; "Job Tittle"; Text[50])
        {
        }
        field(3959; "User ID"; Code[60])
        {
            //TableRelation = "HR Employees"; //B.Dennis
        }
        field(3961; "Employee No"; Code[20])
        {
            TableRelation = "HR Employees"; //B.Dennis

            trigger OnValidate()
            begin
                HREmp.Reset;
                // HREmp.SetRange(HREmp."User ID", UserId);
                IF HREmp.Get("Employee No") then begin
                    "Employee No" := HREmp."No.";

                    "Job Tittle" := HREmp."Job Title";
                    Names := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Global Dimension 1 Code" := HREmp."Global Dimension 2 Code";
                    "Global Dimension 2 Code" := HREmp."Department Code";
                    "User ID" := HREmp."User ID";
                    Validate(Supervisor, HRemp."Supervisor/Manager");
                end else begin
                    Error('User id' + ' ' + '[' + UserId + ']' + ' has not been assigned to any employee. Please consult the HR officer for assistance')
                end;
            end;
        }
        // 

        field(3962; Supervisor; Code[50])
        {
            Editable = false;
            TableRelation = "HR Employees";


        }
        field(3969; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(3970; "Approved days"; Integer)
        {

            trigger OnValidate()
            begin
                HRLeaveTypes.Get("Leave Type");
                if HRLeaveTypes.Recurring then begin
                    if "Approved days" > "Days Applied" then
                        Error(TEXT001);
                    CheckLeaveAllowance;
                end;
            end;
        }
        field(3971; Attachments; Integer)
        {
            Editable = false;
        }
        field(3972; "Leave Period"; Code[20])
        {
        }
        field(3973; "Maximum Leave Days"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(3974; "Total Annual Leave"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Leave Period" = FIELD("Leave Period"),
                                                                             "Staff No." = FIELD("Employee No"),
                                                                             "Leave Type" = FILTER('ANNUAL' | 'INTERMITENT')));
            Description = 'Total Annual Leave taken within Period';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3975; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened" WHERE(Closed = CONST(false));
        }
        field(3976; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(3977; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(3978; "Total Exam Leave"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Leave Period" = FIELD("Leave Period"),
                                                                             "Staff No." = FIELD("Employee No"),
                                                                             "Leave Type" = CONST('EXAM')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(3979; "Total Leave Days Allw"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days (Allw)" WHERE("Leave Period" = FIELD("Leave Period"),
                                                                                    "Staff No." = FIELD("Employee No"),
                                                                                    "Leave Type" = FILTER('ANNUAL' | 'INTERMITENT')));
            FieldClass = FlowField;
        }
        field(3980; "New Entry Max Annual Days"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
    }

    keys
    {
        key(Key1; "Application Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //ERROR('Please be informed that your outstanding leave days is being readjusted based on directives from Management. Service will be back up shortly.');

        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Application Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Leave Application Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.", xRec."No series", 0D, "Application Code", "No series");
        end;
        //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE LEAVE APPLICATION TABLE
        //check if employee has stayed up to 6mnths


        // HREmp.Reset;
        // HREmp.SetRange(HREmp."User ID", UserId);
        // if HREmp.Find('-') then begin
        //     "Employee No" := HREmp."No.";
        //     "Job Tittle" := HREmp."Job Title";
        //     Names := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        //     HREmp.Get(HREmp."No.");
        //     "Global Dimension 1 Code" := HREmp."Global Dimension 2 Code";
        //     "Global Dimension 2 Code" := HREmp."Department Code";
        //     HREmp.CalcFields(HREmp.Picture);
        //     Picture := HREmp.Picture;

        //     "User ID" := UserId;
        // end else begin
        //     Error('User id' + ' ' + '[' + UserId + ']' + ' has not been assigned to any employee. Please consult the HR officer for assistance')
        // end;

        //CheckLeaveQualification;

        //GET LEAVE APPROVER DETAILS FROM USER SETUP TABLE COPY THEM TO THE LEAVE APPLICATION TABLE
        // UserSetup.Reset;
        // if UserSetup.Get(UserId) then begin
        //     UserSetup.TestField(UserSetup."Approver ID");
        //     Supervisor := UserSetup."Approver ID";
        //     UserSetup.Reset;
        //     if UserSetup.Get(Supervisor) then
        //         "Supervisor Email" := UserSetup."E-Mail";
        // end;

        //POPULATE FIELDS
        "Application Date" := Today;
        //"Payroll Period":=DMY2DATE(1,DATE2DMY(TODAY,2),DATE2DMY(TODAY,3));
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        HREmp: Record "HR Employees";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        SMTP: Codeunit "SMTP Mail";
        LeaveGjline: Record "HR Journal Line";
        "LineNo.": Integer;
        ApprovalComments: Record "Approval Comment Line";
        URL: Text[500];
        sDate: Record Date;
        Customized: Record "HR Calendar List";
        HREmailParameters: Record "HR E-Mail Parameters";
        HRLeavePeriods: Record "HR Leave Periods";
        HRJournalBatch: Record "HR Leave Journal Batch";
        TEXT001: Label 'Days Approved cannot be more than applied days';
        i: Integer;
        ReturnDate: Date;
        BaseCalendar: Record "Base Calendar Change";
        NextDate: Date;
        EMpHr: Record "HR Employees";
        LeaveType: Record "HR Leave Types";
        LeaveGroup: Record "Leave Group";
        DateofJoin: Integer;
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        HRLeaveReliver: Record "HR Leave Reliver";

    [Scope('OnPrem')]
    procedure DetermineLeaveReturnDate(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    begin
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        repeat
            if DetermineIfIncludesNonWorking("Leave Type") = false then begin
                fReturnDate := CalcDate('1D', fReturnDate);
                if DetermineIfIsNonWorking(fReturnDate) then
                    varDaysApplied := varDaysApplied + 1
                else
                    varDaysApplied := varDaysApplied;
                varDaysApplied := varDaysApplied - 1
            end
            else begin
                fReturnDate := CalcDate('1D', fReturnDate);
                varDaysApplied := varDaysApplied - 1;
            end;
        until varDaysApplied = 0;
        exit(fReturnDate);
    end;

    [Scope('OnPrem')]
    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[20]): Boolean
    begin
        if HRLeaveTypes.Get(fLeaveCode) then begin
            if HRLeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
        end;
    end;

    [Scope('OnPrem')]
    procedure DetermineIfIsNonWorking(var bcDate: Date) Isnonworking: Boolean
    begin
        /*
        HRSetup.FIND('-');
        HRSetup.TESTFIELD(HRSetup."Base Calendar");
        BaseCalendarChange.RESET;
        BaseCalendarChange.SETFILTER(BaseCalendarChange."Base Calendar Code",HRSetup."Base Calendar");
        BaseCalendarChange.SETRANGE(BaseCalendarChange.Date,bcDate);
        
        IF BaseCalendarChange.FIND('-') THEN BEGIN
        IF BaseCalendarChange.Nonworking = FALSE THEN
        ERROR('Start date can only be a Working Day Date');
        EXIT(TRUE);
        END;
        
        
        Customized.RESET;
        Customized.SETRANGE(Customized.Date,bcDate);
        IF Customized.FIND('-') THEN BEGIN
            IF Customized."Non Working" = TRUE THEN
            EXIT(TRUE)
            ELSE
            EXIT(FALSE);
        END;
         */


        HRSetup.Find('-');
        HRSetup.TestField(HRSetup."Base Calendar");
        BaseCalendarChange.Reset;
        BaseCalendarChange.SetFilter(BaseCalendarChange."Base Calendar Code", HRSetup."Base Calendar");
        if (Date2DWY(bcDate, 1) = 6) or (Date2DWY(bcDate, 1) = 7) then
            BaseCalendarChange.SetRange(BaseCalendarChange."Recurring System", BaseCalendarChange."Recurring System"::"Weekly Recurring")
        else
            BaseCalendarChange.SetRange(BaseCalendarChange.Date, bcDate);
        if BaseCalendarChange.Find('-') then begin
            if (Date2DWY(bcDate, 1) = 6) and (BaseCalendarChange.Nonworking = false) then
                exit(true)
            else
                if (Date2DWY(bcDate, 1) = 7) and (BaseCalendarChange.Nonworking = false) then
                    exit(true)
                else
                    if BaseCalendarChange.Nonworking = false then
                        Error('Start date can only be a Working Day Date');
            exit(true);
        end;

    end;

    [Scope('OnPrem')]
    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    begin
        ReturnDateLoop := true;
        fEndDate := fDate;
        if fEndDate <> 0D then begin
            fEndDate := CalcDate('-1D', fEndDate);
            while (ReturnDateLoop) do begin
                if DetermineIfIsNonWorking(fEndDate) then
                    fEndDate := CalcDate('-1D', fEndDate)
                else
                    ReturnDateLoop := false;
            end
        end;
        exit(fEndDate);
    end;

    [Scope('OnPrem')]
    procedure CreateLeaveLedgerEntries()
    begin
        TestField("Approved days");

        HRSetup.Reset;
        if HRSetup.Find('-') then begin

            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            LeaveGjline.DeleteAll;

            HRSetup.TestField(HRSetup."Leave Template");
            HRSetup.TestField(HRSetup."Leave Batch");

            HREmp.Get("Employee No");
            HREmp.TestField(HREmp."Company E-Mail");

            //POPULATE JOURNAL LINES

            "LineNo." := 10000;
            LeaveGjline.Init;
            LeaveGjline."Journal Template Name" := HRSetup."Leave Template";
            LeaveGjline."Journal Batch Name" := HRSetup."Leave Batch";
            LeaveGjline."Line No." := "LineNo.";
            LeaveGjline."Leave Period" := "Leave Period";
            LeaveGjline."Document No." := "Application Code";
            LeaveGjline."Staff No." := "Employee No";
            LeaveGjline.Validate(LeaveGjline."Staff No.");
            LeaveGjline."Posting Date" := Today;
            LeaveGjline."No. of days (Allw)" := "Approved days";
            LeaveGjline."Leave Entry Type" := LeaveGjline."Leave Entry Type"::Negative;
            LeaveGjline."Leave Approval Date" := Today;
            LeaveGjline.Description := 'Leave Taken';
            LeaveGjline."Leave Type" := "Leave Type";
            LeaveGjline."Maximum Leave Days" := "Maximum Leave Days";
            LeaveGjline."Leave Period Start Date" := "Start Date";
            LeaveGjline."Leave Period End Date" := "End Date";

            //------------------------------------------------------------
            //HRSetup.RESET;
            //HRSetup.FIND('-');
            HRSetup.TestField(HRSetup."Leave Posting Period[FROM]");
            HRSetup.TestField(HRSetup."Leave Posting Period[TO]");
            //------------------------------------------------------------
            LeaveGjline."Leave Period Start Date" := HRSetup."Leave Posting Period[FROM]";

            if HRLeavePeriods.Get("Leave Period") then begin
                if HRLeavePeriods.Closed then
                    LeaveGjline."Leave Period Closed" := true;
            end;
            LeaveGjline."Leave Period End Date" := HRSetup."Leave Posting Period[TO]";
            LeaveGjline."No. of Days" := "Approved days";
            if LeaveGjline."No. of Days" <> 0 then
                LeaveGjline.Insert(true);


            //Post Journal
            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            if LeaveGjline.Find('-') then begin
                CODEUNIT.Run(CODEUNIT::"HR Leave Jnl.-Post", LeaveGjline);
            end;

            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Document No.", "Application Code");
            if HRLeaveLedgerEntries.FindFirst then begin
                Status := Status::Posted;
                Modify;
            end;
            HREmp.Get("Employee No");
            HREmp."Leave Status" := HREmp."Leave Status"::"On Leave";
            HREmp.Modify;


            /*END ELSE BEGIN
            ERROR('You must specify no of days');
            END;
            END;*/
            //NotifyApplicant;
        end;

    end;

    [Scope('OnPrem')]
    procedure NotifyApplicant()
    var
        CompanyEmail: List Of [text];
    begin
        HREmp.Get("Employee No");
        HREmp.TestField(HREmp."Company E-Mail");

        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        HREmailParameters.Reset;
        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."Associate With"::General);
        if HREmailParameters.Find('-') then begin


            HREmp.TestField(HREmp."Company E-Mail");
            CompanyEmail.Add(HREmp."Company E-Mail");

            SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", CompanyEmail,
            HREmailParameters.Subject, 'Dear' + ' ' + HREmp."First Name" + ' ' +
            HREmailParameters.Body + ' ' + "Application Code" + ' ' + HREmailParameters."Body 2", true);
            SMTP.Send();


            Message('Leave applicant has been notified successfully');
        end;
    end;

    local procedure CheckLengthOfServ()
    var
        Emp: Record "HR Employees";
        HrDates: Codeunit "HR Dates No Permission Monthso";
        TotalMonths: Decimal;
        LeaveType: Record "HR Leave Types";
        LookUpVal: Record "HR Lookup Values";
        LeaveDays: Decimal;
        Text001: Label 'Previous year %1 Leave Days Forfeited';
    begin
        HRSetup.Get;
        LeaveType.Get("Leave Type");
        LeaveDays := 0;


        if HRSetup."Current Leave Period" <> Rec."Leave Period" then begin
            if Rec."Application Date" >= HRSetup."Forfeit Leave After" then
                Error(Text001, Rec."Leave Period");
        end;

        if Emp.Get(Rec."Employee No") then begin
            Emp.TestField("Job Level");
            LookUpVal.SetRange(LookUpVal.Type, LookUpVal.Type::"Job Level");
            LookUpVal.SetRange(LookUpVal.Code, Emp."Job Level");
            if LookUpVal.FindFirst then begin
                LeaveDays := LookUpVal."Annual Leave Days";
                "Maximum Leave Days" := LookUpVal."Annual Leave Days";
                Modify;
            end;


            if CalcDate(HRSetup."Annual Leave Qualification", Emp."Date Of Joining the Company") > Today then
                Error('you are not qualified for this leave type %1', "Leave Type")
            else
                if CalcDate('365D', Emp."Date Of Joining the Company") > Today then begin
                    TotalMonths := HrDates.DetermineAge(Emp."Date Of Joining the Company", Today);
                    Rec."New Entry Max Annual Days" := Round((TotalMonths / 12) * LeaveDays, 1);
                    Rec.Modify;
                end;
        end;
        //Message('%1', "Days Applied");
    end;

    [Scope('OnPrem')]
    procedure CheckLeaveAllowance()
    var
        Emp: Record "HR Employees";
        LeaveApp: Record "HR Leave Application";
        LeaveEntry: Record "HR Leave Ledger Entries";
        prSalaryCard: Record "prSalary Card";
        HrSetup: Record "HR Setup";
    begin
        //Check Current Period
        HRLeavePeriods.Get("Leave Period");
        if HRLeavePeriods.Closed = false then begin
            HrSetup.Get;
            CalcFields("Total Leave Days Allw");
            if ("Total Leave Days Allw" < HrSetup."Leave Allowance Days") and ("Approved days" >= HrSetup."Leave Allowance Days") then begin   //add to setup
                Message('Employee is entitled to leave allowance');
                //IF prSalaryCard.GET(Rec."Employee No") THEN BEGIN
                Rec."Request Leave Allowance" := true;
                //Rec."Leave Allowance Amount":= prSalaryCard."Basic Pay" * 0.1;
                //MODIFY;
            end;
        end;
    end;

    [Scope('OnPrem')]
    procedure GeneratePV()
    var
        VouchHeader: Record "Voucher Header";
        VouchLine: Record "Voucher Line";
        text001: Label 'Leave Allowance Pymt to  %1 for the period of %2';
        PostingGroup: Code[20];
        PayHead: Record "Voucher Header";
        PostedApprovalEntry: Record "Posted Approval Entry";
        AppEntry: Record "Approval Entry";
        Customer: Record Customer;
        UserSetup: Record "User Setup";
        Emp: Record "HR Employees";
        EmpName: Text[100];
    begin
        VouchHeader.Reset;
        VouchHeader.SetRange(VouchHeader."External Document No.", Rec."Application Code");
        if VouchHeader.Find('-') = true then
            Error('Payment Voucher has already been created for this document,Payment Voucher No: %1', VouchHeader."No.");

        if Emp.Get("Employee No") then
            EmpName := Emp."Last Name" + ' ' + Emp."First Name" + ' ' + CopyStr(Emp."Middle Name", 1, 1);

        UserSetup.Get(UserId);
        UserSetup.TestField("Staff Travel Account");
        begin
            VouchHeader.Init;
            VouchHeader."Posting Date" := WorkDate;
            //VouchHeader.Payee := EmpName;
            //VouchHeader."On Behalf Of":="Employee Name";
            //VouchHeader.Cashier:=Cashier;
            VouchHeader.Status := VouchHeader.Status::"Pending Approval";
            //VouchHeader."Payment Type" := VouchHeader."Payment Type"::Normal;
            //VouchHeader."Pay Mode" := VouchHeader."Pay Mode"::Cheque;
            VouchHeader."Voucher Type" := VouchHeader."Voucher Type"::BPV;
            //VouchHeader."Leave Payment" := true;

            //VouchHeader."Payment Type" := VouchHeader."Payment Type"::Normal;
            VouchHeader."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
            VouchHeader.Validate("Shortcut Dimension 1 Code");
            VouchHeader."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
            VouchHeader.Validate("Shortcut Dimension 2 Code");
            VouchHeader."Responsibility Center" := "Responsibility Center";
            //VouchHeader."Payment Release Date":="Payment Release Date";
            //VouchHeader."Shortcut Dimension 3 Code":="Shortcut Dimension 3 Code";
            //VouchHeader.VALIDATE("Shortcut Dimension 3 Code");
            //VouchHeader."Shortcut Dimension 4 Code":="Shortcut Dimension 4 Code";
            VouchHeader.Validate("Shortcut Dimension 4 Code");
            VouchHeader.Narration := StrSubstNo(text001, "Employee No", "Leave Period");
            VouchHeader."External Document No." := "Application Code";
            VouchHeader."Created By" := UserId;
            VouchHeader.Insert(true);

            //create Line
            VouchLine.Init;
            VouchLine."Line No." := 10000;
            VouchLine."Document No." := VouchHeader."No.";
            //add Vendor to Type
            if Customer.Get(UserSetup."Staff Travel Account") then   //Get users staff travel account
                PostingGroup := Customer."Customer Posting Group";
            //VouchLine.Grouping := PostingGroup;
            //VouchLine.Type := 'CASHVENDOR';
            VouchLine."Account Type" := VouchLine."Account Type"::Customer;
            VouchLine."Account No." := UserSetup."Staff Travel Account";
            VouchLine.Validate("Account No.");
            //VouchLine."Account Name":= "Provider Name";
            VouchLine."Voucher Type" := VouchHeader."Voucher Type";
            VouchLine.Amount := Rec."Leave Allowance Amount";
            // VouchLine."Net Amount" := Rec."Leave Allowance Amount";

            //VouchLine."Pay Mode" := VouchHeader."Pay Mode";
            VouchLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
            VouchLine.Validate("Shortcut Dimension 1 Code");
            VouchLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
            VouchLine.Validate("Shortcut Dimension 2 Code");
            /*VouchLine."Shortcut Dimension 3 Code":=PurchLine."Shortcut Dimension 3 Code";
            VouchLine.VALIDATE("Shortcut Dimension 3 Code");
            VouchLine."Shortcut Dimension 4 Code":=PurchLine."Shortcut Dimension 4 Code";
            VouchLine.VALIDATE("Shortcut Dimension 4 Code");*/
            VouchLine.Insert(true);
        end;
        /*
     //move approval entrie
      PostedApprovalEntry.SETRANGE("Document No.",Rec."Application No");
      PostedApprovalEntry.SETRANGE(Status,PostedApprovalEntry.Status::Approved);
      IF PostedApprovalEntry.FINDSET THEN BEGIN
       REPEAT
       AppEntry.INIT;
       AppEntry.TRANSFERFIELDS(PostedApprovalEntry);
       AppEntry."Document No.":=PayHead."No.";
       AppEntry."Document Type":=AppEntry."Document Type"::"24";
       AppEntry."Table ID":=39005589;
       AppEntry.INSERT;
       UNTIL PostedApprovalEntry.NEXT = 0;
      END; */
        Message('Payment Voucher created successfully');

        //NotifyApplicant;

    end;

    local procedure CheckLeaveQualification()
    var
        Emp: Record "HR Employees";
    begin
        if Emp.Get(Rec."Employee No") then begin
            HRSetup.Get;
            if CalcDate(HRSetup."Annual Leave Qualification", Emp."Date Of Joining the Company") > Today then
                Error('you are not qualified for this leave type %1', "Leave Type")
        end;
    end;

    procedure CheckHRLeaveAppLines(): Boolean
    begin
        HRLeaveReliver.Reset;
        HRLeaveReliver.SetRange("Application No.", "Application Code");
        HRLeaveReliver.SetRange("Employee No", "Employee No");
        exit(not HRLeaveReliver.IsEmpty);
    end;
}


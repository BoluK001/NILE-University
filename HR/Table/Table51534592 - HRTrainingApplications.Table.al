table 51534592 "HR Training Applications"
{

    fields
    {
        field(1; "Application No"; Code[20])
        {
            Editable = true;

            trigger OnValidate()
            begin
                if "Employee No." <> xRec."Employee No." then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Training Application Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Course Title"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Training Needs".Code;

            trigger OnValidate()
            begin

                if HRTrainingNeeds.Get("Course Title") then
                    //"Course Title":=HRTrainingNeeds.Code;
                    Description := HRTrainingNeeds.Description;
                Provider := HRTrainingNeeds.Provider;
                "Provider Name" := HRTrainingNeeds."Provider Name";

                /*
                "From Date":=HRTrainingNeeds."Start Date";
                "To Date":=HRTrainingNeeds."End Date";
                "Duration Units":=HRTrainingNeeds."Duration Units";
                Duration:=HRTrainingNeeds.Duration;
                "Cost Of Training":=HRTrainingNeeds."Cost Of Training";
                Location:=HRTrainingNeeds.Location;
                Provider:=HRTrainingNeeds.Provider;
                "Provider Name":=HRTrainingNeeds."Provider Name";
                  */

            end;
        }
        field(3; "From Date"; Date)
        {
            Editable = true;
        }
        field(4; "To Date"; Date)
        {
            Editable = true;
        }
        field(5; "Duration Units"; Option)
        {
            Editable = true;
            OptionMembers = Hours,Days,Weeks,Months,Years;
        }
        field(6; Duration; Decimal)
        {
            DecimalPlaces = 0 : 6;
            Editable = true;
        }
        field(7; "Cost Of Training"; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            begin
                /*IF Posted THEN BEGIN
                IF Duration <> xRec.Duration THEN BEGIN
                MESSAGE('%1','You cannot change the costs after posting');
                Duration := xRec.Duration;
                END
                END
                */

            end;
        }
        field(8; Location; Text[30])
        {
            Editable = true;
        }
        field(11; Posted; Boolean)
        {
            Editable = true;
        }
        field(12; Description; Text[100])
        {
            Editable = false;
        }
        field(28; "Training Evaluation Results"; Option)
        {
            OptionMembers = "Not Evaluated",Passed,Failed;
        }
        field(29; Year; Integer)
        {
        }
        field(30; Provider; Code[20])
        {
            Editable = true;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.", Provider);
                if Vend.Find('-') then begin
                    "Provider Name" := Vend.Name;
                end;
            end;
        }
        field(31; "Reason for Training"; Option)
        {
            OptionMembers = " ","Regulatory Compliance","New system/equipment","Internal/external audit","Started/starting on project","Development plan","corporate requirement","new policy/procedures","Started/starting new role","Revised role responsibilities","Performance improvement";
        }
        field(32; Status; Option)
        {
            Editable = true;
            OptionMembers = New,"Pending Approval",Approved,Rejected,Posted;
        }
        field(33; "Employee No."; Code[20])
        {
            //NotBlank = true;
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmp.Get("Employee No.");
                "Shortcut Dimension 1 Code" := HREmp."Department Code";
                "Shortcut Dimension 2 Code" := HREmp."Global Dimension 2 Code";
                "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            end;
        }
        field(35; "Application Date"; Date)
        {
            Editable = false;
        }
        field(36; "No. Series"; Code[20])
        {
        }
        field(37; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(39; Recommendations; Code[20])
        {
        }
        field(40; "User ID"; Code[50])
        {
        }
        field(41; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(42; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(43; "Employee Name"; Text[50])
        {
        }
        field(44; "Provider Name"; Text[50])
        {
        }
        field(47; "Approved Cost"; Decimal)
        {
        }
        field(48; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(49; "No. of Applicants"; Integer)
        {
            CalcFormula = Count("HR Training Need Participant" WHERE(Selected = CONST(true),
                                                                      "Document No." = FIELD("Application No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; Type; Option)
        {
            OptionMembers = " ",HR,HOD,Staff;
        }
        field(51; "Staff Course Title"; Code[30])
        {
        }
        field(52; "Recommended By"; Option)
        {
            OptionCaption = ' ,Staff,Company';
            OptionMembers = " ",Staff,Company;
        }
        field(53; "Sent to Staff"; Boolean)
        {
        }
        field(54; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("HR Training Need Participant".Amount WHERE("Document No." = FIELD("Application No")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(55; "Sent to HR"; Boolean)
        {
        }
        field(56; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

        }
        field(57; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(58; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(59; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(60; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(61; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
    }

    keys
    {
        key(Key1; "Application No")
        {
            Clustered = true;
        }
        key(Key2; Provider)
        {
            // Clustered = true;
            Enabled = false;
        }

    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        if Status <> Status::New then
            Error(mcontent);
    end;

    trigger OnInsert()
    var
        Emp: Record "HR Employees";
    begin
        if "Application No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Training Application Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Training Application Nos.", xRec."No. Series", 0D, "Application No", "No. Series");  //jj270422
        end;

        "User ID" := UserId;
        "Application Date" := Today;


        if Type = Type::Staff then begin
            UserSetup.Get(UserId);
            Emp.SetRange("User ID", UserSetup."User ID");
            if Emp.FindFirst then begin
                TrainingApplicant.Init;
                TrainingApplicant."Line No." := 0;
                TrainingApplicant."Document No." := Rec."Application No";
                TrainingApplicant."Employee Code" := Emp."No.";
                TrainingApplicant.Department := Emp."Department Code";
                TrainingApplicant."Job Title" := Emp."Job Title";
                TrainingApplicant.Selected := true;
                TrainingApplicant.Validate("Employee Code");
                TrainingApplicant.Insert;
            end;
        end;
    end;

    var
        HRTrainingNeeds: Record "HR Training Needs";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        mcontent: Label 'Status must be new on Training Application No.';
        mcontent2: Label '. Please cancel the approval request and try again';
        HREmp: Record "HR Employees";
        Vend: Record Vendor;
        TrainingApplicant: Record "HR Training Need Participant";
        UserSetup: Record "User Setup";
        HRTraining: Record "HR Training Need Participant";

    [Scope('OnPrem')]
    procedure GeneratePV()
    var
        VouchHeader: Record "Voucher Header";
        VouchLine: Record "Voucher Line";
        text001: Label 'Paymt For Employee Training Program %1';
        PostingGroup: Code[20];
        PayHead: Record "Voucher Header";
        PostedApprovalEntry: Record "Posted Approval Entry";
        AppEntry: Record "Approval Entry";
        LineNo: Integer;
    begin
        VouchHeader.Reset;
        VouchHeader.SetRange(VouchHeader."External Document No.", Rec."Application No");
        if VouchHeader.Find('-') = true then
            Error('Payment Request has already been created for this document,Payment Voucher No: %1', VouchHeader."No.");

        begin
            VouchHeader.Init;
            VouchHeader."Document Date" := WorkDate;
            //VouchHeader.Payee := Rec."Provider Name";
            //VouchHeader."On Behalf Of" := "Employee Name";
            //VouchHeader.Cashier := Cashier;
            VouchHeader.Status := VouchHeader.Status::Open;
            //VouchHeader."Payment Type" := VouchHeader."Payment Type"::Express;
            //VouchHeader."Pay Mode" := VouchHeader."Pay Mode"::Cheque;
            VouchHeader."Voucher Type" := VouchHeader."Voucher Type"::BPV;
            //VouchHeader."Payment Type" := VouchHeader."Payment Type"::Normal;
            VouchHeader."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            VouchHeader.Validate("Shortcut Dimension 1 Code");
            VouchHeader."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            VouchHeader.Validate("Shortcut Dimension 2 Code");
            VouchHeader."Responsibility Center" := "Responsibility Center";
            VouchHeader."Created Date" := today;
            VouchHeader."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
            VouchHeader.VALIDATE("Shortcut Dimension 3 Code");
            VouchHeader."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
            VouchHeader.Validate("Shortcut Dimension 4 Code");
            VouchHeader.Narration := StrSubstNo(text001, "Course Title");
            VouchHeader."External Document No." := "Application No";
            VouchHeader."Created By" := UserId;
            VouchHeader.Insert(true);

            //create Line
            TrainingApplicant.SetRange(TrainingApplicant."Document No.", "Application No");
            if TrainingApplicant.FindFirst then begin
                repeat
                    LineNo += 10000;
                    VouchLine.Init;
                    VouchLine."Line No." := LineNo;
                    VouchLine."Document No." := VouchHeader."No.";
                    VouchHeader."Voucher Type" := VouchHeader."Voucher Type";
                    //add Vendor to Type
                    if Vend.Get(Rec.Provider) then
                        PostingGroup := Vend."Vendor Posting Group";
                    VouchLine."Posting Group" := PostingGroup;
                    //VouchLine.Type := 'CASHVENDOR';
                    VouchLine."Account Type" := VouchLine."Account Type"::Vendor;
                    VouchLine."Account No." := Rec.Provider;
                    VouchLine.Validate("Account No.");
                    VouchLine."Account Name" := "Provider Name";
                    VouchLine.Narration := TrainingApplicant."Employee Name";
                    VouchLine."Voucher Type" := VouchHeader."Voucher Type"::BPV;
                    VouchLine.Amount := TrainingApplicant.Amount;
                    VouchLine.Validate(Amount);
                    //VouchLine."Net Amount":= ;

                    //VouchLine."Bank Payment Type" := VouchHeader."Pay Mode";
                    VouchLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                    VouchLine.Validate("Shortcut Dimension 1 Code");
                    VouchLine."Shortcut Dimension 2 Code" := TrainingApplicant.Department;
                    VouchLine.Validate("Shortcut Dimension 2 Code");
                    VouchLine.Insert(true);
                until TrainingApplicant.Next = 0;
            end;
        end;
        Message('Payment Request created successfully');

        //NotifyApplicant;
    end;

    [Scope('OnPrem')]
    procedure NotifyApplicant()
    var
        HREmp: Record "HR Employees";
        ApplicantsEmail: Text[30];
        SMTP: Codeunit "SMTP Mail";
        HREmailParameters: Record "HR E-Mail Parameters";
        CompanyEmail: List of [Text];
    begin
        HREmp.Get("Employee No.");
        HREmp.TestField(HREmp."Company E-Mail");
        CompanyEmail.Add(HREmp."Company E-Mail");
        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        HREmailParameters.Reset;
        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."Associate With"::"Training Application");
        if HREmailParameters.Find('-') then begin
            HREmp.TestField(HREmp."Company E-Mail");
            CompanyEmail.Add(HREmp."Company E-Mail");
            SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", CompanyEmail,
            HREmailParameters.Subject, 'Dear' + ' ' + HREmp."First Name" + ' ' +
            HREmailParameters.Body + ' ' + "Application No" + ' ' + HREmailParameters."Body 2", true);
            SMTP.Send();
            Message('Training applicant has been notified successfully');
        end;
    end;

    procedure CheckTrainingAppLines(): Boolean
    begin
        HRTraining.Reset;
        HRTraining.SetRange("Document No.", "Application No");
        exit(not HRTraining.IsEmpty);
    end;
}


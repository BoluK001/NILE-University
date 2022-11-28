table 51534566 "HR Company Activities"
{

    fields
    {
        field(1; "Code"; Code[20])
        {

            trigger OnValidate()
            var

                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                if Code <> xRec.Code then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Company Activities");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[200])
        {
        }
        field(3; Date; DateTime)
        {
        }
        field(4; Venue; Text[200])
        {
        }
        field(5; "Employee Responsible"; Code[20])
        {
            TableRelation = "HR Employees"."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Employee Responsible");
                if HREmp.Find('-') then begin
                    EmpName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Employee Name" := EmpName;
                end;
            end;
        }
        field(6; Costs; Decimal)
        {
        }
        field(7; "G/L Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin
                GLAccts.Reset;
                GLAccts.SetRange(GLAccts."No.", "G/L Account No");
                if GLAccts.Find('-') then begin
                    "G/L Account Name" := GLAccts.Name;
                end;
            end;
        }
        field(8; "Bal. Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";

            trigger OnValidate()
            begin
                //{
                //IF "Bal. Account Type" = "Bal. Account Type"::"G/L Account" THEN
                //GLAccts.GET(GLAccts."No.")
                //ELSE
                //Banks.GET(Banks."No.");
                //}
            end;
        }
        field(9; "Bal. Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner";
        }
        field(11; Posted; Boolean)
        {
            Editable = false;
        }
        field(16; "Email Message"; Text[250])
        {
        }
        field(17; "No. Series"; Code[20])
        {
        }
        field(18; Closed; Boolean)
        {
            Editable = false;
        }
        field(19; "Contribution Amount (If Any)"; Decimal)
        {
        }
        field(20; Status; Option)
        {
            OptionMembers = Planning,"On going",Complete;
        }
        field(21; "G/L Account Name"; Text[50])
        {
        }
        field(22; "Employee Name"; Text[50])
        {
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                if Participants = Participants::"Notify All" then begin

                    HRActivityParticipants.SetRange(HRActivityParticipants."Document No.", Code);
                    if HRActivityParticipants.FindFirst then
                        HRActivityParticipants.DeleteAll;

                    HREmp.SetRange(HREmp."Department Code", "Global Dimension 2 Code");
                    if HREmp.FindFirst then
                        repeat
                            HRActivityParticipants.Init;
                            HRActivityParticipants."Document No." := Code;
                            HRActivityParticipants."Approver ID" := HREmp."User ID";
                            HRActivityParticipants.Participant := HREmp."No.";
                            HRActivityParticipants.Validate(Participant);
                            HRActivityParticipants.Insert;
                        until HREmp.Next = 0;
                end;
            end;
        }
        field(25; "Participant Group"; Integer)
        {
            TableRelation = "HR Participant Group"."No." WHERE("Created By" = FIELD("Created By"));

            trigger OnValidate()
            begin
                if Participants = Participants::"Select Participants" then begin

                    HRActivityParticipants.SetRange(HRActivityParticipants."Document No.", Code);
                    if HRActivityParticipants.FindFirst then
                        HRActivityParticipants.DeleteAll;

                    HRParticipantGroupLines.SetRange(HRParticipantGroupLines."Doc No", "Participant Group");
                    if HRParticipantGroupLines.FindFirst then
                        repeat

                            HREmp.SetRange(HREmp."Department Code", "Global Dimension 2 Code");
                            HREmp.SetRange(HREmp."Job Level", HRParticipantGroupLines."Job Level");
                            if HREmp.FindFirst then begin
                                repeat
                                    HREmp.SetRange(HREmp."Department Code", "Global Dimension 2 Code");
                                    HRActivityParticipants.Init;
                                    HRActivityParticipants."Document No." := Code;
                                    HRActivityParticipants.Participant := HREmp."No.";
                                    HRActivityParticipants."Approver ID" := HREmp."User ID";
                                    HRActivityParticipants.Validate(Participant);
                                    HRActivityParticipants.Insert;
                                until HREmp.Next = 0;
                            end;

                        until HRParticipantGroupLines.Next = 0;
                end;
            end;
        }
        field(26; "Created By"; Code[50])
        {
        }
        field(27; Participants; Option)
        {
            OptionMembers = " ","Notify All","Select Participants";
        }
        field(28; "Employee No"; Code[20])
        {
            TableRelation = "HR Employees";
        }
        field(29; Sent; Boolean)
        {
        }
        field(30; Subject; Text[100])
        {
        }
        field(31; "Activity Type"; Option)
        {
            OptionMembers = Company,Staff;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if Code = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Company Activities");
            NoSeriesMgt.InitSeries(HRSetup."Company Activities", xRec."No. Series", 0D, Code, "No. Series");
        end;

        "Created By" := UserId;
    end;

    var
        GLAccts: Record "G/L Account";
        Banks: Record "Bank Account";
        Text000: Label 'You have canceled the create process.';
        Text001: Label 'Replace existing attachment?';
        Text002: Label 'You have canceled the import process.';
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmp: Record "HR Employees";
        EmpName: Text;
        HRActivityParticipants: Record "HR Activity Participants";
        HRParticipantGroupLines: Record "HR Participant Group Lines";
}


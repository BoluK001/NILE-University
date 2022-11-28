table 51534586 "HR Activity Participants"
{
    Caption = 'HR Activity Participants';

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Company Activity';
            OptionMembers = "Company Activity";
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(4; "Sequence No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Sequence No.';
        }
        field(5; "Approval Code"; Code[20])
        {
            Caption = 'Approval Code';
        }
        field(6; "Sender ID"; Code[50])
        {
            Caption = 'Sender ID';
            Editable = false;
        }
        field(7; Contribution; Decimal)
        {
            Caption = 'Contribution';
        }
        field(8; "Approver ID"; Code[50])
        {
            Caption = 'Participant User ID';
            Editable = false;
        }
        field(9; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Created,Open,Canceled,Rejected,Approved';
            OptionMembers = Created,Open,Canceled,Rejected,Approved;
        }
        field(10; "Date-Time Sent for Approval"; DateTime)
        {
            Caption = 'Date-Time Sent for Approval';
        }
        field(11; "Last Date-Time Modified"; DateTime)
        {
            Caption = 'Last Date-Time Modified';
        }
        field(12; "Last Modified By ID"; Code[50])
        {
            Caption = 'Last Modified By ID';
        }
        field(13; Comment; Boolean)
        {
            CalcFormula = Exist("Approval Comment Line" WHERE("Table ID" = FIELD("Table ID"),
                                                               "Document Type" = FIELD("Document Type"),
                                                               "Document No." = FIELD("Document No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Event Date"; DateTime)
        {
            Caption = 'Event Date';
            Editable = false;
        }
        field(15; "Event Code"; Code[20])
        {
            AutoFormatType = 1;
            Caption = 'Event Code';
            Editable = false;
        }
        field(16; "Event Description"; Text[30])
        {
            AutoFormatType = 1;
            Caption = 'Event Description';
            Editable = false;
        }
        field(17; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(18; "Approval Type"; Option)
        {
            Caption = 'Approval Type';
            OptionCaption = ' ,Sales Pers./Purchaser,Approver';
            OptionMembers = " ","Sales Pers./Purchaser",Approver;
        }
        field(19; "Limit Type"; Option)
        {
            Caption = 'Limit Type';
            OptionCaption = 'Approval Limits,Credit Limits,Request Limits,No Limits';
            OptionMembers = "Approval Limits","Credit Limits","Request Limits","No Limits";
        }
        field(20; "Event Venue"; Text[30])
        {
            Caption = 'Event Venue';
            Editable = false;
        }
        field(21; "Email Message"; Text[250])
        {
            Caption = 'Email Message';
        }
        field(22; Participant; Code[20])
        {
            TableRelation = "HR Employees"."No." WHERE("Job Title" = FILTER(<> 'DRIVER'));

            trigger OnValidate()
            begin
                HREmp.Reset;
                if HREmp.Get(Participant) then begin
                    "Approver ID" := HREmp."User ID";
                    HRCompanyActivities.Get("Document No.");
                    "Participant Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Table ID" := 39003946;
                    "Event Date" := HRCompanyActivities.Date;
                    "Event Venue" := HRCompanyActivities.Venue;
                    "Email Message" := HRCompanyActivities."Email Message";
                    "Event Code" := HRCompanyActivities.Code;
                    "Event Description" := HRCompanyActivities.Description;
                    "Sender ID" := UserId;
                    Status := Status::Created;
                end;
            end;
        }
        field(23; Notified; Boolean)
        {
            Editable = false;
        }
        field(24; "Participant Name"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Approver ID", "Document No.")
        {
            Clustered = true;
        }
        key(Key2; "Table ID", "Document Type", "Document No.", "Sequence No.")
        {
            //Clustered = true;
            Enabled = false;
        }
        key(Key3; "Approver ID", Status)
        {
            Enabled = false;
        }
        key(Key4; "Sender ID")
        {
            Enabled = false;
        }
    }

    fieldgroups
    {
    }

    var
        HRCompanyActivities: Record "HR Company Activities";
        HREmp: Record "HR Employees";

    [Scope('OnPrem')]
    procedure ShowDocument()
    var
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
    begin
        case "Table ID" of
            DATABASE::"Sales Header":
                begin
                    if not SalesHeader.Get("Document Type", "Document No.") then
                        exit;
                    case "Document Type" of
                        "Document Type"::"Company Activity":
                            PAGE.Run(PAGE::"Sales Quote", SalesHeader);
                    /*
                "Document Type"::"1":
                    PAGE.Run(PAGE::"Sales Order", SalesHeader);
                "Document Type"::"2":
                    PAGE.Run(PAGE::"Sales Invoice", SalesHeader);
                "Document Type"::"3":
                    PAGE.Run(PAGE::"Sales Credit Memo", SalesHeader);
                "Document Type"::Currency:
                    PAGE.Run(PAGE::"Blanket Sales Order", SalesHeader);
                "Document Type"::"5":
                    PAGE.Run(PAGE::"Sales Return Order", SalesHeader);
                    */
                    end;
                end;
            DATABASE::"Purchase Header":
                begin
                    if not PurchHeader.Get("Document Type", "Document No.") then
                        exit;
                    case "Document Type" of
                        "Document Type"::"Company Activity":
                            PAGE.Run(PAGE::"Purchase Quote", PurchHeader);
                    /*
                "Document Type"::"1":
                    PAGE.Run(PAGE::"Purchase Order", PurchHeader);
                "Document Type"::"2":
                    PAGE.Run(PAGE::"Purchase Invoice", PurchHeader);
                "Document Type"::"3":
                    PAGE.Run(PAGE::"Purchase Credit Memo", PurchHeader);
                "Document Type"::Currency:
                    PAGE.Run(PAGE::"Blanket Purchase Order", PurchHeader);
                "Document Type"::"5":
                    PAGE.Run(PAGE::"Purchase Return Order", PurchHeader);
                    */
                    end;
                end;
        end;
    end;
}


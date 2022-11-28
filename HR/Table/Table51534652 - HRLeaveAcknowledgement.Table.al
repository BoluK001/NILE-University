table 51534652 "HR Leave Acknowledgement"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Leave No."; Code[20])
        {
            TableRelation = "HR Leave Application"."Application Code" WHERE(Status = CONST(Posted));

            trigger OnValidate()
            begin
                HRLeaveApplication.Get("Leave No.");
                "Days Applied" := HRLeaveApplication."Approved days";
                "Start Date" := HRLeaveApplication."Start Date";
                "Return Date" := HRLeaveApplication."Return Date";
                "Leave Type" := HRLeaveApplication."Leave Type";
                "Employee No." := HRLeaveApplication."Employee No";
                HREmp.Get("Employee No.");
                "Employee Name" := HREmp."Last Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."First Name";
            end;
        }
        field(3; "Days Applied"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(4; "Start Date"; Date)
        {
        }
        field(5; "Return Date"; Date)
        {
        }
        field(6; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved,Updated';
            OptionMembers = Open,"Pending Approval",Approved,Updated;
        }
        field(7; "Leave Type"; Code[20])
        {
        }
        field(8; "Actual Days Spent"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Actual Days Spent" > "Days Applied" then
                    Error('Actual Days Spent can not exceed days applied');
            end;
        }
        field(9; "User ID"; Code[50])
        {
        }
        field(65; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(66; "Actual Return Day"; Date)
        {
        }
        field(67; Comment; Text[250])
        {
        }
        field(68; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(69; "Employee No."; Code[20])
        {
        }
        field(70; "First Name"; Text[30])
        {
        }
        field(71; "Middle Name"; Text[30])
        {
        }
        field(72; "Last Name"; Text[30])
        {
        }
        field(73; "Employee Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User ID" := UserId;
        if "No." = '' then begin
            HRSetup.Get;
            //HRSetup.TESTFIELD(HRSetup."Ticket Nos") ;
            //NoSeriesMgt.InitSeries(HRSetup."Leave Acknowledgement Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    trigger OnModify()
    begin
        //Leave Acknowledgement Nos
    end;

    var
        HRLeaveApplication: Record "HR Leave Application";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        HRSetup: Record "HR Setup";
        HREmp: Record "HR Employees";
}


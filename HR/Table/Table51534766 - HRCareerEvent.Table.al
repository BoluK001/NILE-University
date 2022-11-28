table 51534766 "HR Career Event"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Event Type"; Option)
        {
            OptionCaption = ' ,Promotion,Transfer';
            OptionMembers = " ",Promotion,Transfer;
        }
        field(3; "Date Modified"; Date)
        {
        }
        field(4; "User Id"; Code[50])
        {
        }
        field(6; "New Value"; Code[20])
        {
        }
        field(7; "Employee No."; Code[20])
        {
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                if HrEmp.Get("Employee No.") then begin
                    "First Name" := HrEmp."First Name";
                    "Last Name" := HrEmp."Last Name";
                    "Middle Name" := HrEmp."Middle Name";
                    "Current Job Title" := HrEmp."Job Title";
                    "Current Location" := HrEmp."Department Code";
                    //"Length of service":=HrEmp."Length Of Service";
                end;
            end;
        }
        field(8; "Requisition No."; Code[20])
        {
            TableRelation = "HR Employee Requisitions";

            trigger OnValidate()
            begin
                HREmpReq.SetRange(HREmpReq."Requisition No.", "Requisition No.");
                if HREmpReq.FindFirst then begin
                    "Job Title" := HREmpReq."Job ID";
                end;
            end;
        }
        field(9; "First Name"; Text[50])
        {
        }
        field(10; "Last Name"; Text[50])
        {
        }
        field(11; "Middle Name"; Text[50])
        {
        }
        field(12; "Current Job Title"; Code[20])
        {
        }
        field(13; "Current Location"; Code[20])
        {
        }
        field(14; "Length of service"; Code[50])
        {
        }
        field(15; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Updated';
            OptionMembers = Open,"Pending Approval",Approved,Updated;
        }
        field(16; "Job Title"; Code[20])
        {
        }
        field(19; "Old Value"; Code[30])
        {
        }
        field(20; "Field Modified"; Code[20])
        {
        }
        field(21; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmpReq: Record "HR Employee Requisitions";
        HrEmp: Record "HR Employees";
}


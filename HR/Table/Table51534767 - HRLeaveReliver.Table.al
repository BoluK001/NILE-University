table 51534767 "HR Leave Reliver"
{

    fields
    {
        field(1; "Application No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Reliver No."; Code[50])
        {
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                if "Reliver No." = "Employee No" then
                    Error('you cannot pick self as a reliver');

                if HrEmp.Get("Reliver No.") then
                    "Reliver Name" := HrEmp."Last Name" + ' ' + HrEmp."First Name" + ' ' + HrEmp."Middle Name";
            end;
        }
        field(4; "Reliver Name"; Text[100])
        {
        }
        field(5; "Employee No"; Code[20])
        {
        }
        field(6; "Department Code"; Code[20])
        {
        }
        field(7; "Location Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Application No.", "Line No.", "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HrEmp: Record "HR Employees";
}


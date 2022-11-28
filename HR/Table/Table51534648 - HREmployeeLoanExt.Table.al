table 51534648 "HR Employee Loan Ext"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.") then begin
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; Current; Boolean)
        {
        }
        field(5; "Bank Name"; Code[20])
        {
        }
        field(6; "Monthly Repayment"; Decimal)
        {
        }
        field(7; Amount; Decimal)
        {
        }
        field(8; "Start Date"; Date)
        {
        }
        field(9; "End Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No", "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Emp: Record "HR Employees";
}


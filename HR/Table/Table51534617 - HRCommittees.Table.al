table 51534617 "HR Committees"
{
    LookupPageID = "HR Committees";

    fields
    {
        field(1; Commitee; Option)
        {
            NotBlank = false;
            OptionMembers = " ","Disciplinary Commitee","Query","Query Mgt (others)","Internal job";
        }
        field(2; Description; Text[200])
        {
            NotBlank = true;
        }
        field(3; Roles; Text[200])
        {
        }
        field(4; "Employee No."; Code[20])
        {
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                Emp.Get("Employee No.");
                "Employee Name" := Format(Emp."Last Name" + ' ' + Emp."First Name");
            end;
        }
        field(5; "Employee Name"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; Commitee, "Employee No.")
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


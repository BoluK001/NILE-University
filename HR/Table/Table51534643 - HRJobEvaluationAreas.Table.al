table 51534643 "HR Job Evaluation Areas"
{

    fields
    {
        field(10; "Requisition No."; Code[50])
        {

            trigger OnValidate()
            begin
                /* InterV.RESET;
                 InterV.SETRANGE(InterV."Evaluation Code","Requisition No.");
                 IF InterV.FIND('-') THEN BEGIN
                 "Evaluation Description":=InterV."Evaluation Description";
                  Weight:=InterV."Evaluation Score";
                  END
                 */

            end;
        }
        field(20; "Evaluation Description"; Text[250])
        {
            Editable = false;
        }
        field(21; Stage; Option)
        {
            OptionCaption = 'Stage1,Stage2,Stage3';
            OptionMembers = Stage1,Stage2,Stage3;
        }
        field(22; Job; Code[30])
        {
            TableRelation = "HR Jobs";
        }
        field(23; "Pass Mark"; Decimal)
        {
        }
        field(24; Weight; Decimal)
        {
        }
        field(25; "Employee Code"; Code[20])
        {
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                if Emp.Get("Employee Code") then
                    "Employee Name" := Emp."Last Name" + ' ' + Emp."First Name";
                "Job Title" := Emp."Job Title";
            end;
        }
        field(26; "Employee Name"; Text[100])
        {
        }
        field(27; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(28; "Job Title"; Code[20])
        {
        }
        field(29; "ED of Requesting Dept"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Requisition No.", "Entry No.", "Employee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Employee Code", "Employee Name")
        {
        }
    }

    var
        InterV: Record "Hr Interview Evaluation Areas";
        Emp: Record "HR Employees";
}


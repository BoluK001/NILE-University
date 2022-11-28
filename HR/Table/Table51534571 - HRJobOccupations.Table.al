table 51534571 "HR Job Occupations"
{

    fields
    {
        field(2; "Employee No."; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmp.Get("Employee No.");

                CalcFields("First Name");
                CalcFields("Middle Name");
                CalcFields("Last Name");
                Email := HREmp."Personal E-Mail";
                "Date of Join" := HREmp."Date Of Joining the Company";
                HREmp."Job Title" := "Job Id";
                HREmp.Validate(HREmp."Job Title");
                HREmp.Modify;
            end;
        }
        field(3; "First Name"; Text[50])
        {
            CalcFormula = Lookup ("HR Employees"."First Name" WHERE ("No." = FIELD ("Employee No.")));
            FieldClass = FlowField;
        }
        field(4; "Middle Name"; Text[50])
        {
            CalcFormula = Lookup ("HR Employees"."Middle Name" WHERE ("No." = FIELD ("Employee No.")));
            FieldClass = FlowField;
        }
        field(5; "Last Name"; Text[50])
        {
            CalcFormula = Lookup ("HR Employees"."Last Name" WHERE ("No." = FIELD ("Employee No.")));
            FieldClass = FlowField;
        }
        field(6; Extension; Text[30])
        {
            FieldClass = Normal;
        }
        field(7; Email; Text[30])
        {
            FieldClass = Normal;
        }
        field(8; "Date of Join"; Date)
        {
            FieldClass = Normal;
        }
        field(9; Department; Code[20])
        {
            FieldClass = Normal;
        }
        field(55; "Job Desc"; Text[250])
        {
            CalcFormula = Lookup ("HR Jobs1"."Job Description" WHERE ("Job ID" = FIELD ("Job Id")));
            FieldClass = FlowField;
        }
        field(56; "Job Id"; Code[100])
        {
            TableRelation = "Vendor Invoice Disc."."Service Charge";
        }
    }

    keys
    {
        key(Key1; "Job Id", "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmp: Record "HR Employees";
        HRJobs: Record "HR Transport Requisition Pass";
}


table 51534645 "HR Job Working Relationship"
{

    fields
    {
        field(1; "Working Relationship Code"; Code[50])
        {
            TableRelation = "HR Jobs";

            trigger OnValidate()
            begin
                HrJobs.Get("Working Relationship Code");
                Description := HrJobs."Job Title";
            end;
        }
        field(2; "Job ID"; Code[50])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; Remarks; Text[150])
        {
        }
        field(5; "No. of Occupants"; Integer)
        {
            CalcFormula = Count ("HR Employees" WHERE ("Job Title" = FIELD ("Working Relationship Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Vacant Position"; Decimal)
        {
            CalcFormula = Lookup ("HR Jobs"."Vacant Positions" WHERE ("Job ID" = FIELD ("Working Relationship Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Job ID", "Working Relationship Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HRAppEvalArea: Record "HR Appraisal Evaluation Areas";
        HrJobs: Record "HR Jobs";
}


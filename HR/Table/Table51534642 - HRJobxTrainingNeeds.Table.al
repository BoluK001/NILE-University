table 51534642 "HR Jobx Training Needs"
{

    fields
    {
        field(1; "Job ID"; Code[30])
        {
        }
        field(2; "Line No"; Integer)
        {
        }
        field(3; "Code"; Code[30])
        {
            TableRelation = "HR Training Needs".Code;

            trigger OnValidate()
            begin
                if TrainingNeeds.Get(Code) then
                    Description := TrainingNeeds.Description;
            end;
        }
        field(4; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Job ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        TrainingNeeds: Record "HR Training Needs";
}


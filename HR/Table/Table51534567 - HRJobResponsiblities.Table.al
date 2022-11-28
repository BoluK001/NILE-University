table 51534567 "HR Job Responsiblities"
{

    fields
    {
        field(1; "Responsibility Code"; Integer)
        {
            InitValue = 1;
        }
        field(2; "Job ID"; Code[50])
        {
        }
        field(3; "Responsibility Description"; Text[250])
        {
        }
        field(4; Remarks; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Job ID", "Responsibility Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        HRJobResponsiblities.SetRange(HRJobResponsiblities."Job ID", "Job ID");
        if HRJobResponsiblities.FindLast then
            "Responsibility Code" := HRJobResponsiblities."Responsibility Code" + 1;
    end;

    var
        HRAppEvalArea: Record "HR Appraisal Evaluation Areas";
        HRJobResponsiblities: Record "HR Job Responsiblities";
}


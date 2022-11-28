table 51534609 "HR Appraisal Evaluation Areas"
{
    LookupPageID = "HR Appraisal Evaluation Areas";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[200])
        {
        }
        field(3; "Include in Evaluation Form"; Boolean)
        {
        }
        field(8; "Objective Type"; Option)
        {
            OptionMembers = Quantitative,Qualitative;
        }
        field(9; "Categorize As"; Option)
        {
            OptionMembers = "JOB SPECIFIC EVALUATION AREA","EMPLOYEE PERFORMANCE FACTOR";
        }
        field(10; "Assign To"; Code[20])
        {
            TableRelation = "HR Jobs";
        }
        field(11; "Sub Category"; Code[50])
        {
            TableRelation = "HR Lookup Values".Code WHERE (Type = CONST ("Appraisal Sub Category"));
        }
        field(12; Group; Code[45])
        {
            TableRelation = "HR Lookup Values".Code WHERE (Type = CONST ("Appraisal Group Item"));
        }
        field(13; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(14; Supervisor; Boolean)
        {
        }
        field(15; Stage; Option)
        {
            OptionMembers = "Stage 1","Stage 2","Stage 3";
        }
        field(16; "Self Evaluation"; Text[250])
        {
        }
        field(17; "Employee No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Line No", Description, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


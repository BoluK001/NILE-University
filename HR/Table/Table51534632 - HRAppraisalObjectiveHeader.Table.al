table 51534632 "HR Appraisal Objective Header"
{

    fields
    {
        field(1; Level; Option)
        {
            OptionMembers = " ","1-4","5-8";
        }
        field(2; Description; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; Level)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


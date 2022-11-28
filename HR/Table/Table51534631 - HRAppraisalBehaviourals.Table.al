table 51534631 "HR Appraisal Behaviourals"
{

    fields
    {
        field(1; "Behavioural Group"; Code[50])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Rating; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Behavioural Group")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


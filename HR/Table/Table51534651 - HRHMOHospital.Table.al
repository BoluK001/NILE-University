table 51534597 "HR HMO Hospital"
{
    LookupPageID = "HR HMO Hospitals";

    fields
    {
        field(1; "Hospital Code"; Code[20])
        {
        }
        field(2; Name; Text[100])
        {
        }
        field(3; Address; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Hospital Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


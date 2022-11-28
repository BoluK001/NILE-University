table 51534506 prPAYE
{

    fields
    {
        field(1; "Tier Code"; Code[20])
        {
        }
        field(2; "PAYE Tier"; Decimal)
        {
        }
        field(3; Rate; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Tier Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


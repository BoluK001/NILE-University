table 51534508 prCurrencies
{

    fields
    {
        field(1; "Currency Code"; Code[20])
        {
        }
        field(2; "Currency Name"; Text[50])
        {
        }
        field(3; Rate; Decimal)
        {
        }
        field(4; Default; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Currency Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


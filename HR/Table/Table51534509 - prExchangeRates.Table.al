table 51534509 "prExchange Rates"
{

    fields
    {
        field(1; "Currency Code"; Code[20])
        {
        }
        field(2; "Exchange Rate"; Decimal)
        {
        }
        field(3; "Period Month"; Integer)
        {
        }
        field(4; "Period Year"; Integer)
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


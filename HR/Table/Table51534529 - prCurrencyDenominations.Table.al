table 51534529 "prCurrency Denominations"
{

    fields
    {
        field(1; "Currency Code"; Code[20])
        {
        }
        field(2; "Denomination Value"; Decimal)
        {
        }
        field(3; "Denomination Name"; Text[30])
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


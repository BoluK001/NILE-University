table 51534728 "HR Deduction Account"
{

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account" WHERE("Direct Posting" = CONST(true));
        }
        field(3; NetPay; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


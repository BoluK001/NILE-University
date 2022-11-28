table 51534510 "prPayslip Messages"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
        }
        field(2; "Period Message"; Text[200])
        {
        }
        field(3; Recurring; Boolean)
        {
        }
        field(4; "Period Month"; Integer)
        {
        }
        field(5; "Period Year"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


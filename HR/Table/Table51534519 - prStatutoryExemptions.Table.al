table 51534519 "prStatutory Exemptions"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
        }
        field(2; NSSF; Boolean)
        {
            Description = 'Is staff exempted from NSSF?';
        }
        field(3; NHIF; Boolean)
        {
            Description = 'Is staff exempted from NHIF?';
        }
        field(4; PAYE; Boolean)
        {
            Description = 'Is staff exempted from PAYE?';
        }
        field(5; Recurring; Boolean)
        {
            Description = 'Is exemption carried to next period?';
        }
        field(6; "Period Month"; Integer)
        {
        }
        field(7; "Period Year"; Integer)
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


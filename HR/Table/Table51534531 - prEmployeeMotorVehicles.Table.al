table 51534531 "prEmployee Motor Vehicles"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
        }
        field(2; "Vehicle Category"; Code[20])
        {
        }
        field(3; "Vehicle Value"; Decimal)
        {
        }
        field(4; "Is Leased"; Boolean)
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


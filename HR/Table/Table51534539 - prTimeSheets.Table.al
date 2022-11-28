table 51534539 prTimeSheets
{

    fields
    {
        field(1; "Schedule Code"; Text[30])
        {
        }
        field(2; "Primary File Path"; Text[150])
        {
        }
        field(3; "Secondary File Path"; Text[150])
        {
        }
        field(4; "Delete After Import"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Schedule Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


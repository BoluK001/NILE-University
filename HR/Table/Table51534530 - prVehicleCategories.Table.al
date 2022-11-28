table 51534530 "prVehicle Categories"
{

    fields
    {
        field(1; "Category Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Vehicle Value"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Category Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


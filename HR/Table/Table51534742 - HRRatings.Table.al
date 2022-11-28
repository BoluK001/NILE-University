table 51534742 "HR Ratings"
{

    fields
    {
        field(2; Score; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(3; Rating; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; Rating)
        {
            Clustered = true;
        }
        key(Key2; Score)
        {
        }
    }

    fieldgroups
    {
    }
}


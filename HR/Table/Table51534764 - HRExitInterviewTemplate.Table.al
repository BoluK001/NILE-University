table 51534764 "HR Exit Interview Template"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Question; Text[100])
        {
        }
        field(3; Segment; Option)
        {
            OptionMembers = " ","Part 1","Part 2";
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


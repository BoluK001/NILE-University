table 51534763 "HR Emp. Exit Interview Line"
{

    fields
    {
        field(1; "Exit No."; Code[20])
        {
        }
        field(2; "Employee No."; Code[20])
        {
        }
        field(3; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(4; Question; Text[150])
        {
        }
        field(5; Answer; Text[250])
        {
        }
        field(6; "Yes/No"; Boolean)
        {
        }
        field(7; Excellent; Boolean)
        {
        }
        field(8; Good; Boolean)
        {
        }
        field(9; Fair; Boolean)
        {
        }
        field(10; Poor; Boolean)
        {
        }
        field(11; Comment; Text[250])
        {
        }
        field(12; Segment; Option)
        {
            OptionMembers = " ","Part 1","Part 2";
        }
    }

    keys
    {
        key(Key1; "Exit No.", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


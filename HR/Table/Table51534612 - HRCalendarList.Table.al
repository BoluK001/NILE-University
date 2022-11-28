table 51534612 "HR Calendar List"
{
    LookupPageID = "HR Calendar List";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Day; Text[40])
        {
            Editable = false;
        }
        field(3; Date; Date)
        {
            Editable = false;
        }
        field(4; "Non Working"; Boolean)
        {
            Editable = false;
        }
        field(5; Reason; Text[40])
        {
        }
    }

    keys
    {
        key(Key1; "Code", Date, Day)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


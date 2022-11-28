table 51534613 "HR Calendar"
{

    fields
    {
        field(2; Year; Code[20])
        {
        }
        field(3; Starts; Date)
        {
        }
        field(4; Ends; Date)
        {
        }
        field(5; Current; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; Year)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


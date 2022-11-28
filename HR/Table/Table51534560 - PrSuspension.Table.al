table 51534560 "Pr Suspension"
{

    fields
    {
        field(1; Employee; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Date Of Suspension"; Date)
        {
        }
        field(4; "End Of Suspension"; Date)
        {
        }
        field(5; "Reason Of Suspension"; Text[200])
        {
        }
        field(6; "Last Date Modified"; Date)
        {
        }
        field(7; "User ID"; Code[50])
        {
        }
        field(8; "Suspend Pay"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Employee, "Date Of Suspension")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


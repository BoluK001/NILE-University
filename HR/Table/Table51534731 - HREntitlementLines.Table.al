table 51534731 "HR Entitlement Lines"
{

    fields
    {
        field(1; "Application No."; Code[20])
        {
        }
        field(2; Question; Text[30])
        {
        }
        field(3; Answer; Text[30])
        {
        }
        field(4; "Yes/No"; Boolean)
        {
        }
        field(5; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(6; Option; Option)
        {
            OptionMembers = " ",Excellent,Good,Fair,Poor;
        }
        field(7; "Question Header"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Application No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


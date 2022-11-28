table 51534633 "HR App Career Dev Template"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; Grade; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST(Grade));
        }
        field(4; Criteria; Text[250])
        {
        }
        field(7; Description; Text[200])
        {
        }
        field(8; Type; Option)
        {
            OptionMembers = "Career Development","Self Evaluation";
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


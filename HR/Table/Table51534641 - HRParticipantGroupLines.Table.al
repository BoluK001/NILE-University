table 51534641 "HR Participant Group Lines"
{

    fields
    {
        field(1; "Doc No"; Integer)
        {
        }
        field(2; "Job Level"; Code[20])
        {
            TableRelation = "HR Employees"."Job Level" WHERE("Department Code" = FIELD("Global Dimension 2 Code"),
                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 1 Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Description = 'Location For pen';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
    }

    keys
    {
        key(Key1; "Doc No", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


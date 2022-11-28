table 51534624 "HR Appraisal Evaluation Descri"
{

    fields
    {
        field(1; "Evaluation Area"; Code[80])
        {
            TableRelation = "HR Appraisal Evaluation Areas".Code;
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(3; "Evaluation Description"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Evaluation Area", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


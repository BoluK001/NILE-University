table 51534640 "HR Participant Group"
{

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Editable = true;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; BU; Code[20])
        {
        }
        field(4; "Created By"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, BU)
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
    end;
}


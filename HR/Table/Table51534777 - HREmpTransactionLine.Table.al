table 51534777 "HR Emp Transaction Line"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; Transaction; Code[30])
        {
            TableRelation = "prTransaction Codes";

            trigger OnValidate()
            begin
                if Trans.Get(Transaction) then begin
                    "Transaction Name" := Trans."Transaction Name";
                end;
            end;
        }
        field(3; "Transaction Name"; Text[70])
        {
        }
        field(4; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Type; Option)
        {
            OptionCaption = ' ,Create,Update';
            OptionMembers = " ",Create,Update;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Trans: Record "prTransaction Codes";
}


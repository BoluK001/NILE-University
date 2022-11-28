table 51534565 "HR Policies"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Rules & Regulations"; Text[250])
        {
        }
        field(4; "Document Link"; Text[200])
        {
        }
        field(5; Remarks; Text[200])
        {
            NotBlank = false;
        }
        field(6; "Language Code (Default)"; Code[20])
        {
        }
        field(7; Attachement; Option)
        {
            OptionMembers = No,Yes;
        }
        field(8; Type; Option)
        {
            OptionCaption = 'Is Rules & Regulation,Is Policy,Is Hr Procedure';
            OptionMembers = "Is Rules & Regulation","Is Policy","Is Hr Procedure";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


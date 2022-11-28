table 51534562 "Reminder Buffer"
{

    fields
    {
        field(1; "Reminder Code"; Code[20])
        {
        }
        field(2; "Reminder Type"; Option)
        {
            OptionMembers = " ","Post Training Evaluation","3 Months Post Evaluation";
        }
        field(3; "Entry Date"; Date)
        {
        }
        field(4; "Reminder Start Date"; Date)
        {
        }
        field(5; "User to be Reminded"; Code[50])
        {
        }
        field(6; "Entered by"; Code[50])
        {
        }
        field(7; "Reminder Message"; Text[160])
        {
        }
        field(8; "Reminder Expiry Date"; Date)
        {
        }
        field(9; "Last Reminder Date"; DateTime)
        {
        }
        field(10; "Entry No"; Integer)
        {
        }
        field(11; "Fund Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Reminder Code", "Fund Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


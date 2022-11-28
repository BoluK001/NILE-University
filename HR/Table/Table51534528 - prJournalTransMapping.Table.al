table 51534528 "prJournal Trans Mapping"
{

    fields
    {
        field(1; "Transaction Code"; Code[20])
        {
            TableRelation = "prTransaction Codes"."Transaction Code";
        }
        field(3; "GL Navision"; Text[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(4; "Append StaffCode"; Boolean)
        {
        }
        field(5; "Is Formula"; Boolean)
        {
        }
        field(6; Formula; Text[100])
        {
        }
        field(7; Analysis0; Boolean)
        {
        }
        field(8; Analysis1; Boolean)
        {
        }
        field(9; Analysis2; Boolean)
        {
        }
        field(10; Analysis3; Boolean)
        {
        }
        field(11; Analysis4; Boolean)
        {
        }
        field(12; Analysis5; Boolean)
        {
        }
        field(13; "Amount (Dr/Cr)"; Option)
        {
            OptionMembers = Debit,Credit;
        }
        field(14; "GL Others"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Transaction Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


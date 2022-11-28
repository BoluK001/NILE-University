table 51534751 "HR Employee Exit Deductions"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; "Exit No."; Code[20])
        {
        }
        field(5; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Exit No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


table 51534646 PayrollYearEndingBuffer
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
        }
        field(2; "Transaction Code"; Code[15])
        {
        }
        field(3; "Transaction Name"; Text[35])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(7; "Period Month"; Integer)
        {
        }
        field(8; "Period Year"; Integer)
        {
        }
        field(42; "Transaction Type"; Option)
        {
            CalcFormula = Lookup("prTransaction Codes"."Transaction Type" WHERE("Transaction Code" = FIELD("Transaction Code")));
            FieldClass = FlowField;
            OptionMembers = Income,Deduction;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}


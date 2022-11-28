table 51534543 prEmpPayrollBuffer
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
        }
        field(2; "Transaction Code"; Code[20])
        {
        }
        field(3; "Transaction Name"; Text[30])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Balance; Decimal)
        {
        }
        field(7; "Period Month"; Integer)
        {
        }
        field(8; "Period Year"; Integer)
        {
        }
        field(9; "Payroll Period"; Date)
        {
        }
        field(10; "#of Repayments"; Integer)
        {
        }
        field(12; "Reference No"; Text[50])
        {
        }
        field(13; "Previous TransName"; Text[100])
        {
        }
        field(14; "Previous TransCode"; Code[20])
        {
        }
        field(15; "Previous Amount"; Decimal)
        {
        }
        field(16; "Previous Payroll Period"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Reference No", "Payroll Period")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}


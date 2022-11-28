table 51534524 "prEmployer Deductions"
{
    DrillDownPageID = "prEmployer Deductions";
    LookupPageID = "prEmployer Deductions";

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
        }
        field(2; "Transaction Code"; Code[20])
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; "Period Month"; Integer)
        {
        }
        field(5; "Period Year"; Integer)
        {
        }
        field(6; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(7; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(8; "Payroll Classification"; Code[20])
        {
            CalcFormula = Lookup("HR-Employee"."Payroll Filter Group" WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}


table 51534511 "prPayroll Periods"
{
    LookupPageID = "prPayroll Periods";

    fields
    {
        field(1; "Period Month"; Integer)
        {
        }
        field(2; "Period Year"; Integer)
        {
        }
        field(3; "Period Name"; Text[30])
        {
            Description = 'e.g November 2009';
        }
        field(4; "Date Opened"; Date)
        {
            NotBlank = true;
        }
        field(5; "Date Closed"; Date)
        {
        }
        field(6; Closed; Boolean)
        {
            Description = 'A period is either closed or open';
        }
        field(7; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(8; "Tax Paid"; Decimal)
        {
            CalcFormula = Sum ("prPeriod Transactions".Amount WHERE ("Payroll Period" = FIELD ("Date Opened"),
                                                                    "Group Order" = CONST (7),
                                                                    "Sub Group Order" = CONST (3)));
            FieldClass = FlowField;
        }
        field(9; Quarter; Boolean)
        {
        }
        field(10; "Total Working Days"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Date Opened")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


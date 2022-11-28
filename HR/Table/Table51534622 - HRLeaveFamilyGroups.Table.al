table 51534622 "HR Leave Family Groups"
{
    DrillDownPageID = "Pr Payroll Transactions Codes";
    LookupPageID = "Pr Payroll Transactions Codes";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Remarks; Text[200])
        {
        }
        field(4; "Max Employees On Leave"; Integer)
        {
            Description = 'Maximum nmber of employees allowed to be on leave at once';
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


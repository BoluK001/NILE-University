page 51534811 "prEmployer Deductions"
{
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "prEmployer Deductions";

    layout
    {
        area(content)
        {
            repeater(New)
            {
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Period Month"; "Period Month")
                {
                    ApplicationArea = All;
                }
                field("Period Year"; "Period Year")
                {
                    ApplicationArea = All;
                }
                field("Payroll Period"; "Payroll Period")
                {
                    ApplicationArea = All;
                }
                field("Payroll Code"; "Payroll Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}


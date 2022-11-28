page 51534633 "Processed Employee Loans"
{
    CardPageID = "Processed Employee Loan";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = prAssignEmployeeLoan;
    SourceTableView = WHERE(Status = CONST(Posted));
    AdditionalSearchTerms = 'Processed Employee Loans';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = all;
                }
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = all;
                }
                field("Transaction Name"; "Transaction Name")
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = all;
                }
                field("Period Month"; "Period Month")
                {
                    ApplicationArea = all;
                }
                field("Period Year"; "Period Year")
                {
                    ApplicationArea = all;
                }
                field("Payroll Period"; "Payroll Period")
                {
                    ApplicationArea = all;
                }
                field("#of Repayments"; "#of Repayments")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}


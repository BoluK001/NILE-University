page 51534631 "HR Employees External Loans"
{
    CardPageID = "HR Employee External Loan";
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Employees External Loans';
    UsageCategory = Lists;
    SourceTable = "HR Employee Loan Ext";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field(Current; Current)
                {
                    ApplicationArea = all;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = all;
                }
                field("Monthly Repayment"; "Monthly Repayment")
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = all;
                }
                field("End Date"; "End Date")
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


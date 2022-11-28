page 51534616 "prEmployee Posting Group"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "prEmployee Posting Group";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Employee Posting Group';

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Code"; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Salary Account"; "Salary Account")
                {
                    ApplicationArea = all;
                    visible = false;  //jj12102022
                }
                field("Income Tax Account"; "Income Tax Account")
                {
                    ApplicationArea = all;
                    visible = false;  //jj12102022
                }
                field("SSF Employer Account"; "SSF Employer Account")
                {
                    ApplicationArea = all;
                    visible = false;  //jj12102022
                }
                field("SSF Employee Account"; "SSF Employee Account")
                {
                    ApplicationArea = all;
                    visible = false;  //jj12102022
                }
                field("Net Salary Payable"; "Net Salary Payable")
                {
                    ApplicationArea = all;
                    visible = false;  //jj12102022
                }
                field("Operating Overtime"; "Operating Overtime")
                {
                    ApplicationArea = all;
                    visible = false;  //jj12102022
                }
                field("Employee Provident Fund Acc."; "Employee Provident Fund Acc.")
                {
                    ApplicationArea = all;
                    visible = false;  //jj12102022
                }
                field("Pension Employer Acc"; "Pension Employer Acc")
                {
                    ApplicationArea = all;
                    visible = false;  //jj12102022
                }
                field("Pension Employee Acc"; "Pension Employee Acc")
                {
                    ApplicationArea = all;
                    visible = false;  //jj12102022
                }
                field("Payroll Code"; "Payroll Code")
                {
                    ApplicationArea = all;
                    visible = false;  //jj12102022
                }
                field("NHIF Employee Account"; "NHIF Employee Account")
                {
                    ApplicationArea = all;
                    visible = false;  //jj12102022
                }
                field("Suspense Account"; "Suspense Account")
                {
                    ApplicationArea = all;
                    visible = false;  //jj12102022
                }
            }
        }
    }

    actions
    {
    }
}


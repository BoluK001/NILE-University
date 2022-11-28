page 51534621 "prPayroll Type"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "prPayroll Type";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Payroll Type';

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Payroll Code"; "Payroll Code")
                {
                    ApplicationArea = all;
                }
                field("Payroll Name"; "Payroll Name")
                {
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                }
                field("Period Length"; "Period Length")
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


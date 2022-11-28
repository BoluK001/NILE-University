page 51534699 "HR Leave Period List"
{
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Leave Period List';
    UsageCategory = Lists;
    SourceTable = "HR Leave Periods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Code"; "Period Code")   //jj180322
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; "Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Period Description"; "Period Description")
                {
                    ApplicationArea = all;
                }
                field("New Fiscal Year"; "New Fiscal Year")
                {
                    ApplicationArea = all;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = all;
                }
                field("Date Locked"; "Date Locked")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
            }
            systempart(Control1102755009; Notes)
            {
            }
        }
    }

    actions
    {
    }
}


page 51534537 "HR Non Working Days & Dates"
{
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Non Working Days & Dates';
    SourceTable = "HR Non Working Days & Dates";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Non Working Days"; "Non Working Days")
                {
                    ApplicationArea = all;
                }
                field("Non Working Dates"; "Non Working Dates")
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


page 51534522 "HR Commitee Members"
{
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Commitee Members';
    SourceTable = "HR Commitee Members";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Member No."; "Member No.")
                {
                    ApplicationArea = all;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = all;
                }
                field(Role; Role)
                {
                    ApplicationArea = all;
                }
                field("Date Appointed"; "Date Appointed")
                {
                    ApplicationArea = all;
                }
                field(Active; Active)
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


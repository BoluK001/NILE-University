page 51534536 "HR Calendar List"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Calendar List";
    AdditionalSearchTerms = 'HR Calendar List';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = true;
                ShowCaption = false;
                field(Date; Date)
                {
                    ApplicationArea = all;
                }
                field(Day; Day)
                {
                    ApplicationArea = all;
                }
                field("Non Working"; "Non Working")
                {
                    ApplicationArea = all;
                }
                field(Reason; Reason)
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


page 51534618 "prInstitutional Membership"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "prInstitutional Membership";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Institutional Membership';

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Group No"; "Group No")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Institution No"; "Institution No")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("pfa code"; "pfa code")
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


page 51534608 "prBank Structure"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "prBank Structure";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Bank Structure';

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = all;
                }
                field("Branch Code"; "Branch Code")
                {
                    ApplicationArea = all;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = all;
                }
                field("Branch Name"; "Branch Name")
                {
                    ApplicationArea = all;
                }
                field("Bank Sort Code"; "Bank Sort Code")
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


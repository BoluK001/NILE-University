page 51534498 "HR Committees"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Committees";
    AdditionalSearchTerms = 'HR Committees';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Commitee; Commitee)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Roles; Roles)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Committee)
            {
                Caption = 'Committee';
                action(Members)
                {
                    Caption = 'Members';
                    RunObject = Page "HR Commitee Members";
                    //RunPageLink = Committee = FIELD (Commitee);
                }
            }
        }
    }
}


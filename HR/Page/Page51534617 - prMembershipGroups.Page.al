page 51534617 "prMembership Groups"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "prMembership Groups";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Membership Groups';

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Group No"; "Group No")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Comments; Comments)
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
            group("Member Details")
            {
                Caption = 'Member Details';
                action("Institutional Listing")
                {
                    Caption = 'Institutional Listing';
                    Image = IndustryGroups;
                    RunObject = Page "prInstitutional Membership";
                    RunPageLink = "Group No" = FIELD("Group No");
                    ApplicationArea = all;   //jj030322  
                    Promoted = true;  //jj110522 I added
                    PromotedCategory = Process;  //jj110522
                }
            }
        }
    }
}


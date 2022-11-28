page 51534531 "HR Training Needs"
{
    CardPageID = "HR Training Needs Card";
    ApplicationArea = all;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Training Needs";
    AdditionalSearchTerms = 'HR Training Needs';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                ShowCaption = false;
                field("Code"; Code)
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Description; Description)
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field(Location; Location)
                {
                    ApplicationArea = all;
                }
                field(Provider; Provider)
                {
                    ApplicationArea = all;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755003; Outlook)
            {
            }
            systempart(Control1102755005; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Training Needs")
            {
                Caption = 'Training Needs';
                action("&Card")
                {
                    Caption = '&Card';
                    Image = Card;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Training Needs";
                    RunPageLink = Code = FIELD(Code);
                }
            }
        }
        area(reporting)
        {
            action(Action1102755006)
            {
                Caption = 'Training Needs';
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                RunObject = Report "HR Training Needs";//Report39005595;
            }
        }
    }
}


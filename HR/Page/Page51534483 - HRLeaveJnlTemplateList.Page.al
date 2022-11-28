page 51534483 "HR Leave Jnl. Template List"
{
    Caption = 'Leave Jnl. Template List';
    Editable = true;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Leave Jnl. Template List';
    PromotedActionCategories = 'New,Process,Report,Template';
    SourceTable = "HR Leave Journal Template";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Name; Name)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Source Code"; "Source Code")
                {
                    ApplicationArea = all;
                }
                field("Reason Code"; "Reason Code")
                {
                    Visible = true;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Template)
            {
                Caption = 'Template';
                action("&Batches")
                {
                    Caption = '&Batches';
                    Image = ChangeBatch;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Leave Batches";
                    RunPageLink = "Journal Template Name" = FIELD(Name);
                    ApplicationArea = all;   //jj170322
                }
                action("Leave Journal ")
                {
                    Caption = 'Leave Journal ';
                    Image = ChangeBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HR Leave Journal Lines";
                    ApplicationArea = all;   //jj170322
                }
            }
        }
    }

    var
        HRLeaveJournalTemplate: Record "HR Leave Journal Template";
}


page 51534469 "HR Qualifications"
{
    Caption = 'HR Qualifications ';
    DelayedInsert = true;
    ApplicationArea = all;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Qualifications';
    SourceTable = "HR Qualifications";
    AdditionalSearchTerms = 'HR Qualifications';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Qualification Type"; "Qualification Type")
                {
                    ApplicationArea = all;
                }
                field("Code"; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
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
            group(Qualification)
            {
                Caption = 'Qualification';
                action("Q&ualification Overview")
                {
                    Caption = 'Q&ualification Overview';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Qualification Overview";
                    ApplicationArea = All;
                }
            }
        }
    }
}


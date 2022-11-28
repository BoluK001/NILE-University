page 51534458 "HR Job Occupants"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report';
    SourceTable = "HR Jobs";

    layout
    {
        area(content)
        {
            group("Job Details")
            {
                Caption = 'Job Details';
                Editable = false;
                field("Job ID"; "Job ID")
                {
                    Enabled = false;
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Job Title"; "Job Title")
                {
                    Enabled = false;
                    ApplicationArea = all;
                    Importance = Promoted;
                }
            }
            part("Job Occupants"; "HR Employee List")
            {
                Caption = 'Job Occupants';
                Editable = false;
                SubPageLink = "Job Title" = FIELD("Job ID");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part(Control1102755005; "HR Job Applications Factbox")
            {
                SubPageLink = "Application No" = FIELD("Job ID");
                ApplicationArea = All;
            }
            systempart(Control1102755003; Outlook)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print HR Job Occupants")
            {
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Job Occupants";   //jj100322  not the right report found here, changed to this report
                  
            }
        }
    }

    trigger OnOpenPage()
    begin
        if IsEmpty then
            Error('No jobs have been setup');
    end;

    var
        Text19006026: Label 'Job Occupants';
}


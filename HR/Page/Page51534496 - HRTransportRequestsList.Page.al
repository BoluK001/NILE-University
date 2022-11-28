page 51534496 "HR Transport Requests List"
{
    CardPageID = "HR Staff Transport Requisition";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Transport Requisition";
    AdditionalSearchTerms = 'HR Transport Requests List';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Application Code"; "Application Code")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = all;
                }
                field(Names; Names)
                {
                    ApplicationArea = all;
                }
                field("Job Tittle"; "Job Tittle")
                {
                    ApplicationArea = all;
                }
                field("Days Applied"; "Days Applied")
                {
                    ApplicationArea = all;
                }
                field(Supervisor; Supervisor)
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755004; Outlook)
            {
            }
            systempart(Control1102755006; Notes)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Transport Requests")
            {
                Caption = 'Transport Requests';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Transport Requests";
                ApplicationArea = all;
            }
        }
    }
}


page 51534538 "HR Exit Interview List"
{
    CardPageID = "HR Employee Exit Interviews";
    ModifyAllowed = false;
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Exit Interview List';
    SourceTable = "HR Employee Exit Interviews";
    SourceTableView = WHERE(Status = FILTER(<> "Pending Approval"));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Exit Interview No"; "Exit Interview No")
                {
                    Style = StrongAccent;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field("Date Of Interview"; "Date Of Interview")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Interview Done By"; "Interviewer Name")
                {
                    ApplicationArea = all;
                }
                field("Reason For Leaving"; "Reason For Leaving")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Date Of Leaving"; "Date Of Leaving")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Re Employ In Future"; "Re Employ In Future")
                {
                    Importance = Promoted;
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
            action("Exit Interviews")
            {
                Caption = 'Exit Interviews';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report Report39005594;
            }
        }
    }
}


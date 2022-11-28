page 51534643 "HR Exit Interview List Self"
{
    CardPageID = "HR Employee Exit Interviews se";
    ModifyAllowed = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Exit Interview List Self';
    SourceTable = "HR Employee Exit Interviews";
    SourceTableView = WHERE(Status = FILTER(<> "Pending Approval"));

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
                }
                field("Date Of Leaving"; "Date Of Leaving")
                {
                    Importance = Promoted;
                }
                field("Re Employ In Future"; "Re Employ In Future")
                {
                    Importance = Promoted;
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

    trigger OnOpenPage()
    begin
        FilterGroup(2);
        SetRange("User Id", UserId);
        FilterGroup(0);
    end;
}


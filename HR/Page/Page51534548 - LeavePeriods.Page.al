page 51534548 "Leave Periods"
{
    RefreshOnActivate = true;
    SourceTable = "HR Leave Periods";

    layout
    {
        area(content)
        {
            repeater(Control1102755005)
            {
                ShowCaption = false;
                field("Starting Date"; "Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Period Description"; "Period Description")
                {
                    ApplicationArea = all;
                }
                field("New Fiscal Year"; "New Fiscal Year")
                {
                    ApplicationArea = all;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = all;
                }
                field("Date Locked"; "Date Locked")
                {
                    ApplicationArea = all;
                }
                field("Reimbursement Clossing Date"; "Reimbursement Clossing Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Create Year")
            {
                Caption = '&Create Year';
                Ellipsis = true;
                Image = CreateYear;
                Promoted = true;
                PromotedCategory = Process;
                //RunObject = Report Report39005925;
            }
            action("C&lose Year")
            {
                Caption = 'C&lose Year';
                Image = CloseYear;
                Promoted = true;
                PromotedCategory = Process;
                //RunObject = Codeunit  "Leave Year-Close";
            }
        }
    }
}


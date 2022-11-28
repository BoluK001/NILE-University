page 51534554 "HR Setup List"
{
    CardPageID = "HR Setup";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ApplicationArea = all;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Administration';
    RefreshOnActivate = false;
    SourceTable = "HR Setup";
    AdditionalSearchTerms = 'HR Setup List';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Leave Posting Period[FROM]"; "Leave Posting Period[FROM]")
                {
                    ApplicationArea = All;
                }
                field("Leave Posting Period[TO]"; "Leave Posting Period[TO]")
                {
                    ApplicationArea = All;
                }
                field("Default Leave Posting Template"; "Default Leave Posting Template")
                {
                    ApplicationArea = All;
                }
                field("Default Leave Posting Batch"; "Default Leave Posting Batch")
                {
                    ApplicationArea = All;
                }
                field("Employee Nos."; "Employee Nos.")
                {
                    ApplicationArea = All;
                }
                field("Training Application Nos."; "Training Application Nos.")
                {
                    ApplicationArea = All;
                }
                field("Leave Application Nos."; "Leave Application Nos.")
                {
                    ApplicationArea = All;
                }
                field("Disciplinary Cases Nos."; "Disciplinary Cases Nos.")
                {
                    ApplicationArea = All;
                    visible = false;  //jj300922
                }
                field("Transport Req Nos"; "Transport Req Nos")
                {
                    ApplicationArea = All;
                    visible = false;  //jj300922
                }
                field("Employee Requisition Nos."; "Employee Requisition Nos.")
                {
                    ApplicationArea = All;
                    visible = false;  //jj300922
                }
                field("Job Application Nos"; "Job Application Nos")
                {
                    ApplicationArea = All;
                }
                field("Exit Interview Nos"; "Exit Interview Nos")
                {
                    ApplicationArea = All;
                    visible = false;  //jj300922
                }
                field("Appraisal Nos"; "Appraisal Nos")
                {
                    ApplicationArea = All;
                    visible = false;  //jj300922
                }
                field("Company Activities"; "Company Activities")
                {
                    ApplicationArea = All;
                    visible = false;  //jj300922
                }
                field("Job Interview Nos"; "Job Interview Nos")
                {
                    ApplicationArea = All;
                    visible = false;  //jj300922
                }
                field("Ticket Nos"; "Ticket Nos")
                {
                    ApplicationArea = All;
                    visible = false;  //jj300922
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("HR Policies")
            {
                Caption = 'HR Policies';
                Image = Planning;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HR Policies";
                Visible = false;
                ApplicationArea = All;

            }
            action("E-Mail Parameters")
            {
                Caption = 'E-Mail Parameters';
                Image = Email;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HR Email Parameter List";
                ApplicationArea = All;
            }
            action(Calendar)
            {
                Caption = 'Calendar';
                Image = Calendar;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Base Calendar List";
                ApplicationArea = All;
            }
            action("Leave Periods")
            {
                Caption = 'Leave Periods';
                Image = AccountingPeriods;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HR Leave Period List";
                ApplicationArea = All;
            }
            action("Close Appraisal Half")
            {
                Caption = 'Close Appraisal Half';
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    trigger OnOpenPage()
    begin

        Reset;
        if not Get then begin
            Init;
            Insert;
        end;
    end;
}


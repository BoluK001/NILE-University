page 51534546 "HR Setup Card"
{
    PageType = Card;
    SourceTable = "HR Setup";

    layout
    {
        area(content)
        {
            group("Leave Period")
            {
                Caption = 'Leave Period';
                field("Leave Posting Period[FROM]"; "Leave Posting Period[FROM]")
                {
                    ApplicationArea = all;
                }
                field("Leave Posting Period[TO]"; "Leave Posting Period[TO]")
                {
                    ApplicationArea = all;
                }
                field("Leave Template"; "Leave Template")
                {
                    ApplicationArea = all;
                }
                field("Leave Batch"; "Leave Batch")
                {
                    ApplicationArea = all;
                }
            }
            group("HR Number Series")
            {
                Caption = 'HR Number Series';
                field("Employee Nos."; "Employee Nos.")
                {
                    ApplicationArea = all;
                }
                field("Training Application Nos."; "Training Application Nos.")
                {
                    ApplicationArea = all;
                }
                field("Leave Application Nos."; "Leave Application Nos.")
                {
                    ApplicationArea = all;
                }
                field("Disciplinary Cases Nos."; "Disciplinary Cases Nos.")
                {
                    ApplicationArea = all;
                }
                field("Transport Req Nos"; "Transport Req Nos")
                {
                    ApplicationArea = all;
                }
                field("Employee Requisition Nos."; "Employee Requisition Nos.")
                {
                    ApplicationArea = all;
                }
                field("Job Application Nos"; "Job Application Nos")
                {
                    ApplicationArea = all;
                }
                field("Exit Interview Nos"; "Exit Interview Nos")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Nos"; "Appraisal Nos")
                {
                    ApplicationArea = all;
                }
                field("Company Activities"; "Company Activities")
                {
                    ApplicationArea = all;
                }
                field("Default Leave Posting Template"; "Default Leave Posting Template")
                {
                    ApplicationArea = all;
                }
                field(s; "Default Leave Posting Batch")
                {
                    ApplicationArea = all;
                }
                field("Ticket Nos"; "Ticket Nos")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}


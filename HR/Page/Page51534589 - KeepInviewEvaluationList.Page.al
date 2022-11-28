page 51534589 "Keep In-view Evaluation List"
{
    CardPageID = "Keep In-View Evaluation Card";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Hr Interview Evaluation";
    SourceTableView = WHERE("Offer Status" = FILTER("Keep In-view"));
    AdditionalSearchTerms = 'Keep In-view Evaluation List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Interview No."; "Interview No.")
                {
                    ApplicationArea = all;
                }
                field("Application No."; "Application No.")
                {
                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = all;
                }
                field("Date Applied"; "Date Applied")
                {
                    ApplicationArea = all;
                }
                field(Email; Email)
                {
                    ApplicationArea = all;
                }
                field("Interview Date"; "Interview Date")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Stage 1 Score"; "Stage 1 Score")
                {
                    ApplicationArea = all;
                }
                field("Stage 2 Score"; "Stage 2 Score")
                {
                    ApplicationArea = all;
                }
                field("Stage 3 Score"; "Stage 3 Score")
                {
                    ApplicationArea = all;
                }
                field("Recommend for Stage 2"; "Recommend for Stage 2")
                {
                    ApplicationArea = all;
                }
                field("Recommend for Stage 3"; "Recommend for Stage 3")
                {
                    ApplicationArea = all;
                }
                field("Recommendation for Hire"; "Recommendation for Hire")
                {
                    ApplicationArea = all;
                }
                field("Job Acceptance"; "Job Acceptance")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        HRJobApplications: Record "HR Job Applications";
        HrIntMessage: Record "Receipts and Payment Types";
        SMTP: Codeunit "SMTP Mail";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        CompInfo: Record "Company Information";
}


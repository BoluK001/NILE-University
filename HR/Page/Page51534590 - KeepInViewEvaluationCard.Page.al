page 51534590 "Keep In-View Evaluation Card"
{
    PageType = Card;
    SourceTable = "Hr Interview Evaluation";

    layout
    {
        area(content)
        {
            group(General)
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
                field(Initial; Initial)
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
                field("Interview Done By"; "Interview Done By")
                {
                    Visible = false;
                }
                field("Interviewer Name"; "Interviewer Name")
                {
                    Visible = false;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = all;
                }
                field("Job Position"; "Job Position")
                {
                    ApplicationArea = all;
                }
                field("Current Salary (N) P/A"; "Current Salary (N) P/A")
                {
                    ApplicationArea = all;
                }
                field("Expected Salary (N) P/A"; "Expected Salary (N) P/A")
                {
                    ApplicationArea = all;
                }
                field("Notice Period"; "Notice Period")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Stage 1 Pass Mark"; "Stage 1 Pass Mark")
                {
                    AutoFormatExpression = 'Stage 1 Pass Mark';
                    AutoFormatType = 100;
                }
                field("Stage 1 Score"; "Stage 1 Score")
                {
                    ApplicationArea = all;
                }
                field("Stage 2 Pass Mark"; "Stage 2 Pass Mark")
                {
                    ApplicationArea = all;
                }
                field("Stage 2 Score"; "Stage 2 Score")
                {
                    ApplicationArea = all;
                }
                field("Stage 3 Pass Mark"; "Stage 3 Pass Mark")
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
                    Caption = 'Recommend for Hire';
                }
                field("HMO Stage"; "HMO Stage")
                {
                    Caption = 'Recommend for Medical Test Stage';
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    MultiLine = true;
                }
                field("Offer Status"; "Offer Status")
                {
                    ApplicationArea = all;
                }
                field("Job Acceptance"; "Job Acceptance")
                {
                    ApplicationArea = all;
                }
            }
            part("INTERVIEW SPECIFIC EVALUATION AREA -STAGE 1"; "Hr Interview Evaluation Stage1")
            {
                Caption = 'INTERVIEW SPECIFIC EVALUATION AREA -STAGE 1';
                SubPageLink = "Interview No." = FIELD("Interview No."),
                              Stage = CONST(Stage2);
            }
            part("INTERVIEW SPECIFIC EVALUATION AREA -STAGE 2"; "HR Interview Evaluation Stage2")
            {
                Caption = 'INTERVIEW SPECIFIC EVALUATION AREA -STAGE 2';
                SubPageLink = "Interview No." = FIELD("Interview No."),
                              Stage = CONST(Stage3);
            }
            part("INTERVIEW SPECIFIC EVALUATION AREA -STAGE 3"; "HR Interview Evaluation Stage3")
            {
                Caption = 'INTERVIEW SPECIFIC EVALUATION AREA -STAGE 3';
                SubPageLink = "Interview No." = FIELD("Interview No."),
                              Stage = CONST("Stage3");
            }
            part(INTERVIEWER; "HR Interviewer Details")
            {
                Caption = 'INTERVIEWER';
                SubPageLink = "Interview No." = FIELD("Interview No.");
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
        HREmpApplication: Record "HR Employee Requisitions";
        LinesRec: Record "Hr Interview Specific Evaluatn";
        //Areas: Record "Cash Office User Template";
        IntEv: Record "Hr Interview Evaluation";
}


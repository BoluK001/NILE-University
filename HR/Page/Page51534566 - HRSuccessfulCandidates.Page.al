page 51534566 "HR Successful Candidates"
{
    CardPageID = "HR Interview Evaluation Card1";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Hr Interview Evaluation";
    SourceTableView = WHERE(Status = CONST(Approved));
    AdditionalSearchTerms = 'HR Successful Candidates';

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
                field("Offer Status"; "Offer Status")
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
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicant)
            {
                Caption = 'Applicant';
                action("Generate Offer Letter")
                {
                    Caption = 'Generate Offer Letter';
                    Image = Document;
                    ApplicationArea = all;
                    Promoted = true;
                    RunObject = Report "HR Employement Letter";
                    Visible = true;
                }
                action(Qualifications)
                {
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Qualifications";
                    RunPageLink = "Application No" = FIELD("Application No.");
                }
                action(Referees)
                {
                    Caption = 'Referees';
                    Image = ContactReference;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Referees";
                    RunPageLink = "Job Application No" = FIELD("Application No.");
                }
                action(Hobbies)
                {
                    Caption = 'Hobbies';
                    Image = Holiday;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Hobbies";
                    RunPageLink = "Job Application No" = FIELD("Application No.");
                }
                action("Employment History")
                {
                    Caption = 'Employment History';
                    Image = History;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Employment History Lines";
                    RunPageLink = "Employee No." = FIELD("Application No."),
                                  Status = CONST(Applicant);
                }
            }
        }
    }

    var
        HRJobApplications: Record "HR Job Applications";
        HREmpApplication: Record "HR Employee Requisitions";
        CompInfo: Record "Company Information";
        HrIntMessage: Record "Receipts and Payment Types";
        SMTP: Codeunit "SMTP Mail";
}


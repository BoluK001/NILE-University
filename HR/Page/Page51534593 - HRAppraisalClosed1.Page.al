page 51534593 "HR Appraisal Closed1"
{
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Appraisal Goal Setting H";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; "Appraisal No")
                {
                    ApplicationArea = all;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field(Supervisor; Supervisor)
                {
                    ApplicationArea = all;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Period"; "Appraisal Period")
                {
                    ApplicationArea = all;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Evaluation Period Start"; "Evaluation Period Start")
                {
                    ApplicationArea = all;
                }
                field("Evaluation Period End"; "Evaluation Period End")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Date"; "Appraisal Date")
                {
                    ApplicationArea = all;
                }
                field("Contract Type"; "Contract Type")
                {
                    ApplicationArea = all;
                }
                field(Unit; Unit)
                {
                    ApplicationArea = all;
                }
                field("Company Score"; "Company Score")
                {
                    ApplicationArea = all;
                }
                field("Bonus Point appraisee"; "Bonus Point appraisee")
                {
                    ApplicationArea = all;
                }
                field("KPIs Appraisee Score"; "KPIs Appraisee Score")
                {
                    ApplicationArea = all;
                }
                field("KPIs Appraiser Score"; "KPIs Appraiser Score")
                {
                    ApplicationArea = all;
                }
                field("KPIs Mgt Score"; "KPIs Mgt Score")
                {
                    ApplicationArea = all;
                }
                field("Performance Score Appraisee"; "Performance Score Appraisee")
                {
                    ApplicationArea = all;
                }
                field("Performance Score Appraiser"; "Performance Score Appraiser")
                {
                    ApplicationArea = all;
                }
                field("Performance Score Mgt"; "Performance Score Mgt")
                {
                    ApplicationArea = all;
                }
                field("Comments Appraisee"; "Comments Appraisee")
                {
                    ApplicationArea = all;
                }
                field("Comments Appraiser"; "Comments Appraiser")
                {
                    ApplicationArea = all;
                }
                field("Comments Mgt"; "Comments Mgt")
                {
                    ApplicationArea = all;
                }
                field("Development Plans"; "Development Plans")
                {
                    ApplicationArea = all;
                }
                field("Development Requirements Appra"; "Development Requirements Appra")
                {
                    ApplicationArea = all;
                }
                field("Development Requirements Mgt"; "Development Requirements Mgt")
                {
                    ApplicationArea = all;
                }
            }
            part("PERSONAL GOALS/OBJECTIVES"; "HR Appraisal Goal Setting L")
            {
                Caption = 'PERSONAL GOALS/OBJECTIVES';
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
            }
            part(SF; "HR Mgt Evaluation Lines")
            {
                Caption = 'JOB SPECIFIC EVALUATION (KEY RESULTS IN LINE WITH STAFF JOB DESCRIPTION AND/ OR SCORECARD)';
                SubPageLink = "Employee No" = FIELD("Employee No"),
                              "Appraisal Period" = FIELD("Appraisal Period");
            }
            part("Next Period's KPI"; "HR Appraisal Next KPI")
            {
                Caption = 'Next Period''s KPI';
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
            }
            group("Evaluation Scores/Remarks")
            {
                Caption = 'Evaluation Scores/Remarks';
                Editable = false;
                field("Bonus Point Appraiser"; "Bonus Point Appraiser")
                {
                    ApplicationArea = all;
                }
                field("Bonus Point Mgt"; "Bonus Point Mgt")
                {
                    ApplicationArea = all;
                }
                field("Bonus Point Appraiser Remarks"; "Bonus Point Appraiser Remarks")
                {
                    ApplicationArea = all;
                }
                field("Bonus Point Mgt Remarks"; "Bonus Point Mgt Remarks")
                {
                    ApplicationArea = all;
                }
                field("Recommendation Appraiser"; "Recommendation Appraiser")
                {
                    ApplicationArea = all;
                }
                field("Recommendation 2"; "Recommendation 2")
                {
                    ApplicationArea = all;
                }
                field("Recommendation Mgt"; "Recommendation Mgt")
                {
                    ApplicationArea = all;
                }
                field("Recommendation 3"; "Recommendation 3")
                {
                    ApplicationArea = all;
                }
                field("Overall Appraisee Score"; "Overall Appraisee Score")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Overall Appraiser Score"; "Overall Appraiser Score")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Overal Rating Desc"; "Overal Rating Desc")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Overall Mgt Score"; "Overall Mgt Score")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
            group("MD's Recommendation & Comment")
            {
                field("MD's Recommendation"; "MD's Recommendation")
                {
                    MultiLine = false;
                    ApplicationArea = all;
                }
                field(Confirmation; Confirmation)
                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field("Salary Grade"; "Salary Grade")
                {
                    Caption = 'Current Salary Grade';
                    ApplicationArea = all;
                }
                field(Step; Step)
                {
                    Caption = 'Current Step';
                }
                field("MD's Comment"; "MD's Comment")
                {
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field("MD's Remark"; "MD's Remark")
                {
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field("MD's Signature"; "MD's Signature")
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
        HRAppraisalEvaluationAreas: Record "HR Appraisal Evaluation Areas";
        HRAppraisalEvaluations: Record "HR Appraisal Evaluations";
        HRAppraisalEvaluationsF: Page "HR Appraisal Evaluation Lines";
        HREmp: Record "HR Employees";
        HasLines: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender;
        KPIGoalSetting: Record "HR Appraisal Goal Setting L";
        NextKPI: Record "HR Appraisal Goal Setting L";
        CompanyScoreAppraisee: Decimal;
        KPIScoreAppraisee: Decimal;
        PFScoreAppraisee: Decimal;
        PFBase: Decimal;
        HrRatings: Record "HR Appraisal Career Dev";
        UserSetup: Record "User Setup";
        SMTP: Codeunit "SMTP Mail";
        Approver: Record "User Setup";
        KPIScoreAppraiser: Decimal;
        KPIScoreMgt: Decimal;
        PFScoreAppraiser: Decimal;
        PFScoreMgt: Decimal;
}


page 51534938 "HR Appraisal Goal EV list MD"
{
    CardPageID = "HR Appraisal Goal EV";
    ApplicationArea = all;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Functions,NextPage';
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Appraisal Goal EV list MD';
    SourceTable = "HR Appraisal Goal Setting H";
    SourceTableView = WHERE(Status = CONST("Pending Approval"));

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
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Type"; "Appraisal Type")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Period"; "Appraisal Period")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if HREmp.Get("Employee No") then
            "Job Title" := HREmp."Job Title";
    end;

    trigger OnOpenPage()
    begin
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Get then
            SetRange("User ID", HREmp."User ID")
        else
            //user id may not be the creator of the doc
            SetRange("User ID", UserId);
    end;

    var
        HRAppraisalEvaluationAreas: Record "HR Appraisal Evaluation Areas";
        HRAppraisalEvaluations: Record "HR Appraisal Evaluations";
        HRAppraisalEvaluationsF: Page "HR Appraisal Evaluation Lines";
        HREmp: Record "HR Employees";
}


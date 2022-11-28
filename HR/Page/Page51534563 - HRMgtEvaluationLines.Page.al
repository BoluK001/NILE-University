page 51534563 "HR Mgt Evaluation Lines"
{
    PageType = ListPart;
    SourceTable = "HR Appraisal Evaluations";
    SourceTableView = WHERE(Category = CONST("JOB SPECIFIC EVALUATION AREA"));

    layout
    {
        area(content)
        {
            repeater(Control1000000009)
            {
                ShowCaption = false;
                field(Category; Category)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Group; Group)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Sub Category"; "Sub Category")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Evaluation Code"; "Evaluation Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Evaluation Description"; "Evaluation Description")
                {
                    Editable = false;
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("Achievement % (Self)."; "Achievement % (Self).")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Appraisal Rating"; "Appraisal Rating")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Achievement % (Manager)."; "Achievement % (Manager).")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Appraiser Remarks"; "Appraiser Remarks")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Mgt Review Score"; "Mgt Review Score")
                {
                    ApplicationArea = all;
                }
                field("Msg Review Remarks"; "Msg Review Remarks")
                {
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field("Appraisal Period"; "Appraisal Period")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        YesNo: Boolean;
        HRAppraisalEvaluations: Record "HR Appraisal Evaluations";
        HREmp: Record "HR Employees";
        HRAppraisalRatings: Record "HR Appraisal Career Dev";
        TotalScore: Decimal;

    [Scope('OnPrem')]
    procedure TotScore()
    begin
    end;
}


page 51534526 "HR Appraisal Evaluation Lines"
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
                    ApplicationArea = all;
                }
                field(Group; Group)
                {
                    ApplicationArea = all;
                }
                field("Sub Category"; "Sub Category")
                {
                    ApplicationArea = all;
                }
                field("Evaluation Code"; "Evaluation Code")
                {
                    ApplicationArea = all;
                }
                field("Evaluation Description"; "Evaluation Description")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("KRA Individual objectives"; "KRA Individual objectives")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("Appraisal Period"; "Appraisal Period")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Key Results Area"; "Key Results Area")
                {
                    ApplicationArea = all;
                }
                field("KRA (Self)"; "KRA (Self)")
                {
                    ApplicationArea = all;
                }
                field("KRA (Manager)"; "KRA (Manager)")
                {
                    ApplicationArea = all;
                }
                field("Rating (Self)"; "Rating (Self)")
                {
                    ApplicationArea = all;
                }
                field("Rating (Manager)"; "Rating (Manager)")
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


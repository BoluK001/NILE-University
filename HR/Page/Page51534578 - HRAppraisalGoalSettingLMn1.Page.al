page 51534578 "HR Appraisal Goal Setting LMn1"
{
    PageType = ListPart;
    SourceTable = "HR Appraisal Goal Setting L";
    SourceTableView = WHERE("KPI Period" = CONST(Current));

    layout
    {
        area(content)
        {
            repeater(Control1000000013)
            {
                ShowCaption = false;
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = all;
                }
                field("Planned Targets/Objectives"; "Planned Targets/Objectives")
                {
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field("Measurement Criteria"; "Measurement Criteria")
                {
                    Caption = 'Measurement Criteria';
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("Key Outputs"; "Key Outputs")
                {
                    ApplicationArea = all;
                }
                field(Timing; Timing)
                {
                    ApplicationArea = all;
                }
                field("Target Score %"; "Target Score %")
                {
                    Caption = 'Weighting % (Total=100)';
                    ApplicationArea = all;
                }
                field("Agreement With Rating"; "Agreement With Rating")
                {
                    Editable = "Agreement With RatingEditable";
                    ApplicationArea = all;
                }
                field("Actual Results (Self)"; "Actual Results (Self)")
                {
                    ApplicationArea = all;
                }
                field("Actual Results (Manager)"; "Actual Results (Manager)")
                {
                    ApplicationArea = all;
                }
                field("Achievement % (Self)."; "Achievement % (Self).")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = ScoreVisible;
                }
                field("Achievement % (Manager)."; "Achievement % (Manager).")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Appraiser Remarks"; "Appraiser Remarks")
                {
                    Caption = 'Manager''s Remarks';
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        "Agreement With RatingEditable" := true;
        ScoreVisible := true;
        "Appraisal RatingVisible" := true;
    end;

    trigger OnOpenPage()
    begin

        HRAppraisalGoalSettingH.SetRange("Appraisal No", "Appraisal No");
        if HRAppraisalGoalSettingH.Find('-') then
            if HRAppraisalGoalSettingH.Status = HRAppraisalGoalSettingH.Status::Open then begin
                "Agreement With RatingEditable" := false;
                "Appraisal RatingVisible" := false;
                ScoreVisible := false;
            end else begin
                "Agreement With RatingEditable" := true;
            end;
    end;

    var
        HRAppraisalGoalSettingH: Record "HR Appraisal Goal Setting H";
        [InDataSet]
        "Appraisal RatingVisible": Boolean;
        [InDataSet]
        ScoreVisible: Boolean;
        [InDataSet]
        "Agreement With RatingEditable": Boolean;
}


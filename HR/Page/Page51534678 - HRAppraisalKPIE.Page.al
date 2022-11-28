page 51534678 "HR Appraisal KPI E"
{
    DeleteAllowed = true;
    PageType = ListPart;
    SourceTable = "HR Appraisal Goal Setting L";
    SourceTableView = WHERE("Evaluation Type" = CONST(KPI),
                            "Behavioural Group" = CONST('LEARNING GROWTH'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Behavioural Group"; "Behavioural Group")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Appraisal No"; "Appraisal No")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Appraisal Period"; "Appraisal Period")
                {
                    Editable = FieldEdit;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Planned Targets/Objectives"; "Planned Targets/Objectives")
                {
                    Editable = RateEdit;
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    Editable = RateEdit;
                    ApplicationArea = all;
                    MultiLine = true;
                    Visible = true;
                }
                field(Timing; Timing)
                {
                    ApplicationArea = all;
                }
                field("Target Score %"; "Target Score %")
                {
                    Caption = 'Weighting %';
                }
                field(Ratings; Ratings)
                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field(Score; Score)
                {
                    ApplicationArea = all;
                }
                field(Weight; Weight)
                {
                    Caption = 'Supervisor Score';
                    Editable = false;
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Self Rating"; "Self Rating")
                {
                    Editable = false;
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
        if "Appraisal No" <> '' then begin
            HRAppraisal.Get("Appraisal No");
            if HRAppraisal.Status <> HRAppraisal.Status::Open then begin
                //IF (HRAppraisal.Status <> HRAppraisal.Status::"Pending Approval") OR (HRAppraisal.Status <> HRAppraisal.Status::Open) THEN BEGIN
                FieldEdit := true;
                RateEdit := false;
            end
            else begin
                FieldEdit := false;
                RateEdit := true;
            end;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Evaluation Type" := "Evaluation Type"::KPI;
        "Behavioural Group" := 'LEARNING GROWTH';
    end;

    trigger OnOpenPage()
    begin
        if "Appraisal No" <> '' then begin
            HRAppraisal.Get("Appraisal No");
            if HRAppraisal.Status <> HRAppraisal.Status::Open then begin
                FieldEdit := true;
                RateEdit := false;
            end
            else begin
                FieldEdit := false;
                RateEdit := true;
            end;
        end;
    end;

    var
        AppraisalHalf: Option First,Second;
        HRAppraisalGoalSettingL: Record "HR Appraisal Goal Setting L";
        HRAppraisal: Record "HR Appraisal Goal Setting H";
        FieldEdit: Boolean;
        RateEdit: Boolean;

    local procedure SetAppraisalHalf()
    begin
        FilterGroup := 2;
        SetRange(Half, AppraisalHalf);
        //SETRANGE("Evaluation Type","Evaluation Type");
        FilterGroup := 0;
        if Find('-') then;
    end;
}


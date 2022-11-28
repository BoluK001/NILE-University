page 51534675 "HR Appraisal KPI B"
{
    Caption = 'Financial';
    DeleteAllowed = true;
    PageType = ListPart;
    SourceTable = "HR Appraisal Goal Setting L";
    SourceTableView = WHERE("Evaluation Type" = CONST(KPI),
                            "Behavioural Group" = CONST('FINANCIAL'));

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
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Appraisal Period"; "Appraisal Period")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Planned Targets/Objectives"; "Planned Targets/Objectives")
                {
                    //Editable = RateEdit;
                    ApplicationArea = all;
                }
                field("Target Score %"; "Target Score %")
                {
                    Caption = 'Weighting %';
                    ApplicationArea = all;
                }
                field(Timing; Timing)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    //Editable = RateEdit;
                    MultiLine = true;
                    Visible = true;
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
                    ApplicationArea = all;
                }
                field("Self Rating"; "Self Rating")
                {
                    //Editable = false;
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
        if "Submit to HR" then
            PageEditable := false
        else
            PageEditable := true;

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
        //Half:=AppraisalHalf;
        "Behavioural Group" := 'FINANCIAL';
    end;

    trigger OnOpenPage()
    begin
        if "Submit to HR" then
            PageEditable := false
        else
            PageEditable := true;

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
        HRAppraisal: Record "HR Appraisal Goal Setting H";
        FieldEdit: Boolean;
        AppraisalHalf: Option First,Second;
        HRAppraisalGoalSettingL: Record "HR Appraisal Goal Setting L";
        PageEditable: Boolean;
        RateEdit: Boolean;

    local procedure SetAppraisalHalf()
    begin
    end;
}


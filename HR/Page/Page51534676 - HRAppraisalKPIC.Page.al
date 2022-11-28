page 51534676 "HR Appraisal KPI C"
{
    Caption = 'Customer';
    DeleteAllowed = true;
    PageType = ListPart;
    SourceTable = "HR Appraisal Goal Setting L";
    SourceTableView = WHERE("Evaluation Type" = CONST(KPI),
                            "Behavioural Group" = CONST('CUSTOMER'));

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
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Planned Targets/Objectives"; "Planned Targets/Objectives")
                {
                    //Editable = RateEdit;
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    //Editable = RateEdit;
                    MultiLine = true;
                    ApplicationArea = all;
                    Visible = true;
                }
                field(Timing; Timing)
                {
                    ApplicationArea = all;
                }
                field("Target Score %"; "Target Score %")
                {
                    ApplicationArea = all;
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
                    Visible = true;
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
        "Behavioural Group" := 'CUSTOMER';
    end;

    trigger OnOpenPage()
    begin
        //SetAppraisalHalf;
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
        AppraisalHalf: Option First,Second;
        HRAppraisalGoalSettingL: Record "HR Appraisal Goal Setting L";
        HRAppraisal: Record "HR Appraisal Goal Setting H";
        FieldEdit: Boolean;
        PageEditable: Boolean;
        RateEdit: Boolean;

    local procedure SetAppraisalHalf()
    begin
    end;
}


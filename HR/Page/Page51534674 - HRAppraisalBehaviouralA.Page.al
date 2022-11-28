page 51534674 "HR Appraisal Behavioural A"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HR Appraisal Goal Setting L";
    SourceTableView = WHERE("Evaluation Type" = CONST(Behavioural));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Behavioural Group"; "Behavioural Group")
                {
                    Editable = false;
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
                    Editable = FieldEdit;
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    Editable = FieldEdit;
                    ApplicationArea = all;
                }
                field(Timing; Timing)
                {
                    Editable = FieldEdit;
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Weight; Weight)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Actual Results (Self)"; "Actual Results (Self)")
                {
                    Editable = FieldEdit;
                    ApplicationArea = all;
                }
                field("Agreed Score"; "Agreed Score")
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
        if "Appraisal No" <> '' then begin
            HRAppraisal.Get("Appraisal No");
            if HRAppraisal.Status <> HRAppraisal.Status::Open then
                FieldEdit := false
            else
                FieldEdit := true;
        end;
    end;

    trigger OnOpenPage()
    begin
        if "Appraisal No" <> '' then begin
            HRAppraisal.Get("Appraisal No");
            if HRAppraisal.Status <> HRAppraisal.Status::Open then
                FieldEdit := false
            else
                FieldEdit := true;
        end;
    end;

    var
        HRAppraisal: Record "HR Appraisal Goal Setting H";
        FieldEdit: Boolean;
}


page 51534681 "HR Confirmation KPI A"
{
    PageType = ListPart;
    SourceTable = "HR Confirmation KPI";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Objectives; Objectives)
                {
                    ApplicationArea = All;
                }
                field(Weight; Weight)
                {
                    ApplicationArea = All;
                }
                field("Behavioural Group"; "Behavioural Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Ratings; Ratings)
                {
                    ApplicationArea = All;
                }
                field(Score; Score)
                {
                    ApplicationArea = All;
                }
                field("KPI Weighting"; "KPI Weighting")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Target Score %"; "Target Score %")
                {
                    Caption = 'Weight';
                    ApplicationArea = All;
                }
                field("Employee No."; "Employee No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "Document No.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", UserId);
        if ApprovalEntry.FindFirst then begin
            SupEditable := true;
            EmpEditable := false;
        end else begin
            EmpEditable := true;
            SupEditable := false;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Behavioural Group" := 'FINANCIAL';
    end;

    trigger OnOpenPage()
    begin
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "Document No.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", UserId);
        if ApprovalEntry.FindFirst then begin
            SupEditable := true;
            EmpEditable := false;
        end else begin
            EmpEditable := true;
            SupEditable := false;
        end;
    end;

    var
        ApprovalEntry: Record "Approval Entry";
        SupEditable: Boolean;
        EmpEditable: Boolean;
}


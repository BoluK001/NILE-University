page 51534703 "HR Appraisal Goal Setting HSL1"
{
    CardPageID = "HR Appraisal Goal Setting HS";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
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
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field(Unit; Unit)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender;
        AppraiserEditable: Boolean;
        MgtEditable: Boolean;
        HREmp: Record "HR Employees";
        UserSetup: Record "User Setup";
        Approver: Record "User Setup";
        SMTP: Codeunit "SMTP Mail";
        CompanyScoreAppraisee: Decimal;
        KPIScoreAppraisee: Decimal;
        PFScoreAppraisee: Decimal;
        PFBase: Decimal;
}


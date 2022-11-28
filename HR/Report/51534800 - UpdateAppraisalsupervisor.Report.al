report 51534800 "Update Appraisal supervisor"
{
    DefaultLayout = RDLC;
    RDLCLayout = './UpdateAppraisalsupervisor.rdlc';

    dataset
    {
        dataitem("HR Appraisal Goal Setting H"; "HR Appraisal Goal Setting H")
        {

            trigger OnAfterGetRecord()
            begin
                ApprovalUserSetup.Reset;
                ApprovalUserSetup.SetCurrentKey(ApprovalUserSetup."Sequence No.");
                ApprovalUserSetup.SetRange(ApprovalUserSetup."User ID", "HR Appraisal Goal Setting H"."User ID");
                if ApprovalUserSetup.FindFirst then begin
                    "HR Appraisal Goal Setting H".Supervisor := ApprovalUserSetup."Approver ID";
                    Emp.SetRange(Emp."User ID", Supervisor);
                    if Emp.FindFirst then
                        "HR Appraisal Goal Setting H"."Supervisor's Job Title" := Emp."Job Title";
                    "HR Appraisal Goal Setting H".Modify;
                end;
                "HR Appraisal Goal Setting H".Modify;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ApprovalUserSetup: Record "Approval User Setup";
        Emp: Record "HR Employees";
}


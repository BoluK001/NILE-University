page 51534580 "Hr Trasnsport Requisition Card"
{
    SourceTable = "HR Transport Requisition";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application Code"; "Application Code")
                {
                    Caption = 'Application No';
                    ApplicationArea = all;
                }
                field("Employee No"; "Employee No")
                {
                    Caption = 'Applicant No.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(EmpName; EmpName)
                {
                    Caption = 'Applicant Name';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Job Tittle"; "Job Tittle")
                {
                    ApplicationArea = all;
                    Caption = 'Job Title';
                    Editable = false;
                }
                field(EmpJobDesc; EmpJobDesc)
                {
                    Caption = 'Job Description';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(EmpDept; EmpDept)
                {
                    Caption = 'Department';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = all;
                }
                field("Days Applied"; "Days Applied")
                {
                    Caption = 'No of Days';
                    ApplicationArea = all;
                }
                field("Time of Trip"; "Time of Trip")
                {
                    ApplicationArea = all;
                }
                field("From Destination"; "From Destination")
                {
                    ApplicationArea = all;
                }
                field("To Destination"; "To Destination")
                {
                    ApplicationArea = all;
                }
                field("Return Date"; "Return Date")
                {
                    ApplicationArea = all;
                }
                field("Purpose of Trip"; "Purpose of Trip")
                {
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field(Supervisor; Supervisor)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(SupervisorName; SupervisorName)
                {
                    Caption = 'Supervisor Name';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Supervisor Email"; "Supervisor Email")
                {
                    Caption = 'Supervisor Email';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field(Comment; Comment)
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

    var
        HREmp: Record "HR Employees";
        EmpJobDesc: Text[30];
        HRJobs: Record "HR Jobs";
        SupervisorName: Text[30];
        SMTP: Codeunit "SMTP Mail";
        URL: Text[500];
        dAlloc: Decimal;
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Decimal;
        HRSetup: Record "HR Setup";
        EmpDept: Text[30];
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        HRLeaveApp: Record "HR Transport Requisition";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Budget Transfer","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        D: Date;
        EmpName: Text[70];
        DoclLink: Record "HR Leave Attachments";
}


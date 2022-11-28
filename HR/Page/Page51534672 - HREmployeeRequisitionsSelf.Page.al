page 51534672 "HR Employee Requisitions Self"
{
    CardPageID = "HR Emp Requisition Self";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Employee Requisitions Self';
    PromotedActionCategories = 'New,Process,Reports,Job,Functions,Employee';
    ShowFilter = true;
    SourceTable = "HR Employee Requisitions";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                ShowCaption = false;
                field("Requisition No."; "Requisition No.")
                {
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Requisition Date"; "Requisition Date")
                {
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Job Description"; "Job Description")
                {
                    ApplicationArea = all;
                }
                field(Requestor; Requestor)
                {
                    ApplicationArea = all;
                }
                field("Reason For Request"; "Reason For Request")
                {
                    ApplicationArea = all;
                }
                field("Required Positions"; "Required Positions")
                {
                    ApplicationArea = all;
                }
                field("Type of Contract Required"; "Type of Contract Required")
                {
                    Caption = 'Contract';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Closing Date"; "Closing Date")
                {
                    ApplicationArea = all;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755006; "HR Employee Req. Factbox")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
            systempart(Control1102755008; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Job)
            {
                Caption = 'Job';
                action(Requirements)
                {
                    Caption = 'Requirements';
                    Image = JobListSetup;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Job Requirement Lines";
                    RunPageLink = "Job Id" = FIELD("Job ID");
                }
                action(Responsibilities)
                {
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Job Responsiblities Lines";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
            }
            group("Fu&nctions")
            {
                Caption = 'Fu&nctions';
                action("&Approvals")
                {
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal;
                    begin
                        DocumentType := DocumentType::"Employee Requisition";
                        ApprovalEntries.Setfilters(DATABASE::"HR Employee Requisitions", DocumentType, "Requisition No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("&Send Approval Request")
                {
                    Caption = '&Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        if Confirm('Send this Requisition for Approval?', true) = false then exit;

                        TESTFIELDS;


                        /// if ApprovalMgt.CheckEmpRequisitionApprovalPossible(Rec) then
                        ///   ApprovalMgt.OnSendEmpRequisitionForApproval(Rec);RBS DENNIS
                    end;
                }
                action("&Cancel Approval Request")
                {
                    Caption = '&Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Confirm('Cancel Approval Request?', true) = false then exit;

                        /// ApprovalMgt.OnCancelEmpRequisitionForApproval(Rec);
                        ///WorkflowWebhookMgt.FindAndCancel(RecordId); RBS DENNIS
                    end;
                }
                action("Mark as Closed/Open")
                {
                    Caption = 'Mark as Closed/Open';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        if Closed then begin
                            if not Confirm('Are you sure you want to Re-Open this Document', false) then exit;
                            Closed := false;
                            Modify;
                            Message('Employee Requisition %1 has been Re-Opened', "Requisition No.");

                        end else begin
                            if not Confirm('Are you sure you want to close this Document', false) then exit;
                            Closed := true;
                            Modify;
                            Message('Employee Requisition %1 has been marked as Closed', "Requisition No.");
                        end;
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category5;
                    //RunObject = Report "IBS Notes 2";
                    Visible = false;

                    trigger OnAction()
                    begin
                        HREmpReq.Reset;
                        HREmpReq.SetRange(HREmpReq."Requisition No.", "Requisition No.");
                        if HREmpReq.Find('-') then
                            REPORT.RUN(51534518, true, true, HREmpReq);
                    end;
                }
                action("Re-Open")
                {
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Status := Status::New;
                        Modify;
                    end;
                }
            }
            action("Applicant to Employee")
            {
                Caption = 'Applicant to Employee';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report Report39005600;
                Visible = false;
            }
            action("Employee Requisitions")
            {
                Caption = 'Employee Requisitions';
                Image = "Report ";
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report "IBS Notes 2";
                Visible = false;
            }
        }
    }

    trigger OnOpenPage()
    begin
        FilterGroup(2);
        SetFilter(Requestor, UserId);
        FilterGroup(0);
    end;

    var
        HREmp: Record "HR Employees";
        HREmailParameters: Record "HR E-Mail Parameters";
        SMTP: Codeunit "SMTP Mail";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal;
        ApprovalEntries:Page "Approval Entries";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        HREmpReq: Record "HR Employee Requisitions";
        EmpName: Text[100];

    [Scope('OnPrem')]
    procedure TESTFIELDS()
    begin
        TestField("Job ID");
        TestField("Closing Date");
        TestField("Type of Contract Required");
        TestField("Recruitment Type");
        TestField("Required Positions");
        if "Reason For Request" = "Reason For Request"::Other then
            TestField("Reason for Request(Other)");
    end;
}


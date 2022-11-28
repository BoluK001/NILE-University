Codeunit 51534407 "Approval Mgmt. ExtCal"
{

    trigger OnRun()
    begin
    end;

    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        NoworkflowEnabledErr: Label 'No approval workflow for this record type is Enabled';
    //cust: page "Customer Card";

    // StaffClaim workflow begin
    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendStaffClaimForApproval(var StaffClaim: Record "Staff Claims Header")
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckStaffClaimApprovalsWorkflowEnable(StaffClaim: Record "Staff Claims Header"): Boolean
    begin
        if not IsStaffClaimDocApprovalsWorkflowEnable(StaffClaim) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsStaffClaimDocApprovalsWorkflowEnable(var StaffClaim: Record "Staff Claims Header"): Boolean
    begin
        if StaffClaim.Status <> StaffClaim.Status::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(StaffClaim, WorkflowEventHandlingCust.RunWorkflowOnSendStaffClaimForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelStaffClaimForApproval(var StaffClaim: Record "Staff Claims Header")
    begin
    end;
    // StaffClaim workflow end  

    //G/L Account Work flow
    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendGLAccountForApproval(var GLAccount: Record "G/L Account")
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckGLAccountApprovalsWorkflowEnable(GLAccount: Record "G/L Account"): Boolean
    begin
        if not IsGLAccountDocApprovalsWorkflowEnable(GLAccount) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsGLAccountDocApprovalsWorkflowEnable(var GLAccount: Record "G/L Account"): Boolean
    begin
        if GLAccount.Status <> GLAccount.Status::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(GLAccount, WorkflowEventHandlingCust.RunWorkflowOnSendGLAccountForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelGLAccountForApproval(var GLAccount: Record "G/L Account")
    begin
    end;
    //Voucher Workflow
    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendVoucherForApproval(var Voucher: Record "Voucher Header")
    begin
    end;

    //Store Requisition
    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendStoreReqForApproval(var StoreReq: Record "Store Requisition Header")
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckStoreReqApprovalsWorkflowEnable(StoreReq: Record "Store Requisition Header"): Boolean
    begin
        if not IsStoreReqDocApprovalsWorkflowEnable(StoreReq) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsStoreReqDocApprovalsWorkflowEnable(var StoreReq: Record "Store Requisition Header"): Boolean
    begin
        if StoreReq.Status <> StoreReq.Status::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(StoreReq, WorkflowEventHandlingCust.RunWorkflowOnSendStoreReqForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelStoreReqForApproval(var StoreReq: Record "Store Requisition Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendItemJnlBatchForApproval(var ItemJnlBatch: Record "Item Journal Batch")
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendHRJobsForApproval(var HRJobs: Record "HR Jobs")
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendHMOForApproval(var HMO: Record "HR HMO")
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendHREmpLoanForApproval(var HREmpLoan: Record "prAssignEmployeeLoan")
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendHRInterviewEvalForApproval(var HRInterviewEval: Record "Hr Interview Evaluation")
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendHRLeaveAppForApproval(var HRLeaveApp: Record "HR Leave Application")
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendHREmpReqForApproval(var HREmpReq: Record "HR Employee Requisitions")
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendHRAppraisalEvalForApproval(var HRAppraisalEval: Record "HR Appraisal Goal Setting H")
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendHRTrainingAppForApproval(var HRTrainingApp: Record "HR Training Applications")
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendHRCanteenAppForApproval(var HRCanteenApp: Record "Hr Canteen Application")
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendEmpTransferForApproval(var EmpTransfer: Record "HR Emp. Transaction Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendHRLeaveAckForApproval(var HRLeaveAck: Record "HR Leave Acknowledgement")
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendHREmpConForApproval(var HREmpCon: Record "HR Employee Confirmation")
    begin
    end;

    //Staff Advance
    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendStaffAdvanceForApproval(var StaffAdvance: Record "Staff Advance Header")
    begin
    end;

    //Advance Surrender
    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendAdvanceSurrenderForApproval(var StaffAdvanceSurrender: Record "Staff Advance Surrender Header")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Voucher: Record "Voucher Header";
        DocType: Enum "Approval Document Type";
        //DocType: Option "Vouchers","Staff Claim","Staff Advance",Retirement,"Express Pv",Requisition,JV," ",GLAccount,BPV,BRV,CPV,CRV,Receipt,PettyCash,"Store Requisition","Item Journal Batch",Jobs,HMO,Loan,"Interview Evaluation","Leave Application","Employee Requisitions",Appraisal,"Training Applications","Canteen Application","Employee Transaction","Leave Acknowledgement","Employee Confirmation",Employee;
        StaffAdvance: Record "Staff Advance Header";
        AdvanceSurrender: Record "Staff Advance Surrender Header";
        GLAccount: Record "G/L Account";
        StaffClaim: Record "Staff Claims Header";
        StoreReq: Record "Store Requisition Header";
        ItemJnlBatch: Record "Item Journal Batch";
        HRJobs: Record "HR Jobs";
        HMO: Record "HR HMO";
        HREmpLoan: Record "prAssignEmployeeLoan";
        HRInterviewEval: Record "Hr Interview Evaluation";
        HRLeaveApp: Record "HR Leave Application";
        HREmpReq: Record "HR Employee Requisitions";
        HRAppraisalEval: Record "HR Appraisal Goal Setting H";
        HRTrainingApp: Record "HR Training Applications";
        HRCanteenApp: Record "Hr Canteen Application";
        EmpTransfer: Record "HR Emp. Transaction Header";
        HRLeaveAck: Record "HR Leave Acknowledgement";
        HREmpCon: Record "HR Employee Confirmation";
        EMP: Record "HR Employees";
        PurchaseHeader: Record "Purchase Header";
        ApprovalAmount: Decimal;
        ApprovalAmountLCY: Decimal;

    begin
        case RecRef.Number of
            DATABASE::"Voucher Header":
                begin
                    RecRef.SetTable(Voucher);
                    ApprovalEntryArgument."Document No." := Voucher."No.";
                    //ApprovalEntryArgument."Document Type" := DocType::Vouchers;
                    ApprovalEntryArgument."Amount (LCY)" := Voucher."Amount (LCY)";
                    begin
                        case Voucher."Voucher Type" of
                            Voucher."Voucher Type"::BPV:
                                begin
                                    ApprovalEntryArgument."Document Type" := DocType::BPV;
                                end;
                            Voucher."Voucher Type"::BRV:
                                begin
                                    ApprovalEntryArgument."Document Type" := DocType::BRV;
                                end;
                            Voucher."Voucher Type"::CPV:
                                begin
                                    ApprovalEntryArgument."Document Type" := DocType::CPV;
                                end;
                            Voucher."Voucher Type"::CRV:
                                begin
                                    ApprovalEntryArgument."Document Type" := DocType::CRV;
                                end;
                            Voucher."Voucher Type"::JV:
                                begin
                                    ApprovalEntryArgument."Document Type" := DocType::JV;
                                end;
                            Voucher."Voucher Type"::PettyCash:
                                begin
                                    ApprovalEntryArgument."Document Type" := DocType::PettyCash;
                                end;
                        end;

                    end;
                end;

            DATABASE::"Staff Advance Header":
                begin
                    RecRef.SetTable(StaffAdvance);
                    ApprovalEntryArgument."Document No." := StaffAdvance."No.";
                    ApprovalEntryArgument."Document Type" := DocType::"Staff Advance";
                    ApprovalEntryArgument.Amount := StaffAdvance."Total Net Amount";
                    ApprovalEntryArgument."Amount (LCY)" := StaffAdvance."Total Net Amount LCY";
                end;
            // Database::"Purchase Header":
            // begin

            // end;

            DATABASE::"Staff Advance Surrender Header":
                begin
                    RecRef.SetTable(AdvanceSurrender);
                    ApprovalEntryArgument."Document No." := AdvanceSurrender."No.";
                    ApprovalEntryArgument."Document Type" := DocType::Retirement;
                    ApprovalEntryArgument."Amount (LCY)" := AdvanceSurrender."Amount Surrendered LCY";
                    ApprovalEntryArgument.Amount := AdvanceSurrender.Amount;
                end;

            DATABASE::"G/L Account":
                begin
                    RecRef.SetTable(GLAccount);
                    ApprovalEntryArgument."Document No." := GLAccount."No.";
                    ApprovalEntryArgument."Document Type" := DocType::GLAccount;
                end;

            DATABASE::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaim);
                    ApprovalEntryArgument."Document No." := StaffClaim."No.";
                    ApprovalEntryArgument."Document Type" := DocType::"Staff Claim";
                    ApprovalEntryArgument.Amount := StaffClaim."Total Net Amount";
                end;
            DATABASE::"Store Requisition Header":
                begin
                    RecRef.SetTable(StoreReq);
                    ApprovalEntryArgument."Document No." := StoreReq."No.";
                    ApprovalEntryArgument."Document Type" := DocType::"Store Requisition"

                end;
            DATABASE::"Item Journal Batch":
                begin
                    RecRef.SetTable(ItemJnlBatch);
                    ApprovalEntryArgument."Document No." := ItemJnlBatch.Name;
                    ApprovalEntryArgument."Document Type" := DocType::"Item Journal Batch";
                end;
            DATABASE::"HR Jobs":
                begin
                    RecRef.SetTable(HRJobs);
                    ApprovalEntryArgument."Document No." := HRJobs."Job ID";
                    ApprovalEntryArgument."Document Type" := DocType::Jobs;
                end;
            DATABASE::"HR HMO":
                begin
                    RecRef.SetTable(HMO);
                    ApprovalEntryArgument."Document No." := HMO."Employee No.";
                    ApprovalEntryArgument."Document Type" := DocType::HMO;
                end;
            DATABASE::"prAssignEmployeeLoan":
                begin
                    RecRef.SetTable(HREmpLoan);
                    ApprovalEntryArgument."Document No." := HREmpLoan."Document No.";
                    ApprovalEntryArgument."Document Type" := DocType::Loan;
                end;
            DATABASE::"Hr Interview Evaluation":
                begin
                    RecRef.SetTable(HRInterviewEval);
                    ApprovalEntryArgument."Document No." := HRInterviewEval."Interview No.";
                    ApprovalEntryArgument."Document Type" := DocType::"Interview Evaluation"
                end;
            DATABASE::"HR Leave Application":
                begin
                    RecRef.SetTable(HRLeaveApp);
                    ApprovalEntryArgument."Document No." := HRLeaveApp."Application Code";
                    ApprovalEntryArgument."Document Type" := DocType::"Leave Application";
                end;
            DATABASE::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(HREmpReq);
                    ApprovalEntryArgument."Document No." := HREmpReq."Job ID";
                    ApprovalEntryArgument."Document Type" := DocType::"Employee Requisitions";
                end;
            DATABASE::"HR Appraisal Goal Setting H":
                begin
                    RecRef.SetTable(HRAppraisalEval);
                    ApprovalEntryArgument."Document No." := HRAppraisalEval."Appraisal No";
                    ApprovalEntryArgument."Document Type" := DocType::Appraisal;
                end;
            DATABASE::"HR Training Applications":
                begin
                    RecRef.SetTable(HRTrainingApp);
                    ApprovalEntryArgument."Document No." := HRTrainingApp."Application No";
                    ApprovalEntryArgument."Document Type" := DocType::"Training Applications";
                    ApprovalEntryArgument.Amount := HRTrainingApp."Total Amount";
                    ApprovalEntryArgument."Amount (LCY)" := HRTrainingApp."Total Amount";

                end;
            DATABASE::"Hr Canteen Application":
                begin
                    RecRef.SetTable(HRCanteenApp);
                    ApprovalEntryArgument."Document No." := HRCanteenApp."Ticket No.";
                    ApprovalEntryArgument."Document Type" := DocType::"Canteen Application";
                end;
            DATABASE::"HR Emp. Transaction Header":
                begin
                    RecRef.SetTable(EmpTransfer);
                    ApprovalEntryArgument."Document No." := EmpTransfer."Document No.";
                    ApprovalEntryArgument."Document Type" := DocType::"Employee Transaction"
                end;
            DATABASE::"HR Leave Acknowledgement":
                begin
                    RecRef.SetTable(HRLeaveAck);
                    ApprovalEntryArgument."Document No." := HRLeaveAck."No.";
                    ApprovalEntryArgument."Document Type" := DocType::"Leave Acknowledgement"
                end;
            DATABASE::"HR Employee Confirmation":
                begin
                    RecRef.SetTable(HREmpCon);
                    ApprovalEntryArgument."Document No." := HREmpCon."Application No.";
                    ApprovalEntryArgument."Document Type" := DocType::"Employee Confirmation";
                end;
            DATABASE::"HR Employees":
                begin
                    RecRef.SetTable(EMP);
                    ApprovalEntryArgument."Document No." := EMP."No.";
                    ApprovalEntryArgument."Document Type" := DocType::Employee;
                end;
            //Test
            DATABASE::"Purchase Header":
                begin
                    //  If PurchaseHeader."Purchase Type" = PurchaseHeader."Purchase Type"::Requisition then begin
                    RecRef.SetTable(PurchaseHeader);
                    //If (PurchaseHeader."Purchase Type" = PurchaseHeader."Purchase Type"::Requisition) then begin
                    CalcPurchaseDocAmount(PurchaseHeader, ApprovalAmount, ApprovalAmountLCY);
                    If PurchaseHeader."Purchase Type" = PurchaseHeader."Purchase Type"::Requisition then
                        ApprovalEntryArgument."Document Type" := DocType::Requisition else
                        ApprovalEntryArgument."Document Type" := PurchaseHeader."Document Type";
                    ApprovalEntryArgument."Document No." := PurchaseHeader."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := PurchaseHeader."Purchaser Code";
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := PurchaseHeader."Currency Code";
                    // end;
                end;
        //
        end;
    end;

    procedure CalcPurchaseDocAmount(PurchaseHeader: Record "Purchase Header"; var ApprovalAmount: Decimal; var ApprovalAmountLCY: Decimal)
    var
        TempPurchaseLine:
            Record "Purchase Line" temporary;
        TotalPurchaseLine:
                Record "Purchase Line";
        TotalPurchaseLineLCY:
                Record "Purchase Line";
        PurchPost:
                Codeunit "Purch.-Post";
        TempAmount:
                Decimal;
        VAtText:
                Text[30];
    begin
        PurchaseHeader.CalcInvDiscForHeader;
        PurchPost.GetPurchLines(PurchaseHeader, TempPurchaseLine, 0);
        Clear(PurchPost);
        PurchPost.SumPurchLinesTemp(
      PurchaseHeader, TempPurchaseLine, 0, TotalPurchaseLine, TotalPurchaseLineLCY,
      TempAmount, VAtText);
        ApprovalAmount := TotalPurchaseLine.Amount;
        ApprovalAmountLCY := TotalPurchaseLineLCY.Amount;
    end;

    [Scope('OnPrem')]
    procedure CheckVoucherApprovalsWorkflowEnable(Voucher: Record "Voucher Header"): Boolean
    begin
        if not IsVoucherDocApprovalsWorkflowEnable(Voucher) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsVoucherDocApprovalsWorkflowEnable(var Voucher: Record "Voucher Header"): Boolean
    begin
        if Voucher.Status <> Voucher.Status::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(Voucher, WorkflowEventHandlingCust.RunWorkflowOnSendVoucherForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelVoucherForApproval(var Voucher: Record "Voucher Header")
    begin
    end;
    //
    [Scope('OnPrem')]
    procedure CheckHRJobsApprovalsWorkflowEnable(HRJobs: Record "HR Jobs"): Boolean
    begin
        if not IsHRJobsDocApprovalsWorkflowEnable(HRJobs) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsHRJobsDocApprovalsWorkflowEnable(var HRJobs: Record "HR Jobs"): Boolean
    begin
        if HRJobs.Status <> HRJobs.Status::New then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(HRJobs, WorkflowEventHandlingCust.RunWorkflowOnSendHRJobsForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelHRJobsForApproval(var HRJobs: Record "HR Jobs")
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckHMOApprovalsWorkflowEnable(HMO: Record "HR HMO"): Boolean
    begin
        if not IsHMODocApprovalsWorkflowEnable(HMO) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsHMODocApprovalsWorkflowEnable(var HMO: Record "HR HMO"): Boolean
    begin
        if HMO.Status <> HMO.Status::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(HMO, WorkflowEventHandlingCust.RunWorkflowOnSendHMOForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelHMOForApproval(var HMO: Record "HR HMO")
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckHREmpLoanApprovalsWorkflowEnable(HREmpLoan: Record prAssignEmployeeLoan): Boolean
    begin
        if not IsHREmpLoanDocApprovalsWorkflowEnable(HREmpLoan) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsHREmpLoanDocApprovalsWorkflowEnable(var HREmpLoan: Record prAssignEmployeeLoan): Boolean
    begin
        if HREmpLoan.Status <> HREmpLoan.Status::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(HREmpLoan, WorkflowEventHandlingCust.RunWorkflowOnSendHREmpLoanForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelHREmpLoanForApproval(var HREmpLoan: Record prAssignEmployeeLoan)
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckHRInterviewEvalApprovalsWorkflowEnable(HRInterviewEval: Record "Hr Interview Evaluation"): Boolean
    begin
        if not IsHRInterviewEvalDocApprovalsWorkflowEnable(HRInterviewEval) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsHRInterviewEvalDocApprovalsWorkflowEnable(var HRInterviewEval: Record "Hr Interview Evaluation"): Boolean
    begin
        if HRInterviewEval.Status <> HRInterviewEval.Status::New then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(HRInterviewEval, WorkflowEventHandlingCust.RunWorkflowOnSendHRInterviewEvalForApprovalCode()))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelHRInterviewEvalForApproval(var HRInterviewEval: Record "Hr Interview Evaluation")
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckHRLeaveAppApprovalsWorkflowEnable(HRLeaveApp: Record "HR Leave Application"): Boolean
    begin
        if not IsHRLeaveAppDocApprovalsWorkflowEnable(HRLeaveApp) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsHRLeaveAppDocApprovalsWorkflowEnable(var HRLeaveApp: Record "HR Leave Application"): Boolean
    begin
        if HRLeaveApp.Status <> HRLeaveApp.Status::New then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(HRLeaveApp, WorkflowEventHandlingCust.RunWorkflowOnSendHRLeaveAppForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelHRLeaveAppForApproval(var HRLeaveApp: Record "HR Leave Application")
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckHREmpReqApprovalsWorkflowEnable(HREmpReq: Record "HR Employee Requisitions"): Boolean
    begin
        if not IsHREmpReqDocApprovalsWorkflowEnable(HREmpReq) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsHREmpReqDocApprovalsWorkflowEnable(var HREmpReq: Record "HR Employee Requisitions"): Boolean
    begin
        if HREmpReq.Status <> HREmpReq.Status::New then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(HREmpReq, WorkflowEventHandlingCust.RunWorkflowOnSendHREmpReqForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelHREmpReqForApproval(var HREmpReq: Record "HR Employee Requisitions")
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckHRAppraisalEvalApprovalsWorkflowEnable(HRAppraisalEval: Record "HR Appraisal Goal Setting H"): Boolean
    begin
        if not IsHRAppraisalEvalDocApprovalsWorkflowEnable(HRAppraisalEval) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsHRAppraisalEvalDocApprovalsWorkflowEnable(var HRAppraisalEval: Record "HR Appraisal Goal Setting H"): Boolean
    begin
        if HRAppraisalEval.Status <> HRAppraisalEval.Status::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(HRAppraisalEval, WorkflowEventHandlingCust.RunWorkflowOnSendHRAppraisalEvalForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelHRAppraisalEvalForApproval(var HRAppraisalEval: Record "HR Appraisal Goal Setting H")
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckHRTrainingApprovalsWorkflowEnable(HRTrainingApp: Record "HR Training Applications"): Boolean
    begin
        if not IsHRTrainingAppDocApprovalsWorkflowEnable(HRTrainingApp) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsHRTrainingAppDocApprovalsWorkflowEnable(var HRTrainingApp: Record "HR Training Applications"): Boolean
    begin
        if HRTrainingApp.Status <> HRTrainingApp.Status::New then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(HRTrainingApp, WorkflowEventHandlingCust.RunWorkflowOnSendHRTrainingAppForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelHRTrainingAppForApproval(var HRTrainingApp: Record "HR Training Applications")
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckHRCanteenAppApprovalsWorkflowEnable(HRCanteenApp: Record "Hr Canteen Application"): Boolean
    begin
        if not IsHRCanteenAppDocApprovalsWorkflowEnable(HRCanteenApp) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsHRCanteenAppDocApprovalsWorkflowEnable(var HRCanteenApp: Record "Hr Canteen Application"): Boolean
    begin
        if HRCanteenApp.Status <> HRCanteenApp.Status::New then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(HRCanteenApp, WorkflowEventHandlingCust.RunWorkflowOnSendHRCanteenAppForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelHRCanteenAppForApproval(var HRCanteenApp: Record "Hr Canteen Application")
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckEmpTransferApprovalsWorkflowEnable(EmpTransfer: Record "HR Emp. Transaction Header"): Boolean
    begin
        if not IsEmpTransferDocApprovalsWorkflowEnable(EmpTransfer) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsEmpTransferDocApprovalsWorkflowEnable(var EmpTransfer: Record "HR Emp. Transaction Header"): Boolean
    begin
        if EmpTransfer.Status <> EmpTransfer.Status::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(EmpTransfer, WorkflowEventHandlingCust.RunWorkflowOnSendEmpTransferForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelEmpTransferForApproval(var EmpTransfer: Record "HR Emp. Transaction Header")
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckHRLeaveAckApprovalsWorkflowEnable(HRLeaveAck: Record "HR Leave Acknowledgement"): Boolean
    begin
        if not IsHRLeaveAckDocApprovalsWorkflowEnable(HRLeaveAck) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsHRLeaveAckDocApprovalsWorkflowEnable(var HRLeaveAck: Record "HR Leave Acknowledgement"): Boolean
    begin
        if HRLeaveAck.Status <> HRLeaveAck.Status::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(HRLeaveAck, WorkflowEventHandlingCust.RunWorkflowOnSendHRLeaveAckForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelHRLeaveAckForApproval(var HRLeaveAck: Record "HR Leave Acknowledgement")
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckHREmpConApprovalsWorkflowEnable(HREmpCon: Record "HR Employee Confirmation"): Boolean
    begin
        if not IsHREmpConDocApprovalsWorkflowEnable(HREmpCon) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsHREmpConDocApprovalsWorkflowEnable(var HREmpCon: Record "HR Employee Confirmation"): Boolean
    begin
        if HREmpCon.Status <> HREmpCon.Status::New then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(HREmpCon, WorkflowEventHandlingCust.RunWorkflowOnSendHREmpConForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelHREmpConForApproval(var HREmpCon: Record "HR Employee Confirmation")
    begin
    end;

    //HR Employees 
    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnSendEMPForApproval(var EMP: Record "HR Employees")
    begin
    end;

    [Scope('OnPrem')]
    procedure CheckEmpApprovalsWorkflowEnable(Emp: Record "HR Employees"): Boolean
    begin
        if not IsEmpDocApprovalsWorkflowEnable(Emp) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsEmpDocApprovalsWorkflowEnable(var Emp: Record "HR Employees"): Boolean
    begin
        if Emp."Approval Status" <> Emp."Approval Status"::New then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(Emp, WorkflowEventHandlingCust.RunWorkflowOnSendEmpForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelEmpForApproval(var Emp: Record "HR Employees")
    begin
    end;
    //

    [Scope('OnPrem')]
    procedure CheckStaffAdvanceApprovalsWorkflowEnable(StaffAdvance: Record "Staff Advance Header"): Boolean
    begin
        if not IsStaffAdvanceDocApprovalsWorkflowEnable(StaffAdvance) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsStaffAdvanceDocApprovalsWorkflowEnable(var StaffAdvance: Record "Staff Advance Header"): Boolean
    begin
        if StaffAdvance.Status <> StaffAdvance.Status::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(StaffAdvance, WorkflowEventHandlingCust.RunWorkflowOnSendStaffAdvanceForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelStaffAdvanceForApproval(var StaffAdvance: Record "Staff Advance Header")
    begin
    end;




    [Scope('OnPrem')]
    procedure CheckAdvanceSurrenderApprovalsWorkflowEnable(AdvanceSurrender: Record "Staff Advance Surrender Header"): Boolean
    begin
        if not IsAdvanceSurrenderDocApprovalsWorkflowEnable(AdvanceSurrender) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [Scope('OnPrem')]
    procedure IsAdvanceSurrenderDocApprovalsWorkflowEnable(var AdvanceSurrender: Record "Staff Advance Surrender Header"): Boolean
    begin
        if AdvanceSurrender.Status <> AdvanceSurrender.Status::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(AdvanceSurrender, WorkflowEventHandlingCust.RunWorkflowOnSendAdvanceSurrenderForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelAdvanceSurrenderForApproval(var AdvanceSurrender: Record "Staff Advance Surrender Header")
    begin
    end;

    //Staff Claim

    [Scope('OnPrem')]
    procedure IsStaffClaimsDocApprovalsWorkflowEnable(var StaffClaim: Record "Staff Claims Header"): Boolean
    begin
        if StaffClaim.Status <> StaffClaim.Status::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(StaffClaim, WorkflowEventHandlingCust.RunWorkflowOnSendStaffClaimForApprovalCode))
    end;



    [Scope('OnPrem')]
    procedure CheckStaffClaimsApprovalsWorkflowEnable(StaffClaims: Record "Staff Claims Header"): Boolean
    begin
        if not IsStaffClaimsDocApprovalsWorkflowEnable(StaffClaims) then
            Error(NoworkflowEnabledErr);
        exit(true);
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnCancelStaffClaimsForApproval(var StaffClaims: Record "Staff Claims Header")
    begin
    end;





    // [Scope('OnPrem')]
    // procedure CheckItemJnlBatchApprovalsWorkflowEnable(ItemJnlBatch: Record "Item Journal Batch"): Boolean
    // begin
    //     if not IsItemJnlBatchDocApprovalsWorkflowEnable(ItemJnlBatch) then
    //         Error(NoworkflowEnabledErr);
    //     exit(true);
    // end;

    // [Scope('OnPrem')]
    // procedure IsItemJnlBatchDocApprovalsWorkflowEnable(var ItemJnlBatch: Record "Item Journal Batch"): Boolean
    // begin
    //     if ItemJnlBatch.Status <> ItemJnlBatch.Status::Open then
    //         exit(false);
    //     exit(WorkflowManagement.CanExecuteWorkflow(ItemJnlBatch, WorkflowEventHandlingCust.RunWorkflowOnSendItemJnlBatchForApprovalCode))
    // end;

    // [IntegrationEvent(false, false)]
    // [Scope('OnPrem')]
    // procedure OnCancelItemJnlBatchForApproval(var ItemJnlBatch: Record "Item Journal Batch")
    // begin
    // end;
}


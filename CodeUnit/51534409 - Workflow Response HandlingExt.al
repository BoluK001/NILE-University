codeunit 51534409 "Workflow Response HandlingExt"
{

    trigger OnRun()
    begin
    end;

    var
        UnsupportedRecordTypeErr: Label 'Record type %1 is not supported by this workflow response.', Comment = 'Record type Customer is not supported by this workflow response.';
        WorkflowEventHandling: Codeunit "Workflow Event Handling";

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PaymentsHeader: Record "Voucher Header";
        StaffAdvance: Record "Staff Advance Header";
        AdvanceSurrender: Record "Staff Advance Surrender Header";
        GLAccount: Record "G/L Account";
        StaffClaim: Record "Staff Claims Header";
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
        StoreReq: Record "Store Requisition Header";
    begin
        case RecRef.Number of
            DATABASE::"Voucher Header":
                begin
                    RecRef.SetTable(PaymentsHeader);
                    PaymentsHeader.Status := PaymentsHeader.Status::Open;
                    PaymentsHeader.Modify;
                    Handled := true;
                end;

            DATABASE::"Staff Advance Header":
                begin
                    RecRef.SetTable(StaffAdvance);
                    StaffAdvance.Status := StaffAdvance.Status::Open;
                    StaffAdvance.Modify;
                    Handled := true;
                end;

            DATABASE::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaim);
                    StaffClaim.Status := StaffClaim.Status::Open;
                    StaffClaim.Modify;
                    Handled := true;
                end;

            DATABASE::"Staff Advance Surrender Header":
                begin
                    RecRef.SetTable(AdvanceSurrender);
                    AdvanceSurrender.Status := AdvanceSurrender.Status::Open;
                    AdvanceSurrender.Modify;
                    Handled := true;
                end;

            DATABASE::"G/L Account":
                begin
                    RecRef.SetTable(GLAccount);
                    GLAccount.Status := GLAccount.Status::Open;
                    GLAccount.Modify;
                    Handled := true;
                end;

            DATABASE::"HR Jobs":
                BEGIN
                    RecRef.SETTABLE(HRJobs);
                    HRJobs.Status := HRJobs.Status::New;
                    HRJobs.MODIFY;
                    //Variant := HRJobs;
                    Handled := true;
                END;

            DATABASE::"HR HMO":
                BEGIN
                    RecRef.SETTABLE(HMO);
                    HMO.Status := HMO.Status::Open;
                    HMO.MODIFY(TRUE);
                    //Variant := HMO;
                    Handled := true;
                END;

            DATABASE::prAssignEmployeeLoan:
                BEGIN
                    RecRef.SETTABLE(HREmpLoan);
                    HREmpLoan.Status := HREmpLoan.Status::Open;
                    HREmpLoan.MODIFY(TRUE);
                    //Variant := HREmpLoan;
                    Handled := true;
                END;

            DATABASE::"Hr Interview Evaluation":
                BEGIN
                    RecRef.SETTABLE(HRInterviewEval);
                    HRInterviewEval.Status := HRInterviewEval.Status::New;
                    HRInterviewEval.MODIFY(TRUE);
                    //Variant := HRInterviewEv;
                    Handled := true;
                END;

            DATABASE::"HR Leave Application":
                BEGIN
                    RecRef.SETTABLE(HRLeaveApp);
                    HRLeaveApp.Status := HRLeaveApp.Status::New;
                    HRLeaveApp.MODIFY(TRUE);
                    // Variant := HRLeaveApp;
                    Handled := true;

                END;

            DATABASE::"HR Employee Requisitions":
                BEGIN
                    RecRef.SETTABLE(HREmpReq);
                    HREmpReq.Status := HREmpReq.Status::New;
                    HREmpReq.MODIFY(TRUE);
                    //Variant := HREmpReq;
                    Handled := true;
                END;

            DATABASE::"HR Appraisal Goal Setting H":
                BEGIN
                    RecRef.SETTABLE(HRAppraisalEval);
                    HRAppraisalEval.Status := HRAppraisalEval.Status::Open;
                    HRAppraisalEval.MODIFY(TRUE);
                    // Variant := HRAppraisalEval;
                    Handled := true;
                END;

            DATABASE::"HR Training Applications":
                BEGIN
                    RecRef.SETTABLE(HRTrainingApp);
                    HRTrainingApp.Status := HRTrainingApp.Status::New;
                    HRTrainingApp.MODIFY(TRUE);
                    //Variant := HRTrainingApp;
                    Handled := true;
                END;

            DATABASE::"Hr Canteen Application":
                BEGIN
                    RecRef.SETTABLE(HRCanteenApp);
                    HRCanteenApp.Status := HRCanteenApp.Status::New;
                    HRCanteenApp.MODIFY(TRUE);
                    // Variant := HRCanteenApp;
                    Handled := true;
                END;

            DATABASE::"HR Emp. Transaction Header":
                BEGIN
                    RecRef.SETTABLE(EmpTransfer);
                    EmpTransfer.Status := EmpTransfer.Status::Open;
                    EmpTransfer.MODIFY(TRUE);
                    //Variant := EmpTransfer;
                    Handled := true;
                END;

            DATABASE::"HR Leave Acknowledgement":
                BEGIN
                    RecRef.SETTABLE(HRLeaveAck);
                    HRLeaveAck.Status := HRLeaveAck.Status::Open;
                    HRLeaveAck.MODIFY(TRUE);
                    // Variant := HRLeaveAck;
                    Handled := true;
                END;

            DATABASE::"HR Employee Confirmation":
                BEGIN
                    RecRef.SETTABLE(HREmpCon);
                    HREmpCon.Status := HREmpCon.Status::New;
                    HREmpCon.MODIFY(TRUE);
                    //Variant := HREmpCon;
                    Handled := true;
                END;

            DATABASE::"HR Employees":
                BEGIN
                    RecRef.SETTABLE(EMP);
                    EMP."Approval Status" := EMP."Approval Status"::New;
                    EMP.MODIFY(TRUE);
                    Handled := true;
                END;
            DATABASE::"Store Requisition Header":
                BEGIN
                    RecRef.SETTABLE(StoreReq);
                    StoreReq.Status := StoreReq.Status::Open;
                    StoreReq.MODIFY(TRUE);
                    //Variant :=StoreReq;
                    Handled := true;
                END;

        end;
    end;

    local procedure CancelAllApprovalRequestsCode(): Code[128]
    begin
        exit(UpperCase('CancelAllApprovalRequests'))
    end;

    local procedure CancelAllApprovalRequests(Variant: Variant; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    RecRef.Get(ApprovalEntry."Record ID to Approve");
                    CancelAllApprovalRequests(RecRef, WorkflowStepInstance);
                end;
            else
                ApprovalsMgmt.CancelApprovalRequestsForRecord(RecRef, WorkflowStepInstance);
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Voucher: Record "Voucher Header";
        StaffAdvance: Record "Staff Advance Header";
        AdvanceSurrender: Record "Staff Advance Surrender Header";
        ApprovalEntry: Record "Approval Entry";
        Variant: Variant;
        TargetRecRef: RecordRef;
        PaymentsHeader: Record "Voucher Header";
        GLAccount: Record "G/L Account";
        StaffClaim: Record "Staff Claims Header";
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
        StoreReq: Record "Store Requisition Header";
    begin
        // ReleaseDocument(Variant);
        //RecRef.GETTABLE(Variant);
        case RecRef.Number of
            DATABASE::"Voucher Header":
                begin
                    RecRef.SetTable(PaymentsHeader);
                    PaymentsHeader.Status := PaymentsHeader.Status::Released;
                    PaymentsHeader.Modify;
                    Handled := true;
                end;

            DATABASE::"Staff Advance Header":
                begin
                    RecRef.SetTable(StaffAdvance);
                    StaffAdvance.Status := StaffAdvance.Status::Approved;
                    StaffAdvance.Modify;
                    Handled := true;
                end;

            DATABASE::"Staff Advance Surrender Header":
                begin
                    RecRef.SetTable(AdvanceSurrender);
                    AdvanceSurrender.Status := AdvanceSurrender.Status::Approved;
                    AdvanceSurrender.Modify;
                    Handled := true;
                end;

            DATABASE::"G/L Account":
                begin
                    RecRef.SetTable(GLAccount);
                    GLAccount.Status := GLAccount.Status::Approved;
                    GLAccount.Modify;
                    Handled := true;
                end;

            DATABASE::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaim);
                    StaffClaim.Status := StaffClaim.Status::Approved;
                    StaffClaim.Modify;
                    Handled := true;
                end;

            DATABASE::"HR Jobs":
                BEGIN
                    RecRef.SetTable(HRJobs);
                    HRJobs.Status := HRJobs.Status::Approved;
                    HRJobs.Modify;
                    Handled := true;
                end;
            DATABASE::"HR HMO":
                BEGIN
                    RecRef.SetTable(HMO);
                    HMO.Status := HMO.Status::Approved;
                    HMO.Modify;
                    Handled := true;
                end;
            DATABASE::"prAssignEmployeeLoan":
                BEGIN
                    RecRef.SetTable(HREmpLoan);
                    HREmpLoan.Status := HREmpLoan.Status::Approved;
                    HREmpLoan.Modify;
                    Handled := true;
                end;
            DATABASE::"Hr Interview Evaluation":
                BEGIN
                    RecRef.SetTable(HRInterviewEval);
                    HRInterviewEval.Status := HRInterviewEval.Status::Approved;
                    HRInterviewEval.Modify;
                    Handled := true;
                end;
            DATABASE::"HR Leave Application":
                BEGIN
                    RecRef.SetTable(HRLeaveApp);
                    HRLeaveApp.Status := HRLeaveApp.Status::Approved;
                    HRLeaveApp.Modify;
                    Handled := true;
                end;
            DATABASE::"HR Employee Requisitions":
                BEGIN
                    RecRef.SetTable(HREmpReq);
                    HREmpReq.Status := HREmpReq.Status::Approved;
                    HREmpReq.Modify;
                    Handled := true;
                end;
            DATABASE::"HR Appraisal Goal Setting H":
                BEGIN
                    RecRef.SetTable(HRAppraisalEval);
                    HRAppraisalEval.Status := HRAppraisalEval.Status::Approved;
                    HRAppraisalEval.Modify;
                    Handled := true;
                end;
            DATABASE::"HR Training Applications":
                BEGIN
                    RecRef.SetTable(HRTrainingApp);
                    HRTrainingApp.Status := HRTrainingApp.Status::Approved;
                    HRTrainingApp.Modify;
                    Handled := true;
                end;
            DATABASE::"Hr Canteen Application":
                BEGIN
                    RecRef.SetTable(HRCanteenApp);
                    HRCanteenApp.Status := HRCanteenApp.Status::Approved;
                    HRCanteenApp.Modify;
                    Handled := true;
                end;
            DATABASE::"HR Emp. Transaction Header":
                BEGIN
                    RecRef.SetTable(EmpTransfer);
                    EmpTransfer.Status := EmpTransfer.Status::Approved;
                    EmpTransfer.Modify;
                    Handled := true;
                end;
            DATABASE::"HR Leave Acknowledgement":
                BEGIN
                    RecRef.SetTable(HRLeaveAck);
                    HRLeaveAck.Status := HRLeaveAck.Status::Approved;
                    HRLeaveAck.Modify;
                    Handled := true;
                end;

            DATABASE::"HR Employee Confirmation":
                BEGIN
                    RecRef.SetTable(HREmpCon);
                    HREmpCon.Status := HREmpCon.Status::Approved;
                    HREmpCon.Modify;
                    Handled := true;
                end;
            DATABASE::"HR Employees":
                BEGIN
                    RecRef.SetTable(EMP);
                    EMP."Approval Status" := EMP."Approval Status"::Approved;
                    EMP.Modify;
                    Handled := true;
                end;

            DATABASE::"Store Requisition Header":
                BEGIN
                    RecRef.SetTable(StoreReq);
                    StoreReq.Status := StoreReq.Status::Released;
                    StoreReq.Modify;
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        Voucher: Record "Voucher Header";
        StaffAdvance: Record "Staff Advance Header";
        AdvanceSurrender: Record "Staff Advance Surrender Header";
        GLAccount: Record "G/L Account";
        StaffClaim: Record "Staff Claims Header";

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
        StoreReq: Record "Store Requisition Header";
    begin
        RecRef.GetTable(Variant);

        case RecRef.Number of
            DATABASE::"Voucher Header":
                begin
                    RecRef.SetTable(Voucher);
                    Voucher.Status := Voucher.Status::"Pending Approval";
                    Voucher.Modify;
                    IsHandled := true;
                end;

            DATABASE::"Staff Advance Header":
                begin
                    RecRef.SetTable(StaffAdvance);
                    StaffAdvance.Status := StaffAdvance.Status::"Pending Approval";
                    StaffAdvance.Modify;
                    IsHandled := true;
                end;

            DATABASE::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaim);
                    StaffClaim.Status := StaffClaim.Status::"Pending Approval";
                    StaffClaim.Modify;
                    IsHandled := true;
                end;

            DATABASE::"Staff Advance Surrender Header":
                begin
                    RecRef.SetTable(AdvanceSurrender);
                    AdvanceSurrender.Status := AdvanceSurrender.Status::"Pending Approval";
                    AdvanceSurrender.Modify;
                    IsHandled := true;
                end;

            DATABASE::"G/L Account":
                begin
                    RecRef.SetTable(GLAccount);
                    GLAccount.Status := GLAccount.Status::"Pending Approval";
                    GLAccount.Modify;
                    IsHandled := true;
                end;

            DATABASE::"HR Jobs":
                begin
                    RecRef.SetTable(HRJobs);
                    HRJobs.Validate(Status, HRJobs.Status::"Pending Approval");
                    HRJobs.Modify(true);
                    Variant := HRJobs;
                    IsHandled := true;
                end;

            DATABASE::"HR HMO":
                begin
                    RecRef.SetTable(HMO);
                    HMO.Validate(Status, HMO.Status::"Pending Approval");
                    HMO.Modify;
                    IsHandled := true;
                end;
            DATABASE::"prAssignEmployeeLoan":
                begin
                    RecRef.SetTable(HREmpLoan);
                    HREmpLoan.Status := HREmpLoan.Status::"Pending Approval";
                    HREmpLoan.Modify;
                    IsHandled := true;
                end;
            DATABASE::"Hr Interview Evaluation":
                begin
                    RecRef.SetTable(HRInterviewEval);
                    HRInterviewEval.Status := HRInterviewEval.Status::"Pending Approval";
                    HRInterviewEval.Modify;
                    IsHandled := true;
                end;
            DATABASE::"HR Leave Application":
                begin
                    RecRef.SetTable(HRLeaveApp);
                    HRLeaveApp.Status := HRLeaveApp.Status::"Pending Approval";
                    HRLeaveApp.Modify;
                    IsHandled := true;
                end;
            DATABASE::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(HREmpReq);
                    HREmpReq.Status := HREmpReq.Status::"Pending Approval";
                    HREmpReq.Modify;
                    IsHandled := true;
                end;
            DATABASE::"HR Appraisal Goal Setting H":
                begin
                    RecRef.SetTable(HRAppraisalEval);
                    HRAppraisalEval.Status := HRAppraisalEval.Status::"Pending Approval";
                    HRAppraisalEval.Modify;
                    IsHandled := true;
                end;
            DATABASE::"HR Training Applications":
                begin
                    RecRef.SetTable(HRTrainingApp);
                    HRTrainingApp.Validate(Status, HRTrainingApp.Status::"Pending Approval");
                    HRTrainingApp.Modify;
                    IsHandled := true;
                end;
            DATABASE::"Hr Canteen Application":
                begin
                    RecRef.SetTable(HRCanteenApp);
                    HRCanteenApp.Status := HRCanteenApp.Status::"Pending Approval";
                    HRCanteenApp.Modify;
                    IsHandled := true;
                end;
            DATABASE::"HR Emp. Transaction Header":
                begin
                    RecRef.SetTable(EmpTransfer);
                    EmpTransfer.Status := EmpTransfer.Status::"Pending Approval";
                    EmpTransfer.Modify;
                    IsHandled := true;
                end;
            DATABASE::"HR Leave Acknowledgement":
                begin
                    RecRef.SetTable(HRLeaveAck);
                    HRLeaveAck.Status := HRLeaveAck.Status::"Pending Approval";
                    HRLeaveAck.Modify;
                    IsHandled := true;
                end;
            DATABASE::"HR Employee Confirmation":
                begin
                    RecRef.SetTable(HREmpCon);
                    HREmpCon.Status := HREmpCon.Status::"Pending Approval";
                    HREmpCon.Modify;
                    IsHandled := true;
                end;
            DATABASE::"HR Employees":
                begin
                    RecRef.SetTable(EMP);
                    EMP."Approval Status" := EMP."Approval Status"::"Pending Approval";
                    EMP.Modify;
                    IsHandled := true;
                end;
            DATABASE::"Store Requisition Header":
                begin
                    RecRef.SetTable(StoreReq);
                    StoreReq.Status := StoreReq.Status::"Pending Approval";
                    StoreReq.Modify;
                    IsHandled := true;
                end

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                             WorkflowEventHandlingCust.RunWorkflowOnSendVoucherForApprovalCode);
                    //staff advance
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendStaffAdvanceForApprovalCode);

                    //staff Claim
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendStaffClaimForApprovalCode);

                    //staff adv surrender
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendAdvanceSurrenderForApprovalCode);

                    //staff G/L Account  
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendGLAccountForApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
            WorkflowEventHandlingCust.RunWorkflowOnSendHRJobsForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHMOForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHREmpLoanForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHRInterviewEvalForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHRLeaveAppForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHREmpReqForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHRAppraisalEvalForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHRTrainingAppForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHRCanteenAppForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendEmpTransferForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHRLeaveAckForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHREmpConForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendEMPForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendStoreReqForApprovalCode);
                end;

            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                             WorkflowEventHandlingCust.RunWorkflowOnSendVoucherForApprovalCode);

                    //staff advance
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendStaffAdvanceForApprovalCode);
                    //Staff Claim

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                         WorkflowEventHandlingCust.RunWorkflowOnSendStaffClaimForApprovalCode);

                    //staff advance surrender
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendAdvanceSurrenderForApprovalCode);

                    //GL Account
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendGLAccountForApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                 WorkflowEventHandlingCust.RunWorkflowOnSendHRJobsForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHMOForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHREmpLoanForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHRInterviewEvalForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHRLeaveAppForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHREmpReqForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHRAppraisalEvalForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHRTrainingAppForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHRCanteenAppForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendEmpTransferForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandlingCust.RunWorkflowOnSendHRLeaveAckForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendHREmpConForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                            WorkflowEventHandlingCust.RunWorkflowOnSendEMPForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
        WorkflowEventHandlingCust.RunWorkflowOnSendStoreReqForApprovalCode);
                end;
            CancelAllApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                              WorkflowEventHandlingCust.RunWorkflowOnCanceledVoucherForApprovalCode);

                    // staff advance
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                              WorkflowEventHandlingCust.RunWorkflowOnCanceledStaffAdvanceForApprovalCode);

                    // staff Claim
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                              WorkflowEventHandlingCust.RunWorkflowOnCanceledStaffClaimForApprovalCode);


                    // staff advance surrender
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                              WorkflowEventHandlingCust.RunWorkflowOnCanceledAdvanceSurrenderForApprovalCode);

                    // G/ L Account
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                              WorkflowEventHandlingCust.RunWorkflowOnCanceledGLAccountForApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                    WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRJobsCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHMOCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHREmpLoanCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRInterviewEvalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRLeaveAppCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHREmpReqCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRAppraisalEvalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRTrainingAppCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRCanteenAppCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForEmpTransferCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRLeaveAckCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHREmpConCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForEMPCode);
                    //Store Requisition
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForStoreReqCode);
                end;

            WorkflowResponseHandling.OpenDocumentCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                              WorkflowEventHandlingCust.RunWorkflowOnCanceledVoucherForApprovalCode);
                    //staff advance
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                              WorkflowEventHandlingCust.RunWorkflowOnCanceledStaffAdvanceForApprovalCode);
                    // staff advance surrender
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                              WorkflowEventHandlingCust.RunWorkflowOnCanceledAdvanceSurrenderForApprovalCode);
                    // staff Claim
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                              WorkflowEventHandlingCust.RunWorkflowOnCanceledStaffClaimForApprovalCode);

                    // GL Account
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                              WorkflowEventHandlingCust.RunWorkflowOnCanceledGLAccountForApprovalCode);
                    //
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                     WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRJobsCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHMOCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHREmpLoanCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRInterviewEvalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRLeaveAppCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHREmpReqCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRAppraisalEvalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRTrainingAppCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRCanteenAppCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForEmpTransferCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                    WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRLeaveAckCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                  WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHREmpConCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                  WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForEMPCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                  WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForStoreReqCode);
                end;

            ReleaseDocumentCode:
                BEGIN
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.ReleaseDocumentCode, WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode);
                    WorkflowResponseHandling.AddResponsePredecessor(ReleaseDocumentCode, WorkflowEventHandling.RunWorkflowOnCustomerCreditLimitNotExceededCode);
                END;


            WorkflowResponseHandling.ReleaseDocumentCode:
                BEGIN
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.ReleaseDocumentCode, WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode);

                END;
        end;
    end;

    local procedure ReleaseDocument(var Variant: Variant)
    var
        ApprovalEntry: Record "Approval Entry";
        ReleasePurchaseDocument: Codeunit "Release Purchase Document";
        ReleaseSalesDocument: Codeunit "Release Sales Document";
        ReleaseIncomingDocument: Codeunit "Release Incoming Document";
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        PaymentsHeader: Record "Voucher Header";
        StaffAdv: Record "Staff Advance Header";
        StaffAdvanceSurrenderHeader: Record "Staff Advance Surrender Header";
        GLAccount: Record "G/L Account";
        StaffClaim: Record "Staff Claims Header";
        StoreReq: Record "Store Requisition Header";
        HrJobs: Record "HR Jobs";
        Emp: Record "HR Employees";
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
    //EMP: Record "HR Employees";


    begin
        RecRef.GetTable(Variant);

        case RecRef.Number of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseDocument(Variant);
                end;
            DATABASE::"Purchase Header":
                ReleasePurchaseDocument.PerformManualRelease(Variant);
            DATABASE::"Sales Header":
                ReleaseSalesDocument.PerformManualRelease(Variant);
            //DATABASE::"Incoming Document":
            //  ReleaseIncomingDocument.PerformManualRelease(Variant);
            //Custom Approvals
            //JV Header

            //JV Header
            //Staff Advance
            DATABASE::"Staff Advance Header":
                begin
                    StaffAdv := Variant;
                    with StaffAdv do begin
                        if Status = Status::Approved then
                            exit;
                        Status := Status::Approved;
                        Modify(true);
                    end;
                end;

            //Staff Claims
            DATABASE::"Staff Claims Header":
                begin
                    StaffClaim := Variant;
                    with StaffClaim do begin
                        if Status = Status::Approved then
                            exit;
                        Status := Status::Approved;
                        Modify(true);
                    end;
                end;

            //Payments Document
            DATABASE::"Voucher Header":
                begin
                    PaymentsHeader := Variant;
                    with PaymentsHeader do begin
                        if Status = Status::Released then
                            exit;
                        Status := Status::Released;
                        Modify(true);
                    end;
                end;

            // Requisition
            //Staff Advance Retirement
            DATABASE::"Staff Advance Surrender Header":
                begin
                    StaffAdvanceSurrenderHeader := Variant;
                    with StaffAdvanceSurrenderHeader do begin
                        if Status = Status::Approved then
                            exit;
                        Status := Status::Approved;
                        Modify(true);
                    end;
                end;

            //G/L account workflow
            DATABASE::"G/L Account":
                begin
                    GLAccount := Variant;
                    with GLAccount do begin
                        if Status = Status::Approved then
                            exit;
                        Status := Status::Approved;
                        Modify(true);
                    end;
                end;

            DATABASE::"HR Employees":
                begin
                    Emp := Variant;
                    with Emp do begin
                        if "Approval Status" = "Approval Status"::Approved then
                            exit;
                        "Approval Status" := "Approval Status"::Approved;
                        Modify(true);
                    end;
                end;

            //Store Requisition
            DATABASE::"Store Requisition Header":
                begin
                    StoreReq := Variant;
                    with StoreReq do begin
                        if Status = Status::Released then
                            exit;
                        Status := Status::Released;
                        Modify(true);
                    end;
                end;
            //
            // /HR Jobs
            DATABASE::"Hr Jobs":
                begin
                    HRJobs := Variant;
                    with HRJobs do begin
                        if Status = Status::Approved then
                            exit;
                        Status := Status::Approved;
                        Modify(true);
                    end;
                end;
            DATABASE::"HR Training Applications":
                begin
                    HRTrainingApp := Variant;
                    with HRTrainingApp do begin
                        if Status = Status::Approved then
                            exit;
                        Status := Status::Approved;
                        Modify(true);
                    end;
                end;

            //

            //Custom Approvals
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;

    local procedure ReleaseDocumentCode(): Code[128]
    begin
        exit(UpperCase('OnReleaseDocument'))
    end;
}

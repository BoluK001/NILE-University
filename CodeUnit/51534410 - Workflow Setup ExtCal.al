codeunit 51534410 "Workflow Setup ExtCal"
{

    trigger OnRun()
    begin
    end;

    var
        WorkflowSetup: Codeunit "Workflow Setup";
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        NoworkflowEnabledErr: Label 'No approval workflow for this record type is enabled';
        PaymentWorkflowCategoryDescTxt: Label 'Voucher Documents';
        PaymentWorkflowCategoryTxt: Label 'VOUCHERDOC';
        PaymentApprWorkflowCodeTxt: Label 'VIW';
        //BRV
        BRVApprWorkflowCodeTxt: Label 'BRVAppro Work';
        BRVWorkflowCategoryDescTxt: Label 'BRV Approval Workflow';
        //BPV
        BPVApprWorkflowCodeTxt: Label 'BPVAppro Work';
        BPVWorkflowCategoryDescTxt: Label 'BPV Approval Workflow';
        //CPV
        CPVApprWorkflowCodeTxt: Label 'CPVAppro Work';
        CPVWorkflowCategoryDescTxt: Label 'CPv Approval Workflow';
        //CRV
        CRVApprWorkflowCodeTxt: Label 'CRV Approval Work';
        CRVWorkflowCategoryDescTxt: Label 'CRV Approval Workflow';
        //PettyCash
        PettyCashApprWorkflowCodeTxt: Label 'PettyCash';
        PettyCashWorkflowCategoryDescTxt: Label 'PettyCash Approval WorkfloW';
        //JV
        JVApprWorkflowCodeTxt: Label 'JVA pproval Work';
        JVWorkflowCategoryDescTxt: Label 'JV App. Workflow';
        PaymentTypeCondnTxt: Label 'Voucher Approval Workflow Type';
        VoucherTypeCondnTxt: Label 'Voucher Approval Workflow Type';
        StaffAdvanceWorkflowCategoryDescTxt: Label 'StaffAdvance Document';
        StaffAdvanceWorkflowCategoryTxt: Label 'StaffAdvance Doc';
        StaffAdvanceApprWorkflowCodeTxt: Label 'StaffAdv AppWork';
        StaffAdvanceTypeCondnTxt: Label 'StaffAdvance Approval Workflow Type';
        //
        StoreReqWorkflowCategoryTxt: Label 'StoreReq Doc';
        StoreReqApprWorkflowCodeTxt: Label 'StoreReqWorkflow';
        StoreReqTypeCondnTxt: Label 'StoreReqApproval Workflow Type';

        //ItemJnlBatchWorkflowCategoryTxt: Label 'ItemJnlBatch Doc';
        //ItemJnlBatchApprWorkflowCodeTxt: Label 'ItemJnlBatchWorkflow';
        //ItemJnlBatchTypeCondnTxt: Label 'ItemJnlBatchApproval Workflow Type';

        HRJobsWorkflowCategoryTxt: Label 'HRJobs Doc';
        HRJobsApprWorkflowCodeTxt: Label 'HRJobsWorkflow';
        HRJobsTypeCondnTxt: Label 'HRJobsApproval Workflow Type';

        HMOWorkflowCategoryTxt: Label 'HMO Doc';
        HMOApprWorkflowCodeTxt: Label 'HMOWorkflow';
        HMOTypeCondnTxt: Label 'HMOApproval Workflow Type';

        HREmpLoanWorkflowCategoryTxt: Label 'HREmpLoan Doc';
        HREmpLoanApprWorkflowCodeTxt: Label 'HREmpLoanWorkflow';
        HREmpLoanTypeCondnTxt: Label 'HREmpLoanApproval Workflow Type';

        HRInterviewEvalWorkflowCategoryTxt: Label 'HRInterviewEval Doc';
        HRInterviewEvalApprWorkflowCodeTxt: Label 'HRInterviewEvalWorkflow';
        HRInterviewEvalTypeCondnTxt: Label 'HRInterviewEvalApproval Workflow Type';

        HRLeaveAppWorkflowCategoryTxt: Label 'HRLeaveApp Doc';
        HRLeaveAppApprWorkflowCodeTxt: Label 'HRLeaveAppWorkflow';
        HRLeaveAppTypeCondnTxt: Label 'HRLeaveAppApproval Workflow Type';

        HREmpReqWorkflowCategoryTxt: Label 'HREmpReq Doc';
        HREmpReqApprWorkflowCodeTxt: Label 'HREmpReqWorkflow';
        HREmpReqTypeCondnTxt: Label 'HREmpReqApproval Workflow Type';

        HRAppraisalEvWorkflowCategoryTxt: Label 'HRAppraisalEv Doc';
        HRAppraisalEvApprWorkflowCodeTxt: Label 'HRAppraisalEvWorkflow';
        HRAppraisalEvTypeCondnTxt: Label 'HRAppraisalEvApproval Workflow Type';

        HRTrainingWorkflowCategoryTxt: Label 'HRTraining Doc';
        HRTrainingApprWorkflowCodeTxt: Label 'HRTrainingWorkflow';
        HRTrainingTypeCondnTxt: Label 'HRTrainingApproval Workflow Type';

        HRCanteenAppWorkflowCategoryTxt: Label 'HRCanteenApp Doc';
        HRCanteenAppApprWorkflowCodeTxt: Label 'HRCanteenAppWorkflow';
        HRCanteenAppTypeCondnTxt: Label 'HRCanteenAppApproval Workflow Type';

        EmpTransferWorkflowCategoryTxt: Label 'EmpTransfer Doc';
        EmpTransferApprWorkflowCodeTxt: Label 'EmpTransferWorkflow';
        EmpTransferTypeCondnTxt: Label 'EmpTransferApproval Workflow Type';

        HRLeaveAckWorkflowCategoryTxt: Label 'HRLeaveAck Doc';
        HRLeaveAckApprWorkflowCodeTxt: Label 'HRLeaveAckWorkflow';
        HRLeaveAckTypeCondnTxt: Label 'HRLeaveAckApproval Workflow Type';

        HREmpConWorkflowCategoryTxt: Label 'HREmpCon Doc';
        HREmpConApprWorkflowCodeTxt: Label 'HREmpConWorkflow';
        HREmpConTypeCondnTxt: Label 'HREmpConApproval Workflow Type';

        EMPWorkflowCategoryTxt: Label 'EMP Doc';
        EMPApprWorkflowCodeTxt: Label 'EMPWorkflow';
        EMPTypeCondnTxt: Label 'EMPApproval Workflow Type';

        BankAcctUpHeaderWorkflowCategoryTxt: Label 'BankAcctUpHeader Doc';
        BankAcctUpHeaderApprWorkflowCodeTxt: Label 'BankAcctUpHeaderWorkflow';
        BankAcctUpHeaderTypeCondnTxt: Label 'BankAcctUpHeaderApproval Workflow Type';

        RSAModificationFormWorkflowCategoryTxt: Label 'RSA Modification Form Doc';
        RSAModFormApprWorkflowCodeTxt: Label 'RSA Modification FormWorkflow';
        RSAModTypeCondnTxt: Label 'RSA Modification FormApproval Workflow Type';

        FundMovWorkflowCategoryTxt: Label 'Fund Movement Card Doc';
        FundMovApprWorkflowCodeTxt: Label 'Fund Movement CardWorkflow';
        FundMovTypeCondnTxt: Label 'Fund Movement CardApproval Workflow Type';

        LCHWorkflowCategoryTxt: Label 'Ledger Correction Header Doc';
        LCHApprWorkflowCodeTxt: Label 'Ledger Correction HeaderWorkflow';
        LCHTypeCondnTxt: Label 'Ledger Correction HeaderApproval Workflow Type';

        LienRemovalWorkflowCategoryTxt: Label 'Lien Removal Doc';
        LienRemovalApprWorkflowCodeTxt: Label 'Lien RemovalWorkflow';
        LienRemovalTypeCondnTxt: Label 'Lien RemovalApproval Workflow Type';

        //
        AdvanceSurrenderWorkflowCategoryDescTxt: Label 'Retirement';
        AdvanceSurrenderWorkflowCategoryTxt: Label 'Retirement Document';
        AdvanceSurrenderApprWorkflowCodeTxt: Label 'AdvanSurApp Work';
        AdvanceSurrenderTypeCondnTxt: Label 'AdvanceSurrender Approval Workflow Type';
        GLAccountWorkflowCategoryDescTxt: Label 'GL Account';
        GLAccountWorkflowCategoryTxt: Label 'GL Account';
        GLAccountApprWorkflowCodeTxt: Label 'GLAcc Appro Work';
        GLAccountTypeCondnTxt: Label 'GL Account Approval Workflow Type';
        StaffClaimWorkflowCategoryDescTxt: Label 'StaffClaim';
        StaffClaimWorkflowCategoryTxt: Label 'StaffClaim';
        StaffClaimApprWorkflowCodeTxt: Label 'StaffClaiApp Work';
        StaffClaimTypeCondnTxt: Label 'StaffClaim Approval Workflow Type';

        StoreReqWorkflowCategoryDescTxt: Label 'StoreReqDocument';
        //ItemJnlBatchWorkflowCategoryDescTxt: Label 'ItemJnlBatchDocument';
        HRJobsWorkflowCategoryDescTxt: Label 'HRJobsDocument';
        HMOWorkflowCategoryDescTxt: Label 'HMODocument';
        HREmpLoanWorkflowCategoryDescTxt: Label 'HREmpLoanDocument';
        HRInterviewEvalWorkflowCategoryDescTxt: Label 'HRInterviewEvalDocument';
        HRLeaveAppWorkflowCategoryDescTxt: Label 'HRLeaveAppDocument';
        HREmpReqWorkflowCategoryDescTxt: Label 'HREmpReqDocument';
        HRAppraisalEvWorkflowCategoryDescTxt: Label 'HRAppraisalEvDocument';
        HRTrainingWorkflowCategoryDescTxt: Label 'HRTrainingDocument';
        HRCanteenAppWorkflowCategoryDescTxt: Label 'HRCanteenAppDocument';
        EmpTransferWorkflowCategoryDescTxt: Label 'EmpTransferDocument';
        HRLeaveAckWorkflowCategoryDescTxt: Label 'HRLeaveAckDocument';
        HREmpConWorkflowCategoryDescTxt: Label 'HREmpConDocument';
        EMPWorkflowCategoryDescTxt: Label 'EMPDocument';
        BankAcctUpHeaderWorkflowCategoryDescTxt: Label 'BankAcctUpHeaderDocument';


    [EventSubscriber(ObjectType::Codeunit, 1502, 'OnAddWorkflowCategoriesToLibrary', '', false, false)]
    local procedure OnAddWorkflowCategoriesToLibrary()
    begin
        WorkflowSetup.InsertWorkflowCategory(PaymentWorkflowCategoryTxt, PaymentWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(GLAccountWorkflowCategoryTxt, GLAccountWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(StaffClaimWorkflowCategoryTxt, StaffClaimWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(StaffAdvanceWorkflowCategoryTxt, StaffAdvanceWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(AdvanceSurrenderWorkflowCategoryTxt, AdvanceSurrenderWorkflowCategoryDescTxt);

        //WorkflowSetup.InsertWorkflowCategory(JVWorkflowCategoryTxt, JVWorkflowCategoryDescTxt);
        //WorkflowSetup.InsertWorkflowCategory(PaymentVoucherWorkflowCategoryTxt, PaymentVoucherWorkflowCategoryDescTxt);
        //WorkflowSetup.InsertWorkflowCategory(interbankTransferWorkflowCategoryTxt, interbankTransferWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(StoreReqWorkflowCategoryTxt, StoreReqWorkflowCategoryDescTxt);
        //WorkflowSetup.InsertWorkflowCategory(ItemJnlBatchWorkflowCategoryTxt, ItemJnlBatchWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(HRJobsWorkflowCategoryTxt, HRJobsWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(HMOWorkflowCategoryTxt, HMOWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(HREmpLoanWorkflowCategoryTxt, HREmpLoanWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(HRInterviewEvalWorkflowCategoryTxt, HRInterviewEvalWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(HRLeaveAppWorkflowCategoryTxt, HRLeaveAppWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(HREmpReqWorkflowCategoryTxt, HREmpReqWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(HRAppraisalEvWorkflowCategoryTxt, HRAppraisalEvWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(HRTrainingWorkflowCategoryTxt, HRTrainingWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(HRCanteenAppWorkflowCategoryTxt, HRCanteenAppWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(EmpTransferWorkflowCategoryTxt, EmpTransferWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(HRLeaveAckWorkflowCategoryTxt, HRLeaveAckWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(HREmpConWorkflowCategoryTxt, HREmpConWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(EMPWorkflowCategoryTxt, EMPWorkflowCategoryDescTxt);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1502, 'OnAfterInsertApprovalsTableRelations', '', false, false)]
    local procedure OnAfterInsertApprovalsTableRelations()
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Voucher Header", 0, DATABASE::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"Staff Advance Header", 0, DATABASE::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"Staff Advance Surrender Header", 0, DATABASE::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"G/L Account", 0, DATABASE::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"Staff Claims Header", 0, DATABASE::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
        // WorkflowSetup.InsertTableRelation(DATABASE::Lease, 0, DATABASE::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));


        //InsertTableRelation(DATABASE::"JV Header", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        //InsertTableRelation(DATABASE::"Payments Header", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        //InsertTableRelation(DATABASE::"InterBank Transfers", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"Staff Claims Header", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"Staff Advance Header", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"Staff Advance Surrender Header", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"Store Requisition Header", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"Item Journal Batch", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"HR Jobs", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"HR HMO", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"prAssignEmployeeLoan", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"Hr Interview Evaluation", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"HR Leave Application", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"HR Employee Requisitions", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"HR Appraisal Goal Setting H", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"HR Training Applications", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"Hr Canteen Application", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"HR Emp. Transaction Header", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"HR Leave Acknowledgement", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        //InsertTableRelation(DATABASE::"PFA Cust. All. Modification", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        //InsertTableRelation(DATABASE::"PFA Transfer Header Payout", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"HR Employee Confirmation", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(DATABASE::"HR Employees", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        //InsertTableRelation(DATABASE::"FA Budget Entry Transfer", 0, DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
    end;
    //payement workflow begin
    local procedure InsertPaymentApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, PaymentApprWorkflowCodeTxt, PaymentWorkflowCategoryDescTxt, PaymentWorkflowCategoryTxt);
        InsertPaymentApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertPaymentApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        //Voucher: Record "Voucher Header";
        VoucherLine: Record "Voucher Line";
        VoucherHeader: Record "Voucher Header";
    begin
        //
        WorkflowSetup.InsertTableRelation(DATABASE::"Voucher Header", VoucherHeader.FIELDNO("Voucher Type"),
          DATABASE::"Voucher Line", VoucherLine.FIELDNO("Voucher Type"));
        WorkflowSetup.InsertTableRelation(DATABASE::"Voucher Header", VoucherHeader.FIELDNO("No."),
          DATABASE::"Voucher Line", VoucherLine.FIELDNO("Document No."));
        //
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildPaymentTypeConditions(VoucherHeader.Status::Open),
            WorkflowEventHandlingCust.RunWorkflowOnSendVoucherForApprovalCode,
            BuildPaymentTypeConditions(VoucherHeader.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCanceledVoucherForApprovalCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildPaymentTypeConditions(Status: Integer): Text
    var
        Voucher: Record "Voucher Header";
    begin
        Voucher.SetRange(Status, Status);
        exit(StrSubstNo(PaymentTypeCondnTxt, WorkflowSetup.Encode(Voucher.GetView(false))));
    end;

    //HR Jobs
    local procedure InsertHRJobsApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, HRJobsApprWorkflowCodeTxt, HRJobsWorkflowCategoryDescTxt, HRJobsWorkflowCategoryTxt);
        InsertHRJobsApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertHRJobsApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        HRJobs: Record "HR Jobs";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildHRJobsTypeConditions(HRJobs.Status::New),
            WorkflowEventHandlingCust.RunWorkflowOnSendHRJobsForApprovalCode,
            BuildHRJobsTypeConditions(HRJobs.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRJobsCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildHRJobsTypeConditions(Status: Integer): Text
    var
        HRJobs: Record "HR Jobs";
    begin
        HRJobs.SetRange(Status, Status);
        exit(StrSubstNo(HRJobsTypeCondnTxt, WorkflowSetup.Encode(HRJobs.GetView(false))));
    end;
    //HR Jobs End


    //Store Requisition
    local procedure InsertStoreReqApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, StoreReqApprWorkflowCodeTxt, StoreReqWorkflowCategoryDescTxt, StoreReqWorkflowCategoryTxt);
        InsertStoreReqApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertStoreReqApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        StoreReq: Record "Store Requisition Header";
    begin
        WorkflowSetup.InitWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildStoreReqTypeConditions(StoreReq.Status::Open),
            WorkflowEventHandlingCust.RunWorkflowOnSendStoreReqForApprovalCode,
            BuildStoreReqTypeConditions(StoreReq.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForStoreReqCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildStoreReqTypeConditions(Status: Integer): Text
    var
        StoreReq: Record "Store Requisition Header";
    begin
        StoreReq.SetRange(Status, Status);
        exit(StrSubstNo(StoreReqTypeCondnTxt, WorkflowSetup.Encode(StoreReq.GetView(false))));
    end;
    //Store Requisition End

    //Loan Start
    local procedure InsertHREmpLoanApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, HREmpLoanApprWorkflowCodeTxt, HREmpLoanWorkflowCategoryDescTxt, HREmpLoanWorkflowCategoryTxt);
        InsertHREmpLoanApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertHREmpLoanApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        HREmpLoan: Record prAssignEmployeeLoan;
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildHREmpLoanTypeConditions(HREmpLoan.Status::Open),
            WorkflowEventHandlingCust.RunWorkflowOnSendHREmpLoanForApprovalCode,
            BuildHREmpLoanTypeConditions(HREmpLoan.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHREmpLoanCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildHREmpLoanTypeConditions(Status: Integer): Text
    var
        HREmpLoan: Record prAssignEmployeeLoan;
    begin
        HREmpLoan.SetRange(Status, Status);
        exit(StrSubstNo(HREmpLoanTypeCondnTxt, WorkflowSetup.Encode(HREmpLoan.GetView(false))));
    end;
    //Loan Ends

    //HR HMO Start

    local procedure InsertHMOApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, HMOApprWorkflowCodeTxt, HMOWorkflowCategoryDescTxt, HMOWorkflowCategoryTxt);
        InsertHMOApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertHMOApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        HMO: Record "HR HMO";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildHMOTypeConditions(HMO.Status::Open),
            WorkflowEventHandlingCust.RunWorkflowOnSendHMOForApprovalCode,
            BuildHMOTypeConditions(HMO.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHMOCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildHMOTypeConditions(Status: Integer): Text
    var
        HMO: Record "HR HMO";
    begin
        HMO.SetRange(Status, Status);
        exit(StrSubstNo(HMOTypeCondnTxt, WorkflowSetup.Encode(HMO.GetView(false))));
    end;
    //HR HMO End

    //HR Interview Evaluation Start

    local procedure InsertHRInterviewEvalApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, HRInterviewEvalApprWorkflowCodeTxt, HRInterviewEvalWorkflowCategoryDescTxt, HRInterviewEvalWorkflowCategoryTxt);
        InsertHRInterviewEvalApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertHRInterviewEvalApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        HRInterviewEval: Record "Hr Interview Evaluation";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildHRInterviewEvalTypeConditions(HRInterviewEval.Status::New),
            WorkflowEventHandlingCust.RunWorkflowOnSendHRInterviewEvalForApprovalCode,
            BuildHRInterviewEvalTypeConditions(HRInterviewEval.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRInterviewEvalCode(),
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildHRInterviewEvalTypeConditions(Status: Integer): Text
    var
        HRInterviewEval: Record "Hr Interview Evaluation";
    begin
        HRInterviewEval.SetRange(Status, Status);
        exit(StrSubstNo(HRInterviewEvalTypeCondnTxt, WorkflowSetup.Encode(HRInterviewEval.GetView(false))));
    end;
    // HR Interview Evaluation End

    //HR Leave Application Start

    local procedure InsertHRLeaveAppApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, HRLeaveAppApprWorkflowCodeTxt, HRLeaveAppWorkflowCategoryDescTxt, HRLeaveAppWorkflowCategoryTxt);
        InsertHRLeaveAppApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertHRLeaveAppApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        HRLeaveApp: Record "HR Leave Application";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildHRLeaveAppTypeConditions(HRLeaveApp.Status::New),
            WorkflowEventHandlingCust.RunWorkflowOnSendHRLeaveAppForApprovalCode,
            BuildHRLeaveAppTypeConditions(HRLeaveApp.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRLeaveAppCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildHRLeaveAppTypeConditions(Status: Integer): Text
    var
        HRLeaveApp: Record "HR Leave Application";
    begin
        HRLeaveApp.SetRange(Status, Status);
        exit(StrSubstNo(HRLeaveAppTypeCondnTxt, WorkflowSetup.Encode(HRLeaveApp.GetView(false))));
    end;
    //HR Leave Application End

    //HR Employee Requisition

    local procedure InsertHREmpReqApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, HREmpReqApprWorkflowCodeTxt, HREmpReqWorkflowCategoryDescTxt, HREmpReqWorkflowCategoryTxt);
        InsertHREmpReqApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertHREmpReqApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        HREmpReq: Record "HR Employee Requisitions";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildHREmpReqTypeConditions(HREmpReq.Status::New),
            WorkflowEventHandlingCust.RunWorkflowOnSendHREmpReqForApprovalCode,
            BuildHREmpReqTypeConditions(HREmpReq.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHREmpReqCode(),
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildHREmpReqTypeConditions(Status: Integer): Text
    var
        HREmpReq: Record "HR Employee Requisitions";
    begin
        HREmpReq.SetRange(Status, Status);
        exit(StrSubstNo(HREmpReqTypeCondnTxt, WorkflowSetup.Encode(HREmpReq.GetView(false))));
    end;
    //HR Employee Requisition End

    // HR Appraisal Goal Settings Start

    local procedure InsertHRAppraisalEvApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, HRAppraisalEvApprWorkflowCodeTxt, HRAppraisalEvWorkflowCategoryDescTxt, HRAppraisalEvWorkflowCategoryTxt);
        InsertHRAppraisalEvApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertHRAppraisalEvApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        HRAppraisalEv: Record "HR Appraisal Goal Setting H";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildHRAppraisalEvTypeConditions(HRAppraisalEv.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnSendHRAppraisalEvalForApprovalCode,
            BuildHRAppraisalEvTypeConditions(HRAppraisalEv.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRAppraisalEvalCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildHRAppraisalEvTypeConditions(Status: Integer): Text
    var
        HRAppraisalEv: Record "HR Appraisal Goal Setting H";
    begin
        HRAppraisalEv.SetRange(Status, Status);
        exit(StrSubstNo(HRAppraisalEvTypeCondnTxt, WorkflowSetup.Encode(HRAppraisalEv.GetView(false))));
    end;
    //HR Appraisal Goal Settings End

    //HR Training Application Start

    local procedure InsertHRTrainingApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, HRTrainingApprWorkflowCodeTxt, HRTrainingWorkflowCategoryDescTxt, HRTrainingWorkflowCategoryTxt);
        InsertHRTrainingApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertHRTrainingApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        HRTraining: Record "HR Training Applications";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildHRTrainingTypeConditions(HRTraining.Status::New),
            WorkflowEventHandlingCust.RunWorkflowOnSendHRTrainingAppForApprovalCode,
            BuildHRTrainingTypeConditions(HRTraining.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRTrainingAppCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildHRTrainingTypeConditions(Status: Integer): Text
    var
        HRTraining: Record "HR Training Applications";
    begin
        HRTraining.SetRange(Status, Status);
        exit(StrSubstNo(HRTrainingTypeCondnTxt, WorkflowSetup.Encode(HRTraining.GetView(false))));
    end;
    //HR Training Application Ends

    //HR Canteen Application Start

    local procedure InsertHRCanteenAppApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, HRCanteenAppApprWorkflowCodeTxt, HRCanteenAppWorkflowCategoryDescTxt, HRCanteenAppWorkflowCategoryTxt);
        InsertHRCanteenAppApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertHRCanteenAppApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        HRCanteenApp: Record "Hr Canteen Application";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildHRCanteenAppTypeConditions(HRCanteenApp.Status::New),
            WorkflowEventHandlingCust.RunWorkflowOnSendHRCanteenAppForApprovalCode,
            BuildHRCanteenAppTypeConditions(HRCanteenApp.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRCanteenAppCode(),
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildHRCanteenAppTypeConditions(Status: Integer): Text
    var
        HRCanteenApp: Record "Hr Canteen Application";
    begin
        HRCanteenApp.SetRange(Status, Status);
        exit(StrSubstNo(HRCanteenAppTypeCondnTxt, WorkflowSetup.Encode(HRCanteenApp.GetView(false))));
    end;
    //HR Canteen Application End

    //HR Emp. Transaction Header Start

    local procedure InsertEmpTransferApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, EmpTransferApprWorkflowCodeTxt, EmpTransferWorkflowCategoryDescTxt, EmpTransferWorkflowCategoryTxt);
        InsertEmpTransferApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertEmpTransferApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        EmpTransfer: Record "HR Emp. Transaction Header";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildEmpTransferTypeConditions(EmpTransfer.Status::Open),
            WorkflowEventHandlingCust.RunWorkflowOnSendEmpTransferForApprovalCode,
            BuildEmpTransferTypeConditions(EmpTransfer.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForEmpTransferCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildEmpTransferTypeConditions(Status: Integer): Text
    var
        EmpTransfer: Record "HR Emp. Transaction Header";
    begin
        EmpTransfer.SetRange(Status, Status);
        exit(StrSubstNo(EmpTransferTypeCondnTxt, WorkflowSetup.Encode(EmpTransfer.GetView(false))));
    end;
    //HR Emp. Transaction Header End

    //HR Leave Acknowledgement Start

    local procedure InsertHRLeaveAckApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, HRLeaveAckApprWorkflowCodeTxt, HRLeaveAckWorkflowCategoryDescTxt, HRLeaveAckWorkflowCategoryTxt);
        InsertHRLeaveAckApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertHRLeaveAckApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        HRLeaveAck: Record "HR Leave Acknowledgement";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildHRLeaveAckTypeConditions(HRLeaveAck.Status::Open),
            WorkflowEventHandlingCust.RunWorkflowOnSendHRLeaveAckForApprovalCode,
            BuildHRLeaveAckTypeConditions(HRLeaveAck.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHRLeaveAckCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildHRLeaveAckTypeConditions(Status: Integer): Text
    var
        HRLeaveAck: Record "HR Leave Acknowledgement";
    begin
        HRLeaveAck.SetRange(Status, Status);
        exit(StrSubstNo(HRLeaveAckTypeCondnTxt, WorkflowSetup.Encode(HRLeaveAck.GetView(false))));
    end;
    //HR Leave Acknowledgement End

    //HR Employee Confirmation Start

    local procedure InsertHREmpConApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, HREmpConApprWorkflowCodeTxt, HREmpConWorkflowCategoryDescTxt, HREmpConWorkflowCategoryTxt);
        InsertHREmpConApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertHREmpConApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        HREmpCon: Record "HR Employee Confirmation";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildHREmpConTypeConditions(HREmpCon.Status::New),
            WorkflowEventHandlingCust.RunWorkflowOnSendHREmpConForApprovalCode,
            BuildHREmpConTypeConditions(HREmpCon.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForHREmpConCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildHREmpConTypeConditions(Status: Integer): Text
    var
        HREmpCon: Record "HR Employee Confirmation";
    begin
        HREmpCon.SetRange(Status, Status);
        exit(StrSubstNo(HREmpConTypeCondnTxt, WorkflowSetup.Encode(HREmpCon.GetView(false))));
    end;
    //HR Employee Confirmation End

    //HR Employees Approval Starts

    local procedure InsertEMPApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, EMPApprWorkflowCodeTxt, EMPWorkflowCategoryDescTxt, EMPWorkflowCategoryTxt);
        InsertEMPApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertEMPApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        EMP: Record "HR Employees";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildEMPTypeConditions(EMP."Approval Status"::New),
            WorkflowEventHandlingCust.RunWorkflowOnSendEMPForApprovalCode,
            BuildEMPTypeConditions(EMP."Approval Status"::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCancelApprovalRequestForEMPCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildEMPTypeConditions(Status: Integer): Text
    var
        EMP: Record "HR Employees";
    begin
        EMP.SetRange(Status, Status);
        exit(StrSubstNo(EMPTypeCondnTxt, WorkflowSetup.Encode(EMP.GetView(false))));
    end;
    //HR  Employee Approval Ends

    //Staff Advance Starts
    local procedure InsertStaffAdvanceApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, StaffAdvanceApprWorkflowCodeTxt, StaffAdvanceWorkflowCategoryDescTxt, StaffAdvanceWorkflowCategoryTxt);
        InsertStaffAdvanceApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertStaffAdvanceApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        //Voucher: Record "Voucher Header";
        StaffAdvance: Record "Staff Advance Header";
    //AdvanceSurrender: Record "Staff Advance Surrender Header";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildStaffAdvanceTypeConditions(StaffAdvance.Status::Open),
            WorkflowEventHandlingCust.RunWorkflowOnSendStaffAdvanceForApprovalCode,
            BuildStaffAdvanceTypeConditions(StaffAdvance.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCanceledStaffAdvanceForApprovalCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildStaffAdvanceTypeConditions(Status: Integer): Text
    var
        StaffAdvance: Record "Staff Advance Header";
    begin
        StaffAdvance.SetRange(Status, Status);
        exit(StrSubstNo(StaffAdvanceTypeCondnTxt, WorkflowSetup.Encode(StaffAdvance.GetView(false))));
    end;
    //Staff advance workflow end

    //Advance surrender workflow begin
    local procedure InsertAdvanceSurrenderApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, AdvanceSurrenderApprWorkflowCodeTxt, AdvanceSurrenderWorkflowCategoryDescTxt, AdvanceSurrenderWorkflowCategoryTxt);
        InsertAdvanceSurrenderApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertAdvanceSurrenderApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        Voucher: Record "Voucher Header";
        StaffAdvance: Record "Staff Advance Header";
        AdvanceSurrender: Record "Staff Advance Surrender Header";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildAdvanceSurrenderTypeConditions(AdvanceSurrender.Status::Open),
            WorkflowEventHandlingCust.RunWorkflowOnSendAdvanceSurrenderForApprovalCode,
            BuildAdvanceSurrenderTypeConditions(Voucher.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCanceledAdvanceSurrenderForApprovalCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildAdvanceSurrenderTypeConditions(Status: Integer): Text
    var
        AdvanceSurrender: Record "Staff Advance Surrender Header";
    begin
        AdvanceSurrender.SetRange(Status, Status);
        exit(StrSubstNo(AdvanceSurrenderTypeCondnTxt, WorkflowSetup.Encode(AdvanceSurrender.GetView(false))));
    end;
    //Advance surrender workflow end


    //GLAccount worflow begin
    local procedure InsertGLAccountApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, GLAccountApprWorkflowCodeTxt, GLAccountWorkflowCategoryDescTxt, GLAccountWorkflowCategoryTxt);
        InsertGLAccountApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertGLAccountApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        Voucher: Record "Voucher Header";
        StaffAdvance: Record "Staff Advance Header";
        AdvanceSurrender: Record "Staff Advance Surrender Header";
        GLAccount: Record "G/L Account";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildGLAccountTypeConditions(GLAccount.Status::Open),
            WorkflowEventHandlingCust.RunWorkflowOnSendGLAccountForApprovalCode,
            BuildGLAccountTypeConditions(GLAccount.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCanceledGLAccountForApprovalCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildGLAccountTypeConditions(Status: Integer): Text
    var
        GLAccount: Record "G/L Account";
    begin
        GLAccount.SetRange(Status, Status);
        exit(StrSubstNo(GLAccountTypeCondnTxt, WorkflowSetup.Encode(GLAccount.GetView(false))));
    end;
    //GLAccount worflow End

    //StaffClaim worflow begin
    local procedure InsertStaffClaimApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, StaffClaimApprWorkflowCodeTxt, StaffClaimWorkflowCategoryDescTxt, StaffClaimWorkflowCategoryTxt);
        InsertStaffClaimApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertStaffClaimApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "Workflow Event Handling ExtCal";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        Voucher: Record "Voucher Header";
        StaffAdvance: Record "Staff Advance Header";
        AdvanceSurrender: Record "Staff Advance Surrender Header";
        //GLAccount: Record "G/L Account";
        StaffClaim: Record "Staff Claims Header";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
                   WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
                    0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildStaffClaimTypeConditions(StaffClaim.Status::Open),
            WorkflowEventHandlingCust.RunWorkflowOnSendStaffClaimForApprovalCode,
            BuildStaffClaimTypeConditions(StaffClaim.Status::"Pending Approval"),
            WorkflowEventHandlingCust.RunWorkflowOnCanceledStaffClaimForApprovalCode,
            WorkflowStepArgument,
        true);
    end;

    local procedure BuildStaffClaimTypeConditions(Status: Integer): Text
    var
        StaffClaim: Record "Staff Claims Header";
    begin
        StaffClaim.SetRange(Status, Status);
        exit(StrSubstNo(StaffClaimTypeCondnTxt, WorkflowSetup.Encode(StaffClaim.GetView(false))));
    end;
    //

}


codeunit 51534408 "Workflow Event Handling ExtCal"
{

    trigger OnRun()
    begin
    end;

    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        VoucherHeaderSendForApprovalEventDescTxt: Label 'Approval of a Voucher document is requested';
        VoucherHeaderApprovalRequestCancelEventDescTxt: Label 'Approval of a Voucher document is cancelled';
        StaffAdvanceSendForApprovalEventDescTxt: Label 'Approval of a Staff Advance document is requested';
        StaffAdvanceApprovalRequestCancelEventDescTxt: Label 'Approval of a Staff Advance document is canceled';
        AdvanceSurrenderSendForApprovalEventDescTxt: Label 'Approval of a Advance Surrender document is requested';
        AdvanceSurrenderApprovalRequestCancelEventDescTxt: Label 'Approval of a Advance Surrender document is canceled';
        GLAccountSendForApprovalEventDescTxt: Label 'Approval of a GLAccount document is requested';
        GLAccountApprovalRequestCancelEventDescTxt: Label 'Approval of a GLAccount document is canceled';
        StaffClaimSendForApprovalEventDescTxt: Label 'Approval of a StaffClaim document is requested';
        StaffClaimApprovalRequestCancelEventDescTxt: Label 'Approval of a StaffClaim document is canceled';
        VoucherHeaderDocReleasedEventDescTxt: Label 'Approval of a Voucher document is released';

        //
        //"---------------HR JOBS": ;
        HRJobsDocSendForApprovalEventDescTxt: Label 'An Approval for HR Jobs is requested.';
        HRJobsDocApprovedEventDescTxt: Label 'An approval request for Jobs is approved.';
        HRJobsDocApprReqCancelledEventDescTxt: Label 'An approval request for Jobs is cancelled.';
        HRJobsDocRejectedEventDescTxt: Label 'An approval for a Jobs is rejected.';
        HRJobsDocDelegatedEventDescTxt: Label 'An approval request for Jobs is delegated.';
        //"---------------HMO": ;
        HMODocSendForApprovalEventDescTxt: Label 'An Approval for HMO is requested.';
        HMODocApprovedEventDescTxt: Label 'An approval request for HMO is approved.';
        HMODocApprReqCancelledEventDescTxt: Label 'An approval request for HMO is cancelled.';
        HMODocRejectedEventDescTxt: Label 'An approval for a HMO is rejected.';
        HMODocDelegatedEventDescTxt: Label 'An approval request foR HMO is delegated.';
        //"---------------HRLeaveApp": ;
        HRLeaveAppDocSendForApprovalEventDescTxt: Label 'An Approval for leave is requested.';
        HRLeaveAppDocApprovedEventDescTxt: Label 'An approval request for a leave is approved.';
        HRLeaveAppDocApprReqCancelledEventDescTxt: Label 'An approval request for a leave is cancelled.';
        HRLeaveAppDocRejectedEventDescTxt: Label 'An approval for a leave is rejected.';
        HRLeaveAppDocDelegatedEventDescTxt: Label 'An approval request for a leave is delegated.';
        //"---------------HRTrainingApp": ;
        HRTrainingAppDocSendForApprovalEventDescTxt: Label 'An Approval for training is requested.';
        HRTrainingAppDocApprovedEventDescTxt: Label 'An approval request for training is approved.';
        HRTrainingAppDocApprReqCancelledEventDescTxt: Label 'An approval request for training is cancelled.';
        HRTrainingAppDocRejectedEventDescTxt: Label 'An approval for a training is rejected.';
        HRTrainingAppDocDelegatedEventDescTxt: Label 'An approval request foR training is delegated.';
        //"---------------HREmpReq": ;
        HREmpReqDocSendForApprovalEventDescTxt: Label 'An Approval for a requisition is requested.';
        HREmpReqDocApprovedEventDescTxt: Label 'An approval request for a requisition is approved.';
        HREmpReqDocApprReqCancelledEventDescTxt: Label 'An approval request for a requisition is cancelled.';
        HREmpReqDocRejectedEventDescTxt: Label 'An approval for a requisition is rejected.';
        HREmpReqDocDelegatedEventDescTxt: Label 'An approval request for a requisition is delegated.';
        //"--------------HRAppraisalEval": ;
        HRAppraisalEvalDocSendForApprovalEventDescTxt: Label 'An Approval for Appraisal is requested.';
        HRAppraisalEvalDocApprovedEventDescTxt: Label 'An approval request for Appraisal is approved.';
        HRAppraisalEvalDocApprReqCancelledEventDescTxt: Label 'An approval request for Appraisal is cancelled.';
        HRAppraisalEvalDocRejectedEventDescTxt: Label 'An approval for a Appraisal is rejected.';
        HRAppraisalEvalDocDelegatedEventDescTxt: Label 'An approval request for Appraisal is delegated.';
        //"--------------HRInterviewEval": ;
        HRInterviewEvalDocSendForApprovalEventDescTxt: Label 'An Approval for Interview evaluation is requested.';
        HRInterviewEvalDocApprovedEventDescTxt: Label 'An approval request for Interview evaluation is approved.';
        HRInterviewEvalDocApprReqCancelledEventDescTxt: Label 'An approval request for Interview evaluation is cancelled.';
        HRInterviewEvalDocRejectedEventDescTxt: Label 'An approval for a Interview evaluation is rejected.';
        HRInterviewEvalDocDelegatedEventDescTxt: Label 'An approval request for Interview evaluation is delegated.';
        //"--------------HREmpLoan": ;
        HREmpLoanDocSendForApprovalEventDescTxt: Label 'An Approval for loan is requested.';
        HREmpLoanDocApprovedEventDescTxt: Label 'An approval request for loan is approved.';
        HREmpLoanDocApprReqCancelledEventDescTxt: Label 'An approval request for loan is cancelled.';
        HREmpLoanDocRejectedEventDescTxt: Label 'An approval for a loan is rejected.';
        HREmpLoanDocDelegatedEventDescTxt: Label 'An approval request for loan is delegated.';
        //"------------FABudgetEntryTransfer": ;
        FABudgetEntryTransferDocSendForApprovalEventDescTxt: Label 'An Approval for a fixed asset budget entry is requested.';
        FABudgetEntryTransferDocApprovedEventDescTxt: Label 'An approval request for Fixed asset budget entry is approved.';
        FABudgetEntryTransferDocApprReqCancelledEventDescTxt: Label 'An approval request for Fixed asset budget entry is cancelled.';
        FABudgetEntryTransferDocRejectedEventDescTxt: Label 'An approval for a Fixed asset budget entry is rejected.';
        FABudgetEntryTransferDocDelegatedEventDescTxt: Label 'An approval request for Fixed asset budget entry is delegated.';
        //"-------------JVHeader": ;
        JVHeaderDocSendForApprovalEventDescTxt: Label 'An Approval for Journal Voucher is requested.';
        JVHeaderDocApprovedEventDescTxt: Label 'An approval request for Journal Voucher is approved.';
        JVHeaderDocApprReqCancelledEventDescTxt: Label 'An approval request for Journal Voucher is cancelled.';
        JVHeaderDocRejectedEventDescTxt: Label 'An approval for a Journal Voucher is rejected.';
        JVHeaderDocDelegatedEventDescTxt: Label 'An approval request for Journal Voucher is delegated.';
        //"-------------StoreReq": ;
        StoreReqDocSendForApprovalEventDescTxt: Label 'An Approval for store Requisition is requested.';
        StoreReqDocApprovedEventDescTxt: Label 'An approval request for store Requisition is approved.';
        StoreReqDocApprReqCancelledEventDescTxt: Label 'An approval request for store Requisition is cancelled.';
        StoreReqDocRejectedEventDescTxt: Label 'An approval for a store Requisition is rejected.';
        StoreReqDocDelegatedEventDescTxt: Label 'An approval request for store Requisition is delegated.';
        //"-----------ItemJnlBatch": ;
        ItemJnlBatchDocSendForApprovalEventDescTxt: Label 'An Approval for Lodgment is requested.';
        ItemJnlBatchDocApprovedEventDescTxt: Label 'An approval request for Lodgment is approved.';
        ItemJnlBatchDocApprReqCancelledEventDescTxt: Label 'An approval request for Lodgment is cancelled.';
        ItemJnlBatchDocRejectedEventDescTxt: Label 'An approval for a Lodgment is rejected.';
        ItemJnlBatchDocDelegatedEventDescTxt: Label 'An approval request for Lodgment is delegated.';
        //"-----------EmpTransfer": ;
        EmpTransferDocSendForApprovalEventDescTxt: Label 'An Approval for Employee Transaction is requested.';
        EmpTransferDocApprovedEventDescTxt: Label 'An approval request for Employee Transaction is approved.';
        EmpTransferDocApprReqCancelledEventDescTxt: Label 'An approval request for Employee Transaction is cancelled.';
        EmpTransferDocRejectedEventDescTxt: Label 'An approval for a Employee Transaction is rejected.';
        EmpTransferDocDelegatedEventDescTxt: Label 'An approval request for Employee Transaction is delegated.';
        //"-----------HRCanteenApp": ;
        HRCanteenAppDocSendForApprovalEventDescTxt: Label 'An Approval for Leave Acknowledgement is requested.';
        HRCanteenAppDocApprovedEventDescTxt: Label 'An approval request for Leave Acknowledgement is approved.';
        HRCanteenAppDocApprReqCancelledEventDescTxt: Label 'An approval request for Leave Acknowledgement is cancelled.';
        HRCanteenAppDocRejectedEventDescTxt: Label 'An approval for a Leave Acknowledgement is rejected.';
        HRCanteenAppDocDelegatedEventDescTxt: Label 'An approval request for Leave Acknowledgement is delegated.';
        //"-----------HRLeaveAck": ;
        HRLeaveAckDocSendForApprovalEventDescTxt: Label 'An Approval for Leave is requested.';
        HRLeaveAckDocApprovedEventDescTxt: Label 'An approval request for Leave is approved.';
        HRLeaveAckDocApprReqCancelledEventDescTxt: Label 'An approval request for Leave is cancelled.';
        HRLeaveAckDocRejectedEventDescTxt: Label 'An approval for a Leave is rejected.';
        HRLeaveAckDocDelegatedEventDescTxt: Label 'An approval request for Leave is delegated.';
        ////"-----------PFAMod":;
        PFAModDocSendForApprovalEventDescTxt: Label 'An Approval for PFA Modification is requested.';
        PFAModDocApprovedEventDescTxt: Label 'An approval request for PFA Modification is approved.';
        PFAModDocApprReqCancelledEventDescTxt: Label 'An approval request for PFA Modification is cancelled.';
        PFAModDocRejectedEventDescTxt: Label 'An approval for a PFA Modification is rejected.';
        PFAModDocDelegatedEventDescTxt: Label 'An approval request for PFA Modification is delegated.';
        // //"-----------PFATransfer": ;
        PFATransferDocSendForApprovalEventDescTxt: Label 'An Approval for PFA Transfer is requested.';
        PFATransferDocApprovedEventDescTxt: Label 'An approval request for PFA Transfer is approved.';
        PFATransferDocApprReqCancelledEventDescTxt: Label 'An approval request for PFA Transfert is cancelled.';
        PFATransferDocRejectedEventDescTxt: Label 'An approval for a PFA Transfer is rejected.';
        PFATransferDocDelegatedEventDescTxt: Label 'An approval request for PFA Transfer is delegated.';
        ////"-----------HREmpCon": ;
        HREmpConDocSendForApprovalEventDescTxt: Label 'An Approval for Employee Confirmation is requested.';
        HREmpConDocApprovedEventDescTxt: Label 'An approval request for Employee Confirmation is approved.';
        HREmpConDocApprReqCancelledEventDescTxt: Label 'An approval request for Employee Confirmation is cancelled.';
        HREmpConDocRejectedEventDescTxt: Label 'An approval for a Employee Confirmation is rejected.';
        HREmpConDocDelegatedEventDescTxt: Label 'An approval request for Employee Confirmation is delegated.';
        ////"-----------EMP": ;
        EMPDocSendForApprovalEventDescTxt: Label 'An Approval for a new employee is requested.';
        EMPDocApprovedEventDescTxt: Label 'An approval request for a new employee is approved.';
        EMPDocApprReqCancelledEventDescTxt: Label 'An approval request for a new employeeis cancelled.';
        EMPDocRejectedEventDescTxt: Label 'An approval for a new employee is rejected.';
        EMPDocDelegatedEventDescTxt: Label 'An approval request for a new employee is delegated.';

    //
    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        //payment
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendVoucherForApprovalCode, DATABASE::"Voucher Header", VoucherHeaderSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCanceledVoucherForApprovalCode, DATABASE::"Voucher Header", VoucherHeaderApprovalRequestCancelEventDescTxt, 0, false);
        //staffadvance
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendStaffAdvanceForApprovalCode, DATABASE::"Staff Advance Header", StaffAdvanceSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCanceledStaffAdvanceForApprovalCode, DATABASE::"Staff Advance Header", StaffAdvanceApprovalRequestCancelEventDescTxt, 0, false);
        //staff advance surrender
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendAdvanceSurrenderForApprovalCode, DATABASE::"Staff Advance Surrender Header", AdvanceSurrenderSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCanceledAdvanceSurrenderForApprovalCode, DATABASE::"Staff Advance Surrender Header", AdvanceSurrenderApprovalRequestCancelEventDescTxt, 0, false);
        //GL Account 
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendGLAccountForApprovalCode, DATABASE::"G/L Account", GLAccountSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCanceledGLAccountForApprovalCode, DATABASE::"G/L Account", GLAccountApprovalRequestCancelEventDescTxt, 0, false);
        //StaffClaim
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendStaffClaimForApprovalCode, DATABASE::"Staff Claims Header", StaffClaimSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCanceledStaffClaimForApprovalCode, DATABASE::"Staff Claims Header", StaffClaimApprovalRequestCancelEventDescTxt, 0, false);
        /*
                //Item Journal Batch
                WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendItemJnlBatchForApprovalCode, DATABASE::"Item Journal Batch", ItemJnlBatchSendForApprovalEventDescTxt, 0, false);
                WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCanceledItemJnlBatchForApprovalCode, DATABASE::"Item Journal Batch", ItemJnlBatchApprovalRequestCancelEventDescTxt, 0, false);
                //HR Jobs
                WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHRJobsForApprovalCode, DATABASE::"HR Jobs", HRJobsSendForApprovalEventDescTxt, 0, false);
                WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCanceledHRJobsForApprovalCode, DATABASE::"HR Jobs", HRJobsApprovalRequestCancelEventDescTxt, 0, false);
                //HMO 
                WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHMOForApprovalCode, DATABASE::"HR HMO", HMOSendForApprovalEventDescTxt, 0, false);
                WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCanceledHMOForApprovalCode, DATABASE::"HR HMO", HMOApprovalRequestCancelEventDescTxt, 0, false);
                //HREmpLoan
                WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHREmpLoanForApprovalCode, DATABASE::"prAssignEmployeeLoan", HREmpLoanSendForApprovalEventDescTxt, 0, false);
                WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCanceledHREmpLoanForApprovalCode, DATABASE::"prAssignEmployeeLoan", HREmpLoanApprovalRequestCancelEventDescTxt, 0, false);
        */

        //

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHRJobsForApprovalCode, DATABASE::"HR Jobs", HRJobsDocSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForHRJobsCode, DATABASE::"Approval Entry", HRJobsDocApprovedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForHRJobsCode, DATABASE::"Approval Entry", HRJobsDocRejectedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForHRJobsCode, DATABASE::"Approval Entry", HRJobsDocDelegatedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForHRJobsCode, DATABASE::"HR Jobs", HRJobsDocApprReqCancelledEventDescTxt, 0, FALSE);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHMOForApprovalCode, DATABASE::"HR HMO",
          HMODocSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForHMOCode, DATABASE::"Approval Entry", HMODocApprovedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForHMOCode, DATABASE::"Approval Entry", HMODocRejectedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForHMOCode, DATABASE::"Approval Entry", HMODocDelegatedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForHMOCode, DATABASE::"HR HMO", HMODocApprReqCancelledEventDescTxt, 0, FALSE);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHRLeaveAppForApprovalCode, DATABASE::"HR Leave Application",
          HRLeaveAppDocSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForHRLeaveAppCode, DATABASE::"Approval Entry", HRLeaveAppDocApprovedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForHRLeaveAppCode, DATABASE::"Approval Entry", HRLeaveAppDocRejectedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForHRLeaveAppCode, DATABASE::"Approval Entry", HRLeaveAppDocDelegatedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForHRLeaveAppCode, DATABASE::"HR Leave Application", HRLeaveAppDocApprReqCancelledEventDescTxt, 0, FALSE);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHRTrainingAppForApprovalCode, DATABASE::"HR Training Applications",
          HRTrainingAppDocSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForHRTrainingAppCode, DATABASE::"Approval Entry", HRTrainingAppDocApprovedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForHRTrainingAppCode, DATABASE::"Approval Entry", HRTrainingAppDocRejectedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForHRTrainingAppCode, DATABASE::"Approval Entry", HRTrainingAppDocDelegatedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForHRTrainingAppCode, DATABASE::"HR Training Applications", HRTrainingAppDocApprReqCancelledEventDescTxt, 0, FALSE);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHREmpReqForApprovalCode, DATABASE::"HR Employee Requisitions",
          HREmpReqDocSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForHREmpReqCode, DATABASE::"Approval Entry", HREmpReqDocApprovedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForHREmpReqCode, DATABASE::"Approval Entry", HREmpReqDocRejectedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForHREmpReqCode, DATABASE::"Approval Entry", HREmpReqDocDelegatedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForHREmpReqCode, DATABASE::"HR Employee Requisitions", HREmpReqDocApprReqCancelledEventDescTxt, 0, FALSE);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHRAppraisalEvalForApprovalCode, DATABASE::"HR Appraisal Goal Setting H",
          HRAppraisalEvalDocSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForHRAppraisalEvalCode, DATABASE::"Approval Entry", HRAppraisalEvalDocApprovedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForHRAppraisalEvalCode, DATABASE::"Approval Entry", HRAppraisalEvalDocRejectedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForHRAppraisalEvalCode, DATABASE::"Approval Entry", HRAppraisalEvalDocDelegatedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForHRAppraisalEvalCode, DATABASE::"HR Appraisal Goal Setting H", HRAppraisalEvalDocApprReqCancelledEventDescTxt, 0, FALSE);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHRInterviewEvalForApprovalCode, DATABASE::"Hr Interview Evaluation",
          HRInterviewEvalDocSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForHRInterviewEvalCode, DATABASE::"Approval Entry", HRInterviewEvalDocApprovedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForHRInterviewEvalCode, DATABASE::"Approval Entry", HRInterviewEvalDocRejectedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForHRInterviewEvalCode, DATABASE::"Approval Entry", HRInterviewEvalDocDelegatedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForHRInterviewEvalCode, DATABASE::"Hr Interview Evaluation", HRInterviewEvalDocApprReqCancelledEventDescTxt, 0, FALSE);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHREmpLoanForApprovalCode, DATABASE::prAssignEmployeeLoan,
          HREmpLoanDocSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForHREmpLoanCode, DATABASE::"Approval Entry", HREmpLoanDocApprovedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForHREmpLoanCode, DATABASE::"Approval Entry", HREmpLoanDocRejectedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForHREmpLoanCode, DATABASE::"Approval Entry", HREmpLoanDocDelegatedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForHREmpLoanCode, DATABASE::prAssignEmployeeLoan, HREmpLoanDocApprReqCancelledEventDescTxt, 0, FALSE);

        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendFABudgetEntryTransferForApprovalCode, DATABASE::"FA Budget Entry Transfer",
        //   FABudgetEntryTransferDocSendForApprovalEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForFABudgetEntryTransferCode, DATABASE::"Approval Entry", FABudgetEntryTransferDocApprovedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForFABudgetEntryTransferCode, DATABASE::"Approval Entry", FABudgetEntryTransferDocRejectedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForFABudgetEntryTransferCode, DATABASE::"Approval Entry", FABudgetEntryTransferDocDelegatedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForFABudgetEntryTransferCode, DATABASE::"FA Budget Entry Transfer", FABudgetEntryTransferDocApprReqCancelledEventDescTxt, 0, FALSE);

        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendJVHeaderForApprovalCode, DATABASE::"JV Header",
        //   JVHeaderDocSendForApprovalEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForJVHeaderCode, DATABASE::"Approval Entry", JVHeaderDocApprovedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForJVHeaderCode, DATABASE::"Approval Entry", JVHeaderDocRejectedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForJVHeaderCode, DATABASE::"Approval Entry", JVHeaderDocDelegatedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForJVHeaderCode, DATABASE::"JV Header", JVHeaderDocApprReqCancelledEventDescTxt, 0, FALSE);

        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPaymentVoucherForApprovalCode, DATABASE::"Payments Header", PaymentVoucherDocSendForApprovalEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForPaymentVoucherCode, DATABASE::"Approval Entry", PaymentVoucherDocApprovedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForPaymentVoucherCode, DATABASE::"Approval Entry", PaymentVoucherDocRejectedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForPaymentVoucherCode, DATABASE::"Approval Entry", PaymentVoucherDocDelegatedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForPaymentVoucherCode, DATABASE::"Payments Header", PaymentVoucherDocApprReqCancelledEventDescTxt, 0, FALSE);

        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendInterBankTransferForApprovalCode, DATABASE::"InterBank Transfers", InterbankTransferDocSendForApprovalEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForInterBankTransferCode, DATABASE::"Approval Entry", InterbankTransferDocApprovedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForInterBankTransferCode, DATABASE::"Approval Entry", InterbankTransferDocRejectedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForInterBankTransferCode, DATABASE::"Approval Entry", InterbankTransferDocDelegatedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForInterBankTransferCode, DATABASE::"InterBank Transfers", InterbankTransferDocApprReqCancelledEventDescTxt, 0, FALSE);

        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendItemJnlBatchForApprovalCode, DATABASE::"Item Journal Batch", ItemJnlBatchDocSendForApprovalEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForItemJnlBatchCode, DATABASE::"Approval Entry", ItemJnlBatchDocApprovedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForItemJnlBatchCode, DATABASE::"Approval Entry", ItemJnlBatchDocRejectedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForItemJnlBatchCode, DATABASE::"Approval Entry", ItemJnlBatchDocDelegatedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForItemJnlBatchCode, DATABASE::"Item Journal Batch", ItemJnlBatchDocApprReqCancelledEventDescTxt, 0, FALSE);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHRCanteenAppForApprovalCode, DATABASE::"Hr Canteen Application", HRCanteenAppDocSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForHRCanteenAppCode, DATABASE::"Approval Entry", HRCanteenAppDocApprovedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForHRCanteenAppCode, DATABASE::"Approval Entry", HRCanteenAppDocRejectedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForHRCanteenAppCode, DATABASE::"Approval Entry", HRCanteenAppDocDelegatedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForHRCanteenAppCode, DATABASE::"Hr Canteen Application", HRCanteenAppDocApprReqCancelledEventDescTxt, 0, FALSE);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendEmpTransferForApprovalCode, DATABASE::"HR Emp. Transaction Header", EmpTransferDocSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForEmpTransferCode, DATABASE::"Approval Entry", EmpTransferDocApprovedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForEmpTransferCode, DATABASE::"Approval Entry", EmpTransferDocRejectedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForEmpTransferCode, DATABASE::"Approval Entry", EmpTransferDocDelegatedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForEmpTransferCode, DATABASE::"HR Emp. Transaction Header", EmpTransferDocApprReqCancelledEventDescTxt, 0, FALSE);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHRLeaveAckForApprovalCode, DATABASE::"HR Leave Acknowledgement", HRLeaveAckDocSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForHRLeaveAckCode, DATABASE::"Approval Entry", HRLeaveAckDocApprovedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForHRLeaveAckCode, DATABASE::"Approval Entry", HRLeaveAckDocRejectedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForHRLeaveAckCode, DATABASE::"Approval Entry", HRLeaveAckDocDelegatedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForHRLeaveAckCode, DATABASE::"HR Leave Acknowledgement", HRLeaveAckDocApprReqCancelledEventDescTxt, 0, FALSE);

        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPFAModForApprovalCode, DATABASE::"PFA Cust. All. Modification", PFAModDocSendForApprovalEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForPFAModCode, DATABASE::"Approval Entry", PFAModDocApprovedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForPFAModCode, DATABASE::"Approval Entry", PFAModDocRejectedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForPFAModCode, DATABASE::"Approval Entry", PFAModDocDelegatedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForPFAModCode, DATABASE::"PFA Cust. All. Modification", PFAModDocApprReqCancelledEventDescTxt, 0, FALSE);

        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPFATransferForApprovalCode, DATABASE::"PFA Transfer Header Payout", PFATransferDocSendForApprovalEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForPFATransferCode, DATABASE::"Approval Entry", PFATransferDocApprovedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForPFATransferCode, DATABASE::"Approval Entry", PFATransferDocRejectedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForPFATransferCode, DATABASE::"Approval Entry", PFATransferDocDelegatedEventDescTxt, 0, FALSE);
        // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForPFATransferCode, DATABASE::"PFA Transfer Header Payout", PFATransferDocApprReqCancelledEventDescTxt, 0, FALSE);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHREmpConForApprovalCode, DATABASE::"HR Employee Confirmation", HREmpConDocSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForHREmpConCode, DATABASE::"Approval Entry", HREmpConDocApprovedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForHREmpConCode, DATABASE::"Approval Entry", HREmpConDocRejectedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForHREmpConCode, DATABASE::"Approval Entry", HREmpConDocDelegatedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForHREmpConCode, DATABASE::"HR Employee Confirmation", HREmpConDocApprReqCancelledEventDescTxt, 0, FALSE);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendEMPForApprovalCode, DATABASE::"HR Employees", EMPDocSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForEMPCode, DATABASE::"Approval Entry", EMPDocApprovedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForEMPCode, DATABASE::"Approval Entry", EMPDocRejectedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForEMPCode, DATABASE::"Approval Entry", EMPDocDelegatedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForEMPCode, DATABASE::"HR Employees", EMPDocApprReqCancelledEventDescTxt, 0, FALSE);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendStoreReqForApprovalCode, DATABASE::"Store Requisition Header", StoreReqDocSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestForStoreReqCode, DATABASE::"Approval Entry", StoreReqDocApprovedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestForStoreReqCode, DATABASE::"Approval Entry", StoreReqDocRejectedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestForStoreReqCode, DATABASE::"Approval Entry", StoreReqDocDelegatedEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprovalRequestForStoreReqCode, DATABASE::"Store Requisition Header", StoreReqDocApprReqCancelledEventDescTxt, 0, FALSE);

        //

    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        case EventFunctionName of
            //Payment
            RunWorkflowOnCanceledVoucherForApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCanceledVoucherForApprovalCode, RunWorkflowOnSendVoucherForApprovalCode);

            //staff advance
            RunWorkflowOnCanceledStaffAdvanceForApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCanceledStaffAdvanceForApprovalCode, RunWorkflowOnSendStaffAdvanceForApprovalCode);

            //staff advance surrender
            RunWorkflowOnCanceledAdvanceSurrenderForApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCanceledAdvanceSurrenderForApprovalCode, RunWorkflowOnSendAdvanceSurrenderForApprovalCode);

            //staff GLAccount
            RunWorkflowOnCanceledGLAccountForApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCanceledGLAccountForApprovalCode, RunWorkflowOnSendGLAccountForApprovalCode);

            //StaffClaim
            RunWorkflowOnCanceledStaffClaimForApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCanceledStaffClaimForApprovalCode, RunWorkflowOnSendStaffClaimForApprovalCode);

            RunWorkflowOnCancelApprovalRequestForHRJobsCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForHRJobsCode, RunWorkflowOnSendHRJobsForApprovalCode);
            RunWorkflowOnCancelApprovalRequestForHMOCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForHMOCode, RunWorkflowOnSendHMOForApprovalCode);

            RunWorkflowOnCancelApprovalRequestForHRLeaveAppCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForHRLeaveAppCode, RunWorkflowOnSendHRLeaveAppForApprovalCode);
            RunWorkflowOnCancelApprovalRequestForHRTrainingAppCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForHRTrainingAppCode, RunWorkflowOnSendHRTrainingAppForApprovalCode);
            RunWorkflowOnCancelApprovalRequestForHREmpReqCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForHREmpReqCode, RunWorkflowOnSendHREmpReqForApprovalCode);
            RunWorkflowOnCancelApprovalRequestForHRAppraisalEvalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForHRAppraisalEvalCode, RunWorkflowOnSendHRAppraisalEvalForApprovalCode);
            RunWorkflowOnCancelApprovalRequestForHRInterviewEvalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForHRInterviewEvalCode, RunWorkflowOnSendHRInterviewEvalForApprovalCode);
            RunWorkflowOnCancelApprovalRequestForHREmpLoanCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForHREmpLoanCode, RunWorkflowOnSendHREmpLoanForApprovalCode);
            // RunWorkflowOnCancelApprovalRequestForFABudgetEntryTransferCode:
            //     WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForFABudgetEntryTransferCode, RunWorkflowOnSendFABudgetEntryTransferForApprovalCode);
            // RunWorkflowOnCancelApprovalRequestForJVHeaderCode:
            //     WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForJVHeaderCode, RunWorkflowOnSendJVHeaderForApprovalCode);

            RunWorkflowOnCancelApprovalRequestForStoreReqCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForStoreReqCode, RunWorkflowOnSendStoreReqForApprovalCode);
            // RunWorkflowOnCancelApprovalRequestForItemJnlBatchCode:
            //     WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForItemJnlBatchCode, RunWorkflowOnSendItemJnlBatchForApprovalCode);
            RunWorkflowOnCancelApprovalRequestForHRCanteenAppCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForHRCanteenAppCode, RunWorkflowOnSendHRCanteenAppForApprovalCode);
            RunWorkflowOnCancelApprovalRequestForEmpTransferCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForEmpTransferCode, RunWorkflowOnSendEmpTransferForApprovalCode);
            RunWorkflowOnCancelApprovalRequestForHRLeaveAckCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForHRLeaveAckCode, RunWorkflowOnSendHRLeaveAckForApprovalCode);
            // RunWorkflowOnCancelApprovalRequestForPFAModCode:
            //     WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForPFAModCode, RunWorkflowOnSendPFAModForApprovalCode);
            // RunWorkflowOnCancelApprovalRequestForPFATransferCode:
            //     WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForPFATransferCode, RunWorkflowOnSendPFATransferForApprovalCode);
            RunWorkflowOnCancelApprovalRequestForHREmpConCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForHREmpConCode, RunWorkflowOnSendHREmpConForApprovalCode);
            RunWorkflowOnCancelApprovalRequestForEMPCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelApprovalRequestForEMPCode, RunWorkflowOnSendEMPForApprovalCode);
            //


            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendVoucherForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendStaffAdvanceForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendAdvanceSurrenderForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendGLAccountForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendStaffClaimForApprovalCode);

                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRJobsForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHMOForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRLeaveAppForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRTrainingAppForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHREmpReqForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRAppraisalEvalForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRInterviewEvalForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHREmpLoanForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendFABudgetEntryTransferForApprovalCode);
                    //WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendJVHeaderForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendStoreReqForApprovalCode);
                    // WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendItemJnlBatchForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRCanteenAppForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendEmpTransferForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHRLeaveAckForApprovalCode);
                    //WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPFAModForApprovalCode);
                    //WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPFATransferForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHREmpConForApprovalCode);
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendEMPForApprovalCode);

                end;
        end
    end;
    //work for  StaffClaim
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendStaffClaimForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStaffClaimForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendStaffClaimForApproval', '', false, false)]
    procedure RunWorkflowOnSendStaffClaimForApproval(var StaffClaim: Record "Staff Claims Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffClaimForApprovalCode, StaffClaim);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnCanceledStaffClaimForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCanceledStaffClaimForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelStaffClaimForApproval', '', false, false)]
    procedure RunWorkflowOnCanceledStaffClaimForApproval(var StaffClaim: Record "Staff Claims Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCanceledStaffClaimForApprovalCode, StaffClaim);
    end;

    //work for  G/L Account
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendGLAccountForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendGLAccountForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendGLAccountForApproval', '', false, false)]
    procedure RunWorkflowOnSendGLAccountForApproval(var GLAccount: Record "G/L Account")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendGLAccountForApprovalCode, GLAccount);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnCanceledGLAccountForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCanceledGLAccountForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelGLAccountForApproval', '', false, false)]
    procedure RunWorkflowOnCanceledGLAccountForApproval(var GLAccount: Record "G/L Account")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCanceledGLAccountForApprovalCode, GLAccount);
    end;
    // payment work flow begin
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendVoucherForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendVoucherForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendVoucherForApproval', '', false, false)]
    procedure RunWorkflowOnSendVoucherForApproval(var Voucher: Record "Voucher Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendVoucherForApprovalCode, Voucher);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnCanceledVoucherForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCanceledVoucherForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelVoucherForApproval', '', false, false)]
    procedure RunWorkflowOnCanceledVoucherForApproval(var Voucher: Record "Voucher Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCanceledVoucherForApprovalCode, Voucher);
    end;

    //Staff Advance
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendStaffAdvanceForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStaffAdvanceForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendStaffAdvanceForApproval', '', false, false)]
    procedure RunWorkflowOnSendStaffAdvanceForApproval(var StaffAdvance: Record "Staff Advance Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffAdvanceForApprovalCode, StaffAdvance);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnCanceledStaffAdvanceForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCanceledStaffAdvanceForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelStaffAdvanceForApproval', '', false, false)]
    procedure RunWorkflowOnCanceledStaffAdvanceForApproval(var StaffAdvance: Record "Staff Advance Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCanceledStaffAdvanceForApprovalCode, StaffAdvance);
    end;

    //Staff Surrender
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendAdvanceSurrenderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendAdvanceSurrenderForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendAdvanceSurrenderForApproval', '', false, false)]
    procedure RunWorkflowOnSendAdvanceSurrenderForApproval(var StaffAdvanceSurrender: Record "Staff Advance Surrender Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendAdvanceSurrenderForApprovalCode, StaffAdvanceSurrender);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnCanceledAdvanceSurrenderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCanceledAdvanceSurrenderForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelAdvanceSurrenderForApproval', '', false, false)]
    procedure RunWorkflowOnCanceledAdvanceSurrenderForApproval(var AdvanceSurrender: Record "Staff Advance Surrender Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCanceledAdvanceSurrenderForApprovalCode, AdvanceSurrender);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnSendHRJobsForApprovalCode(): Code[128]
    begin
        EXIT(UpperCase('RunWorkflowOnSendHRJobsForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendHRJobsForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnSenHRJobsForApproval(var HRJobs: Record "HR Jobs")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRJobsForApprovalCode, HRJobs);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnApproveApprovalRequestForHRJobsCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForHRJobs'));
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForHRJobsCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForHRJobs'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnRejectApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForHRJobs(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForHRJobsCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForHRJobsCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForHRJobs'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForHRJobs(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelApprovalRequestForHRJobsCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    procedure RunWorkflowOnCancelApprovalRequestForHRJobsCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForHRJobs'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelHRJobsForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnCancelApprovalRequestForHRJobs(var HRJobs: Record "HR Jobs")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForHRJobsCode, HRJobs);
    end;

    local procedure _________________________________________HMO()
    begin
    end;

    procedure RunWorkflowOnSendHMOForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendHMOForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendHMOForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnSenHMOForApproval(var HMO: Record "HR HMO")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHMOForApprovalCode, HMO);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnApproveApprovalRequestForHMOCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForHMO'));
    end;


    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForHMOCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForHMO'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnRejectApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForHMO(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForHMOCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForHMOCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForHMO'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForHMO(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelApprovalRequestForHMOCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    procedure RunWorkflowOnCancelApprovalRequestForHMOCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForHMO'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelHMOForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnCancelApprovalRequestForHMO(var HMO: Record "HR HMO")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForHMOCode, HMO);
    end;

    local procedure _____________________________________HRLeaveApp()
    begin
    end;

    procedure RunWorkflowOnSendHRLeaveAppForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendHRLeaveAppForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendHRLeaveAppForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendHRLeaveAppForApproval(var HRLeaveApp: Record "HR Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRLeaveAppForApprovalCode, HRLeaveApp);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnApproveApprovalRequestForHRLeaveAppCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForHRLeaveApp'));
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForHRLeaveAppCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForHRLeaveApp'));
    end;


    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForHRLeaveAppCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForHRLeaveApp'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForHRLeaveApp(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelApprovalRequestForHRLeaveAppCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    procedure RunWorkflowOnCancelApprovalRequestForHRLeaveAppCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForHRLeaveApp'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelHRLeaveAppForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnCancelApprovalRequestForHRLeaveApp(var HRLeaveApp: Record "HR Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForHRLeaveAppCode, HRLeaveApp);
    end;

    local procedure ________________________________________HRTrainingApp()
    begin
    end;

    procedure RunWorkflowOnSendHRTrainingAppForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendHRTrainingAppForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendHRTrainingAppForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendHRTrainingAppForApproval(var HRTrainingApp: Record 51534592)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRTrainingAppForApprovalCode, HRTrainingApp);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnApproveApprovalRequestForHRTrainingAppCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForHRTrainingApp'));
    end;


    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForHRTrainingAppCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForHRTrainingApp'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnRejectApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForHRTrainingApp(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForHRTrainingAppCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForHRTrainingAppCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForHRTrainingApp'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForHRTrainingApp(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelApprovalRequestForHRTrainingAppCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    procedure RunWorkflowOnCancelApprovalRequestForHRTrainingAppCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForHRTrainingApp'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelHRTrainingAppForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnCancelApprovalRequestForHRTrainingApp(var HRTrainingApp: Record 51534592)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForHRTrainingAppCode, HRTrainingApp);
    end;

    local procedure _______________________________________HREmpReq()
    begin
    end;

    procedure RunWorkflowOnSendHREmpReqForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendHREmpReqForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendHREmpReqForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendHREmpReqForApproval(var HREmpReq: Record 51534575)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHREmpReqForApprovalCode, HREmpReq);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnApproveApprovalRequestForHREmpReqCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForHREmpReq'));
    end;


    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForHREmpReqCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForHREmpReq'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnRejectApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForHREmpReq(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForHREmpReqCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForHREmpReqCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForHREmpReq'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForHREmpReq(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelApprovalRequestForHREmpReqCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    procedure RunWorkflowOnCancelApprovalRequestForHREmpReqCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForHREmpReq'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelHREmpReqForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnCancelApprovalRequestForHREmpReq(var HREmpReq: Record 51534575)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForHREmpReqCode, HREmpReq);
    end;

    local procedure _______________________________________HRAppraisalEval()
    begin
    end;

    procedure RunWorkflowOnSendHRAppraisalEvalForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendHRAppraisalEvalForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendHRAppraisalEvalForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendHRAppraisalEvalForApproval(var HRAppraisalEval: Record "HR Appraisal Goal Setting H")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRAppraisalEvalForApprovalCode, HRAppraisalEval);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnApproveApprovalRequestForHRAppraisalEvalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForHRAppraisalEval'));
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForHRAppraisalEvalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForHRAppraisalEval'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnRejectApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForHRAppraisalEval(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForHRAppraisalEvalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForHRAppraisalEvalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForHRAppraisalEval'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForHRAppraisalEval(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelApprovalRequestForHRAppraisalEvalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    procedure RunWorkflowOnCancelApprovalRequestForHRAppraisalEvalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForHRAppraisalEval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelHRAppraisalEvalForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnCancelApprovalRequestForHRAppraisalEval(var HRAppraisalEval: Record "HR Appraisal Goal Setting H")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForHRAppraisalEvalCode, HRAppraisalEval);
    end;

    local procedure _______________________________________HRInterviewEval()
    begin
    end;

    procedure RunWorkflowOnSendHRInterviewEvalForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendHRInterviewEvalForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendHRInterviewEvalForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendHRInterviewEvalForApproval(var HRInterviewEval: Record 51534659)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRInterviewEvalForApprovalCode, HRInterviewEval);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnApproveApprovalRequestForHRInterviewEvalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForHRInterviewEval'));
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForHRInterviewEvalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForHRInterviewEval'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnRejectApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForHRInterviewEvaln(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForHRInterviewEvalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForHRInterviewEvalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForHRInterviewEval'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForHRInterviewEval(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelApprovalRequestForHRInterviewEvalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    procedure RunWorkflowOnCancelApprovalRequestForHRInterviewEvalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForHRInterviewEval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelHRInterviewEvalForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnCancelApprovalRequestForHRInterviewEval(var HRInterviewEval: Record 51534659)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForHRInterviewEvalCode, HRInterviewEval);
    end;

    local procedure ______________________________________HREmpLoan()
    begin
    end;

    procedure RunWorkflowOnSendHREmpLoanForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendHREmpLoanForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendHREmpLoanForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendHREmpLoanForApproval(var HREmpLoan: Record 51534557)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHREmpLoanForApprovalCode, HREmpLoan);
    end;

    procedure RunWorkflowOnApproveApprovalRequestForHREmpLoanCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForHREmpLoan'));
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForHREmpLoanCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForHREmpLoan'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnRejectApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForHREmpLoan(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForHREmpLoanCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForHREmpLoanCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForHREmpLoan'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForHREmpLoan(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelApprovalRequestForHREmpLoanCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    procedure RunWorkflowOnCancelApprovalRequestForHREmpLoanCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForHREmpLoan'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelHREmpLoanForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnCancelApprovalRequestForHREmpLoan(var HREmpLoan: Record 51534557)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForHREmpLoanCode, HREmpLoan);
    end;

    local procedure _______________________________________FABudgetEntryTransfer()
    begin
    end;

    procedure RunWorkflowOnSendFABudgetEntryTransferForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendFABudgetEntryTransferForApproval'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendFABudgetEntryTransferForApproval', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnSendFABudgetEntryTransferForApproval(var FABudgetEntryTransfer: Record 51534726)
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendFABudgetEntryTransferForApprovalCode, FABudgetEntryTransfer);
    // end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnApproveApprovalRequestForFABudgetEntryTransferCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForFABudgetEntryTransfer'));
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForFABudgetEntryTransferCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForFABudgetEntryTransfer'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnRejectApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForFABudgetEntryTransfer(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForFABudgetEntryTransferCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForFABudgetEntryTransferCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForFABudgetEntryTransfer'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForFABudgetEntryTransfer(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelApprovalRequestForFABudgetEntryTransferCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // procedure RunWorkflowOnCancelApprovalRequestForFABudgetEntryTransferCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForFABudgetEntryTransfer'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelFABudgetEntryTransferForApproval', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnCancelApprovalRequestForFABudgetEntryTransfer(var FABudgetEntryTransfer: Record 51534726)
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForFABudgetEntryTransferCode, FABudgetEntryTransfer);
    // end;

    // local procedure ______________________________________JVHeader()
    // begin
    // end;

    // procedure RunWorkflowOnSendJVHeaderForApprovalCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnSendJVHeaderForApproval'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendJVHeaderForApproval', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnSendJVHeaderForApproval(var JVHeader: Record 51534736)
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendJVHeaderForApprovalCode, JVHeader);
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnApproveApprovalRequestForJVHeaderCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForJVHeader'));
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForJVHeaderCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForJVHeader'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnRejectApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForJVHeader(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForJVHeaderCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForJVHeaderCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForJVHeader'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForJVHeader(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelApprovalRequestForJVHeaderCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // procedure RunWorkflowOnCancelApprovalRequestForJVHeaderCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForJVHeader'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelJVHeaderForApproval', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnCancelApprovalRequestForJVHeader(var JVHeader: Record 51534736)
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForJVHeaderCode, JVHeader);
    // end;

    // local procedure _________________PaymentVoucher()
    // begin
    // end;

    // procedure RunWorkflowOnSendPaymentVoucherForApprovalCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnSendPaymentVoucherForApproval'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendPaymentVoucherForApproval', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnSendPaymentVoucherForApproval(var PaymentVoucher: Record 51534677)
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendPaymentVoucherForApprovalCode, PaymentVoucher);
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnApproveApprovalRequestForPaymentVoucherCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForPaymentVoucher'));
    // end;


    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForPaymentVoucherCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForPaymentVoucher'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnRejectApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForPaymentVoucher(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForPaymentVoucherCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForPaymentVoucherCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForPaymentVoucher'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForPaymentVoucher(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateApprovalRequestForPaymentVoucherCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // procedure RunWorkflowOnCancelApprovalRequestForPaymentVoucherCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForPaymentVoucher'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelPaymentVoucherForApproval', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnCancelApprovalRequestForPaymentVoucher(var PaymentVoucher: Record 51534677)
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForPaymentVoucherCode, PaymentVoucher);
    // end;

    // local procedure ____________________InterBankTransfer()
    // begin
    // end;

    // procedure RunWorkflowOnSendInterBankTransferForApprovalCode(): Code[128]
    // begin
    //     EXIT(UInternalPPERCASE('RunWorkflowOnSendInterBankTransferForApproval'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendInterBankTransferForApproval', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnSendInterBankTransferForApproval(var InterBankTransfer: Record 51534670)
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendInterBankTransferForApprovalCode, InterBankTransfer);
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnApproveApprovalRequestForInterBankTransferCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForInterBankTransfer'));
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForInterBankTransferCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForInterBankTransfer'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnRejectApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForInterBankTransfer(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForInterBankTransferCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForInterBankTransferCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForInterBankTransfer'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForInterBankTransfer(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateApprovalRequestForInterBankTransferCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // procedure RunWorkflowOnCancelApprovalRequestForInterBankTransferCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForInterBankTransfer'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelInterBankTransferForApproval', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnCancelApprovalRequestForInterBankTransfer(var InterBankTransfer: Record 51534670)
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForInterBankTransferCode, InterBankTransfer);
    // end;

    // local procedure ____________________ItemJnlBatch()
    // begin
    // end;

    // procedure RunWorkflowOnSendItemJnlBatchForApprovalCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnSendItemJnlBatchForApproval'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendItemJnlBatchForApproval', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnSendItemJnlBatchForApproval(var itemJnlBatch: Record 233)
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendItemJnlBatchForApprovalCode, itemJnlBatch);
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnApproveApprovalRequestForItemJnlBatchCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForItemJnlBatch'));
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForItemJnlBatchCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForItemJnlBatch'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForItemJnlBatch(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForItemJnlBatchCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForItemJnlBatchCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForItemJnlBatch'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForItemJnlBatch(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateApprovalRequestForItemJnlBatchCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // procedure RunWorkflowOnCancelApprovalRequestForItemJnlBatchCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForItemJnlBatch'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelItemJnlBatchForApproval', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnCancelApprovalRequestForItemJnlBatch(var ItemJnlBatch: Record "Item Journal Batch")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForItemJnlBatchCode, ItemJnlBatch);
    // end;

    local procedure ____________________StoreReq()
    begin
    end;

    procedure RunWorkflowOnSendStoreReqForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendStoreReqForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendStoreReqForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendStoreReqForApproval(var StoreReq: Record "Store Requisition Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStoreReqForApprovalCode, StoreReq);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnApproveApprovalRequestForStoreReqCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForStoreReq'));
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForStoreReqCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForStoreReq'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForStoreReq(var ApprovalEntry: Record "Approval Entry")
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForStoreReqCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForStoreReqCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForStoreReq'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnDelegateApprovalRequest', '', false, false)]
    //[Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestStoreReq(var ApprovalEntry: Record "Approval Entry")
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateApprovalRequestForStoreReqCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelApprovalRequestForStoreReqCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForStoreReq'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelStoreReqForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnCancelApprovalRequestForStoreReq(var StoreReq: Record "Store Requisition Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForStoreReqCode, StoreReq);
    end;

    local procedure ___________________HRCanteenApp()
    begin
    end;

    procedure RunWorkflowOnSendHRCanteenAppForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendHRCanteenAppForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendHRCanteenAppForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendHRCanteenAppForApproval(var HRCanteenApp: Record 51534625)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRCanteenAppForApprovalCode, HRCanteenApp);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnApproveApprovalRequestForHRCanteenAppCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForHRCanteenApp'));
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForHRCanteenAppCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForHRCanteenApp'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    //[Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForHRCanteenApp(var ApprovalEntry: Record "Approval Entry")
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForHRCanteenAppCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForHRCanteenAppCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForHRCanteenApp'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnDelegateApprovalRequest', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestHRCanteenApp(var ApprovalEntry: Record "Approval Entry")
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateApprovalRequestForHRCanteenAppCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelApprovalRequestForHRCanteenAppCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForHRCanteenApp'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelHRCanteenAppForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnCancelApprovalRequestForHRCanteenApp(var HRCanteenApp: Record 51534625)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForHRCanteenAppCode, HRCanteenApp);
    end;

    local procedure ____________________HRLeaveAck()
    begin
    end;

    procedure RunWorkflowOnSendHRLeaveAckForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendHRLeaveAckForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendHRLeaveAckForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendHRLeaveAckForApproval(var HRLeaveAck: Record 51534652)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHRLeaveAckForApprovalCode, HRLeaveAck);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnApproveApprovalRequestForHRLeaveAckCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForHRLeaveAck'));
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForHRLeaveAckCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForHRLeaveAck'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    //[Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForHRLeaveAck(var ApprovalEntry: Record "Approval Entry")
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForHRLeaveAckCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForHRLeaveAckCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForHRLeaveAck'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnDelegateApprovalRequest', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestHRLeaveAck(var ApprovalEntry: Record "Approval Entry")
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateApprovalRequestForHRLeaveAckCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelApprovalRequestForHRLeaveAckCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForHRLeaveAck'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelHRLeaveAckForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnCancelApprovalRequestForHRLeaveAck(var HRLeaveAck: Record 51534652)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForHRLeaveAckCode, HRLeaveAck);
    end;

    // local procedure ____________________PFAMod()
    // begin
    // end;

    // procedure RunWorkflowOnSendPFAModForApprovalCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnSendPFAModForApproval'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendPFAModForApproval', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnSendPFAModForApproval(var PFAMod: Record 51534781)
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendPFAModForApprovalCode, PFAMod);
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnApproveApprovalRequestForPFAModCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForPFAMod'));
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForPFAModCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForPFAMod'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnRejectApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForPFAMod(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForPFAModCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForPFAModCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForPFAMod'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestPFAMod(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateApprovalRequestForPFAModCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // procedure RunWorkflowOnCancelApprovalRequestForPFAModCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForPFAMod'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelPFAModForApproval', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnCancelApprovalRequestForPFAMod(var PFAMod: Record 51534781)
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForPFAModCode, PFAMod);
    // end;

    // local procedure ____________________PFATransfer()
    // begin
    // end;

    // procedure RunWorkflowOnSendPFATransferForApprovalCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnSendPFATransferForApproval'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendPFATransferForApproval', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnSendPFATransferForApproval(var PFATransfer: Record 51534788)
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendPFATransferForApprovalCode, PFATransfer);
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnApproveApprovalRequestForPFATransferCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForPFATransfer'));
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForPFATransferCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForPFATransfer'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnRejectApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnRejectApprovalRequestForPFATransfer(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForPFATransferCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestForPFATransferCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForPFATransfer'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnDelegateApprovalRequest', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnDelegateApprovalRequestPFATransfer(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateApprovalRequestForPFATransferCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // procedure RunWorkflowOnCancelApprovalRequestForPFATransferCode(): Code[128]
    // begin
    //     EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForPFATransfer'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelPFATransferForApproval', '', false, false)]
    // [Scope('OnPrem')]
    // procedure RunWorkflowOnCancelApprovalRequestForPFATransfer(var PFATransfer: Record 51534788)
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForPFATransferCode, PFATransfer);
    // end;

    local procedure ____________________HREmpCon()
    begin
    end;

    procedure RunWorkflowOnSendHREmpConForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendHREmpConForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendHREmpConForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendHREmpConForApproval(var HREmpCon: Record 51534761)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHREmpConForApprovalCode, HREmpCon);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnApproveApprovalRequestForHREmpConCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForHREmpCon'));
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForHREmpConCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForHREmpCon'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForHREmpCon(var ApprovalEntry: Record "Approval Entry")
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForHREmpConCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForHREmpConCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForHREmpCon'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnDelegateApprovalRequest', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestHREmpCon(var ApprovalEntry: Record "Approval Entry")
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateApprovalRequestForHREmpConCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelApprovalRequestForHREmpConCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForHREmpCon'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelHREmpConForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnCancelApprovalRequestForHREmpCon(var HREmpCon: Record 51534761)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForHREmpConCode, HREmpCon);
    end;

    local procedure ____________________EMP()
    begin
    end;

    procedure RunWorkflowOnSendEMPForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendEMPForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendEMPForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendEMPForApproval(var EMP: Record "HR Employees")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendEMPForApprovalCode, EMP);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnApproveApprovalRequestForEMPCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForEMP'));
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForEMPCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForEMP'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForEMP(var ApprovalEntry: Record "Approval Entry")
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForEMPCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForEMPCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForEMP'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnDelegateApprovalRequest', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestEMP(var ApprovalEntry: Record "Approval Entry")
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateApprovalRequestForEMPCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelApprovalRequestForEMPCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForEMP'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelEMPForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnCancelApprovalRequestForEMP(var EMP: Record 51534578)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForEMPCode, EMP);
    end;

    local procedure ____________________EmpTransfer()
    begin
    end;

    procedure RunWorkflowOnSendEmpTransferForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendEmpTransferForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnSendEmpTransferForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnSendEmpTransferForApproval(var EmpTransfer: Record 51534776)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendEmpTransferForApprovalCode, EmpTransfer);
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnApproveApprovalRequestForEmpTransferCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnApproveApprovalRequestForEmpTransfer'));
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForEmpTransferCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnRejectApprovalRequestForEmpTransfer'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnRejectApprovalRequestForEmpTransfer(var ApprovalEntry: Record "Approval Entry")
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestForEmpTransferCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestForEmpTransferCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnDelegateApprovalRequestForEmpTransfer'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnDelegateApprovalRequest', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnDelegateApprovalRequestEmpTransfer(var ApprovalEntry: Record "Approval Entry")
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateApprovalRequestForEmpTransferCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelApprovalRequestForEmpTransferCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelApprovalRequestForEmpTransfer'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 51534407, 'OnCancelEmpTransferForApproval', '', false, false)]
    [Scope('OnPrem')]
    procedure RunWorkflowOnCancelApprovalRequestForEmpTransfer(var EmpTransfer: Record 51534776)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApprovalRequestForEmpTransferCode, EmpTransfer);
    end;

    //

    [Scope('OnPrem')]
    procedure RunWorkflowOnAfterReleaseVoucherCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnAfterReleaseVoucherCodeDoc'))
    end;

    /// <summary>
    /// RunWorkflowOnAfterReleaseVoucherCodeDoc.
    /// </summary>
    /// <param name="Voucher">VAR Record "Voucher Header".</param>
    /// <param name="PreviewMode">Boolean.</param>
//[EventSubscriber(ObjectType::Codeunit, 415, 'OnAfterReleasePurchaseDoc', '', false, false)]
    procedure RunWorkflowOnAfterReleaseVoucherCodeDoc(var Voucher: Record "Voucher Header"; PreviewMode: Boolean; Var LinesWereModify: Boolean)
    begin
        if not PreviewMode then
            WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseVoucherCode, Voucher);
    end;
}


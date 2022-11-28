page 51534660 "HR HMO Card"
{
    PageType = Document;
    SourceTable = "HR HMO";
    DeleteAllowed = false; //jj300922

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("HMO Card Number"; "HMO Card Number")
                {
                    ApplicationArea = all;
                }
            }
            group("Employee Detail")
            {
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Department; Department)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Job Level"; "Job Level")
                {
                    ApplicationArea = all;
                }
                field("HMO Level"; "HMO Level")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Medical Scheme Plan"; "Medical Scheme Plan")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Medical Sch. Hospital Code"; "Medical Sch. Hospital Code")
                {
                    ApplicationArea = all;
                }
                field("Medical Scheme Hospital"; "Medical Scheme Hospital")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Hospital Address"; "Hospital Address")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Number of Beneficiaries"; "Number of Beneficiaries")
                {
                    ApplicationArea = all;
                }
                field("Employment Type"; "Employment Type")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                    Visible = false;  //jj290922
                }
            }
            part(Control13; "HR HMO Beneficiary ListPart")
            {
                SubPageLink = "Staff No." = FIELD("Employee No.");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            systempart(Control12; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt2: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt2.ApproveRecordApprovalRequest(RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject to approve the incoming document. Note that this is not related to approval workflows.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt2: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt2.RejectRecordApprovalRequest(RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt2: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt2.DelegateRecordApprovalRequest(RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt2: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt2.GetApprovalComment(Rec);
                    end;
                }
            }
            group(Action35)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator(Action34)
                {
                }
                /* action(Release)
                 {
                     ApplicationArea = Suite;
                     Caption = 'Re&lease';
                     Image = ReleaseDoc;
                     Promoted = true;
                     PromotedCategory = Category8;
                     PromotedIsBig = true;
                     PromotedOnly = true;
                     ShortCutKey = 'Ctrl+F9';
                     ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                     trigger OnAction()
                     var
                         ReleasePurchDoc: Codeunit "Release Purchase Document";
                     begin
                         //ReleasePurchDoc.PerformManualRelease(Rec);
                     end;
                 }
                 action(Reopen)
                 {
                     ApplicationArea = Suite;
                     Caption = 'Re&open';
                     Enabled = Status <> Status::Open;
                     Image = ReOpen;
                     Promoted = true;
                     PromotedCategory = Category8;
                     PromotedOnly = true;
                     ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';

                     trigger OnAction()
                     var
                         ReleasePurchDoc: Codeunit "Release Purchase Document";
                     begin
                         //ReleasePurchDoc.PerformManualReopen(Rec);
                     end;
                 }   */     // jj300922
                action("<Action1102755042>")    //jj300922  I added to re-open the doc.
                {
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category8;
                    Visible = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        TestField(Status, Status::Approved);
                        "Status" := Status::Open;
                        Modify;
                        CurrPage.Close;
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        HMBEN: Record "HR HMO Beneficiary";
                        HMO: Record "HR HMO";
                        ApprovalsMgmt: Codeunit "Approval Mgmt. ExtCal";
                    begin
                        //  if HMBEN.Count > HMO."Number of Beneficiaries" then
                        //  Error('Number of active beneficiaries must not be greater than the number of beneficiaries on the Hmo Card %1', HMBEN.Count);//BOLU

                        if ApprovalsMgmt.CheckHMOApprovalsWorkflowEnable(Rec) then
                            ApprovalsMgmt.OnSendHMOForApproval(Rec);//BDennis

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    //Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Mgmt. ExtCal";
                    begin
                        ApprovalsMgmt.OnCancelHMOForApproval(Rec);
                    end;
                }
            }
            group(Action18)
            {
                Caption = 'Approvals';
                Image = ReleaseDoc;
            }
            action("Update Employee Card")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    TestField(Status, Status::Approved);
                    TestField("HMO Card Number");

                    If HREmp.Get("Employee No.") then begin
                        HREmp."Medical Scheme No." := "HMO Card Number";
                        HREmp."Medical Scheme Plan" := "Medical Scheme Plan";
                        HREmp."Medical Scheme Hospital" := "Medical Scheme Hospital";
                        HREmp."Medical Sch. Hospital Code" := "Medical Sch. Hospital Code";
                        HREmp."Hospital Address" := "Hospital Address";
                        HREmp."Number Of Dependants" := "Number of Beneficiaries";
                        HREmp.Modify;
                        Message('Employee HMO details updated successfully');
                    end;
                end;
            }
            action("Test Attachment")
            {
                ApplicationArea = All;
                Visible = false;
                Caption = 'Attachment';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                /* RunObject = Page "Attachment Test";
                 RunPageLink = "Employee No" = FIELD("Employee No."),
                               "Application No" = FIELD("User ID"),
                               "Document Type" = CONST(HMO),
                               "Folder Type" = CONST(HR);
                               */
            }
        }
    }
    trigger OnOpenPage()
    begin
        if Rec.Status <> Rec.Status::Open then begin
            CurrPage.Editable(false);
        end;
    end;


    var
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentIsPosted: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        ShowShippingOptionsWithLocation: Boolean;
        IsSaaS: Boolean;
        IsBuyFromCountyVisible: Boolean;
        IsPayToCountyVisible: Boolean;
        IsShipToCountyVisible: Boolean;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",JV,"Payment Voucher","Petty Cash",Requisition,InterBank,"Staff Claim","Staff Advance",AdvanceSurrender,Capex,IJ,"Hr Job","Emp Loan","Leave Application","Employee Requisition","Interview Evaluation","Training Requisition",Appraisal,HMO;
        HREmp: Record "HR Employees";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt2: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        //JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        //HasIncomingDocument := "Incoming Document Entry No." <> 0;
        //SetExtDocNoMandatoryCondition;

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt2.HasOpenApprovalEntriesForCurrentUser(RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt2.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt2.CanCancelApprovalForRecord(RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}


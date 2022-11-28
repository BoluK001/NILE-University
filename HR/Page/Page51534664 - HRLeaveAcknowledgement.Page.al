page 51534664 "HR Leave Acknowledgement"
{
    PageType = Card;
    SourceTable = "HR Leave Acknowledgement";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Leave No."; "Leave No.")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Leave Type"; "Leave Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Days Applied"; "Days Applied")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Return Date"; "Return Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Actual Days Spent"; "Actual Days Spent")
                {
                    ApplicationArea = all;
                }
                field("Actual Return Day"; "Actual Return Day")
                {
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
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
            group(Action14)
            {
                action("Update Leave Application")
                {
                    Image = Update;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        LeaveLedger: Record "HR Leave Ledger Entries";
                    begin
                        TestField(Status, Status::Approved);
                        if LeaveApp.Get("Leave No.") then begin
                            LeaveApp."Days Applied" := "Actual Days Spent";
                            LeaveApp.Status := LeaveApp.Status::Resumed;
                            LeaveApp.Modify;
                            //MESSAGE('Update Successful');

                            LeaveLedger.SetRange("Document No.", "Leave No.");
                            if LeaveLedger.FindFirst then begin
                                LeaveLedger."No. of days" := "Actual Days Spent";
                                LeaveLedger.Modify;
                            end;

                            Emp.Get("Employee No.");
                            Emp."Leave Status" := Emp."Leave Status"::Resumed;
                            Emp.Modify;


                            Message('Update Successful');
                            Status := Status::Updated;
                            Modify;
                            exit;
                        end;
                    end;
                }
                action("&Approvals")
                {
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal;
                    begin
                        DocType := DocType::LeaveAck;
                        ApprovalEntries.Setfilters(DATABASE::"HR Leave Acknowledgement", DocType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("&Send Approval Request")
                {
                    Caption = '&Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Mgmt. ExtCal";
                    begin
                        if Confirm('Send this Application for Approval?', true) = false then exit;

                        if ApprovalsMgmt.CheckHRLeaveAckApprovalsWorkflowEnable(Rec) then
                            ApprovalsMgmt.OnSendHRLeaveAckForApproval(Rec);

                    end;
                }
                action("&Cancel Approval Request")
                {
                    Caption = '&Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Mgmt. ExtCal";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";

                    begin
                        ApprovalsMgmt.OnCancelHRLeaveAckForApproval(Rec);
                        WorkflowWebhookMgt.FindAndCancel(RecordId);
                    end;
                }
                action("Test Attachment")
                {
                    Caption = 'Attachment';
                    Image = Attach;
                    Promoted = true;

                    //RunObject = Page "Attachment Test";
                    //RunPageLink = "Employee No" = FIELD("Employee No."),
                    //            "Application No" = FIELD("No."),
                    //          "Document Type" = CONST(Leave),
                    //        "Folder Type" = CONST(HR);
                }
            }
        }
    }

    var
        LeaveApp: Record "HR Leave Application";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",JV,"Payment Voucher","Petty Cash",Requisition,InterBank,"Staff Claim","Staff Advance",AdvanceSurrender,Capex,IJ,"Hr Job","Emp Loan","Leave Application","Employee Requisition","Interview Evaluation","Training Requisition",Appraisal,HMO,Canteen,EmpTransaction,LeaveAck;
        ApprovalEntries:Page "Approval Entries";
        Emp: Record "HR Employees";
}


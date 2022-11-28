page 51534946 "HR Leave Applications Self"
{
    CardPageID = "HR Leave Application Card";
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Approvals,Comments';
    AdditionalSearchTerms = 'HR Leave Applications Self';
    SourceTable = "HR Leave Application";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                ShowCaption = false;
                field("Application Code"; "Application Code")
                {
                    Caption = 'Application No';
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = all;
                }
                field("Leave Type"; "Leave Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Days Applied"; "Days Applied")
                {
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = all;
                }
                field("Return Date"; "Return Date")
                {
                    ApplicationArea = all;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = all;
                }
                field("Reliever Name"; "Reliever Name")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755006; "HR Leave Applicaitons Factbox")
            {
                SubPageLink = "No." = FIELD("Employee No");
                ApplicationArea = All;
            }
            systempart(Control1102755004; Outlook)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition";
                    begin
                        /*DocumentType:=DocumentType::"Leave Application";
                        
                        ApprovalComments.Setfilters(DATABASE::"HR Leave Application",DocumentType,"Application Code");
                        ApprovalComments.SetUpLine(DATABASE::"HR Leave Application",DocumentType,"Application Code");
                        ApprovalComments.RUN;
                         */

                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Approvals")
                {
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal;
                    begin
                        DocumentType := DocumentType::"Leave Application";
                        ApprovalEntries.Setfilters(DATABASE::"HR Leave Application", DocumentType, "Application Code");
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

                        TESTFIELDS;

                        if Confirm('Send this Application for Approval?', true) = false then exit;
                        Selected := true;
                        "User ID" := UserId;



                        if ApprovalsMgmt.CheckHRLeaveAppApprovalsWorkflowEnable(Rec) then
                            ApprovalsMgmt.OnSendHRLeaveAppForApproval(Rec); //BDENNIS
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

                        ApprovalsMgmt.OnCancelHRLeaveAppForApproval(Rec);
                        WorkflowWebhookMgt.FindAndCancel(RecordId);
                    end;
                }
                action("Re-Open")
                {
                    Caption = 'Re-Open';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Status := Status::New;
                        Modify;
                    end;
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Report "HR Leave Application";
                    //ApplicationArea = All;


                    trigger OnAction()
                    begin
                        HRLeaveApp.Reset;
                        HRLeaveApp.SetRange(HRLeaveApp."Application Code", "Application Code");
                        if HRLeaveApp.Find('-') then
                            REPORT.Run(51534519, true, true, HRLeaveApp);
                    end;
                }
                action("Create Leave Ledger Entries")
                {
                    Caption = 'Create Leave Ledger Entries';
                    Image = CreateLinesFromJob;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CreateLeaveLedgerEntries;
                        Reset;
                    end;
                }
                action("HR Leave Adjustments")
                {
                    Caption = 'HR Leave Adjustments';
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Leave Journal Lines";
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
        area(reporting)
        {
            action("Leave Application")
            {
                Caption = 'Leave Application';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Leave Application";
                ApplicationArea = All;
            }
            action("Leave Reimbursements")
            {
                Caption = 'Leave Reimbursements';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Leave Reimbursements";
                Visible = false;
                ApplicationArea = All;
            }
            action("Leave Applications List")
            {
                Caption = 'Leave Applications List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Leave Applications List";
                ApplicationArea = All;
            }
            action("Leave Statement")
            {
                Caption = 'Leave Statement';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Leave Statement";
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    begin
        FilterGroup(2);
        SetFilter("User ID", UserId);
        FilterGroup(0);

        //MESSAGE('Dear %1, Please be informed that your outstanding leave days is being readjusted based on directives from Management. Service will be back up shortly.',USERID);
    end;

    var
        ApprovalEntries:Page "Approval Entries";
        ApprovalComments: Page "Approval Comments";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application";
        HRLeaveApp: Record "HR Leave Application";

    [Scope('OnPrem')]
    procedure TESTFIELDS()
    begin
        TestField("Leave Type");
        TestField("Days Applied");
        TestField("Start Date");
        TestField(Reliever);
        TestField(Supervisor);
    end;
}


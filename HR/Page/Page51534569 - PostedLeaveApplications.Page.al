page 51534569 "Posted Leave Applications"
{
    CardPageID = "Posted Leave Application Card";
    DeleteAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Leave Application";
    SourceTableView = WHERE(Status = FILTER(Posted | Resumed));
    AdditionalSearchTerms = 'Posted Leave Applications';

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
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = all;
                }
                field(Names; Names)
                {
                    ApplicationArea = all;
                }
                field("Leave Type"; "Leave Type")
                {
                    Editable = false;
                    ApplicationArea = all;
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
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755006; "HR Leave Applicaitons Factbox")
            {
                SubPageLink = "No." = FIELD("Employee No");
            }
            systempart(Control1102755004; Outlook)
            {
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
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category5;

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
                    ApplicationArea = all;
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

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
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        TESTFIELDS;

                        if Confirm('Send this Application for Approval?', true) = false then exit;
                        Selected := true;
                        "User ID" := UserId;

                        If ApprovalMgt.CheckHRLeaveAppApprovalsWorkflowEnable(rec) then
                            ApprovalMgt.OnSendHRLeaveAppForApproval(Rec);
                    end;
                }
                action("&Cancel Approval Request")
                {
                    Caption = '&Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        ApprovalMgt.OnCancelHRLeaveAppForApproval(rec);
                    end;
                }
                action("Re-Open")
                {
                    Caption = 'Re-Open';
                    Image = ReopenCancelled;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;

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
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    //RunObject = Report "IBS Notes 3";

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
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    Visible = false;

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
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Leave Journal Lines";
                    Visible = false;
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
                ApplicationArea = all;
                PromotedCategory = "Report";
                //RunObject = Report "IBS Notes 3";
            }
            action("Leave Reimbursements")
            {
                Caption = 'Leave Reimbursements';
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                RunObject = Report "HR Leave Reimbursements";
            }
            action("Leave Applications List")
            {
                Caption = 'Leave Applications List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ApplicationArea = all;
                RunObject = Report "HR Leave Applications List";
            }
            action("Leave Statement")
            {
                Caption = 'Leave Statement';
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                /// RunObject = Report "Fully Unprocessed Instruction";
            }
        }
    }

    var
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
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


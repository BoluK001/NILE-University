page 51534459 "HR Jobs Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Job,Approval';
    SourceTable = "HR Jobs";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = FieldEditable;
                field("Job ID"; Rec."Job ID")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Job Title"; Rec."Job Title")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Position Reporting to"; Rec."Position Reporting to")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    // trigger OnValidate()
                    // begin
                    //     rec.Validate("Responsibility Center", Rec."Global Dimension 2 Code");
                    // end;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Visible = True;  //jj270922
                }
                field("Department Level 2"; Rec."Department Level 2")
                {
                    ToolTip = 'Specifies the value of the Department Level 2 field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Unit; Rec.Unit)
                {
                    ToolTip = 'Specifies the value of the Unit field.';
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Grade; Rec.Grade)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Job Level"; Rec."Job Level")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Main Objective"; Rec."Main Objective")
                {
                    ApplicationArea = all;
                }
                field("Supervisor/Manager"; Rec."Supervisor/Manager")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = all;
                    Caption = 'Responsibility Center';
                }
                field("Employee Requisitions"; Rec."Employee Requisitions")
                {
                    ApplicationArea = all;
                }
                field("Key Position"; Rec."Key Position")
                {
                    ApplicationArea = all;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = true;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
            }
            part("List Of Interviewers"; "HR Job Interview Areas")
            {
                Caption = 'List Of Interviewers';
                SubPageLink = Job = FIELD("Job ID");
                Visible = false;
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
                ApplicationArea = all;
            }
            systempart(Control1102755006; Outlook)
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
                action("Raise Requisition")
                {
                    Caption = 'Raise Requisition';
                    Image = Job;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Employee Requisition Card";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action("Job Requirements")
                {
                    Caption = 'Job Requirements';
                    Image = Card;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines";
                    RunPageLink = "Job Id" = FIELD("Job ID");
                }
                action("Job Responsibilities")
                {
                    Caption = 'Job Responsibilities';
                    Image = JobResponsibility;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Responsiblities Lines";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action("Job Working Relationship")
                {
                    Caption = 'Job Working Relationship';
                    Image = Relationship;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Working Relationship";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action("Job KPI")
                {
                    Image = JobTimeSheet;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Job KPI's";
                    RunPageLink = "Assign To" = FIELD("Job ID");
                    visible = false;   //jj160322
                }
                action(Occupants)
                {
                    Caption = 'Occupants';
                    Image = ContactPerson;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Occupants";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    //Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Mgmt. ExtCal";
                    begin
                        IF CONFIRM('Send this Job Title for Approval?', TRUE) = FALSE THEN EXIT;

                        if ApprovalsMgmt.CheckHRJobsApprovalsWorkflowEnable(Rec) then
                            ApprovalsMgmt.OnSendHRJobsForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    //Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Mgmt. ExtCal";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelHRJobsForApproval(Rec);
                        WorkflowWebhookMgt.FindAndCancel(RecordId);
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        doctype: Enum "Approval Document Type";
                    begin
                        DocType := DocType::Jobs;
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"HR Jobs", DocType.AsInteger(), Rec."Job ID");
                    end;
                }
            }
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(RecordId);

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
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(RecordId);
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
                    ToolTip = 'Delegate the requested changes to the substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(RecordId);
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        rec.Validate("Vacant Positions");
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Created By" := "Created By";
    end;

    trigger OnOpenPage()
    begin
        if Status = Status::New then
            FieldEditable := true;
    end;

    var
        HREmployees: Record "HR Employees";
        AppMgmt: Codeunit "Approval Mgmt. ExtCal";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal;
        ApprovalEntries : Page "Approval Entries";
        FieldEditable: Boolean;
        UserSetup: Record "User Setup";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",JV,"Payment Voucher","Petty Cash",Requisition,InterBank,"Staff Claim","Staff Advance",AdvanceSurrender,Capex,IJ,"Hr Job","Emp Loan","Leave Application","Employee Requisition","Interview Evaluation","Training Requisition",Appraisal,HMO;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentIsPosted: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        ShowShippingOptionsWithLocation: Boolean;
        IsSaaS: Boolean;

    [Scope('OnPrem')]
    procedure UpdateControls()
    begin
        if Status <> Status::New then begin
            FieldEditable := false;
            //CurrPage.UpdateControls();
        end else begin
            FieldEditable := true;
            //CurrPage.UpdateControls();
        end;
        /*
        IF Status=Status::"Pending Approval" THEN BEGIN
         FieldEditable :=TRUE;
         //CurrPage.UpdateControls();
        END ELSE BEGIN
         FieldEditable :=FALSE;
         //CurrPage.UpdateControls();
        END
        */

    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;
}


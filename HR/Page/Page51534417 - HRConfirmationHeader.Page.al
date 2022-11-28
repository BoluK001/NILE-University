page 51534417 "HR Confirmation Header"
{
    Caption = 'HR Confirmation Header';
    DeleteAllowed = true;
    PageType = Card;
    SourceTable = "HR Employee Confirmation";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Date of Employment"; Rec."Date of Employment")
                {
                    ApplicationArea = all;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = all;
                }
                field(Supervisor; Rec.Supervisor)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Second Line Supervisor"; Rec."Second Line Supervisor")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = all;
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Date of Review"; Rec."Date of Review")
                {
                    ApplicationArea = all;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = all;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = all;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = all;
                }
                field("KPI Score"; Rec."KPI Score")
                {
                    ApplicationArea = all;
                }
                field("User ID"; Rec."User ID")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("Second Line Supervisor Comment"; Rec."Second Line Supervisor Comment")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("Development Areas"; Rec."Development Areas")
                {
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field("Training Ideas"; Rec."Training Ideas")
                {
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field("Employee Comment"; Rec."Employee Comment")
                {
                    ApplicationArea = all;
                    MultiLine = true;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    var
                        TotalWeight: Decimal;
                        ConfirmationKPI: Record "HR Confirmation KPI";
                    begin
                    end;
                }
            }
            part("HR Confirmation Line"; "HR Confirmation Lines")
            {
                SubPageLink = "Application No." = FIELD("Application No.");
                ApplicationArea = All;
            }
            part(Financial; 51534681)
            {
                ApplicationArea = All;
                Caption = 'Financial';
                SubPageLink = "Document No." = FIELD("Application No."),
                              "Employee No." = FIELD("Employee No.");
                SubPageView = WHERE("Behavioural Group" = CONST('FINANCIAL'));
            }
            part(Customer; 51534682)
            {
                ApplicationArea = All;
                Caption = 'Customer';
                SubPageLink = "Document No." = FIELD("Application No."),
                              "Employee No." = FIELD("Employee No.");
                SubPageView = WHERE("Behavioural Group" = CONST('CUSTOMER'));
            }
            part("Internal Process"; 51534683)
            {
                ApplicationArea = All;
                Caption = 'Internal Process';
                SubPageLink = "Document No." = FIELD("Application No."),
                              "Employee No." = FIELD("Employee No.");
                SubPageView = WHERE("Behavioural Group" = CONST('INTERNAL PROCESS'));
            }
            part("Learning & Growth"; 51534684)
            {
                ApplicationArea = All;
                Caption = 'Learning & Growth';
                SubPageLink = "Document No." = FIELD("Application No."),
                              "Employee No." = FIELD("Employee No.");
                SubPageView = WHERE("Behavioural Group" = CONST('LEARNING GROWTH'));
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send to HR")
            {
                Image = SendElectronicDocument;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CompInfo: Record "Company Information";
                begin
                    TESTFIELD(Status, Status::Approved);
                    IF "Send to Hr" THEN
                        EXIT
                    ELSE
                        IF CONFIRM('Form will be forwarded to HR,click ok to continue', FALSE) THEN BEGIN
                            HrEmp.GET("Employee No.");
                            IF HrEmp."Company E-Mail" <> '' THEN BEGIN
                                CLEAR(SMTP);
                                EmailAdd.Add('it@optivacp.com');
                                SMTP.CreateMessage('Optiva CP', HrEmp."Company E-Mail", EmailAdd,
                                FORMAT("Appraisal Type") + ' ' + 'Notification', '', TRUE);

                                SMTP.AppendBody('Dear HR Team,' + '<BR><BR>');
                                SMTP.AppendBody("Employee Name" + ' ' + 'has just completed his/her ' + ' ' + FORMAT("Appraisal Type") + 'form.' + '<BR><BR>');
                                SMTP.AppendBody('<BR>');
                                SMTP.AppendBody('Regards,<BR>');
                                SMTP.AppendBody('HR <BR>');

                                SMTP.Send;
                            END;
                            //MESSAGE('Beneficiaries have been notified');
                            IF "Appraisal Type" = "Appraisal Type"::Probation THEN BEGIN
                                HrEmp.GET("Employee No.");
                                HrEmp."Probation Form Filled" := TRUE;
                                HrEmp.MODIFY;
                            END
                            ELSE
                                IF "Appraisal Type" = "Appraisal Type"::Confirmation THEN BEGIN
                                    HrEmp.GET("Employee No.");
                                    HrEmp."Confirmation Form Filled" := TRUE;
                                    HrEmp.MODIFY;
                                END;

                            "Send to Hr" := TRUE;
                            MODIFY;
                            MESSAGE('Document has been transferred to HR');
                        END;
                end;
            }
            action("Probation Report")
            {
                Caption = 'Probation Report';
                Image = Report;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = ProbVisi;

                trigger OnAction()
                begin
                    RESET;
                    SETFILTER("Application No.", "Application No.");
                    REPORT.RUN(51534793, TRUE, TRUE, Rec);
                    RESET;
                end;
            }
            action("Confirmation Report")
            {
                Caption = 'Confirmation Report';
                Image = Report;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = ConfirmVis;

                trigger OnAction()
                begin
                    RESET;
                    SETFILTER("Application No.", "Application No.");
                    REPORT.RUN(51534794, TRUE, TRUE, Rec);
                    RESET;
                end;
            }
            action("Send To Supervisor1")
            {
                Caption = 'Send To Supervisor';
                Image = SendTo;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to send this Appraisal Form to  your Supervisor?', FALSE) = TRUE THEN BEGIN
                        Status := Status::"Pending Approval";
                        MODIFY;
                        MESSAGE('%1', 'Process Completed')
                    END;
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries : Page "Approval Entries";
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                begin
                    DocType := DocType::"Employee Confirmation";
                    //ApprovalEntries.Setfilters(DATABASE::"HR Employee Confirmation", DocType.AsInteger(), "Application No.");
                    WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"HR Employee Confirmation", DocType.AsInteger(), "Application No.");
                    // ApprovalEntries.RUN;
                end;
            }
            action("Send To Supervisor")
            {
                Caption = 'Send To Supervisor';
                Image = SendTo;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
                begin
                    //IF ApprovalMgt.SendConfirmationApprovalReq(Rec) THEN; Lateef
                    if ApprovalMgt.CheckHREmpConApprovalsWorkflowEnable(Rec) then
                        ApprovalMgt.OnSendHREmpConForApproval(Rec);
                end;
            }
            action("Cancel Approval Re&quest")
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
                begin
                    // IF ApprovalMgt.CancelConfirmationRequest(Rec,TRUE,TRUE) THEN; Lateef
                    ApprovalMgt.OnCancelHREmpConForApproval(rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF "Send to Hr" THEN BEGIN
            CurrPage.EDITABLE := FALSE;
            //CurrPage.UPDATE;
        END;

        IF Status = Status::Approved THEN BEGIN
            CurrPage.EDITABLE := FALSE;
        END;


        IF "Appraisal Type" = "Appraisal Type"::Probation THEN BEGIN
            ConfirmVis := FALSE;
            ProbVisi := TRUE;
        END ELSE BEGIN
            ConfirmVis := TRUE;
            ProbVisi := FALSE;
        END;
    end;

    trigger OnInit()
    var
        TotalWeight: Decimal;
    begin
    end;

    trigger OnOpenPage()
    begin
        IF "Send to Hr" THEN BEGIN
            CurrPage.EDITABLE := FALSE;
            CurrPage.UPDATE;
        END;

        IF "Appraisal Type" = "Appraisal Type"::Probation THEN BEGIN
            ConfirmVis := FALSE;
            ProbVisi := TRUE;
        END ELSE BEGIN
            ConfirmVis := TRUE;
            ProbVisi := FALSE;
        END;
    end;

    var
        EmailAdd: List of [Text];
        HrEmp: Record "HR Employees";
        SMTP: Codeunit "SMTP Mail";
        ConfirmVis: Boolean;
        ProbVisi: Boolean;
        //DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",JV,"Payment Voucher","Petty Cash",Requisition,InterBank,"Staff Claim","Staff Advance",AdvanceSurrender,Capex,IJ,"Hr Job","Emp Loan","Leave Application","Employee Requisition","Interview Evaluation","Training Requisition",Appraisal,HMO,Canteen,EmpTransaction,LeaveAck,PFAMod,PFATransfer,Confirmation;
        DocType: Enum "Approval Document Type";
}


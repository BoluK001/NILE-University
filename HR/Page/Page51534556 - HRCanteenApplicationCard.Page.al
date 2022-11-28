page 51534556 "HR Canteen Application Card"
{
    Caption = 'HR Meal Ticket';
    PageType = Card;
    SourceTable = "Hr Canteen Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Ticket No."; "Ticket No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Date; Date)
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; "Department Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        "Payroll Period" := CalcDate('<-CM>', "Start Date");
                        if objPeriod.Get("Payroll Period") then
                            if objPeriod.Closed = true then Error('The %1 period has already been closed', "Payroll Period");
                        Validate("Payroll Period");
                    end;
                }
                field("Payroll Period"; "Payroll Period")
                {
                    ApplicationArea = all;
                }
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = all;
                }
                field("Transaction Name"; "Transaction Name")
                {
                    ApplicationArea = all;
                }
                field("Request Type"; "Request Type")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Visitor Name"; "Visitor Name")
                {
                    Visible = false;
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
                field(Posted; Posted)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if "Request Type" = "Request Type"::Visitor then
                        TestField("Visitor Name");
                    if Confirm('Send this Employee for Approval?', true) = false then exit;

                    If ApprovalMgt.CheckHRCanteenAppApprovalsWorkflowEnable(Rec) then
                        ApprovalMgt.OnSendHRCanteenAppForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = CancelAllLines;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //IF CONFIRM('Cancel Approval Request?',TRUE)=FALSE THEN EXIT;
                    ApprovalMgt.OnCancelHRCanteenAppForApproval(Rec);
                end;
            }
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    if Posted = true then
                        exit;
                    /*
                   Usersetup.SETFILTER(Usersetup."User ID",USERID);
                   IF Usersetup.FIND('-') THEN
                    IF NOT Usersetup."Post Canteen Meal" = TRUE THEN
                    ERROR('Please you are not authorized to post');

                    Posted := TRUE ;
                     MODIFY ;
                      */
                    TestField("Payroll Period");
                    TestField(Status, Status::Approved);
                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then begin
                        if "Payroll Period" = objPeriod."Date Opened" then begin
                            PrEmpTrans.Init;
                            //PrEmpTrans.TRANSFERFIELDS(Rec);
                            PrEmpTrans.Reset;
                            PrEmpTrans.Init;
                            PrEmpTrans."Employee Code" := "Employee No.";
                            PrEmpTrans."Transaction Code" := "Transaction Code";
                            PrEmpTrans."Transaction Name" := "Transaction Name";
                            PrEmpTrans.Amount := Amount;
                            PrEmpTrans."Payroll Period" := "Payroll Period";
                            PrEmpTrans."Period Month" := "Period Month";
                            PrEmpTrans."Period Year" := "Period Year";
                            PrEmpTrans."Start Date" := "Start Date";
                            if PrEmpTrans.Insert then
                                Posted := true;
                            Modify;
                            Message('Meal Ticket %1 successfully processed for employee %2', "Transaction Code", "Employee No.");
                        end
                        else begin
                            Posted := true;
                            Modify;//the transfer will be transferred to the right period when the specified period is opened using close period functionality
                            Message('Meal Ticket %1 successfully processed for employee %2', "Transaction Code", "Employee No.");
                        end
                    end
                    /*ELSE BEGIN
                      Posted:=TRUE;
                      MODIFY;//the transfer will be transferred to the right period when the specified period is opened using close period functionality
                      MESSAGE('Meal Ticket %1 successfully processed for employee %2',"Transaction Code","Employee No.");
                    END
                    */

                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries : Page "Approval Entries";
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    doctype: Enum "Approval Document Type";
                begin
                    DocType := DocType::"Staff Advance";
                    WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Hr Canteen Application", DocType.AsInteger(), "Ticket No.");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Posted then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;

    trigger OnOpenPage()
    begin
        if Posted then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;

    var
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
        Usersetup: Record "User Setup";
        objTransCodes: Record "prTransaction Codes";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        objEmpTrans: Record "prEmployee Transactions";
        transType: Text[30];
        PRTransactions: Record "prTransaction Codes";
        PrEmpTrans: Record "prEmployee Transactions";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",JV,"Payment Voucher","Petty Cash",Requisition,InterBank,"Staff Claim","Staff Advance",AdvanceSurrender,Capex,IJ,"Hr Job","Emp Loan","Leave Application","Employee Requisition","Interview Evaluation","Training Requisition",Appraisal,HMO,Canteen,EmpTransaction,LeaveAck;
}


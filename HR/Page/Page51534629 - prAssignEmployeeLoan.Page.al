page 51534629 prAssignEmployeeLoan
{
    PageType = Card;
    SourceTable = prAssignEmployeeLoan;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PRTransactions.Reset;
                        PRTransactions.SetRange(PRTransactions."IsCoop/LnRep", true);
                        if PAGE.RunModal(51534610, PRTransactions) = ACTION::LookupOK then begin
                            "Transaction Code" := PRTransactions."Transaction Code";
                            "Transaction Name" := PRTransactions."Transaction Name";
                            "Effective Interest Rate" := PRTransactions."Effective Interest Loan";
                            "Nominal Interest Rate" := PRTransactions."Nominal Interest Rate";

                        end
                    end;

                    trigger OnValidate()
                    begin
                        blnIsLoan := false;
                        /*IF objTransCodes.GET("Transaction Code") THEN
                          //"Transaction Name":=objTransCodes."Transaction Name";
                          //"Effective Interest Rate":=objTransCodes."Effective Interest Loan";
                          //"Nominal Interest Rate":=objTransCodes."Nominal Interest Rate";
                        
                          "Payroll Period":=SelectedPeriod;
                          "Period Month":=PeriodMonth;
                          "Period Year":=PeriodYear;
                          IF objTransCodes."Special Transactions"=8 THEN blnIsLoan:=TRUE;
                        
                        IF objTransCodes."Is Formula"=TRUE THEN
                        BEGIN
                         empCode:="Employee Code";
                         CLEAR(objOcx);
                         curTransAmount:=objOcx.fnDisplayFrmlValues(empCode,PeriodMonth,PeriodYear,objTransCodes.Formula);
                         Amount:=curTransAmount;
                        END;
                        */
                        //*************ENTER IF EMPLOYER DEDUCTION IS SET UP
                        curTransAmount := 0;
                        /*
                        IF objTransCodes."Include Employer Deduction"=TRUE THEN
                        BEGIN
                          curTransAmount:=objOcx.fnDisplayFrmlValues(empCode,PeriodMonth,PeriodYear,objTransCodes."Is Formula for employer");
                          "Employer Amount":=curTransAmount;
                        END;
                        */

                    end;
                }
                field("Transaction Name"; "Transaction Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        "Payroll Period" := CalcDate('<-CM>', "Start Date");
                        if objPeriod.Get("Payroll Period") then
                            if objPeriod.Closed = true then Error('The %1 period has already been closed', "Payroll Period");
                        Validate("Payroll Period");
                    end;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = all;
                }
                field("Payroll Period"; "Payroll Period")
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field(Balance; Balance)
                {
                    Caption = 'Loan Amount';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if (blnIsLoan = true) and (Balance > 0) and (Amount > 0) then begin
                            "#of Repayments" := Round(Balance / Amount, 1, '>');
                            "#of Repayments" := Round("#of Repayments", 1, '>');
                        end;
                    end;
                }
                field("#of Repayments"; "#of Repayments")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if blnIsLoan = true then begin
                            "#of Repayments" := Round(Balance / Amount, 1, '>');
                            "#of Repayments" := Round("#of Repayments", 1, '>');
                        end;
                    end;
                }
                field(Amount; Amount)
                {
                    Caption = 'Monthly Deduction';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if (blnIsLoan = true) and (Balance > 0) and (Amount > 0) then begin
                            "#of Repayments" := Round(Balance / Amount, 1, '>');
                            "#of Repayments" := Round("#of Repayments", 1, '>');
                        end;
                    end;
                }
                field("Stop for Next Period"; "Stop for Next Period")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Amortized Loan Total Repay Amt"; "Amortized Loan Total Repay Amt")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Suspended; Suspended)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                }
                label("Interest Details")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Interest Amount"; "Interest Amount")
                {
                    ApplicationArea = all;
                }
                field("Interest Monthly Deduction"; "Interest Monthly Deduction")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Process Loan")
            {
                Caption = 'Process Loan';
                Image = Post;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Status = Status::Posted then Error('The Loan has already been processed');

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then begin
                        if "Payroll Period" = objPeriod."Date Opened" then begin
                            PrEmpTrans.Init;
                            PrEmpTrans.TransferFields(Rec);
                            PrEmpTrans."Original Amount" := Balance;
                            PrEmpTrans.Insert;
                            Status := Status::Posted;
                            Modify;
                            TransCode.SetRange(TransCode."Related Transaction Code", "Transaction Code");
                            if TransCode.FindFirst then begin
                                EmpTrans.Reset;
                                EmpTrans.Init;
                                EmpTrans."Employee Code" := "Employee Code";
                                EmpTrans."Transaction Code" := TransCode."Transaction Code";
                                EmpTrans."Transaction Name" := TransCode."Transaction Name";
                                EmpTrans.Amount := "Interest Monthly Deduction";
                                EmpTrans."Original Amount" := "Interest Amount";
                                EmpTrans.Balance := "Interest Amount";
                                EmpTrans."No Of Repayments" := "#of Repayments";
                                EmpTrans."Payroll Period" := "Payroll Period";
                                EmpTrans."Period Month" := "Period Month";
                                EmpTrans."Period Year" := "Period Year";
                                EmpTrans."Start Date" := "Start Date";
                                EmpTrans."End Date" := "End Date";
                                EmpTrans.Insert;
                            end;
                            Message('Loan %1 successfully processed for employee %2', "Transaction Code", "Employee Code");
                        end
                        else begin
                            Status := Status::Posted;
                            Modify;//the transfer will be transferred to the right period when the specified period is opened using close period functionality
                            Message('Loan %1 successfully processed for employee %2', "Transaction Code", "Employee Code");
                        end
                    end
                    else begin
                        Status := Status::Posted;
                        Modify;//the transfer will be transferred to the right period when the specified period is opened using close period functionality
                        Message('Loan %1 successfully processed for employee %2', "Transaction Code", "Employee Code");
                    end
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;


                trigger OnAction()
                var
                    ApprovalEntries:Page "Approval Entries";
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    doctype: Enum "Approval Document Type";
                begin
                    DocType := DocType::"Staff Advance";
                    WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"prAssignEmployeeLoan", DocType.AsInteger(), "Employee Name");
                end;

            }
            action("Send A&pproval Request")
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
                    GenLedgSetup: Record "General Ledger Setup";
                //NoSeriesMgt: Codeunit NoSeriesManagement;
                begin

                    if ApprovalMgt.CheckHREmpLoanApprovalsWorkflowEnable(Rec) then
                        ApprovalMgt.OnSendHREmpLoanForApproval(Rec);
                    //RBS Dennis
                end;
            }
            action("Cancel Approval Re&quest")
            {
                Caption = 'Cancel Approval Re&quest';
                Image = CancelledEntries;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approval Mgmt. ExtCal";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    ApprovalsMgmt.OnCancelHREmpLoanForApproval(Rec);
                    WorkflowWebhookMgt.FindAndCancel(RecordId);
                end;
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
                    ToolTip = 'Reject the requested changes.';
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
                    ToolTip = 'Delegate the requested changes to the substitute approver.';
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
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Status = Status::"Pending Approval" then
            IntEditable := true;
    end;

    trigger OnInit()
    begin
        /*
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed,FALSE);
        IF objPeriod.FIND('-') THEN
        BEGIN
            SelectedPeriod:=objPeriod."Date Opened";
            PeriodName:=objPeriod."Period Name";
            PeriodMonth:=objPeriod."Period Month";
            PeriodYear:=objPeriod."Period Year";
            //objEmpTrans.RESET;
            //objEmpTrans.SETRANGE("Payroll Period",SelectedPeriod);
        END;
        */

        //Filter per period  - Dennis
        //SETFILTER("Payroll Period",FORMAT(objPeriod."Date Opened"));

    end;

    trigger OnOpenPage()
    begin
        if Status = Status::"Pending Approval" then
            IntEditable := true;
    end;

    var
        objTransCodes: Record "prTransaction Codes";
        SelectedPeriod: Date;
        objPeriod: Record "prPayroll Periods";
        PeriodName: Text[30];
        PeriodTrans: Record "prPeriod Transactions";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        blnIsLoan: Boolean;
        objEmpTrans: Record "prEmployee Transactions";
        transType: Text[30];
        objOcx: Codeunit prPayrollProcessing;
        strExtractedFrml: Text[30];
        curTransAmount: Decimal;
        empCode: Text[30];
        Employee: Record "HR-Employee";
        EmpTrans: Record "prEmployee Transactions";
        VitalSetUp: Record "prVital Setup Info";
        SalaryCard: Record "prSalary Card";
        TotalEarnings: Decimal;
        ArreasAmount: Decimal;
        ArrearsDays: Integer;
        NoOfMonthDays: Integer;
        i: Integer;
        RemainingDays: Integer;
        TDate: Date;
        PRTransactions: Record "prTransaction Codes";
        PrEmpTrans: Record "prEmployee Transactions";
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
        IntEditable: Boolean;
        TransCode: Record "prTransaction Codes";
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

    [Scope('OnPrem')]
    procedure ProcessLoan()
    begin
    end;
}


page 51534641 "prAssignEmployeeLoan Admin"
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
                    ApplicationArea = All;

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
                    ApplicationArea = all;

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
                field("Nominal Interest Rate"; "Nominal Interest Rate")
                {
                    Editable = IntEditable;
                    ApplicationArea = all;
                }
                field("Effective Interest Rate"; "Effective Interest Rate")
                {
                    Editable = IntEditable;
                    ApplicationArea = all;
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
                    end;
                    if Confirm(text001, false) then
                        GeneratePV;
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;

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
                ApplicationArea = all;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                    GenLedgSetup: Record "General Ledger Setup";
                //NoSeriesMgt: Codeunit NoSeriesManagement;
                begin
                    //IF ApprovalMgt.SendHREmpLoanApprovalReq(Rec) THEN;
                end;
            }
            action("Cancel Approval Re&quest")
            {
                Caption = 'Cancel Approval Re&quest';
                Image = CancelledEntries;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    //IF ApprovalMgt.CancelHREmpLoanRequest(Rec,TRUE,TRUE) THEN;
                end;
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
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        IntEditable: Boolean;
        TransCode: Record "prTransaction Codes";
        text001: Label 'Do you want to generate a Payment Voucher for the Loan?';

    [Scope('OnPrem')]
    procedure ProcessLoan()
    begin
    end;
}


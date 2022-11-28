page 51534642 "prAssignEmployeeLoans Admin"
{
    CardPageID = "prAssignEmployeeLoan Admin";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = prAssignEmployeeLoan;
    SourceTableView = WHERE(Status = FILTER(<> Posted));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = all;
                }


                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }


                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PRTransactions.Reset;
                        PRTransactions.SetRange(PRTransactions."IsCoop/LnRep", true);
                        if PAGE.RunModal(39005505, PRTransactions) = ACTION::LookupOK then begin
                            "Transaction Code" := PRTransactions."Transaction Code";
                            "Transaction Name" := PRTransactions."Transaction Name";
                        end
                    end;

                    trigger OnValidate()
                    begin
                        blnIsLoan := false;
                        if objTransCodes.Get("Transaction Code") then
                            "Transaction Name" := objTransCodes."Transaction Name";
                        "Payroll Period" := SelectedPeriod;
                        "Period Month" := PeriodMonth;
                        "Period Year" := PeriodYear;
                        if objTransCodes."Special Transactions" = 8 then blnIsLoan := true;

                        /*IF objTransCodes."Is Formula"=TRUE THEN
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
                    ApplicationArea = All;
                    Caption = 'Loan Balance';

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
                field(Status; Status)
                {
                    ApplicationArea = all;
                }


                field("Amortized Loan Total Repay Amt"; "Amortized Loan Total Repay Amt")
                {
                    ApplicationArea = all;
                }


                field(Suspended; Suspended)
                {
                    Visible = false;
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
                            if PrEmpTrans.Insert then
                                Status := Status::Posted;
                            Modify;
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
        }
    }

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

    [Scope('OnPrem')]
    procedure ProcessLoan()
    begin
    end;
}


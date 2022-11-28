page 51534431 "Allowance Var"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "prPayroll Variations";
    SourceTableView = WHERE(Processed = CONST(false),
                            "Transaction Type" = CONST(Income));
    AdditionalSearchTerms = 'Allowance Var';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(New)
            {
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = all;
                }
                field("Employee Names"; "Employee Names")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        blnIsLoan := FALSE;
                        IF objTransCodes.GET("Transaction Code") THEN
                            "Transaction Name" := objTransCodes."Transaction Name";
                        Frequency := objTransCodes.Frequency;
                        "Payroll Period" := SelectedPeriod;
                        "Period Month" := PeriodMonth;
                        "Period Year" := PeriodYear;
                        IF objTransCodes."Special Transactions" = 8 THEN blnIsLoan := TRUE;

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
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Frequency; Frequency)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("No of Units"; "No of Units")
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (blnIsLoan = TRUE) AND (Balance > 0) AND (Amount > 0) THEN BEGIN
                            "#of Repayments" := ROUND(Balance / Amount, 1, '>');
                            "#of Repayments" := ROUND("#of Repayments", 1, '>');
                        END;
                    end;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (blnIsLoan = TRUE) AND (Balance > 0) AND (Amount > 0) THEN BEGIN
                            "#of Repayments" := ROUND(Balance / Amount, 1, '>');
                            "#of Repayments" := ROUND("#of Repayments", 1, '>');
                        END;
                    end;
                }
                field("#of Repayments"; "#of Repayments")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        IF blnIsLoan = TRUE THEN BEGIN
                            "#of Repayments" := ROUND(Balance / Amount, 1, '>');
                            "#of Repayments" := ROUND("#of Repayments", 1, '>');
                        END;
                    end;
                }
                field("Amortized Loan Total Repay Amt"; "Amortized Loan Total Repay Amt")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Payroll Period"; "Payroll Period")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Membership; Membership)
                {
                    ApplicationArea = all;
                }
                field("Loan Number"; "Loan Number")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Reference No"; "Reference No")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("End Date"; "End Date")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Suspended; Suspended)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Stop for Next Period"; "Stop for Next Period")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Employer Amount"; "Employer Amount")
                {
                    ApplicationArea = all;
                }
                field("Employer Balance"; "Employer Balance")
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
            action("Process All")
            {
                Caption = 'Process All';
                Image = Recalculate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF NOT CONFIRM('This will effect the changes to the employee transactions. ' +
                                    'Do you wish to continue?', FALSE) THEN BEGIN
                        EXIT;

                    END;


                    objPayrollPeriod.RESET;
                    objPayrollPeriod.SETRANGE(objPayrollPeriod.Closed, FALSE);
                    IF objPayrollPeriod.FIND('-') THEN BEGIN

                        TransVariation.RESET;
                        TransVariation.SETRANGE(TransVariation."Transaction Type", TransVariation."Transaction Type"::Income);
                        TransVariation.SETRANGE(TransVariation.Processed, FALSE);
                        TransVariation.SETRANGE(TransVariation."Payroll Period", objPayrollPeriod."Date Opened");
                        IF TransVariation.FIND('-') THEN BEGIN
                            REPEAT

                                EmpTrans.RESET;
                                EmpTrans.SETCURRENTKEY(EmpTrans."Employee Code", EmpTrans."Transaction Code");
                                EmpTrans.SETRANGE(EmpTrans."Employee Code", TransVariation."Employee Code");
                                EmpTrans.SETRANGE(EmpTrans."Transaction Code", TransVariation."Transaction Code");
                                EmpTrans.SETRANGE(EmpTrans."Payroll Period", objPayrollPeriod."Date Opened");
                                EmpTrans.SETRANGE(EmpTrans."Reference No", TransVariation."Reference No");
                                IF EmpTrans.FIND('-') THEN BEGIN
                                    EmpTrans.Amount := TransVariation.Amount;
                                    EmpTrans.Balance := TransVariation.Balance;
                                    EmpTrans."No Of Repayments" := TransVariation."#of Repayments";
                                    EmpTrans."No of Units" := TransVariation."No of Units";
                                    EmpTrans."Employer Amount" := TransVariation."Employer Amount";
                                    EmpTrans."Employer Balance" := TransVariation."Employer Balance";
                                    EmpTrans."Start Date" := TransVariation."Start Date";
                                    EmpTrans."End Date" := TransVariation."End Date";
                                    EmpTrans.Membership := TransVariation.Membership;
                                    EmpTrans."Loan Number" := TransVariation."Loan Number";
                                    EmpTrans."Payroll Code" := TransVariation."Payroll Code";
                                    EmpTrans.Suspended := TransVariation.Suspended;
                                    EmpTrans.MODIFY;

                                END ELSE BEGIN
                                    EmpTransR.INIT;
                                    EmpTransR."Employee Code" := TransVariation."Employee Code";
                                    EmpTransR."Transaction Code" := TransVariation."Transaction Code";
                                    EmpTransR."Reference No" := TransVariation."Reference No";
                                    EmpTransR."Period Month" := objPayrollPeriod."Period Month";
                                    EmpTransR."Period Year" := objPayrollPeriod."Period Year";
                                    EmpTransR."Payroll Period" := objPayrollPeriod."Date Opened";
                                    EmpTransR."Transaction Name" := TransVariation."Transaction Name";
                                    EmpTransR.Amount := TransVariation.Amount;
                                    EmpTransR.Balance := TransVariation.Balance;
                                    EmpTransR."No Of Repayments" := TransVariation."#of Repayments";
                                    EmpTransR."No of Units" := TransVariation."No of Units";
                                    EmpTransR."Employer Amount" := TransVariation."Employer Amount";
                                    EmpTransR."Employer Balance" := TransVariation."Employer Balance";
                                    EmpTransR."Start Date" := TransVariation."Start Date";
                                    EmpTransR."End Date" := TransVariation."End Date";
                                    EmpTransR.Membership := TransVariation.Membership;
                                    EmpTransR."Loan Number" := TransVariation."Loan Number";
                                    EmpTransR."Payroll Code" := TransVariation."Payroll Code";
                                    EmpTransR.Suspended := TransVariation.Suspended;
                                    EmpTransR.INSERT;

                                END;

                                TransVariation.Processed := TRUE;
                                TransVariation.MODIFY;
                            UNTIL TransVariation.NEXT = 0;
                        END;

                    END;
                end;
            }
        }
    }

    trigger OnInit()
    begin

        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        IF objPeriod.FIND('-') THEN BEGIN
            SelectedPeriod := objPeriod."Date Opened";
            PeriodName := objPeriod."Period Name";
            PeriodMonth := objPeriod."Period Month";
            PeriodYear := objPeriod."Period Year";
            //objEmpTrans.RESET;
            //objEmpTrans.SETRANGE("Payroll Period",SelectedPeriod);
        END;

        //Filter per period  - Dennis
        SETFILTER("Payroll Period", FORMAT(objPeriod."Date Opened"));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Transaction Type" := "Transaction Type"::Income;
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
        objOcx: Codeunit "prPayrollProcessing";
        strExtractedFrml: Text[30];
        curTransAmount: Decimal;
        empCode: Text[30];
        EmpTrans: Record "prEmployee Transactions";
        EmpTransR: Record "prEmployee Transactions";
        TransVariation: Record "prPayroll Variations";
        objPayrollPeriod: Record "prPayroll Periods";
}


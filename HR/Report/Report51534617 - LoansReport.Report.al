report 51534617 "Loans Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LoansReport.rdlc';

    dataset
    {
        dataitem("prTransaction Codes"; "prTransaction Codes")
        {
            DataItemTableView = SORTING ("Transaction Code") ORDER(Ascending) WHERE ("IsCoop/LnRep" = CONST (true));
            column(GETFILTERS; GetFilters)
            {
            }
            column(USERID; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(GrandBalance; GrandBalance)
            {
            }
            column(GrandTotInt; GrandTotInt)
            {
            }
            column(GCount; GCount)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loan_TransactionsCaption; Loan_TransactionsCaptionLbl)
            {
            }
            column(prTransaction_Codes_Transaction_Code; "Transaction Code")
            {
            }
            dataitem("prPeriod Transactions"; "prPeriod Transactions")
            {
                DataItemLink = "Transaction Code" = FIELD ("Transaction Code");
                DataItemTableView = SORTING ("Group Order", "Transaction Code", "Period Month", "Period Year");
                RequestFilterFields = "Payroll Period", "Transaction Code";
                column(prPeriod_Transactions__prPeriod_Transactions___Transaction_Name_; "prPeriod Transactions"."Transaction Name")
                {
                }
                column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
                {
                }
                column(prPeriod_Transactions_Amount; Amount)
                {
                }
                column(prPeriod_Transactions_Balance; Balance)
                {
                }
                column(strEmpName; strEmpName)
                {
                }
                column(Interest; Interest)
                {
                }
                column(prPeriod_Transactions__Employee_Code_; "Employee Code")
                {
                }
                column(prPeriod_Transactions_Amount_Control1102755038; Amount)
                {
                }
                column(prPeriod_Transactions_Balance_Control1102755039; Balance)
                {
                }
                column(SubTotInt; SubTotInt)
                {
                }
                column(RCount; RCount)
                {
                }
                column(Transaction_NameCaption; Transaction_NameCaptionLbl)
                {
                }
                column(Period_AmountCaption; Period_AmountCaptionLbl)
                {
                }
                column(BalanceCaption; BalanceCaptionLbl)
                {
                }
                column(Employee_No_Caption; Employee_No_CaptionLbl)
                {
                }
                column(InterestCaption; InterestCaptionLbl)
                {
                }
                column(EmployeeCaption; EmployeeCaptionLbl)
                {
                }
                column(prPeriod_Transactions_Transaction_Code; "Transaction Code")
                {
                }
                column(prPeriod_Transactions_Period_Month; "Period Month")
                {
                }
                column(prPeriod_Transactions_Period_Year; "Period Year")
                {
                }
                column(prPeriod_Transactions_Membership; Membership)
                {
                }
                column(prPeriod_Transactions_Reference_No; "Reference No")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Get the staff details (header)
                    objEmp.SetRange(objEmp."No.", "Employee Code");
                    if objEmp.Find('-') then begin
                        strEmpName := objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";
                    end;

                    "prPeriod Transactions".SetRange("Payroll Period", SelectedPeriod);
                    "prPeriod Transactions".SetFilter("Group Order", '=7|=8');

                    if (Amount <= 0) or ("prPeriod Transactions"."Transaction Code" = 'TOT-DED') or ("prPeriod Transactions"."Group Order" = 1) then begin
                        GrandTotal := GrandTotal + 0;
                        CurrReport.Skip;
                    end;

                    Interest := 0;
                    prPeriodTrans.Reset;
                    prPeriodTrans.SetRange(prPeriodTrans."Employee Code", "prPeriod Transactions"."Employee Code");
                    prPeriodTrans.SetRange(prPeriodTrans."Transaction Code", "prPeriod Transactions"."Transaction Code" + '-INT');
                    prPeriodTrans.SetRange(prPeriodTrans."Payroll Period", "prPeriod Transactions"."Payroll Period");
                    if prPeriodTrans.Find('-') then begin
                        Interest := prPeriodTrans.Amount;
                        SubTotInt := SubTotInt + prPeriodTrans.Amount;
                        GrandTotInt := GrandTotInt + prPeriodTrans.Amount;
                    end;
                    GrandTotal := GrandTotal + Amount;
                    GrandBalance := GrandBalance + Balance;

                    RCount := RCount + 1;
                    GCount := GCount + 1;
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("Period Year");
                    Interest := 0;
                    SubTotInt := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                RCount := 0;
            end;

            trigger OnPreDataItem()
            begin
                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        SelectedPeriod := "prPeriod Transactions".GetRangeMin("Payroll Period");
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;



        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        PeriodTrans: Record "prPeriod Transactions";
        GroupOrder: Label '3';
        objPeriod: Record "prPayroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        GrandTotal: Decimal;
        strEmpName: Text[100];
        objEmp: Record "HR-Employee";
        GrandBalance: Decimal;
        CompanyInfo: Record "Company Information";
        Interest: Decimal;
        SubTotInt: Decimal;
        GrandTotInt: Decimal;
        prPeriodTrans: Record "prPeriod Transactions";
        RCount: Integer;
        GCount: Integer;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Loan_TransactionsCaptionLbl: Label 'Loan Transactions';
        Transaction_NameCaptionLbl: Label 'Transaction Name';
        Period_AmountCaptionLbl: Label 'Period Amount';
        BalanceCaptionLbl: Label 'Balance';
        Employee_No_CaptionLbl: Label 'Employee No.';
        InterestCaptionLbl: Label 'Interest';
        EmployeeCaptionLbl: Label 'Employee';
}


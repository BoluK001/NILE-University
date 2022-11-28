report 51534644 "prLoan Payment History"
{
    DefaultLayout = RDLC;
    RDLCLayout = './prLoanPaymentHistory.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = SORTING ("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
            RequestFilterFields = "Employee Code", "Transaction Code";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(prPeriod_Transactions__Employee_Code_; "Employee Code")
            {
            }
            column(EName; EName)
            {
            }
            column(prPeriod_Transactions__Transaction_Code_; "Transaction Code")
            {
            }
            column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(MonthName; MonthName)
            {
            }
            column(prPeriod_Transactions__Period_Year_; "Period Year")
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(prPeriod_Transactions_Balance; Balance)
            {
            }
            column(prPeriod_Transactions_Amount_Control1102755010; Amount)
            {
            }
            column(Employee_Transaction_HistoryCaption; Employee_Transaction_HistoryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(prPeriod_Transactions__Employee_Code_Caption; FieldCaption("Employee Code"))
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(TransactionCaption; TransactionCaptionLbl)
            {
            }
            column(Running_BalanceCaption; Running_BalanceCaptionLbl)
            {
            }
            column(prPeriod_Transactions_AmountCaption; FieldCaption(Amount))
            {
            }
            column(YearCaption; YearCaptionLbl)
            {
            }
            column(MonthCaption; MonthCaptionLbl)
            {
            }
            column(prPeriod_Transactions_Period_Month; "Period Month")
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
                MonthName := Format("prPeriod Transactions"."Payroll Period", 0, '<Month Text>');
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Transaction Code");
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

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        MonthName: Text[100];
        EName: Text[200];
        HREmployee: Record "HR-Employee";
        CompanyInfo: Record "Company Information";
        Employee_Transaction_HistoryCaptionLbl: Label 'Employee Transaction History';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employee_NameCaptionLbl: Label 'Employee Name';
        TransactionCaptionLbl: Label 'Transaction';
        Running_BalanceCaptionLbl: Label 'Running Balance';
        YearCaptionLbl: Label 'Year';
        MonthCaptionLbl: Label 'Month';
}


report 51534678 "Period Trans without Employee"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PeriodTranswithoutEmployee.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = SORTING ("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
            RequestFilterFields = "Payroll Period";
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
            column(prPeriod_Transactions__Employee_Code_; "Employee Code")
            {
            }
            column(prPeriod_Transactions__Transaction_Code_; "Transaction Code")
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
            column(prPeriod_TransactionsCaption; prPeriod_TransactionsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(prPeriod_Transactions__Employee_Code_Caption; FieldCaption("Employee Code"))
            {
            }
            column(prPeriod_Transactions__Transaction_Code_Caption; FieldCaption("Transaction Code"))
            {
            }
            column(prPeriod_Transactions__Transaction_Name_Caption; FieldCaption("Transaction Name"))
            {
            }
            column(prPeriod_Transactions_AmountCaption; FieldCaption(Amount))
            {
            }
            column(prPeriod_Transactions_BalanceCaption; FieldCaption(Balance))
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
        Employee: Record "HR-Employee";
        prPeriod_TransactionsCaptionLbl: Label 'prPeriod Transactions';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}


report 51534669 "Clear Weekend OT"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ClearWeekendOT.rdlc';

    dataset
    {
        dataitem("prEmployee Transactions"; "prEmployee Transactions")
        {
            DataItemTableView = SORTING ("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period", "Reference No") WHERE ("Payroll Period" = CONST (20121001D), "Transaction Code" = FILTER ('WKE' | 'E5411'));
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
            column(prEmployee_Transactions__Employee_Code_; "Employee Code")
            {
            }
            column(prEmployee_Transactions__Transaction_Code_; "Transaction Code")
            {
            }
            column(prEmployee_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(prEmployee_Transactions_Amount; Amount)
            {
            }
            column(prEmployee_TransactionsCaption; prEmployee_TransactionsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(prEmployee_Transactions__Employee_Code_Caption; FieldCaption("Employee Code"))
            {
            }
            column(prEmployee_Transactions__Transaction_Code_Caption; FieldCaption("Transaction Code"))
            {
            }
            column(prEmployee_Transactions__Transaction_Name_Caption; FieldCaption("Transaction Name"))
            {
            }
            column(prEmployee_Transactions_AmountCaption; FieldCaption(Amount))
            {
            }
            column(prEmployee_Transactions_Period_Month; "Period Month")
            {
            }
            column(prEmployee_Transactions_Period_Year; "Period Year")
            {
            }
            column(prEmployee_Transactions_Payroll_Period; "Payroll Period")
            {
            }
            column(prEmployee_Transactions_Reference_No; "Reference No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "prEmployee Transactions".Delete;
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
        prEmployee_TransactionsCaptionLbl: Label 'prEmployee Transactions';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}


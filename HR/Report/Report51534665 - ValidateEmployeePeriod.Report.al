report 51534665 "Validate Employee Period"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ValidateEmployeePeriod.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
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
            column(prEmployee_TransactionsCaption; prEmployee_TransactionsCaptionLbl)
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
                /*
                HREmployee.RESET;
                HREmployee.SETRANGE(HREmployee."No.","prEmployee Transactions"."Employee Code");
                IF HREmployee.FIND('-') THEN BEGIN
                IF HREmployee.Status <> HREmployee.Status::Normal THEN
                "prEmployee Transactions".DELETE;
                END ELSE BEGIN
                "prEmployee Transactions".DELETE;
                END;
                
                IF Trans.GET("prEmployee Transactions"."Transaction Code") THEN BEGIN
                //"prEmployee Transactions"."Transaction Name":=Trans."Transaction Name";
                //"prEmployee Transactions".MODIFY;
                IF "prEmployee Transactions".Balance <> 0 THEN BEGIN
                
                IF AdjustRunningBal = AdjustRunningBal::"Increase 1 Installment" THEN BEGIN
                IF Trans."Transaction Type" = Trans."Transaction Type"::Income THEN
                "prEmployee Transactions".Balance:="prEmployee Transactions".Balance+"prEmployee Transactions".Amount
                ELSE
                "prEmployee Transactions".Balance:="prEmployee Transactions".Balance-"prEmployee Transactions".Amount;
                
                "prEmployee Transactions".MODIFY;
                END;
                
                
                IF AdjustRunningBal = AdjustRunningBal::"Reduce 1 Installment" THEN BEGIN
                IF Trans."Transaction Type" = Trans."Transaction Type"::Income THEN
                "prEmployee Transactions".Balance:="prEmployee Transactions".Balance-"prEmployee Transactions".Amount
                ELSE
                "prEmployee Transactions".Balance:="prEmployee Transactions".Balance+"prEmployee Transactions".Amount;
                "prEmployee Transactions".MODIFY;
                
                END;
                
                END;
                IF Trans.Pension = TRUE THEN BEGIN
                "prEmployee Transactions"."Employer Amount":="prEmployee Transactions".Amount;
                "prEmployee Transactions"."Employer Balance":="prEmployee Transactions".Balance;
                "prEmployee Transactions".MODIFY;
                END;
                END;
                */
                if Trans.Get("Transaction Code") = false then
                    Error('%1 %2', "Employee Code", "Transaction Code");
                HREmployee.Reset;
                HREmployee.SetRange(HREmployee."No.", "Employee Code");
                if HREmployee.Find('-') = false then
                    Error('%1 %2', "Employee Code", "Transaction Code");

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
        HREmployee: Record "HR-Employee";
        AdjustRunningBal: Option " ","Reduce 1 Installment","Increase 1 Installment";
        Trans: Record "prTransaction Codes";
        prEmployee_TransactionsCaptionLbl: Label 'prEmployee Transactions';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}


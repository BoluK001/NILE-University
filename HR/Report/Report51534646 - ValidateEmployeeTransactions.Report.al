report 51534646 "Validate Employee Transactions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ValidateEmployeeTransactions.rdlc';

    dataset
    {
        dataitem("prEmployee Transactions"; "prEmployee Transactions")
        {
            DataItemTableView = SORTING ("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period", "Reference No");
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
                HREmployee.Reset;
                HREmployee.SetRange(HREmployee."No.", "prEmployee Transactions"."Employee Code");
                if HREmployee.Find('-') then begin
                    if HREmployee.Status <> HREmployee.Status::Normal then begin
                        "prEmployee Transactions".Delete;
                        CurrReport.Skip;
                    end;
                end else begin
                    "prEmployee Transactions".Delete;
                    CurrReport.Skip;
                end;

                if Trans.Get("prEmployee Transactions"."Transaction Code") then begin
                    "prEmployee Transactions"."Transaction Name" := Trans."Transaction Name";
                    "prEmployee Transactions".Modify;
                    if "prEmployee Transactions".Balance <> 0 then begin

                        if AdjustRunningBal = AdjustRunningBal::"Increase 1 Installment" then begin
                            if Trans."Transaction Type" = Trans."Transaction Type"::Income then
                                "prEmployee Transactions".Balance := "prEmployee Transactions".Balance + "prEmployee Transactions".Amount
                            else
                                "prEmployee Transactions".Balance := "prEmployee Transactions".Balance - "prEmployee Transactions".Amount;

                            "prEmployee Transactions".Modify;
                        end;


                        if AdjustRunningBal = AdjustRunningBal::"Reduce 1 Installment" then begin
                            if Trans."Transaction Type" = Trans."Transaction Type"::Income then
                                "prEmployee Transactions".Balance := "prEmployee Transactions".Balance - "prEmployee Transactions".Amount
                            else
                                "prEmployee Transactions".Balance := "prEmployee Transactions".Balance + "prEmployee Transactions".Amount;
                            "prEmployee Transactions".Modify;

                        end;

                    end;
                    if Trans.Pension = true then begin
                        "prEmployee Transactions"."Employer Amount" := "prEmployee Transactions".Amount;
                        "prEmployee Transactions"."Employer Balance" := "prEmployee Transactions".Balance;
                        "prEmployee Transactions".Modify;
                    end;
                end;
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


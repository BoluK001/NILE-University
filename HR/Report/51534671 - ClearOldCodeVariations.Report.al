report 51534671 "Clear Old Code Variations"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ClearOldCodeVariations.rdlc';

    dataset
    {
        dataitem("prPayroll Variations"; "prPayroll Variations")
        {
            DataItemTableView = SORTING ("Transaction Type", "Employee Code", "Transaction Code", "Reference No", "Period Month", "Period Year", "Payroll Period") WHERE ("Payroll Period" = CONST (20121001D), "Transaction Code" = FILTER ('E*'));
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
            column(prPayroll_Variations__Employee_Code_; "Employee Code")
            {
            }
            column(prPayroll_Variations__Transaction_Code_; "Transaction Code")
            {
            }
            column(prPayroll_Variations__Transaction_Name_; "Transaction Name")
            {
            }
            column(prPayroll_Variations_Amount; Amount)
            {
            }
            column(prPayroll_Variations_Balance; Balance)
            {
            }
            column(prPayroll_VariationsCaption; prPayroll_VariationsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(prPayroll_Variations__Employee_Code_Caption; FieldCaption("Employee Code"))
            {
            }
            column(prPayroll_Variations__Transaction_Code_Caption; FieldCaption("Transaction Code"))
            {
            }
            column(prPayroll_Variations__Transaction_Name_Caption; FieldCaption("Transaction Name"))
            {
            }
            column(prPayroll_Variations_AmountCaption; FieldCaption(Amount))
            {
            }
            column(prPayroll_Variations_BalanceCaption; FieldCaption(Balance))
            {
            }
            column(prPayroll_Variations_Transaction_Type; "Transaction Type")
            {
            }
            column(prPayroll_Variations_Reference_No; "Reference No")
            {
            }
            column(prPayroll_Variations_Period_Month; "Period Month")
            {
            }
            column(prPayroll_Variations_Period_Year; "Period Year")
            {
            }
            column(prPayroll_Variations_Payroll_Period; "Payroll Period")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "prPayroll Variations".Delete;
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
        prPayroll_VariationsCaptionLbl: Label 'prPayroll Variations';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}


report 51534620 "prEmployeeTransation ads"
{
    DefaultLayout = RDLC;
    RDLCLayout = './prEmployeeTransationads.rdlc';

    dataset
    {
        dataitem("prEmployee Transactions Ads"; "prEmployee Transactions Ads")
        {
            DataItemTableView = SORTING ("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period", "Reference No") WHERE (Amount = FILTER (<> 0));
            RequestFilterFields = "Payroll Period", "Employee Code", imported;
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
            column(prEmployee_Transactions_Ads__Employee_Code_; "Employee Code")
            {
            }
            column(prEmployee_Transactions_Ads_Amount; Amount)
            {
            }
            column(prEmployee_Transactions_Ads_Balance; Balance)
            {
            }
            column(prEmployee_Transactions_Ads_imported; imported)
            {
            }
            column(prEmployee_Transactions_Ads__Transaction_Code_; "Transaction Code")
            {
            }
            column(prEmployee_Transactions_Ads__Reference_No_; "Reference No")
            {
            }
            column(prEmployee_Transactions_AdsCaption; prEmployee_Transactions_AdsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(prEmployee_Transactions_Ads__Employee_Code_Caption; FieldCaption("Employee Code"))
            {
            }
            column(prEmployee_Transactions_Ads_AmountCaption; FieldCaption(Amount))
            {
            }
            column(prEmployee_Transactions_Ads_BalanceCaption; FieldCaption(Balance))
            {
            }
            column(prEmployee_Transactions_Ads_importedCaption; FieldCaption(imported))
            {
            }
            column(prEmployee_Transactions_Ads__Transaction_Code_Caption; FieldCaption("Transaction Code"))
            {
            }
            column(prEmployee_Transactions_Ads__Reference_No_Caption; FieldCaption("Reference No"))
            {
            }
            column(prEmployee_Transactions_Ads_Period_Month; "Period Month")
            {
            }
            column(prEmployee_Transactions_Ads_Period_Year; "Period Year")
            {
            }
            column(prEmployee_Transactions_Ads_Payroll_Period; "Payroll Period")
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Employee Code");
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
        prEmployee_Transactions_AdsCaptionLbl: Label 'prEmployee Transactions Ads';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}


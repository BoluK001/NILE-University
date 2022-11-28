report 51534661 "Transactions - Detailed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TransactionsDetailed.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = SORTING ("Transaction Code", "Employee Code", "Payroll Period");
            RequestFilterFields = "Payroll Period", "Transaction Code";
            column(GETFILTERS; GetFilters)
            {
            }
            column(USERID; UserId)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(prPeriod_Transactions__Transaction_Code_; "Transaction Code")
            {
            }
            column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(prPeriod_Transactions__Employee_Code_; "Employee Code")
            {
            }
            column(prPeriod_Transactions_Membership; Membership)
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(prPeriod_Transactions_Balance; Balance)
            {
            }
            column(EmpName; EmpName)
            {
            }
            column(prPeriod_Transactions_Amount_Control1102755029; Amount)
            {
            }
            column(prPeriod_Transactions_Balance_Control1102755030; Balance)
            {
            }
            column(RCount; RCount)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Transactions___DetailedCaption; Transactions___DetailedCaptionLbl)
            {
            }
            column(prPeriod_Transactions__Transaction_Code_Caption; FieldCaption("Transaction Code"))
            {
            }
            column(prPeriod_Transactions__Transaction_Name_Caption; FieldCaption("Transaction Name"))
            {
            }
            column(prPeriod_Transactions_BalanceCaption; FieldCaption(Balance))
            {
            }
            column(prPeriod_Transactions_AmountCaption; FieldCaption(Amount))
            {
            }
            column(Membership_No_Caption; Membership_No_CaptionLbl)
            {
            }
            column(prPeriod_Transactions__Employee_Code_Caption; FieldCaption("Employee Code"))
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(prPeriod_Transactions_Period_Month; "Period Month")
            {
            }
            column(prPeriod_Transactions_Period_Year; "Period Year")
            {
            }
            column(prPeriod_Transactions_Reference_No; "Reference No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                EmpName := '';
                if Employee.Get("Employee Code") then begin
                    EmpName := Employee."Last Name" + ' ' + Employee."First Name" + ' ' + Employee."Middle Name";
                end;

                RCount := RCount + 1;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Transaction Code");

                RCount := 1;

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
        Employee: Record "HR-Employee";
        EmpName: Text[200];
        RCount: Integer;
        CompanyInfo: Record "Company Information";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Transactions___DetailedCaptionLbl: Label 'Transactions - Detailed';
        Membership_No_CaptionLbl: Label 'Membership No.';
        NamesCaptionLbl: Label 'Names';
}


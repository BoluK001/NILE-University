report 51534653 "Payroll - Global"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayrollGlobal.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = SORTING ("Group Order", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No", "Department Code");
            RequestFilterFields = "Payroll Period", "Location/Division", Department, "Cost Centre", "Salary Grade", "Salary Notch";
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
            column(GETFILTERS; GetFilters)
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(prPeriod_Transactions__Transaction_Code_; "Transaction Code")
            {
            }
            column(Reconciliation___SummaryCaption; Reconciliation___SummaryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(prPeriod_Transactions_Employee_Code; "Employee Code")
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
            column(prPeriod_Transactions_Group_Order; "Group Order")
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Transaction Code");
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
        Reconciliation___SummaryCaptionLbl: Label 'Reconciliation - Summary';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CodeCaptionLbl: Label 'Code';
        DescriptionCaptionLbl: Label 'Description';
        AmountCaptionLbl: Label 'Amount';
}


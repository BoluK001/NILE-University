report 51534628 "Other Deductions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './OtherDeductions.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = SORTING (Membership) WHERE (Membership = FILTER (<> ''));
            RequestFilterFields = Membership, "Payroll Period";
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(prPeriod_Transactions_Membership; Membership)
            {
            }
            column(Employee_Code_______Names; "Employee Code" + ': ' + Names)
            {
            }
            column(prPeriod_Transactions__Reference_No_; "Reference No")
            {
            }
            column(Transaction_Code________Transaction_Name_; "Transaction Code" + ': ' + "Transaction Name")
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(TOTAL_; 'TOTAL')
            {
            }
            column(prPeriod_Transactions_Amount_Control1102756026; Amount)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(Other_DeductionsCaption; Other_DeductionsCaptionLbl)
            {
            }
            column(Employee_DetailsCaption; Employee_DetailsCaptionLbl)
            {
            }
            column(Membership_NoCaption; Membership_NoCaptionLbl)
            {
            }
            column(Transaction_DetailsCaption; Transaction_DetailsCaptionLbl)
            {
            }
            column(prPeriod_Transactions_AmountCaption; FieldCaption(Amount))
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(prPeriod_Transactions_Employee_Code; "Employee Code")
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

            trigger OnAfterGetRecord()
            begin
                //IF "prPeriod Transactions".Membership='' THEN
                // CurrReport.SKIP;
                Names := '';
                if HrEmp.Get("prPeriod Transactions"."Employee Code") then
                    Names := HrEmp."First Name" + ' ' + HrEmp."Middle Name" + ' ' + HrEmp."Last Name";
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo(Membership);
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
        HrEmp: Record "HR-Employee";
        Names: Text[100];
        CompanyInfo: Record "Company Information";
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Page_No_CaptionLbl: Label 'Page No:';
        Other_DeductionsCaptionLbl: Label 'Other Deductions';
        Employee_DetailsCaptionLbl: Label 'Employee Details';
        Membership_NoCaptionLbl: Label 'Membership No';
        Transaction_DetailsCaptionLbl: Label 'Transaction Details';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                 DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                   DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..              DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
}


report 51534640 "Deductions to Organizations"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DeductionstoOrganizations.rdlc';

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
            column(prPeriod_Transactions__Employee_Code_; "Employee Code")
            {
            }
            column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(Names; Names)
            {
            }
            column(TOTALS_; 'TOTALS')
            {
            }
            column(prPeriod_Transactions_Amount_Control1102756020; Amount)
            {
            }
            column(RemittancesCaption; RemittancesCaptionLbl)
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
            column(prPeriod_Transactions__Employee_Code_Caption; FieldCaption("Employee Code"))
            {
            }
            column(prPeriod_Transactions__Transaction_Name_Caption; FieldCaption("Transaction Name"))
            {
            }
            column(prPeriod_Transactions_AmountCaption; FieldCaption(Amount))
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
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
            column(prPeriod_Transactions_Reference_No; "Reference No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Names := '';
                if HrEmp.Get("prPeriod Transactions"."Employee Code") then
                    Names := HrEmp."First Name" + ' ' + HrEmp."Middle Name" + ' ' + HrEmp."Last Name";
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo(Membership);
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

    trigger OnPreReport()
    begin
        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        Names: Text[50];
        HrEmp: Record "HR-Employee";
        CompanyInfo: Record "Company Information";
        RemittancesCaptionLbl: Label 'Remittances';
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Page_No_CaptionLbl: Label 'Page No:';
        NamesCaptionLbl: Label 'Names';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..              DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                   DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                 DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
}


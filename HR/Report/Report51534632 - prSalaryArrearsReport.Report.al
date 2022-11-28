report 51534632 "prSalary Arrears Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './prSalaryArrearsReport.rdlc';

    dataset
    {
        dataitem("prSalary Arrears"; "prSalary Arrears")
        {
            DataItemTableView = SORTING ("Employee Code", "Period Month", "Period Year");
            RequestFilterFields = "Employee Code";
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
            column(prSalary_Arrears__Employee_Code_; "Employee Code")
            {
            }
            column(Names; Names)
            {
            }
            column(prSalary_Arrears__Employee_Code__Control1102756011; "Employee Code")
            {
            }
            column(prSalary_Arrears__Transaction_Code_; "Transaction Code")
            {
            }
            column(prSalary_Arrears__Start_Date_; "Start Date")
            {
            }
            column(prSalary_Arrears__End_Date_; "End Date")
            {
            }
            column(prSalary_Arrears__Salary_Arrears_; "Salary Arrears")
            {
            }
            column(prSalary_Arrears__PAYE_Arrears_; "PAYE Arrears")
            {
            }
            column(prSalary_Arrears__Period_Month_; "Period Month")
            {
            }
            column(prSalary_Arrears__Period_Year_; "Period Year")
            {
            }
            column(prSalary_Arrears__Current_Basic_; "Current Basic")
            {
            }
            column(prSalary_Arrears__Payroll_Period_; "Payroll Period")
            {
            }
            column(TOTALS_; 'TOTALS')
            {
            }
            column(prSalary_Arrears__Salary_Arrears__Control1102756041; "Salary Arrears")
            {
            }
            column(prSalary_Arrears__PAYE_Arrears__Control1102756042; "PAYE Arrears")
            {
            }
            column(prSalary_Arrears__Current_Basic__Control1102756043; "Current Basic")
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
            column(Salary_ArrearsCaption; Salary_ArrearsCaptionLbl)
            {
            }
            column(prSalary_Arrears__Employee_Code__Control1102756011Caption; FieldCaption("Employee Code"))
            {
            }
            column(prSalary_Arrears__Transaction_Code_Caption; FieldCaption("Transaction Code"))
            {
            }
            column(prSalary_Arrears__Start_Date_Caption; FieldCaption("Start Date"))
            {
            }
            column(prSalary_Arrears__End_Date_Caption; FieldCaption("End Date"))
            {
            }
            column(prSalary_Arrears__Salary_Arrears_Caption; FieldCaption("Salary Arrears"))
            {
            }
            column(prSalary_Arrears__PAYE_Arrears_Caption; FieldCaption("PAYE Arrears"))
            {
            }
            column(prSalary_Arrears__Period_Month_Caption; FieldCaption("Period Month"))
            {
            }
            column(prSalary_Arrears__Period_Year_Caption; FieldCaption("Period Year"))
            {
            }
            column(prSalary_Arrears__Current_Basic_Caption; FieldCaption("Current Basic"))
            {
            }
            column(prSalary_Arrears__Payroll_Period_Caption; FieldCaption("Payroll Period"))
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

    trigger OnPreReport()
    begin
        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

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
        Salary_ArrearsCaptionLbl: Label 'Salary Arrears';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                 DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                   DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..              DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
}


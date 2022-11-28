report 51534615 "prDeductions Report2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './prDeductionsReport2.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = SORTING ("Group Order", "Transaction Code", "Period Month", "Period Year");
            RequestFilterFields = "Payroll Period", "Transaction Code";
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(Deductions_Summary_ReportCaption; Deductions_Summary_ReportCaptionLbl)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(Transaction_Name_Caption; Transaction_Name_CaptionLbl)
            {
            }
            column(Period_Amount_Caption; Period_Amount_CaptionLbl)
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
            column(Grand_Total_Caption; Grand_Total_CaptionLbl)
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
            column(prPeriod_Transactions_Membership; Membership)
            {
            }
            column(prPeriod_Transactions_Reference_No; "Reference No")
            {
            }
            column(prPeriod_Transactions_Group_Order; "Group Order")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Get the staff details (header)
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then begin
                    strEmpName := objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";
                end;

                if (Amount <= 0) or ("prPeriod Transactions"."Transaction Code" = 'TOT-DED') or ("prPeriod Transactions"."Group Order" = 1) then begin
                    GrandTotal := GrandTotal + 0;
                    CurrReport.Skip;
                end;

                GrandTotal := GrandTotal + Amount;
                GrandBalance := GrandBalance + Balance;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Period Year");
                "prPeriod Transactions".SetRange("Payroll Period", SelectedPeriod);
                "prPeriod Transactions".SetFilter("Group Order", '=7|=8');
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
        SelectedPeriod := "prPeriod Transactions".GetRangeMin("Payroll Period");
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;


        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        PeriodTrans: Record "prPeriod Transactions";
        GroupOrder: Label '3';
        objPeriod: Record "prPayroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        GrandTotal: Decimal;
        strEmpName: Text[100];
        objEmp: Record "HR-Employee";
        GrandBalance: Decimal;
        CompanyInfo: Record "Company Information";
        Deductions_Summary_ReportCaptionLbl: Label 'Deductions Summary Report';
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        Transaction_Name_CaptionLbl: Label 'Transaction Name:';
        Period_Amount_CaptionLbl: Label 'Period Amount:';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                 DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                   DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..              DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Grand_Total_CaptionLbl: Label 'Grand Total:';
}


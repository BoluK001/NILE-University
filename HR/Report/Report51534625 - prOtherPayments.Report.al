report 51534625 "prOther Payments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './prOtherPayments.rdlc';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = SORTING ("No.") ORDER(Ascending) WHERE ("Bank Account Number" = FILTER (''));
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
            column(companyinfo_Picture; companyinfo.Picture)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(TaxablePay; TaxablePay)
            {
            }
            column(HR_Employee__HR_Employee___No__; "HR-Employee"."No.")
            {
            }
            column(icount; icount)
            {
            }
            column(TotTaxablePay; TotTaxablePay)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(FOSA_PAYMENT_REPORTCaption; FOSA_PAYMENT_REPORTCaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(Net_Amount_Caption; Net_Amount_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
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
            column(Total_Caption; Total_CaptionLbl)
            {
            }
            dataitem("prSalary Card"; "prSalary Card")
            {
                DataItemLink = "Employee Code" = FIELD ("No.");
                RequestFilterFields = "Period Filter", "Employee Code";

                trigger OnAfterGetRecord()
                begin
                    //  bankAcc:='';
                    //  mainBankNM:='';
                    //  BranchBankNM:='';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                mainBankNM := '';
                BranchBankNM := '';

                EmployeeName := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";

                bankAcc := objEmp."Bank Account Number";

                bankStruct.Reset;
                bankStruct.SetRange(bankStruct."Bank Code", "Main Bank");
                bankStruct.SetRange(bankStruct."Branch Code", "Branch Bank");
                if bankStruct.Find('-') then begin
                    mainBankNM := bankStruct."Bank Name";
                    BranchBankNM := bankStruct."Branch Name";
                end;


                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);

                TaxablePay := 0;
                if PeriodTrans.Find('-') then
                    repeat
                        //TXBP Taxable Pay -  BY DENNIS
                        if (PeriodTrans."Transaction Code" = 'NPAY') then begin
                            TaxablePay := PeriodTrans.Amount;
                        end;
                    until PeriodTrans.Next = 0;

                TotTaxablePay := TotTaxablePay + TaxablePay;
                TotPayeAmount := TotPayeAmount + PayeAmount;
                icount := icount + 1;
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
        PeriodFilter := "prSalary Card".GetFilter("Period Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "prSalary Card".GetRangeMin("Period Filter");
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";


        if companyinfo.Get() then
            companyinfo.CalcFields(companyinfo.Picture);
    end;

    var
        PeriodTrans: Record "prPeriod Transactions";
        PayeAmount: Decimal;
        TotPayeAmount: Decimal;
        TaxablePay: Decimal;
        TotTaxablePay: Decimal;
        EmployeeName: Text[30];
        PinNumber: Text[30];
        objPeriod: Record "prPayroll Periods";
        objEmp: Record "HR-Employee";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        companyinfo: Record "Company Information";
        bankStruct: Record "prBank Structure";
        bankAcc: Text[50];
        BranchBankNM: Text[100];
        mainBankNM: Text[100];
        icount: Integer;
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        FOSA_PAYMENT_REPORTCaptionLbl: Label 'FOSA PAYMENT REPORT';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        Net_Amount_CaptionLbl: Label 'Net Amount:';
        Employee_NameCaptionLbl: Label 'Employee Name';
        No_CaptionLbl: Label 'No:';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..              DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                   DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                 DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Total_CaptionLbl: Label 'Total:';
}


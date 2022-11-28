report 51534624 "prBank Payments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './prBankPayments.rdlc';

    dataset
    {
        dataitem("prBank Structure"; "prBank Structure")
        {
            RequestFilterFields = "Bank Code", "Branch Code";
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
            column(prBank_Structure__Bank_Code_; "Bank Code")
            {
            }
            column(prBank_Structure__Branch_Code_; "Branch Code")
            {
            }
            column(prBank_Structure__Bank_Name_; "Bank Name")
            {
            }
            column(prBank_Structure__Branch_Name_; "Branch Name")
            {
            }
            column(TotTaxablePay; TotTaxablePay)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Bank_Payment_ScheduleCaption; Bank_Payment_ScheduleCaptionLbl)
            {
            }
            column(BankCaption; BankCaptionLbl)
            {
            }
            column(BranchCaption; BranchCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(Net_AmountCaption; Net_AmountCaptionLbl)
            {
            }
            column(Employee_BankCaption; Employee_BankCaptionLbl)
            {
            }
            column(Bank_BranchCaption; Bank_BranchCaptionLbl)
            {
            }
            column(Total_Caption; Total_CaptionLbl)
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
            dataitem("HR-Employee"; "HR-Employee")
            {
                DataItemLink = "Main Bank" = FIELD ("Bank Code"), "Branch Bank" = FIELD ("Branch Code");
                DataItemTableView = SORTING ("No.") ORDER(Ascending);
                column(HR_Employee_No_; "No.")
                {
                }
                column(HR_Employee_Main_Bank; "Main Bank")
                {
                }
                column(HR_Employee_Branch_Bank; "Branch Bank")
                {
                }
                dataitem("prSalary Card"; "prSalary Card")
                {
                    DataItemLink = "Employee Code" = FIELD ("No.");
                    RequestFilterFields = "Period Filter", "Location/Division", Department, "Cost Centre", "Salary Grade", "Salary Notch";
                    column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
                    {
                    }
                    column(EmployeeName; EmployeeName)
                    {
                    }
                    column(TaxablePay; TaxablePay)
                    {
                    }
                    column(bankAcc; bankAcc)
                    {
                    }
                    column(mainBankNM; mainBankNM)
                    {
                    }
                    column(BranchBankNM; BranchBankNM)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //  bankAcc:='';
                        //  mainBankNM:='';
                        //  BranchBankNM:='';

                        objEmp.Reset;
                        objEmp.SetRange(objEmp."No.", "Employee Code");
                        if objEmp.Find('-') then
                            EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                        //Bank Details
                        bankAcc := objEmp."Bank Account Number";

                        bankStruct.Reset;
                        bankStruct.SetRange(bankStruct."Bank Code", objEmp."Main Bank");
                        bankStruct.SetRange(bankStruct."Branch Code", objEmp."Branch Bank");
                        if bankStruct.Find('-') then begin
                            mainBankNM := bankStruct."Bank Name";
                            BranchBankNM := bankStruct."Branch Name";
                        end;

                        PeriodTrans.Reset;
                        PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
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
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                TotTaxablePay := 0;
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
        EmployeeName: Text[200];
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
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Bank_Payment_ScheduleCaptionLbl: Label 'Bank Payment Schedule';
        BankCaptionLbl: Label 'Bank';
        BranchCaptionLbl: Label 'Branch';
        No_CaptionLbl: Label 'No:';
        Employee_NameCaptionLbl: Label 'Employee Name';
        Account_No_CaptionLbl: Label 'Account No.';
        Net_AmountCaptionLbl: Label 'Net Amount';
        Employee_BankCaptionLbl: Label 'Employee Bank';
        Bank_BranchCaptionLbl: Label 'Bank Branch';
        Total_CaptionLbl: Label 'Total:';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                 DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                   DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..              DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
}


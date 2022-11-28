report 51534584 "prAnnual Income And Tax"
{
    DefaultLayout = RDLC;
    RDLCLayout = './prAnnualIncomeAndTax.rdlc';

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            RequestFilterFields = "Period Filter", "Location/Division", Department, "Cost Centre", "Salary Grade", "Salary Notch";
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
            column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(PayeAmount; PayeAmount)
            {
            }
            column(TaxablePay; TaxablePay)
            {
            }
            column(TotTaxablePay; TotTaxablePay)
            {
            }
            column(TotPayeAmounts; TotPayeAmount)
            {
            }
            column(RCount; RCount)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(P_A_Y_E_ScheduleCaption; P_A_Y_E_ScheduleCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(Paye_AmountCaption; Paye_AmountCaptionLbl)
            {
            }
            column(Taxable_PayCaption; Taxable_PayCaptionLbl)
            {
            }
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }
            column(GPAYS; GPAYS)
            {
            }
            column(Zone; Zone)
            {
            }
            column(Depts; Depts)
            {
            }
            column(BranchName; BranchName)
            {
            }
            column(LocationDivision_prSalaryCard; BranchName)
            {
            }
            column(Department_prSalaryCard; "prSalary Card".Department)
            {
            }
            column(EmpLevel; EmpLevel)
            {
            }
            column(SalaryNotch_prSalaryCard; "prSalary Card"."Salary Notch")
            {
            }
            column(NoOfmonths; 12)
            {
            }
            column(Periodend; Format(DMY2Date(31, 12, Date2DMY(SelectedPeriod, 3))))
            {
            }
            column(EmpNation; EmpNation)
            {
            }

            trigger OnAfterGetRecord()
            begin
                EmpNation := '';
                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then begin
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                    BranchName := objEmp."Global Dimension 2 Code";
                    EmpLevel := objEmp."Salary Grade";
                    EmpNation := objEmp.Citizenship;
                end;
                /*Zone:=objEmp.Zone;
                Depts:=objEmp."Department Name";
                BranchName:=objEmp."Location Name";


                PinNumber:=objEmp."PIN No.";*/

                TaxablePay := 0;
                PayeAmount := 0;
                GPAYS := 0;

                for I := 1 to 12 do begin
                    PeriodTrans.Reset;
                    PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", DMY2Date(1, I, Date2DMY(SelectedPeriod, 3)));
                    if PeriodTrans.Find('-') then begin
                        repeat
                            if PeriodTrans."Transaction Code" = 'GPAY' then
                                GPAYS += PeriodTrans.Amount;

                            if (PeriodTrans."Group Order" = 7) and (PeriodTrans."Sub Group Order" = 3) or (PeriodTrans."Transaction Code" = 'PAYE-CALC') then
                                PayeAmount += PeriodTrans.Amount;
                        until PeriodTrans.Next = 0;
                    end;
                end;

                //IF PayeAmount<=0 THEN
                //CurrReport.SKIP;

                TotTaxablePay := TotTaxablePay + TaxablePay;
                TotPayeAmount := TotPayeAmount + PayeAmount;

                RCount := RCount + 1;

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
        objEmp: Record "HR Employees";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        companyinfo: Record "Company Information";
        RCount: Integer;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        P_A_Y_E_ScheduleCaptionLbl: Label 'P.A.Y.E Schedule';
        No_CaptionLbl: Label 'No.';
        Employee_NameCaptionLbl: Label 'Employee Name';
        Paye_AmountCaptionLbl: Label 'Paye Amount';
        Taxable_PayCaptionLbl: Label 'Taxable Pay';
        Totals_CaptionLbl: Label 'Totals:';
        GPAYS: Decimal;
        Zone: Text[30];
        Depts: Text[30];
        BranchName: Text[30];
        EmpLevel: Code[20];
        I: Integer;
        EmpNation: Text;
}


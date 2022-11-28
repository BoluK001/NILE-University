report 51534792 "prPaye Schedule per loc"
{
    DefaultLayout = RDLC;
    RDLCLayout = './prPayeScheduleperloc.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = SORTING("Location/Division") ORDER(Ascending);
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
            column(currLoc; CurrLoc)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if CurrLoc = "prPeriod Transactions"."Location/Division" then
                    CurrReport.Skip
                else
                    CurrLoc := '';

                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Location/Division", "prPeriod Transactions"."Location/Division");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                //PeriodTrans.SETFILTER(PeriodTrans."Group Order",'=6|=7'); //Taxable Pay
                //PeriodTrans.SETFILTER(PeriodTrans."Sub Group Order",'=5|=3'); //Paye Amount

                TaxablePay := 0;
                PayeAmount := 0;
                GPAYS := 0;

                if PeriodTrans.Find('-') then
                    repeat

                        //GrpOrder 7, SubGrpOrder 3 = Taxable Pay
                        if (PeriodTrans."Group Order" = 7) and (PeriodTrans."Sub Group Order" = 3) or (PeriodTrans."Transaction Code" = 'PAYE-EXP')
                        or (PeriodTrans."Transaction Code" = 'PAYE-CALC') then begin
                            PayeAmount += PeriodTrans.Amount;
                        end;
                    until PeriodTrans.Next = 0;

                CurrLoc := "prPeriod Transactions"."Location/Division";

                if PayeAmount <= 0 then
                    CurrReport.Skip;
                TotTaxablePay := TotTaxablePay + TaxablePay;
                TotPayeAmount := TotPayeAmount + PayeAmount;

                /*IF (PeriodTrans."Transaction Code"='GPAY') THEN
                 BEGIN
                   GPAYS:=PeriodTrans.Amount;
                 END;
                
                */
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
        PeriodFilter := "prPeriod Transactions".GetFilter("Period Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "prPeriod Transactions".GetRangeMin("Period Filter");
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
        CurrLoc: Code[20];
}


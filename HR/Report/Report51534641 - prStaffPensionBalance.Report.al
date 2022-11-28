report 51534641 "prStaff Pension Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './prStaffPensionBalance.rdlc';

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            RequestFilterFields = "Period Filter", "Pension House Filter", "Location/Division", Department, "Cost Centre", "Salary Grade", "Salary Notch";
            column(USERID; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(GETFILTERS; GetFilters)
            {
            }
            column(Companyinfo_Picture; Companyinfo.Picture)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
            {
            }
            column(SelfContrib; SelfContrib)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(CompanyContrib; CompanyContrib)
            {
            }
            column(SelfContrib_CompanyContrib; SelfContrib + CompanyContrib)
            {
            }
            column(PINNo; PINNo)
            {
            }
            column(PensionH; PensionH)
            {
            }
            column(RCount; RCount)
            {
            }
            column(SelfContrib_Control1102755022; SelfContrib)
            {
            }
            column(CompanyContrib_Control1102755021; CompanyContrib)
            {
            }
            column(SelfContrib_CompanyContrib_Control1102755023; SelfContrib + CompanyContrib)
            {
            }
            column(Cumm__Self_ContributionCaption; Cumm__Self_ContributionCaptionLbl)
            {
            }
            column(Cumm__Employer_Contr_Caption; Cumm__Employer_Contr_CaptionLbl)
            {
            }
            column(Cumm__Total_ContributionCaption; Cumm__Total_ContributionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Staff_Pension_BalancesCaption; Staff_Pension_BalancesCaptionLbl)
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Pension_HouseCaption; Pension_HouseCaptionLbl)
            {
            }
            column(PIN_No_Caption; PIN_No_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then begin
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                    PINNo := objEmp."PIN No.";
                    PensionH := objEmp."Pension House";
                    if PensionHouse <> '' then begin
                        if PensionHouse <> objEmp."Pension House" then
                            CurrReport.Skip;
                    end;
                end;

                CurrReport.CreateTotals(SelfContrib, CompanyContrib, SelfContribARREARS, CompanyContribARREARS);

                SelfContrib := 0;
                CompanyContrib := 0;
                SelfContribARREARS := 0;
                CompanyContribARREARS := 0;

                //Get the Basic pay
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Group Order", 1);
                PeriodTrans.SetRange(PeriodTrans."Sub Group Order", 1);
                if PeriodTrans.Find('-') then begin
                    BasicPay := PeriodTrans.Amount;
                end;


                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                //PKKPeriodTrans.SETRANGE(PeriodTrans."Company Deduction",FALSE);  //dennis
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", SelfContribCode);
                if PeriodTrans.Find('-') then begin
                    SelfContrib := PeriodTrans.Balance;
                    CompanyContrib := SelfContrib;//PKKPeriodTrans."Emp Balance";
                end;

                SelfContrib := SelfContrib + SelfContribARREARS;

                /*
                prEmployerContrib.RESET;
                prEmployerContrib.SETRANGE(prEmployerContrib."Employee Code","Employee Code");
                prEmployerContrib.SETRANGE(prEmployerContrib."Payroll Period",SelectedPeriod);
                prEmployerContrib.SETRANGE(prEmployerContrib."Transaction Code",SelfContribCode);
                IF prEmployerContrib.FIND('-') THEN
                BEGIN
                CompanyContrib:=prEmployerContrib.Amount;
                END;
                */


                CompanyContrib := CompanyContrib + CompanyContribARREARS;

                CummContrib := SelfContrib + CompanyContrib;

                if (SelfContrib <= 0) and (CompanyContrib <= 0) then
                    CurrReport.Skip;
                TotBasicPay := TotBasicPay + BasicPay;
                TotSelfContrib := TotSelfContrib + SelfContrib;
                TotCompanyContrib := TotCompanyContrib + CompanyContrib;
                TotCummContrib := TotCummContrib + CummContrib;

                RCount := RCount + 1;

            end;

            trigger OnPreDataItem()
            begin
                objTransCode.Reset;
                objTransCode.SetRange(objTransCode.Pension, true);
                if objTransCode.Find('-') then
                    SelfContribCode := objTransCode."Transaction Code";

                PensionHouse := "prSalary Card".GetFilter("Pension House Filter");

                if Companyinfo.Get() then
                    Companyinfo.CalcFields(Companyinfo.Picture);
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

        //self contribution...Defined contribution is a Special Transaction 1
        objTransCode.Reset;
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1); //Defined contribution/pension
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",FALSE);
        objTransCode.SetRange(objTransCode.Pension, true);
        //PKKobjTransCode.SETRANGE(objTransCode."Transaction Code",'F2411'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then begin
            SelfContribCode := objTransCode."Transaction Code";
        end;

        //self contribution...Defined contribution is a Special Transaction 1 PENSION ARREARS
        objTransCode.Reset;
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1); //Defined contribution/pension
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",FALSE);
        objTransCode.SetRange(objTransCode."Transaction Code", '114'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then begin
            SelfContribCodeArrears := objTransCode."Transaction Code";
        end;


        //Company contribution
        objTransCode.Reset;
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1);
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",TRUE);
        objTransCode.SetRange(objTransCode."Transaction Code", 'Emp-455'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then begin
            // CompanyContribCode:=objTransCode."Transaction Code";
        end;
        CompanyContribCode := 'Emp-455';


        //Company contribution ARREARS
        objTransCode.Reset;
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1);
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",TRUE);
        objTransCode.SetRange(objTransCode."Transaction Code", 'Emp-114'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then begin
            // CompanyContribCode:=objTransCode."Transaction Code";
        end;
        CompanyContribCodeArrears := 'Emp-114';


        if Companyinfo.Get() then
            Companyinfo.CalcFields(Companyinfo.Picture);
    end;

    var
        PeriodTrans: Record "prPeriod Transactions";
        BasicPay: Decimal;
        SelfContrib: Decimal;
        CompanyContrib: Decimal;
        CummContrib: Decimal;
        TotBasicPay: Decimal;
        TotSelfContrib: Decimal;
        TotCompanyContrib: Decimal;
        TotCummContrib: Decimal;
        EmployeeName: Text[200];
        objEmp: Record "HR-Employee";
        objPeriod: Record "prPayroll Periods";
        SelectedPeriod: Date;
        PeriodFilter: Text[30];
        PeriodName: Text[30];
        SelfContribCode: Text[30];
        CompanyContribCode: Text[30];
        objTransCode: Record "prTransaction Codes";
        SelfContribCodeArrears: Text[30];
        CompanyContribCodeArrears: Text[30];
        SelfContribARREARS: Decimal;
        CompanyContribARREARS: Decimal;
        prEmployerContrib: Record "prEmployer Deductions";
        Companyinfo: Record "Company Information";
        PINNo: Code[20];
        PensionHouse: Code[100];
        PensionH: Code[20];
        RCount: Integer;
        Cumm__Self_ContributionCaptionLbl: Label 'Cumm. Self Contribution';
        Cumm__Employer_Contr_CaptionLbl: Label 'Cumm. Employer Contr.';
        Cumm__Total_ContributionCaptionLbl: Label 'Cumm. Total Contribution';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Staff_Pension_BalancesCaptionLbl: Label 'Staff Pension Balances';
        Employee_No_CaptionLbl: Label 'Employee No.';
        NameCaptionLbl: Label 'Name';
        Pension_HouseCaptionLbl: Label 'Pension House';
        PIN_No_CaptionLbl: Label 'PIN No.';
}


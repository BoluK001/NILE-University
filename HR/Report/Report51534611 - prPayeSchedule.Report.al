report 51534611 "prPaye Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './prPayeSchedule.rdlc';

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
            column(LocationDivision_prSalaryCard; "prSalary Card"."Location/Division")
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
            dataitem("HR Employees"; "HR Employees")
            {
                DataItemLink = "No." = FIELD("Employee Code");
                DataItemTableView = WHERE(Status = CONST(Active));
                column(LastName; "HR Employees"."Last Name")
                {
                }
                column(FirstName; "HR Employees"."First Name")
                {
                }
                column(MiddleName; "HR Employees"."Middle Name")
                {
                }
                column(EmpNo; "HR Employees"."No.")
                {
                }
                column(Dept; "HR Employees"."Department Code")
                {
                }
                column(Location; "HR Employees"."Global Dimension 2 Code")
                {
                }
                column(TaxID; "HR Employees"."Social Security No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //CurrReport.SKIP;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*
                objEmp.RESET;
                objEmp.SETRANGE(objEmp."No.","Employee Code");
                objEmp.SETFILTER(objEmp.Status,'Active');
                IF objEmp.FIND('-') THEN BEGIN
                  EmployeeName:=objEmp."First Name"+' '+objEmp."Middle Name"+' '+objEmp."Last Name";
                  BranchName:=objEmp.Office;
                  EmpLevel:=objEmp."Salary Grade";
                END;
                */


                GPAYS := 0;
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Employee Code", objEmp."No.");
                PeriodTrans.SetFilter(PeriodTrans."Transaction Code", 'GPAY');

                if PeriodTrans.Find('-') then begin
                    //REPEAT


                    GPAYS := PeriodTrans.Amount;

                    //UNTIL PeriodTrans.NEXT=0;
                end
                else
                    GPAYS := 0;

                TaxablePay := 0;
                PayeAmount := 0;
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Employee Code", objEmp."No.");
                PeriodTrans.SetFilter(PeriodTrans."Transaction Code", 'PAYE');
                //PeriodTrans.SETFILTER(PeriodTrans."Transaction Code",'%1|%2|%3','PAYE-CALC','PAYE','PAYE-S/A');
                // IF (PeriodTrans."Transaction Code"='PAYE-CALC') OR (PeriodTrans."Transaction Code"='PAYE-S/A') OR (PeriodTrans."Transaction Code"='PAYE') THEN
                if PeriodTrans.Find('-') then begin
                    //PeriodTrans.CALCSUMS(Amount);
                    //REPEAT

                    PayeAmount := PeriodTrans.Amount;

                    //UNTIL PeriodTrans.NEXT=0;
                end;
                if PayeAmount <= 0 then
                    CurrReport.Skip;
                TotTaxablePay := TotTaxablePay + TaxablePay;
                TotPayeAmount := TotPayeAmount + PayeAmount;
                RCount := RCount + 1;
                //CurrReport.SKIP;

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
}


report 51534529 "Employee Arrears Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './EmployeeArrearsSummary.rdlc';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            column(No_HREmployee; "HR-Employee"."No.")
            {
            }
            column(FirstName_HREmployee; "HR-Employee"."First Name")
            {
            }
            column(MiddleName_HREmployee; "HR-Employee"."Middle Name")
            {
            }
            column(LastName_HREmployee; "HR-Employee"."Last Name")
            {
            }
            column(ArrearsAmount; ArreasAmount)
            {
            }
            column(DateOfJoin_HREmployee; Format("Date Of Join", 0, 4))
            {
            }
            column(TotalWorkingDays; NoOfMonthDays)
            {
            }
            column(TotalEarnings; TotalEarnings)
            {
            }
            column(ArrearsDays; ArrearsDays)
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(BasicPay; SalaryCard."Basic Pay")
            {
            }
            dataitem("prEmployee Transactions"; "prEmployee Transactions")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                column(TransactionCode_prEmployeeTransactions; "prEmployee Transactions"."Transaction Code")
                {
                }
                column(TransactionName_prEmployeeTransactions; "prEmployee Transactions"."Transaction Name")
                {
                }
                column(Amount_prEmployeeTransactions; "prEmployee Transactions".Amount)
                {
                }
                column(EmployeeCode_prEmployeeTransactions; "prEmployee Transactions"."Employee Code")
                {
                }
                column(SelectedP; SelectedPeriod)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if TransCode.Get("prEmployee Transactions"."Transaction Code") then begin
                        if not ((TransCode.Frequency = TransCode.Frequency::Fixed) and (TransCode."Transaction Type" = TransCode."Transaction Type"::Income)) then
                            CurrReport.Skip;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                RemainingDays := (CalcDate('-1D', CalcDate('1M', DMY2Date(1, Date2DMY("HR-Employee"."Date Of Join", 2), Date2DMY("HR-Employee"."Date Of Join", 3))))
                                              - "HR-Employee"."Date Of Join");

                if SalaryCard.Get("HR-Employee"."No.") then begin
                    TotalEarnings := SalaryCard."Basic Pay";

                    EmpTrans.Reset;
                    EmpTrans.SetRange(EmpTrans."Employee Code", "HR-Employee"."No.");
                    EmpTrans.SetRange(EmpTrans."Payroll Period", SelectedPeriod);
                    if EmpTrans.Find('-') then begin
                        repeat
                            if objTransCodes.Get(EmpTrans."Transaction Code") then begin
                                if (objTransCodes.Frequency = objTransCodes.Frequency::Fixed) and
                                   (objTransCodes."Transaction Type" = objTransCodes."Transaction Type"::Income) then begin
                                    TotalEarnings := TotalEarnings + EmpTrans.Amount;

                                end;
                            end;
                        until EmpTrans.Next = 0;
                    end;
                end;

                TDate := "HR-Employee"."Date Of Join";

                repeat
                    i := i + 1;
                    if (Date2DWY(TDate, 1) <> 6) and (Date2DWY(TDate, 1) <> 7) then   //exclude weekend
                        ArrearsDays := ArrearsDays + 1;

                    TDate := CalcDate('1D', TDate);

                until i = RemainingDays + 1;


                //working days in the selected period
                Jmonth := CalcDate('CM', SelectedPeriod);
                cnt := Date2DMY(Jmonth, 1);
                MonthStart := DMY2Date(1, Date2DMY(Jmonth, 2), Date2DMY(Jmonth, 3));
                repeat
                    if (Date2DWY(MonthStart, 1) <> 6) and (Date2DWY(MonthStart, 1) <> 7) then   //exclude week
                        NoOfMonthDays := NoOfMonthDays + 1;
                    j += 1;
                    MonthStart := CalcDate('1D', MonthStart);
                until j = cnt - 1;

                ArreasAmount := Round(TotalEarnings * (ArrearsDays / NoOfMonthDays), 0.01);
            end;

            trigger OnPreDataItem()
            begin
                objPeriod.Reset;
                objPeriod.SetRange(objPeriod.Closed, false);
                if objPeriod.Find('-') then
                    SelectedPeriod := objPeriod."Date Opened";
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        TransCode: Record "prTransaction Codes";
        objPeriod: Record "prPayroll Periods";
        TotalEarnings: Decimal;
        ArreasAmount: Decimal;
        ArrearsDays: Integer;
        NoOfMonthDays: Integer;
        i: Integer;
        RemainingDays: Integer;
        TDate: Date;
        j: Integer;
        JarrDays: Integer;
        Jmonth: Date;
        cnt: Integer;
        Employee: Record "HR Employees";
        SelectedPeriod: Date;
        MonthStart: Date;
        objTransCodes: Record "prTransaction Codes";
        objEmpTrans: Record "prEmployee Transactions";
        EmpTrans: Record "prEmployee Transactions";
        VitalSetUp: Record "prVital Setup Info";
        SalaryCard: Record "prSalary Card";
        CompInfo: Record "Company Information";
}


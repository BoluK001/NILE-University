report 51534580 "Payroll Variance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayrollVarianceReport.rdlc';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = WHERE (Status = FILTER (Normal));
            column(EmployeeCode_prPeriodTransactions; "HR-Employee"."No.")
            {
            }
            column(BasePeriod; BasePeriod)
            {
            }
            column(ComPeriod; ComparingPeriod)
            {
            }
            column(PrevGross; PrevGross)
            {
            }
            column(PrevNet; PrevNet)
            {
            }
            column(Sn; Sn)
            {
            }
            column(curGross; curGross)
            {
            }
            column(curNet; curNet)
            {
            }
            column(TODAY; Today)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                prTrans.Reset;
                PrevNet := 0;
                PrevGross := 0;
                curNet := 0;
                curGross := 0;

                Sn := Sn + 1;
                prTrans.SetCurrentKey(prTrans.Department, prTrans."Payroll Period");
                prTrans.Reset;
                //prTrans.SETRANGE(prTrans."Transaction Code");
                //prTrans.SETRANGE(prTrans.Department,"prPeriod Transactions".Department);
                //prTrans.SETRANGE(prTrans."Employee Classification","prPeriod Transactions"."Employee Classification");
                prTrans.SetRange(prTrans."Employee Code", "No.");
                prTrans.SetRange(prTrans."Payroll Period", ComparingPeriod);
                if prTrans.FindFirst then begin
                    repeat
                        if prTrans."Transaction Code" = 'NPAY' then
                            PrevNet := prTrans.Amount
                        else
                            if prTrans."Transaction Code" = 'GPAY' then
                                PrevGross := prTrans.Amount
                    until prTrans.Next = 0;
                end;

                prTrans.SetCurrentKey(prTrans.Department, prTrans."Payroll Period");
                prTrans.Reset;
                //prTrans.SETRANGE(prTrans."Transaction Code");
                //prTrans.SETRANGE(prTrans.Department,"prPeriod Transactions".Department);
                prTrans.SetRange(prTrans."Employee Code", "No.");
                prTrans.SetRange(prTrans."Payroll Period", BasePeriod);
                if prTrans.FindFirst then begin
                    repeat
                        if prTrans."Transaction Code" = 'NPAY' then
                            curNet := prTrans.Amount
                        else
                            if prTrans."Transaction Code" = 'GPAY' then
                                curGross := prTrans.Amount
                    until prTrans.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                //SETRANGE("prPeriod Transactions"."Payroll Period",BasePeriod);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Filter")
                {
                    field("Base Period"; BasePeriod)
                    {
                        TableRelation = "prPayroll Periods"."Date Opened";
                    }
                    field("Comparing Period"; ComparingPeriod)
                    {
                        TableRelation = "prPayroll Periods"."Date Opened";
                    }
                }
            }
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
        if (Format(BasePeriod) = '') and (Format(ComparingPeriod) = '') then begin
            prPayrollPeriods.Reset;
            prPayrollPeriods.SetRange(prPayrollPeriods.Closed, false);
            if prPayrollPeriods.FindFirst then
                BasePeriod := prPayrollPeriods."Date Opened";
            ComparingPeriod := CalcDate('-1M', BasePeriod);
        end;
    end;

    var
        PrevGross: Decimal;
        PrevNet: Decimal;
        prTrans: Record "prPeriod Transactions";
        BasePeriod: Date;
        ComparingPeriod: Date;
        prPayrollPeriods: Record "prPayroll Periods";
        Sn: Integer;
        curGross: Decimal;
        curNet: Decimal;
}


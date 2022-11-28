report 51534583 "Payroll Components Variance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayrollComponentsVariance.rdlc';

    dataset
    {
        dataitem(prEmpPayrollBuffer; prEmpPayrollBuffer)
        {
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Sn; Sn)
            {
            }
            column(Name; Name)
            {
            }
            column(COYNAME; CompanyName)
            {
            }
            column(TODAY; Today)
            {
            }
            column(EmployeeCode_prEmpPayrollBuffer; prEmpPayrollBuffer."Employee Code")
            {
            }
            column(TransactionCode_prEmpPayrollBuffer; prEmpPayrollBuffer."Transaction Code")
            {
            }
            column(TransactionName_prEmpPayrollBuffer; prEmpPayrollBuffer."Transaction Name")
            {
            }
            column(Amount_prEmpPayrollBuffer; prEmpPayrollBuffer.Amount)
            {
            }
            column(PreviousTransCode_prEmpPayrollBuffer; prEmpPayrollBuffer."Previous TransCode")
            {
            }
            column(PreviousAmount_prEmpPayrollBuffer; prEmpPayrollBuffer."Previous Amount")
            {
            }
            column(PreviousPayrollPeriod_prEmpPayrollBuffer; prEmpPayrollBuffer."Previous Payroll Period")
            {
            }
            column(BasePeriod; BasePeriod)
            {
            }
            column(ComPeriod; ComparingPeriod)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if EmpRec.Get(prEmpPayrollBuffer."Employee Code") then begin
                    Name := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";

                    Sn += 1;
                end;
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


        PopulateBuffer;
    end;

    var
        Name: Text;
        EmpRec: Record "HR-Employee";
        EmpClassification: Code[50];
        EmpClass: Record "Employee Class";
        ClassFilter: Code[30];
        CompanyInfo: Record "Company Information";
        Sn: Integer;
        prTrans: Record "prPeriod Transactions";
        PrevNet: array[50] of Decimal;
        ComparingPeriod: Date;
        i: Integer;
        BasePeriod: Date;
        prPayrollPeriods: Record "prPayroll Periods";
        PayrollBuffer: Record prEmpPayrollBuffer;
        PayBuffer: Record prEmpPayrollBuffer;

    local procedure PopulateBuffer()
    var
        prtran: Record "prPeriod Transactions";
    begin
        if PayrollBuffer.FindFirst then
            PayrollBuffer.DeleteAll;

        prtran.Reset;
        prtran.SetRange(prtran."Payroll Period", BasePeriod);
        prtran.SetFilter(prtran."Post As", '<>%1', 0);
        if prtran.FindFirst then begin
            repeat
                PayrollBuffer.Init;
                PayrollBuffer."Employee Code" := prtran."Employee Code";
                PayrollBuffer."Transaction Code" := prtran."Transaction Code";
                PayrollBuffer."Payroll Period" := prtran."Payroll Period";
                PayrollBuffer."Transaction Name" := prtran."Transaction Name";
                PayrollBuffer.Amount := prtran.Amount;
                PayrollBuffer.Insert;
            until prtran.Next = 0;
        end;



        prtran.Reset;
        prtran.SetRange(prtran."Payroll Period", ComparingPeriod);
        prtran.SetFilter(prtran."Post As", '<>%1', 0);
        if prtran.FindFirst then begin
            repeat
                PayrollBuffer.Reset;
                PayrollBuffer.SetRange(PayrollBuffer."Transaction Code", prtran."Transaction Code");
                PayrollBuffer.SetRange(PayrollBuffer."Employee Code", prtran."Employee Code");
                if not PayrollBuffer.FindFirst then begin
                    PayBuffer.Init;
                    PayBuffer."Employee Code" := prtran."Employee Code";
                    PayBuffer."Transaction Code" := prtran."Transaction Code";
                    PayBuffer."Previous Payroll Period" := prtran."Payroll Period";
                    PayBuffer."Transaction Name" := prtran."Transaction Name";
                    PayBuffer."Previous Amount" := prtran.Amount;
                    PayBuffer.Insert;
                end else
                    if PayrollBuffer.FindFirst then begin
                        PayrollBuffer."Previous TransCode" := prtran."Transaction Code";
                        PayrollBuffer."Previous Payroll Period" := prtran."Payroll Period";
                        PayrollBuffer."Previous TransName" := prtran."Transaction Name";
                        PayrollBuffer."Previous Amount" := prtran.Amount;
                        PayrollBuffer.Modify;
                    end;
            until prtran.Next = 0;
        end;
    end;
}


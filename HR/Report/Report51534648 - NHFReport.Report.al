report 51534648 "NHF Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './NHFReport.rdlc';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';
            column(No_; "serial number")
            {
            }
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
            column(NHF_No; "HR-Employee"."NHF No.")
            {
            }
            column(BPayAmt; BPayAmt)
            {
            }
            column(NHFAmt; NHFAmt)
            {
            }
            column(Selected_Period; SelectedPeriod)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(strSelectedDate; strSelectedDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                periodTrans.Reset;
                periodTrans.SetRange(periodTrans."Employee Code", "No.");
                periodTrans.SetFilter(periodTrans."Payroll Period", "HR-Employee".GetFilter("Current Month Filter"));
                periodTrans.SetCurrentKey(periodTrans."Employee Code", periodTrans."Period Month", periodTrans."Period Year",
                periodTrans."Group Order", periodTrans."Sub Group Order");
                if not periodTrans.FindFirst then
                    CurrReport.Skip;



                objSalCard.Reset;
                objSalCard.SetRange(objSalCard."Employee Code", "HR-Employee"."No.");
                if objSalCard.Find('-') then begin
                    if objSalCard."Pays NHF" = false then CurrReport.Skip;
                end;

                NHFAmt := 0;
                BPayAmt := 0;

                periodTrans.Reset;
                periodTrans.SetRange(periodTrans."Employee Code", "HR-Employee"."No.");
                periodTrans.SetRange(periodTrans."Transaction Code", 'BPAY');
                periodTrans.SetRange(periodTrans."Payroll Period", SelectedPeriod);
                if periodTrans.Find('-') then begin
                    BPayAmt := periodTrans.Amount;
                end;

                periodTrans.Reset;
                periodTrans.SetRange(periodTrans."Employee Code", "HR-Employee"."No.");
                periodTrans.SetRange(periodTrans."Transaction Code", 'NHF');
                periodTrans.SetRange(periodTrans."Payroll Period", SelectedPeriod);
                if periodTrans.Find('-') then begin
                    NHFAmt := periodTrans.Amount;
                end;



                if NHFAmt = 0 then CurrReport.Skip;

                "serial number" := "serial number" + 1;
            end;

            trigger OnPreDataItem()
            begin
                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Selected Period"; SelectedPeriod)
                {
                    TableRelation = "prPayroll Periods"."Date Opened";
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

    var
        "serial number": Integer;
        BPayAmt: Decimal;
        NHFAmt: Decimal;
        periodTrans: Record "prPeriod Transactions";
        SelectedPeriod: Date;
        objSalCard: Record "prSalary Card";
        CompanyInfo: Record "Company Information";
        strSelectedDate: Text;
}


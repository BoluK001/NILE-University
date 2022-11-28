report 51534766 "Payroll Summary Rep-EXECUTIVE"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayrollSummaryRepEXECUTIVE.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = WHERE ("Employee Classification" = FILTER ('EXEC'), Exclude = CONST (false));
            RequestFilterFields = "Payroll Period";
            column(TransactionName_prPeriodTransactions; "prPeriod Transactions"."Transaction Name")
            {
            }
            column(Amount_prPeriodTransactions; amt)
            {
            }
            column(TransactionCode_prPeriodTransactions; "prPeriod Transactions"."Transaction Code")
            {
            }
            column(EmployeeCode_prPeriodTransactions; "prPeriod Transactions"."Employee Code")
            {
            }
            column(Name; Name)
            {
            }
            column(GroupOrder; "prPeriod Transactions"."Group Order")
            {
            }
            column(SalaryGrade_prPeriodTransactions; "prPeriod Transactions"."Salary Grade")
            {
            }
            column(SubGroupOrder; "prPeriod Transactions"."Sub Group Order")
            {
            }
            column(EmpClassification; EmpClassification)
            {
            }
            column(ClassFilter; ClassFilter)
            {
            }
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
            column(BranchName; BranchName)
            {
            }
            column(Depertment; Depertment)
            {
            }
            column(LocationDivision_prPeriodTransactions; "Location/Division")
            {
            }
            column(SalaryNotch_prPeriodTransactions; "prPeriod Transactions"."Salary Notch")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if EmpRec.Get("prPeriod Transactions"."Employee Code") then begin
                    if EmpRec.Status <> EmpRec.Status::Normal then
                        CurrReport.Skip;
                    Name := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                    EmpClassification := EmpRec."Employee Classification";
                    if DimValue.Get('L. CODE', EmpRec."Location/Division Code") then
                        BranchName := DimValue.Name;
                    if DimValue.Get('BU', EmpRec."Department Code") then
                        Depertment := DimValue.Name;
                    /*
                      IF ClassFilter<>'' THEN
                       IF ClassFilter<>EmpClassification THEN
                         CurrReport.SKIP; */
                end;


                nonTax := 0;
                amt := 0;
                prPeriodTransactions.SetFilter(prPeriodTransactions."Payroll Period", "prPeriod Transactions".GetFilter("Payroll Period"));
                prPeriodTransactions.SetRange(prPeriodTransactions.Exclude, true);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", "prPeriod Transactions"."Employee Code");
                if prPeriodTransactions.FindFirst then
                    repeat
                        nonTax += prPeriodTransactions.Amount;
                    until prPeriodTransactions.Next = 0;

                if "prPeriod Transactions"."Transaction Code" = 'NPAY' then
                    amt := "prPeriod Transactions".Amount - nonTax
                else
                    if "prPeriod Transactions"."Transaction Code" = 'GPAY' then
                        amt := "prPeriod Transactions".Amount - nonTax

                    else
                        amt := "prPeriod Transactions".Amount;

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
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
        Name: Text;
        EmpRec: Record "HR-Employee";
        EmpClassification: Code[50];
        EmpClass: Record "Employee Class";
        EmpClassPage: Page "Emplyee Classification";
        ClassFilter: Code[30];
        CompanyInfo: Record "Company Information";
        Depertment: Code[30];
        BranchName: Code[30];
        DimValue: Record "Dimension Value";
        BranchFilter: Code[30];
        DimensionFilter: Code[30];
        nonTax: Decimal;
        amt: Decimal;
        prPeriodTransactions: Record "prPeriod Transactions";
}


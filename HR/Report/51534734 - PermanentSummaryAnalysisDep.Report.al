report 51534734 "Permanent Summary Analysis-Dep"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PermanentSummaryAnalysisDep.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = WHERE ("Payroll  Classification" = CONST ('PERMANENT'), Exclude = CONST (false));
            RequestFilterFields = "Payroll Period";
            column(TransactionName_prPeriodTransactions; "prPeriod Transactions"."Transaction Name")
            {
            }
            column(Amount_prPeriodTransactions; "prPeriod Transactions".Amount)
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
            column(SalaryGrade_prPeriodTransactions; "prPeriod Transactions"."Salary Grade")
            {
            }
            column(SalaryNotch; "prPeriod Transactions"."Salary Notch")
            {
            }
            column(LocationDivision_prPeriodTransactions; "Location/Division")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if EmpRec.Get("prPeriod Transactions"."Employee Code") then begin
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
                nhf := 0;
                /*
                prPeriodTransactions.RESET;
                prPeriodTransactions.SETFILTER(prPeriodTransactions."Payroll Period","prPeriod Transactions".GETFILTER("Payroll Period"));
                prPeriodTransactions.SETRANGE(prPeriodTransactions."Transaction Code",'NHF');
                prPeriodTransactions.SETRANGE(prPeriodTransactions."Employee Code","prPeriod Transactions"."Employee Code");
                IF prPeriodTransactions.FINDFIRST THEN
                 nhf:=prPeriodTransactions.Amount;
                
                
                amt:=0;
                nonTax:=0;
                
                prPeriodTransactions.RESET;
                prPeriodTransactions.SETFILTER(prPeriodTransactions."Payroll Period","prPeriod Transactions".GETFILTER("Payroll Period"));
                prPeriodTransactions.SETRANGE(prPeriodTransactions.Exclude,TRUE);
                prPeriodTransactions.SETRANGE(prPeriodTransactions."Employee Code","prPeriod Transactions"."Employee Code");
                IF prPeriodTransactions.FINDFIRST THEN
                 REPEAT
                  nonTax+=prPeriodTransactions.Amount;
                 UNTIL prPeriodTransactions.NEXT =0;
                
                StatutoryAmt:=0;
                PeriodTrans.RESET;
                PeriodTrans.SETCURRENTKEY(PeriodTrans."Employee Code",PeriodTrans."Period Month",PeriodTrans."Period Year",
                PeriodTrans."Group Order",PeriodTrans."Sub Group Order",PeriodTrans."Payslip Order");
                PeriodTrans.SETRANGE(PeriodTrans."Employee Code","prPeriod Transactions"."Employee Code");
                PeriodTrans.SETFILTER(PeriodTrans."Payroll Period","prPeriod Transactions".GETFILTER("Payroll Period"));
                PeriodTrans.SETRANGE(PeriodTrans."Group Text",'STATUTORIES');
                PeriodTrans.SETRANGE(PeriodTrans."Company Deduction",FALSE);
                IF PeriodTrans.FIND('-') THEN REPEAT
                 IF  (PeriodTrans."Transaction Code" <> 'TOT-PAYE') AND (PeriodTrans."Transaction Code" <> 'PENS')  THEN
                    StatutoryAmt:=StatutoryAmt+PeriodTrans.Amount;
                UNTIL PeriodTrans.NEXT=0;
                
                IF "prPeriod Transactions"."Transaction Code" ='NPAY' THEN
                    amt:="prPeriod Transactions".Amount - nonTax
                ELSE IF "prPeriod Transactions"."Transaction Code" ='GPAY' THEN
                    amt:="prPeriod Transactions".Amount - nonTax
                ELSE IF "prPeriod Transactions"."Transaction Code" ='TOT-DED' THEN
                   amt:="prPeriod Transactions".Amount+StatutoryAmt
                ELSE
                    amt:="prPeriod Transactions".Amount;
                 */

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
        prPeriodTransactions: Record "prPeriod Transactions";
        nonTax: Decimal;
        amt: Decimal;
        nhf: Decimal;
        StatutoryAmt: Decimal;
        PeriodTrans: Record "prPeriod Transactions";
}


report 51534743 "Payroll Summary Analysis - Dep"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayrollSummaryAnalysisDep.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = SORTING("Transaction Code", "Employee Code", "Payroll Period", "Location/Division", Department) WHERE(Exclude = CONST(false), "Payroll  Classification" = FILTER('PERMANENT'));
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
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Department_prPeriodTransactions; "prPeriod Transactions".Department)
            {
            }
            column(LocationDivision_prPeriodTransactions; "prPeriod Transactions"."Location/Division")
            {
            }
            column(TotalDeptAmount; TotalDeptAmount)
            {
            }
            column(TotalDeptAmtTran; TotalDeptAmtTran)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if EmpRec.Get("prPeriod Transactions"."Employee Code") then begin
                    Name := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                    EmpClassification := EmpRec."Payroll Class";
                    if DimValue.Get('L. CODE', "Location/Division") then
                        BranchName := DimValue.Name;
                    if DimValue.Get('BU', Department) then
                        Depertment := DimValue.Name;
                end;

                TotalDeptAmtTran := 0;
                TotalDeptAmount := 0;
                PsgAmt := 0;
                /*
                prTrans.RESET;
                prTrans.SETCURRENTKEY(prTrans.Department,prTrans."Payroll Period");
                prTrans.CALCFIELDS(prTrans.Exclude);
                //prTrans.SETRANGE(prTrans."Transaction Code","prPeriod Transactions"."Transaction Code");
                prTrans.SETRANGE(prTrans.Department,"prPeriod Transactions".Department);
                prTrans.SETRANGE(prTrans.Exclude,TRUE);
                prTrans.SETRANGE(prTrans."Payroll Period","prPeriod Transactions"."Payroll Period");
                IF prTrans.FINDFIRST THEN
                 REPEAT
                  PsgAmt+=prTrans.Amount;
                 UNTIL prTrans.NEXT = 0;
                 */
                prTrans.Reset;
                prTrans.SetCurrentKey(prTrans.Department, prTrans."Payroll Period");
                prTrans.CalcFields(prTrans.Exclude);
                prTrans.SetRange(prTrans."Transaction Code", "prPeriod Transactions"."Transaction Code");
                prTrans.SetRange(prTrans.Department, "prPeriod Transactions".Department);
                prTrans.SetRange(prTrans.Exclude, false);
                prTrans.SetRange("Payroll  Classification", 'PERMANENT');
                prTrans.SetRange(prTrans."Payroll Period", "prPeriod Transactions"."Payroll Period");
                if prTrans.FindFirst then
                    repeat
                        TotalDeptAmount += prTrans.Amount;
                    until prTrans.Next = 0;

                //IF ("prPeriod Transactions"."Transaction Code"='GPAY') OR ("prPeriod Transactions"."Transaction Code"='NPAY')  THEN
                // TotalDeptAmount:=TotalDeptAmount-PsgAmt;


                //TotalDeptAmtTran+=TotalDeptAmount;

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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
    end;

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
        TotalDeptAmount: Decimal;
        Dept: Code[20];
        prTrans: Record "prPeriod Transactions";
        TotalDeptAmtTran: Decimal;
        prTransac: Record "prPeriod Transactions";
        PsgAmt: Decimal;
}


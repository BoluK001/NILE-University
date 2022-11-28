report 51534776 "Finance Posting Dept CONTRACT"
{
    DefaultLayout = RDLC;
    RDLCLayout = './FinancePostingDeptCONTRACT.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = SORTING("Transaction Code", "Employee Code", "Payroll Period", "Location/Division", Department) WHERE(Exclude = CONST(false), "Payroll  Classification" = FILTER('CONTRACT'));
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
                /* IF EmpRec.GET("prPeriod Transactions"."Employee Code")  THEN BEGIN
                 Name:=EmpRec."First Name"+' '+EmpRec."Middle Name"+' '+EmpRec."Last Name";
                 EmpClassification:=EmpRec."Payroll Class";
                 IF DimValue.GET('L. CODE',"Location/Division") THEN
                  BranchName:=DimValue.Name;
                 IF DimValue.GET('BU',Department) THEN
                  Depertment:=DimValue.Name;
                 END;
                 */
                TotalDeptAmtTran := 0;
                TotalDeptAmount := 0;
                PsgAmt := 0;

                prTrans.Reset;
                prTrans.SetCurrentKey(prTrans.Department, prTrans."Payroll Period");
                prTrans.CalcFields(prTrans.Exclude);
                //prTrans.SETRANGE(prTrans."Transaction Code","prPeriod Transactions"."Transaction Code");
                prTrans.SetRange(prTrans.Department, "prPeriod Transactions".Department);
                prTrans.SetRange(prTrans."Employee Classification", "prPeriod Transactions"."Employee Classification");
                prTrans.SetRange(prTrans.Exclude, true);
                prTrans.SetRange(prTrans."Payroll Period", "prPeriod Transactions"."Payroll Period");
                if prTrans.FindFirst then
                    repeat
                        PsgAmt += prTrans.Amount;
                    until prTrans.Next = 0;

                prTrans.Reset;
                prTrans.SetCurrentKey(prTrans.Department, prTrans."Payroll Period");
                prTrans.CalcFields(prTrans.Exclude);
                prTrans.SetRange(prTrans."Transaction Code", "prPeriod Transactions"."Transaction Code");
                prTrans.SetRange(prTrans.Department, "prPeriod Transactions".Department);
                prTrans.SetRange(prTrans."Employee Classification", "prPeriod Transactions"."Employee Classification");
                prTrans.SetRange(prTrans.Exclude, false);
                prTrans.SetRange(prTrans."Payroll Period", "prPeriod Transactions"."Payroll Period");
                if prTrans.FindFirst then
                    repeat
                        TotalDeptAmount += prTrans.Amount;
                    until prTrans.Next = 0;

                if ("prPeriod Transactions"."Transaction Code" = 'GPAY') or ("prPeriod Transactions"."Transaction Code" = 'NPAY') then
                    TotalDeptAmount := TotalDeptAmount - PsgAmt;


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


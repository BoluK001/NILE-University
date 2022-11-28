report 51534777 "Fin Posting Location CONTRACT"
{
    DefaultLayout = RDLC;
    RDLCLayout = './FinPostingLocationCONTRACT.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = SORTING("Location/Division") WHERE("Payroll  Classification" = CONST('CONTRACT'), Exclude = CONST(false));
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

            trigger OnAfterGetRecord()
            begin
                TotalDeptAmount := 0;

                PsgAmt := 0;

                prTrans.Reset;
                prTrans.SetCurrentKey(prTrans."Location/Division", prTrans."Payroll Period");
                prTrans.CalcFields(prTrans.Exclude);
                //prTrans.SETRANGE(prTrans."Transaction Code","prPeriod Transactions"."Transaction Code");
                //prTrans.SETRANGE(prTrans.Department,"prPeriod Transactions".Department);
                prTrans.SetRange(prTrans."Location/Division", "prPeriod Transactions"."Location/Division");
                prTrans.SetRange(prTrans."Employee Classification", "prPeriod Transactions"."Employee Classification");
                prTrans.SetRange(prTrans.Exclude, true);
                prTrans.SetRange(prTrans."Payroll Period", "prPeriod Transactions"."Payroll Period");
                if prTrans.FindFirst then
                    repeat
                        PsgAmt += prTrans.Amount;
                    until prTrans.Next = 0;

                prTrans.Reset;
                prTrans.SetCurrentKey(prTrans."Location/Division", prTrans."Payroll Period");
                prTrans.SetRange(prTrans."Transaction Code", "prPeriod Transactions"."Transaction Code");
                prTrans.SetRange(prTrans."Employee Classification", "prPeriod Transactions"."Employee Classification");
                prTrans.SetRange(prTrans."Location/Division", "prPeriod Transactions"."Location/Division");
                prTrans.SetRange(prTrans."Payroll Period", "prPeriod Transactions"."Payroll Period");
                if prTrans.FindFirst then
                    repeat
                        TotalDeptAmount += prTrans.Amount;
                    until prTrans.Next = 0;

                //mESSAGE('%1',TotalDeptAmount);
                if ("prPeriod Transactions"."Transaction Code" = 'GPAY') or ("prPeriod Transactions"."Transaction Code" = 'NPAY') then
                    TotalDeptAmount := TotalDeptAmount - PsgAmt;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.CalcFields(Picture);
                //"prPeriod Transactions".SETFILTER("Employee Classification",'%1..%2','IT-INTERN','ADHOC');
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
        PsgAmt: Decimal;
}


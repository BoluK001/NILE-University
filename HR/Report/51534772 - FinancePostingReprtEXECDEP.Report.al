report 51534772 "Finance Posting Reprt-EXEC DEP"
{
    DefaultLayout = RDLC;
    RDLCLayout = './FinancePostingReprtEXECDEP.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = WHERE(Exclude = CONST(false), "Employee Classification" = FILTER('EXEC'));
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
                if EmpRec.Get("prPeriod Transactions"."Employee Code") then begin
                    Name := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                    EmpClassification := EmpRec."Payroll Class";
                    if DimValue.Get('L. CODE', "Location/Division") then
                        BranchName := DimValue.Name;
                    if DimValue.Get('BU', Department) then
                        Depertment := DimValue.Name;
                end;
                TotalDeptAmount := 0;
                prTrans.Reset;
                prTrans.SetRange(prTrans."Transaction Code", "prPeriod Transactions"."Transaction Code");
                prTrans.SetRange(prTrans.Department, "prPeriod Transactions".Department);
                prTrans.SetRange(prTrans."Payroll Period", "prPeriod Transactions"."Payroll Period");
                if prTrans.FindFirst then
                    repeat
                        TotalDeptAmount += prTrans.Amount;
                    until prTrans.Next = 0;
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
}


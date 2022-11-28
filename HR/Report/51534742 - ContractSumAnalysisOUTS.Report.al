report 51534742 "Contract Sum Analysis-OUTS"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ContractSumAnalysisOUTS.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = WHERE ("Employee Classification" = FILTER ('OUTS'));
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
}


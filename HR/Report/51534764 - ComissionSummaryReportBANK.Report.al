report 51534764 "Comission Summary Report-BANK"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ComissionSummaryReportBANK.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = WHERE ("Employee Classification" = FILTER ('SALES' | 'SNR-AS' | 'AS'), Exclude = CONST (true));
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
            column(AccNo; AccNo)
            {
            }
            column(EmpNo1; EmpRec."No.")
            {
            }
            dataitem("HR-Employee"; "HR-Employee")
            {
                DataItemLink = "No." = FIELD ("Employee Code");
                column(EmpNo; EmpRec."No.")
                {
                }
                column(FirstName; EmpRec."First Name")
                {
                }
                column(LastName; EmpRec."Last Name")
                {
                }
                column(MiddleName; EmpRec."Middle Name")
                {
                }
                column(BasicPay; EmpRec."Basic Pay")
                {
                }
                dataitem("Beneficiary Bank List"; "Beneficiary Bank List")
                {
                    DataItemLink = Code = FIELD ("Main Bank");
                    DataItemLinkReference = "HR-Employee";
                    column("Code"; "Beneficiary Bank List".Code)
                    {
                    }
                    column(BankName; "Beneficiary Bank List"."Bank Name")
                    {
                    }
                    column(BankCode; "Beneficiary Bank List"."Bank Code")
                    {
                    }
                    column(BranchCode; "Beneficiary Bank List"."Branch Code")
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                if EmpRec.Get("prPeriod Transactions"."Employee Code") then begin
                    AccNo := EmpRec."Bank Account Number";
                    if EmpRec.Status <> EmpRec.Status::Normal then
                        CurrReport.Skip;

                    Name := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                    AccNo := EmpRec."Bank Account Number";
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
        AccNo: Code[15];
}


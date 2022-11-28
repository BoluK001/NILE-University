report 51534762 "Bank Pay Analysis EXECUTIVES"
{
    DefaultLayout = RDLC;
    RDLCLayout = './BankPayAnalysisEXECUTIVES.rdlc';

    dataset
    {
        dataitem("prBank Structure"; "prBank Structure")
        {
            column(BankName_prBankStructure; "prBank Structure"."Bank Name")
            {
            }
            column(BankCode_prBankStructure; "prBank Structure"."Bank Code")
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
            column(GroupCount; GroupCount)
            {
            }
            column(BankSortCode; "prBank Structure"."Bank Sort Code")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            dataitem("HR-Employee"; "HR-Employee")
            {
                DataItemLink = "Main Bank" = FIELD ("Bank Code");
                DataItemTableView = WHERE (Status = CONST (Normal), "Employee Classification" = FILTER ('EXEC'));
                column(No_HREmployee; "HR-Employee"."No.")
                {
                }
                column(Name; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
                {
                }
                column(LocationDivisionCode_HREmployee; "HR-Employee"."Location/Division Code")
                {
                }
                column(DepartmentCode_HREmployee; "HR-Employee"."Department Code")
                {
                }
                column(TaxablePay; TaxablePay)
                {
                }
                column(TaxCharged; TaxCharged)
                {
                }
                column(NetPay; NetPay)
                {
                }
                column(SalaryGrade_HREmployee; "HR-Employee"."Salary Grade")
                {
                }
                column(Department; DepartmentName)
                {
                }
                column(Branch; BranchName)
                {
                }
                column(BranchBank; "HR-Employee"."Branch Bank")
                {
                }
                column(BankAccountNumber; "HR-Employee"."Bank Account Number")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if DValue.Get('BRANCH', "Location/Division Code") then BranchName := DValue.Name;
                    if DValue.Get('COST CENTER', "Department Code") then DepartmentName := DValue.Name;
                    GroupCount := GroupCount + 1;
                    TaxablePay := 0;
                    TaxCharged := 0;
                    NetPay := 0;

                    prTrans.Reset;
                    prTrans.SetRange(prTrans."Employee Code", "HR-Employee"."No.");
                    prTrans.SetRange(prTrans."Transaction Code", 'NPAY');
                    prTrans.SetRange(prTrans."Payroll Period", Period);
                    if prTrans.Find('-') then
                        NetPay := prTrans.Amount;

                    prTrans.Reset;
                    prTrans.SetRange(prTrans."Employee Code", "HR-Employee"."No.");
                    prTrans.SetFilter(prTrans."Transaction Code", '%1|%2', 'PAYE', 'WHT');
                    prTrans.SetRange(prTrans."Payroll Period", Period);
                    if prTrans.Find('-') then
                        TaxCharged := prTrans.Amount;

                    prTrans.Reset;
                    prTrans.SetRange(prTrans."Employee Code", "HR-Employee"."No.");
                    prTrans.SetRange(prTrans."Transaction Code", 'TXBP');
                    prTrans.SetRange(prTrans."Payroll Period", Period);
                    if prTrans.Find('-') then
                        TaxablePay := prTrans.Amount;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "HR-Employee".Reset;
                "HR-Employee".SetRange("HR-Employee"."Main Bank", "Bank Code");
                if not "HR-Employee".Find('-') then
                    CurrReport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Period; Period)
                {
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
        TaxablePay: Decimal;
        TaxCharged: Decimal;
        NetPay: Decimal;
        prTrans: Record "prPeriod Transactions";
        DValue: Record "Dimension Value";
        DepartmentName: Text[30];
        BranchName: Text[30];
        Period: Date;
        CompanyInfo: Record "Company Information";
        GroupCount: Integer;
}


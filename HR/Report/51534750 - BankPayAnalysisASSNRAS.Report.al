report 51534750 "Bank Pay Analysis AS|SNRAS"
{
    DefaultLayout = RDLC;
    RDLCLayout = './BankPayAnalysisASSNRAS.rdlc';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = WHERE (Status = CONST (Normal), "Employee Classification" = FILTER ('AS' | 'SNR-AS'));
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

            trigger OnAfterGetRecord()
            begin
                if DValue.Get('BRANCH', "Location/Division Code") then BranchName := DValue.Name;
                if DValue.Get('COST CENTER', "Department Code") then DepartmentName := DValue.Name;
                GroupCount := GroupCount + 1;
                TaxablePay := 0;
                TaxCharged := 0;
                NetPay := 0;
                Comm := 0;

                prTrans.Reset;
                prTrans.SetRange(prTrans."Employee Code", "HR-Employee"."No.");
                prTrans.SetRange(prTrans."Transaction Code", 'COMM');
                prTrans.SetRange(prTrans."Payroll Period", Period);
                if prTrans.Find('-') then
                    Comm := prTrans.Amount;


                prTrans.Reset;
                prTrans.SetRange(prTrans."Employee Code", "HR-Employee"."No.");
                prTrans.SetRange(prTrans."Transaction Code", 'NPAY');
                prTrans.SetRange(prTrans."Payroll Period", Period);
                if prTrans.Find('-') then
                    NetPay := prTrans.Amount;
                //NetPay-=Comm;

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
        Comm: Decimal;
}


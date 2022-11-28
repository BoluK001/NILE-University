report 51534730 "Net Pay Per Group"
{
    DefaultLayout = RDLC;
    RDLCLayout = './NetPayPerGroup.rdlc';

    dataset
    {
        dataitem("Employee Class"; "Employee Class")
        {
            RequestFilterFields = "Code";
            column(Code_EmployeeClass; "Employee Class".Code)
            {
            }
            column(Period; Period)
            {
            }
            column(Description_EmployeeClass; "Employee Class".Description)
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
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            dataitem("HR-Employee"; "HR-Employee")
            {
                DataItemLink = "Employee Classification" = FIELD (Code);
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
                column(WitholdingTax; WitholdingTax)
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

                trigger OnAfterGetRecord()
                begin
                    if DValue.Get('BRANCH', "Location/Division Code") then BranchName := DValue.Name;
                    if DValue.Get('COST CENTER', "Department Code") then DepartmentName := DValue.Name;
                    GroupCount := GroupCount + 1;
                    //MESSAGE('%1',GroupCount);
                    TaxablePay := 0;
                    TaxCharged := 0;
                    WitholdingTax := 0;
                    NetPay := 0;



                    prTrans.Reset;
                    prTrans.SetRange(prTrans."Employee Code", "HR-Employee"."No.");
                    prTrans.SetRange(prTrans."Transaction Code", 'NPAY');
                    prTrans.SetRange(prTrans."Payroll Period", Period);
                    if prTrans.Find('-') then
                        NetPay := prTrans.Amount;

                    prTrans.Reset;
                    prTrans.SetRange(prTrans."Employee Code", "HR-Employee"."No.");
                    prTrans.SetFilter(prTrans."Transaction Code", 'PAYE');
                    prTrans.SetRange(prTrans."Payroll Period", Period);
                    if prTrans.Find('-') then
                        TaxCharged := prTrans.Amount;

                    prTrans.Reset;
                    prTrans.SetRange(prTrans."Employee Code", "HR-Employee"."No.");
                    prTrans.SetFilter(prTrans."Transaction Code", 'W-TAX');
                    prTrans.SetRange(prTrans."Payroll Period", Period);
                    if prTrans.Find('-') then
                        WitholdingTax := prTrans.Amount;


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
                CompanyInfo.CalcFields(Picture);

                /* "HR-Employee".RESET;
                 "HR-Employee".SETRANGE("Employee Classification",Code);
                 GroupCount := "HR-Employee".COUNT;*/
                GroupCount := 0;

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
        WitholdingTax: Decimal;
        NetPay: Decimal;
        prTrans: Record "prPeriod Transactions";
        DValue: Record "Dimension Value";
        DepartmentName: Text[30];
        BranchName: Text[30];
        Period: Date;
        GroupCount: Integer;
        CompanyInfo: Record "Company Information";
}


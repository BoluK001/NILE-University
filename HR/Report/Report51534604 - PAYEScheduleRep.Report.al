report 51534604 "PAYE Schedule Rep"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PAYEScheduleRep.rdlc';
    Caption = 'PAYE Schedule';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = WHERE(Status = CONST(Normal));
            RequestFilterFields = "Current Month Filter";
            column(LastName; "HR-Employee"."Last Name")
            {
            }
            column(FirstName; "HR-Employee"."First Name")
            {
            }
            column(MiddleName; "HR-Employee"."Middle Name")
            {
            }
            column(EmpNo; "HR-Employee"."No.")
            {
            }
            column(Dept; "HR-Employee"."Department Code")
            {
            }
            column(GPAY; GPAY)
            {
            }
            column(PAYE; PAYE)
            {
            }
            column(Location; Location)
            {
            }
            column(PayeAmount; PayeAmount)
            {
            }
            column(RCount; RCount)
            {
            }
            column(TaxID; TaxID)
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                prPeriodTransactions.Reset;
                prPeriodTransactions.SetFilter(prPeriodTransactions."Employee Code", "HR-Employee"."No.");
                prPeriodTransactions.SetFilter(prPeriodTransactions."Payroll Period", "HR-Employee".GetFilter("HR-Employee"."Current Month Filter"));
                prPeriodTransactions.SetFilter(prPeriodTransactions."Transaction Code", 'GPAY');
                if prPeriodTransactions.FindFirst then begin
                    GPAY := prPeriodTransactions.Amount;
                end;
                prPeriodTransactions.Reset;
                prPeriodTransactions.SetFilter(prPeriodTransactions."Employee Code", "HR-Employee"."No.");
                prPeriodTransactions.SetFilter(prPeriodTransactions."Payroll Period", "HR-Employee".GetFilter("HR-Employee"."Current Month Filter"));
                prPeriodTransactions.SetFilter(prPeriodTransactions."Transaction Code", '%1|%2|%3', 'PAYE-CALC', 'PAYE', 'PAYE-S/A');
                if prPeriodTransactions.FindFirst then begin
                    prPeriodTransactions.CalcSums(Amount);
                    PAYE := prPeriodTransactions.Amount;

                end;
                HREmployees.Reset;
                HREmployees.SetFilter(HREmployees."No.", "HR-Employee"."No.");
                if HREmployees.FindFirst then begin
                    Location := HREmployees."Global Dimension 2 Code";
                    TaxID := HREmployees."Social Security No.";
                end else
                    if not prPeriodTransactions.Find('-') then
                        CurrReport.Skip;
                RCount += 1;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(CompanyInformation.Picture);
                if "HR-Employee".GetFilter("HR-Employee"."Current Month Filter") = '' then
                    Error('You must specify current Period filter.');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        prPeriodTransactions: Record "prPeriod Transactions";
        GPAY: Decimal;
        PAYE: Decimal;
        HREmployees: Record "HR Employees";
        Location: Text;
        PayeAmount: Decimal;
        RCount: Integer;
        TaxID: Text;
        CompanyInformation: Record "Company Information";
}


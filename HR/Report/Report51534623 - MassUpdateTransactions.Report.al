report 51534623 "Mass Update Transactions"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = SORTING ("No.") ORDER(Ascending) WHERE (Status = CONST (Normal));
            RequestFilterFields = "No.", "Location/Division Code", "Department Code", "Cost Center Code", "Salary Grade", "Salary Notch/Step";

            trigger OnAfterGetRecord()
            begin
                if not SalaryIncrement then begin
                    if (TransactionCode = '') or (PeriodSelected = 0D) then
                        Error('The Transaction Code and Period Selected Should be Update');

                    PayrollPeriod.Reset;
                    PayrollPeriod.SetRange(PayrollPeriod."Date Opened", PeriodSelected);
                    if PayrollPeriod.Find('-') then begin
                        if PayrollPeriod.Closed = true then
                            Error('You cannot make changes on a closed period');

                        Month := Date2DMY(PeriodSelected, 2);
                        Year := Date2DMY(PeriodSelected, 3);
                    end;
                    prEmpTrans.Reset;
                    prEmpTrans.SetRange(prEmpTrans."Transaction Code", TransactionCode);
                    prEmpTrans.SetRange(prEmpTrans."Payroll Period", PeriodSelected);
                    prEmpTrans.SetRange(prEmpTrans."Employee Code", "HR-Employee"."No.");
                    if prEmpTrans.Get('-') then
                        Error('A similar transaction exists for the selected period Delete it First');
                    prEmpTrans.Init;
                    prEmpTrans."Employee Code" := "HR-Employee"."No.";
                    prEmpTrans."Transaction Code" := TransactionCode;
                    prEmpTrans.Validate("Transaction Code");
                    prTransCode.Get(TransactionCode);
                    prEmpTrans."Transaction Name" := prTransCode."Transaction Name";
                    prEmpTrans."Period Month" := Month;
                    prEmpTrans."Period Year" := Year;
                    prEmpTrans."Payroll Period" := PeriodSelected;
                    prEmpTrans.Amount := Amount;
                    prEmpTrans.Balance := BalanceAmt;
                    prEmpTrans.Insert;
                end else begin
                    if SalCard.Get("HR-Employee"."No.") then
                        if "Increment Percentage" = 0 then
                            Error('Enter the Percentage of Increment');
                    SalCard."Basic Pay" := SalCard."Basic Pay" + (("Increment Percentage" / 100) * SalCard."Basic Pay");
                    SalCard.Modify;
                    CommentLine.Reset;
                    CommentLine.SetRange(CommentLine."Table Name", CommentLine."Table Name"::Employee);
                    if CommentLine.FindLast then
                        Int := CommentLine."Line No."
                    else
                        Int := 10000;
                    CommentLine.Init;
                    CommentLine."Table Name" := CommentLine."Table Name"::Employee;
                    CommentLine."No." := "HR-Employee"."No.";
                    CommentLine."Line No." := Int + 10000;
                    CommentLine.Date := Today;
                    CommentLine.Comment := CommentText;
                    CommentLine.Insert;

                end;
            end;

            trigger OnPreDataItem()
            begin
                if not Confirm(Text0003, false) then
                    Error(Text0004);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1000000008)
                {
                    ShowCaption = false;
                    field("Transaction Code"; TransactionCode)
                    {
                        TableRelation = "prTransaction Codes";
                    }
                    field("Period Selected"; PeriodSelected)
                    {
                        TableRelation = "prPayroll Periods";
                    }
                    field(Amount; Amount)
                    {
                    }
                    field("Balance Amount"; BalanceAmt)
                    {
                    }
                    field("Salary Increment"; SalaryIncrement)
                    {
                    }
                    field("Increment Percentage"; "Increment Percentage")
                    {
                    }
                    field(Comment; CommentText)
                    {
                    }
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

    trigger OnPostReport()
    begin
        Message('Process Complete');
    end;

    var
        PayrollPeriod: Record "prPayroll Periods";
        PeriodSelected: Date;
        Month: Integer;
        Year: Integer;
        TransactionCode: Code[20];
        prEmpTrans: Record "prEmployee Transactions";
        prTransCode: Record "prTransaction Codes";
        Amount: Decimal;
        BalanceAmt: Decimal;
        SalaryIncrement: Boolean;
        "Increment Percentage": Decimal;
        SalCard: Record "prSalary Card";
        Text0003: Label 'Are you sure you want to Effect the Changes?';
        Text0004: Label 'You have decided to Abort the process';
        CommentLine: Record "Human Resource Comment Line";
        CommentText: Text[100];
        Int: Integer;
}


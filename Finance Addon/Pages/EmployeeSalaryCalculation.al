/// <summary>
/// Page EmployeeSalaryDetails (ID 50102).
/// </summary>
page 51534436 EmployeeSalaryDetails
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = SalaryDetailCal;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Gross Annual Salary"; Rec."Gross Annual Salary")
                {
                    ApplicationArea = all;
                }
                field("Position Clinic Allowance"; Rec."Position Clinic Allowance")
                {
                    ApplicationArea = all;
                }
            }
            group(Details)
            {
                field(Basic; Rec.Basic)
                {
                    ApplicationArea = all;
                }
                field(Transport; Rec.Transport)
                {
                    ApplicationArea = all;
                }
                field(Housing; Rec.Housing)
                {
                    ApplicationArea = all;
                }
                field("Utility Other Allowance"; Rec.Others)
                {
                    ApplicationArea = all;
                }
                field("Month Gross"; Rec."Monthly Gross")
                {
                    ApplicationArea = all;
                }
                field("Employer Pension"; Rec."Employer Pension")
                {
                    ApplicationArea = all;
                }
                field(NSITF; Rec.NSITF)
                {
                    ApplicationArea = all;
                }
                field("Total Cost"; EmpPayrollCost)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Calculate Salary Detail")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if Rec."Gross Annual Salary" > 0 then begin
                        Rec.Basic := 0;
                        Rec.Housing := 0;
                        rec.Transport := 0;
                        Rec.Others := 0;
                        Rec."Monthly Gross" := 0;
                        rec."Employer Pension" := 0;
                        Rec.NSITF := 0;
                        EmpPayrollCost := 0;

                        Rec.Basic := ((Rec."Gross Annual Salary" - (Rec."Position Clinic Allowance" * 12)) * 0.1) / 12;
                        Rec.Housing := ((Rec."Gross Annual Salary" - (Rec."Position Clinic Allowance" * 12)) * 0.3) / 12;
                        Rec.Transport := ((Rec."Gross Annual Salary" - (Rec."Position Clinic Allowance" * 12)) * 0.15) / 12;
                        Rec.Others := ((Rec."Gross Annual Salary" - (Rec."Position Clinic Allowance" * 12)) * 0.45) / 12;
                        Rec."Monthly Gross" := Rec.Basic + Rec.Housing + Rec.Transport + Rec.Others + Rec."Position Clinic Allowance";
                        Rec."Employer Pension" := (Rec.Basic + Rec.Transport + Rec.Housing) * 0.1;
                        Rec.NSITF := Rec."Monthly Gross" * 0.01;
                        EmpPayrollCost := Rec."Monthly Gross" + Rec."Employer Pension" + Rec.NSITF;
                    end;
                end;
            }
            action("Update All Employees prTransactions")
            {
                Caption = 'Update All Employees Transactions';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All; //jj120422 I added

                trigger OnAction()
                var
                    Employee: Record "HR-Employee";
                    PrTransaction: Record "prPeriod Transactions";
                begin
                    // if Confirm('Are you sure you want to update the in this transaction with the changes?', false) = false then
                    //     exit;

                    PrTransaction.Reset;
                    //Employee.SetRange(Employee."Salary Grade", rec."Employee Code");

                    PrTransaction.SetRange("Employee Code", rec."Employee Code");
                    PrTransaction.Init;
                    if PrTransaction.Find('-') then begin
                        repeat
                            Employee.Validate(Employee."Salary Notch/Step");
                            //Employee.Modify;
                            if PrTransaction."Transaction Code" = 'BPAY' then
                                PrTransaction.Amount := Basic
                            else
                                if PrTransaction."Transaction Code" = 'TRANSPORT' then
                                    PrTransaction.Amount := Transport
                                else
                                    if PrTransaction."Transaction Code" = 'HOUSING' then
                                        PrTransaction.Amount := Housing
                                    else
                                        PrTransaction.Amount := Others;
                            PrTransaction.Modify(true);




                        until Employee.Next = 0;
                    end;

                    Message('Update completed successfully.');
                end;
            }
        }
    }

    var
        EmpPayrollCost: Decimal;
}
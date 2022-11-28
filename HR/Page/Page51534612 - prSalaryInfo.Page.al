page 51534612 "prSalary Info"
{
    PageType = CardPart;
    SourceTable = "prSalary Card";

    layout
    {
        area(content)
        {
            group("Payment Info")
            {
                field("Basic Pay"; "Basic Pay")
                {
                    ApplicationArea = all;
                }
                field("Pays PAYE"; "Pays PAYE")
                {
                    ApplicationArea = all;
                }
                field("Pays NHF"; "Pays NHF")
                {
                    ApplicationArea = all;
                }
            }
            group("Payment History")
            {
                field("Cumm BasicPay"; "Cumm BasicPay")
                {
                    ApplicationArea = all;
                }
                field("Cumm GrossPay"; "Cumm GrossPay")
                {
                    ApplicationArea = all;
                }
                field("Cumm Allowances"; "Cumm Allowances")
                {
                    ApplicationArea = all;
                }
                field("Cumm PAYE"; "Cumm PAYE")
                {
                    ApplicationArea = all;
                }
                field("Cumm Deductions"; "Cumm Deductions")
                {
                    ApplicationArea = all;
                }
                field("Cumm NetPay"; "Cumm NetPay")
                {
                    ApplicationArea = all;
                }
            }
            group("Suspension Of Payment")
            {
                field("Suspend Pay"; "Suspend Pay")
                {
                    ApplicationArea = all;
                }
                field("Suspension Date"; "Suspension Date")
                {
                    ApplicationArea = all;
                }
                field("Suspension Reasons"; "Suspension Reasons")
                {
                    ApplicationArea = all;
                }
                field("Suspension End Date"; "Suspension End Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        //Get the open period
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then begin
            CurrentMonth := objPeriod."Date Opened";
            PeriodName := objPeriod."Period Name";
        end;
    end;

    var
        BasicSalary: Decimal;
        Question: Text[200];
        Answer: Boolean;
        objPeriod: Record "prPayroll Periods";
        CurrentMonth: Date;
        PeriodName: Text[30];
        PeriodTrans: Record "prPeriod Transactions";
}


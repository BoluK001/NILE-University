page 51534613 "prSalary Arrears"
{
    PageType = Card;
    SourceTable = "prSalary Arrears";

    layout
    {
        area(content)
        {
            group("Basic Pay Arrears")
            {
                Caption = 'Basic Pay Arrears';
                field("Employee Code"; "Employee Code")
                {
                    Enabled = true;

                    trigger OnValidate()
                    begin
                        //Get the employee name
                        strEmpName := '';
                        objEmp.Reset;
                        objEmp.SetRange(objEmp."No.", "Employee Code");
                        if objEmp.Find('-') then
                            strEmpName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                    end;
                }
                field(strEmpName; strEmpName)
                {
                    Caption = 'Name';
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field("Transaction Code"; "Transaction Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Period Month"; "Period Month")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Period Year"; "Period Year")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = all;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = all;
                }
                field("Current Basic"; "Current Basic")
                {
                    ApplicationArea = all;
                }
                field("Salary Arrears"; "Salary Arrears")
                {
                    Style = Strong;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field("PAYE Arrears"; "PAYE Arrears")
                {
                    Style = Strong;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        strEmpCode := "Employee Code";
        strTransCode := "Transaction Code";
        //Get the employee name
        strEmpName := '';
        objEmp.Reset;
        objEmp.SetRange(objEmp."No.", "Employee Code");
        if objEmp.Find('-') then
            strEmpName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";



        //Get the open/current period
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then
            PeriodMonth := PayPeriod."Period Month";
        PeriodYear := PayPeriod."Period Year";
        "Period Month" := PeriodMonth;
        "Period Year" := PeriodYear;

        //Get the Salary Arrears code
        TransCode.SetRange(TransCode."Special Transactions", 6);
        if TransCode.Find('-') then
            strTransCode := TransCode."Transaction Code";
        "Transaction Code" := strTransCode;

        //Get the staff current salary
        if SalCard.Get("Employee Code") then begin
            "Current Basic" := SalCard."Basic Pay";
        end;
    end;

    var
        objOcx: Codeunit prPayrollProcessing;
        SalCard: Record "prSalary Card";
        PayPeriod: Record "prPayroll Periods";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        TransCode: Record "prTransaction Codes";
        strTransCode: Text[30];
        strEmpCode: Text[30];
        SalArr: Record "prSalary Arrears";
        strEmpName: Text[50];
        objEmp: Record "HR-Employee";
}


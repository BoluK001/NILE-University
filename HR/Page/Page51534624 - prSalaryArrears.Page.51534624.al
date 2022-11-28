page 51534624 "pr Salary Arrears"
{
    PageType = Document;
    SourceTable = "HR-Employee";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field("""First Name""+' '+""Middle Name""+' '+""Last Name"""; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
                {
                    Caption = 'Name';
                    ApplicationArea = all;
                }
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                    ApplicationArea = all;
                    TableRelation = "prPayroll Periods"."Date Opened";
                }
                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
                    TableRelation = "prPayroll Periods"."Date Opened";
                }
                field(ProcessAll; ProcessAll)
                {
                    Caption = 'All Employees';
                    ApplicationArea = all;
                }
            }
            part(Control1102756010; prSalaryArrears)
            {
                SubPageLink = "Employee Code" = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Process Arrears")
                {
                    Caption = 'Process Arrears';
                    Image = CalculatePlanChange;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //Get the Salary Arrears code
                        TransCode.SetRange(TransCode."Special Transactions", 6);
                        if TransCode.Find('-') then
                            strTransCode := TransCode."Transaction Code";

                        //Get the open/current period
                        PayPeriod.SetRange(PayPeriod.Closed, false);
                        if PayPeriod.Find('-') then begin
                            PeriodMonth := PayPeriod."Period Month";
                            PeriodYear := PayPeriod."Period Year";
                        end;

                        if ProcessAll then begin
                            HrEmployee.Reset;
                            HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Normal);
                            if HrEmployee.Find('-') then begin
                                repeat
                                    //Get the staff current salary
                                    if SalCard.Get(HrEmployee."No.") then begin
                                        CurrBasic := SalCard."Basic Pay";
                                    end;
                                    objOcx.fnSalaryArrears(HrEmployee."No.", strTransCode, CurrBasic, StartDate, EndDate, PayPeriod."Date Opened",
                                    HrEmployee."Date Of Join", HrEmployee."Date Of Leaving");
                                until HrEmployee.Next = 0;
                            end;
                        end else begin
                            //Get the staff current salary
                            if SalCard.Get("No.") then begin
                                CurrBasic := SalCard."Basic Pay";
                            end;

                            objOcx.fnSalaryArrears("No.", strTransCode, CurrBasic, StartDate, EndDate, PayPeriod."Date Opened",
                            "Date Of Join", "Date Of Leaving");

                        end;
                    end;
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        ProcessAll: Boolean;
        HrEmployee: Record "HR-Employee";
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
        CurrBasic: Decimal;
}


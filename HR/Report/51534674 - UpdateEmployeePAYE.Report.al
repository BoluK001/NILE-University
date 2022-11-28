report 51534674 "Update Employee PAYE"
{
    DefaultLayout = RDLC;
    RDLCLayout = './UpdateEmployeePAYE.rdlc';

    dataset
    {
        dataitem("Salary Step/Notch Transactions"; "Salary Step/Notch Transactions")
        {
            DataItemTableView = SORTING ("Salary Grade", "Salary Step/Notch", "Entry No") WHERE ("Transaction Code" = CONST ('PAYE'));
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Salary_Step_Notch_Transactions__Salary_Grade_; "Salary Grade")
            {
            }
            column(Salary_Step_Notch_Transactions__Salary_Step_Notch_; "Salary Step/Notch")
            {
            }
            column(Salary_Step_Notch_Transactions__Transaction_Code_; "Transaction Code")
            {
            }
            column(Salary_Step_Notch_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(Salary_Step_Notch_Transactions__Transaction_Type_; "Transaction Type")
            {
            }
            column(Salary_Step_Notch_Transactions_Amount; Amount)
            {
            }
            column(Salary_Step_Notch_TransactionsCaption; Salary_Step_Notch_TransactionsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Salary_Step_Notch_Transactions__Salary_Grade_Caption; FieldCaption("Salary Grade"))
            {
            }
            column(Salary_Step_Notch_Transactions__Salary_Step_Notch_Caption; FieldCaption("Salary Step/Notch"))
            {
            }
            column(Salary_Step_Notch_Transactions__Transaction_Code_Caption; FieldCaption("Transaction Code"))
            {
            }
            column(Salary_Step_Notch_Transactions__Transaction_Name_Caption; FieldCaption("Transaction Name"))
            {
            }
            column(Salary_Step_Notch_Transactions__Transaction_Type_Caption; FieldCaption("Transaction Type"))
            {
            }
            column(Salary_Step_Notch_Transactions_AmountCaption; FieldCaption(Amount))
            {
            }
            column(Salary_Step_Notch_Transactions_Entry_No; "Entry No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."Salary Grade", "Salary Step/Notch Transactions"."Salary Grade");
                Employee.SetRange(Employee."Salary Notch/Step", "Salary Step/Notch Transactions"."Salary Step/Notch");
                if Employee.Find('-') then begin
                    repeat

                        objPayrollPeriod.Reset;
                        objPayrollPeriod.SetRange(objPayrollPeriod.Closed, false);
                        if objPayrollPeriod.Find('-') then begin
                            EmpTrans.Reset;
                            EmpTrans.SetCurrentKey(EmpTrans."Employee Code", EmpTrans."Transaction Code");
                            EmpTrans.SetRange(EmpTrans."Employee Code", Employee."No.");
                            EmpTrans.SetRange(EmpTrans."Transaction Code", "Transaction Code");
                            EmpTrans.SetRange(EmpTrans."Payroll Period", objPayrollPeriod."Date Opened");
                            if EmpTrans.Find('-') then begin
                                EmpTrans.Amount := Amount;
                                EmpTrans.Modify;
                            end else begin
                                EmpTransR.Init;
                                EmpTransR."Employee Code" := Employee."No.";
                                EmpTransR."Transaction Code" := "Transaction Code";
                                EmpTransR."Period Month" := objPayrollPeriod."Period Month";
                                EmpTransR."Period Year" := objPayrollPeriod."Period Year";
                                EmpTransR."Payroll Period" := objPayrollPeriod."Date Opened";
                                EmpTransR."Transaction Name" := "Transaction Name";
                                EmpTransR.Amount := Amount;
                                EmpTransR.Insert;

                            end;

                        end;

                    until Employee.Next = 0;
                end;
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
        objPayrollPeriod: Record "prPayroll Periods";
        EmpTrans: Record "prEmployee Transactions";
        EmpTransR: Record "prEmployee Transactions";
        Employee: Record "HR-Employee";
        Salary_Step_Notch_TransactionsCaptionLbl: Label 'Salary Step/Notch Transactions';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}


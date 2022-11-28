report 51534789 "Cooperative Report-pens"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CooperativeReportpens.rdlc';

    dataset
    {
        dataitem("prEmployee Transactions"; "prEmployee Transactions")
        {
            CalcFields = IsCoop;
            DataItemTableView = WHERE (IsCoop = CONST (true));
            RequestFilterFields = "Payroll Period";
            column(EmployeeCode_prEmployeeTransactions; "prEmployee Transactions"."Employee Code")
            {
            }
            column(EmpNAme; Emp."Full Name")
            {
            }
            column(EmpDept; Emp."Department Code")
            {
            }
            column(Email; Emp."Company E-Mail")
            {
            }
            column(SerialNumber; SerialNum)
            {
            }
            column(PayrollPeriod_prEmployeeTransactions; Format("prEmployee Transactions"."Payroll Period"))
            {
            }
            column(PayrollPeriod_Month; "prEmployee Transactions"."Payroll Period")
            {
            }
            column(OriginalAmount_prEmployeeTransactions; "prEmployee Transactions"."Original Amount")
            {
            }
            column(Amount_prEmployeeTransactions; "prEmployee Transactions".Amount)
            {
            }
            column(StartDate_prEmployeeTransactions; Format("prEmployee Transactions"."Start Date"))
            {
            }
            column(TransactionName_prEmployeeTransactions; "prEmployee Transactions"."Transaction Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Emp.Get("prEmployee Transactions"."Employee Code");
                SerialNum += 1;


                if Emp.Status = Emp.Status::Inactive then
                    CurrReport.Skip;
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
        Emp: Record "HR Employees";
        SerialNum: Integer;
}


report 51534537 "HR Telephone Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRTelephoneReport.rdlc';

    dataset
    {
        dataitem("prEmployee Transactions"; "prEmployee Transactions")
        {
            DataItemTableView = WHERE("Transaction Code" = CONST('TEL'));
            RequestFilterFields = "Payroll Period";
            column(EmployeeCode_prEmployeeTransactions; "prEmployee Transactions"."Employee Code")
            {
            }
            column(Amount_prEmployeeTransactions; "prEmployee Transactions".Amount)
            {
            }
            column(PeriodMonth_prEmployeeTransactions; "prEmployee Transactions"."Period Month")
            {
            }
            column(PeriodYear_prEmployeeTransactions; "prEmployee Transactions"."Period Year")
            {
            }
            column(PayrollPeriod_prEmployeeTransactions; Format("Payroll Period"))
            {
            }
            column(EmpName; HREmp."Full Name")
            {
            }
            column(CompName; COmpInfo.Name)
            {
            }
            column(CompPicture; COmpInfo.Picture)
            {
            }
            column(WorkPhone; HREmp."Work Phone Number")
            {
            }
            column(CellPhone; HREmp."Cell Phone Number")
            {
            }

            trigger OnAfterGetRecord()
            begin
                HREmp.Get("prEmployee Transactions"."Employee Code");
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

    trigger OnPreReport()
    begin
        COmpInfo.Get;
        COmpInfo.CalcFields(Picture);
    end;

    var
        COmpInfo: Record "Company Information";
        HREmp: Record "HR Employees";
}


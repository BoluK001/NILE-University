report 51534725 "Payroll Transaction Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayrollTransactionReport.rdlc';

    dataset
    {
        dataitem("prEmployee Transactions"; "prEmployee Transactions")
        {
            column(EmployeeID; "prEmployee Transactions"."Employee Code")
            {
            }
            column(Amount; "prEmployee Transactions".Amount)
            {
            }
            column(Period; "prEmployee Transactions"."Payroll Period")
            {
            }
            column(Year; "prEmployee Transactions"."Period Year")
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(TransactionCode; "prEmployee Transactions"."Transaction Code")
            {
            }
            dataitem("HR Employees"; "HR Employees")
            {
                DataItemLink = "No." = FIELD("Employee Code");
                column(FirstName; "HR Employees"."First Name")
                {
                }
                column(MiddleName; "HR Employees"."Middle Name")
                {
                }
                column(LastName; "HR Employees"."Last Name")
                {
                }
                column(Department; "HR Employees"."Department Code")
                {
                }
                column(Location; "HR Employees"."Global Dimension 2 Code")
                {
                }
            }
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
        EmployeeRec: Record "HR Employee";
        TotalAmount: Decimal;
}


report 51534504 "Outstanding Loan"
{
    DefaultLayout = RDLC;
    RDLCLayout = './OutstandingLoan.rdlc';

    dataset
    {
        dataitem(prAssignEmployeeLoan; prAssignEmployeeLoan)
        {
            DataItemTableView = WHERE(Balance = FILTER(<> 0));
            RequestFilterFields = "Start Date";
            column(EmployeeCode_prAssignEmployeeLoan; prAssignEmployeeLoan."Employee Code")
            {
            }
            column(TransactionCode_prAssignEmployeeLoan; prAssignEmployeeLoan."Transaction Code")
            {
            }
            column(TransactionName_prAssignEmployeeLoan; prAssignEmployeeLoan."Transaction Name")
            {
            }
            column(Amount_prAssignEmployeeLoan; prAssignEmployeeLoan.Amount)
            {
            }
            column(Balance_prAssignEmployeeLoan; prAssignEmployeeLoan.Balance)
            {
            }
            column(ofRepayments_prAssignEmployeeLoan; prAssignEmployeeLoan."#of Repayments")
            {
            }
            column(StartDate_prAssignEmployeeLoan; Format(prAssignEmployeeLoan."Start Date", 0, 4))
            {
            }
            column(EndDate_prAssignEmployeeLoan; Format(prAssignEmployeeLoan."End Date", 0, 4))
            {
            }
            column(UserID; UserId)
            {
            }
            column(Today; Format(Today, 0, 4))
            {
            }
            column(Empname; Name)
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Emp.Get("Employee Code");
                Name := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
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

    trigger OnInitReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        Emp: Record "HR Employees";
        Name: Text[100];
}


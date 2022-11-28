report 51534585 "PAYE Remittance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PAYERemittance.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = WHERE("Transaction Code" = FILTER('PAYE' | 'PAYE-CALC' | 'PAYE-X'));
            column(EmployeeCode_prPeriodTransactions; "prPeriod Transactions"."Employee Code")
            {
            }
            column(TransactionCode_prPeriodTransactions; "prPeriod Transactions"."Transaction Code")
            {
            }
            column(TransactionName_prPeriodTransactions; "prPeriod Transactions"."Transaction Name")
            {
            }
            column(Amount_prPeriodTransactions; "prPeriod Transactions".Amount)
            {
            }
            column(PayrollPeriod_prPeriodTransactions; "prPeriod Transactions"."Payroll Period")
            {
            }
            column(Loc; "prPeriod Transactions"."Location/Division")
            {
            }
            column(Department_prPeriodTransactions; "prPeriod Transactions".Department)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(EmpLevel; EmpLevel)
            {
            }
            column(yearP; Date2DMY(payPeriod, 3))
            {
            }
            column(TaxID; objEmp."Social Security No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Date2DMY(payPeriod, 3) <> Date2DMY("prPeriod Transactions"."Payroll Period", 3) then
                    CurrReport.Skip;

                EmpNation := '';
                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then begin
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                    BranchName := objEmp."Department Code";
                    EmpLevel := objEmp."Salary Grade";
                    EmpNation := objEmp.Citizenship;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Payroll Year"; payPeriod)
                {
                    TableRelation = "prPayroll Periods";
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

    trigger OnPreReport()
    begin
        if Format(payPeriod) = '' then
            Error('Please specify a payroll year');
    end;

    var
        payPeriod: Date;
        EmployeeName: Text[200];
        objEmp: Record "HR Employees";
        Depts: Text[30];
        BranchName: Text[30];
        EmpLevel: Code[20];
        EmpNation: Text;
}


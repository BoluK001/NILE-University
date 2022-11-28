report 51534647 "PrEmp Final entitlement sheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PrEmpFinalentitlementsheet.rdlc';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            column(PageNo; CurrReport.PageNo)
            {
            }
            column(Today; Format(Today, 0, 4))
            {
            }
            column(User; UserId)
            {
            }
            column(No_HREmployees; "HR Employees"."No.")
            {
            }
            column(FirstName_HREmployees; "HR Employees"."First Name")
            {
            }
            column(MiddleName_HREmployees; "HR Employees"."Middle Name")
            {
            }
            column(LastName_HREmployees; "HR Employees"."Last Name")
            {
            }
            column(DepartmentCode_HREmployees; "HR Employees"."Department Code")
            {
            }
            column(Supervisor_HREmployees; "HR Employees".Supervisor)
            {
            }
            column(Position_HREmployees; "HR Employees"."Job Description")
            {
            }
            column(NameOfManager_HREmployees; "HR Employees"."Name Of Manager")
            {
            }
            column(JobTitle_HREmployees; "HR Employees"."Job Title")
            {
            }
            column(DateOfJoiningtheCompany_HREmployees; "HR Employees"."Date Of Joining the Company")
            {
            }
            column(DateOfLeavingtheCompany_HREmployees; "HR Employees"."Date Of Leaving the Company")
            {
            }
            column(Picture_CompanyInfo1; CompInfo.Picture)
            {
            }
            column(LeaveBalance_HREmployees; "HR Employees"."Leave Balance")
            {
            }
            column(NoticePeriodServed_HREmployees; "HR Employees"."Notice Period Served")
            {
            }
            column(NoticePeriod_HREmployees; "HR Employees"."Notice Period")
            {
            }
            dataitem("prEmployee Transactions"; "prEmployee Transactions")
            {
                DataItemLink = "Employee Code" = FIELD ("No.");
                column(Amount_prEmployeeTransactions; "prEmployee Transactions".Amount)
                {
                }
                column(TransactionCode_prEmployeeTransactions; "prEmployee Transactions"."Transaction Code")
                {
                }
                column(TransactionName_prEmployeeTransactions; "prEmployee Transactions"."Transaction Name")
                {
                }
                column(EmpTransactionAmount; EmpTransactionAmount)
                {
                }
                column(ProratedDays; Daysworked)
                {
                }
                column(ProratedAmount; ProratedAmount)
                {
                }
                dataitem("prPeriod Transactions"; "prPeriod Transactions")
                {
                    DataItemLink = "Employee Code" = FIELD ("Employee Code"), "Payroll Period" = FIELD ("Payroll Period");
                    column(PeriodTransactionCode; "prPeriod Transactions"."Transaction Code")
                    {
                    }
                    column(PeriodTransactionName; "prPeriod Transactions"."Transaction Name")
                    {
                    }
                    column(PeriodTransactionAmount; "prPeriod Transactions".Amount)
                    {
                    }
                    column(ProratedPeriodAmount; ProratedPeriodAmount)
                    {
                    }
                    column(PeriodAmount; PeriodAmount)
                    {
                    }
                    column(GrantAmount; GrantAmount)
                    {
                    }
                    column(GrantProrated; GrantProrated)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if "prPeriod Transactions"."Transaction Code" <> '' then begin
                            if ("prPeriod Transactions"."Transaction Code" = 'TXCHRG') or ("prPeriod Transactions"."Transaction Code" = 'NHF') then
                                PeriodAmount := "prPeriod Transactions".Amount * -1
                            else
                                CurrReport.Skip;
                        end;
                        ProratedPeriodAmount := Round(((PeriodAmount / 30) * Daysworked), 0.01, '=');

                        TotalPeriodAmount += PeriodAmount;
                        TotalProratedPeriodAmount += ProratedPeriodAmount;

                        //GrantAmount := TotalPeriodAmount + TotalEmpTransactionAmount;
                        //GrantProrated :=  TotalProratedPeriodAmount + TotalProratedAmount;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    /*IF "HR Employees".GET("prEmployee Transactions"."Employee Code") THEN BEGIN
                      "HR Employees".TESTFIELD("HR Employees"."Date Of Leaving the Company");
                       ExitDate := "HR Employees"."Date Of Leaving the Company";
                    END;
                    
                    
                    IF "prEmployee Transactions"."Payroll Period" > ExitDate THEN
                    ERROR(TXT001);
                    
                    
                    Daysworked := ExitDate - "prEmployee Transactions"."Payroll Period";
                    
                    
                    IF "prEmployee Transactions"."Transaction Code" <> '' THEN BEGIN
                      //"prEmployee Transactions".CALCFIELDS("prEmployee Transactions"."Transaction Type");
                    
                      IF "prEmployee Transactions"."Transaction Type" = "prEmployee Transactions"."Transaction Type"::"0" THEN
                        EmpTransactionAmount := "prEmployee Transactions".Amount
                      ELSE IF "prEmployee Transactions"."Transaction Type" = "prEmployee Transactions"."Transaction Type"::"1" THEN
                        EmpTransactionAmount := "prEmployee Transactions".Amount * -1;
                    END;
                    
                    
                    ProratedAmount := ROUND(((EmpTransactionAmount/30) * Daysworked),0.01,'=');
                    TotalEmpTransactionAmount += EmpTransactionAmount;
                    TotalProratedAmount += ProratedAmount;
                       */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                GrantAmount := TotalPeriodAmount + TotalEmpTransactionAmount;
                GrantProrated := TotalProratedPeriodAmount + TotalProratedAmount;
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
        CompInfo.Get();
        CompInfo.CalcFields(CompInfo.Picture);
    end;

    var
        CompInfo: Record "Company Information";
        HREmp: Record "HR-Employee";
        Daysworked: Integer;
        ExitDate: Date;
        PayrollPeriod: Record "prPayroll Periods";
        TXT001: Label 'Sorry, the Employee  exit date is cannot be less than accounting period start date ';
        ProratedAmount: Decimal;
        TXT002: Label 'The Date Opened in the New accounting period must have a value';
        PeriodTransactions: Record "prPeriod Transactions";
        EmpTransactionAmount: Decimal;
        PeriodAmount: Decimal;
        ProratedPeriodAmount: Decimal;
        i: Integer;
        TotalEmpTransactionAmount: Decimal;
        TotalProratedAmount: Decimal;
        TotalPeriodAmount: Decimal;
        TotalProratedPeriodAmount: Decimal;
        GrantAmount: Decimal;
        GrantProrated: Decimal;
}


report 51534680 "Payroll Summary Detailed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayrollSummaryDetailed.rdlc';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(Name2_CompanyInformation; "Company Information"."Name 2")
            {
            }
            column(Address_CompanyInformation; "Company Information".Address)
            {
            }
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields(Picture);
            end;
        }
        dataitem("HR-Employee"; "HR-Employee")
        {
            column(No_HREmployee; "HR-Employee"."No.")
            {
            }
            column(FirstName_HREmployee; "HR-Employee"."First Name")
            {
            }
            column(MiddleName_HREmployee; "HR-Employee"."Middle Name")
            {
            }
            column(LastName_HREmployee; "HR-Employee"."Last Name")
            {
            }
            column(LocationDivisionCode_HREmployee; "HR-Employee"."Location/Division Code")
            {
            }
            column(DepartmentCode_HREmployee; "HR-Employee"."Department Code")
            {
            }
            column(Office_HREmployee; "HR-Employee".Office)
            {
            }
            column(SalaryGrade_HREmployee; "HR-Employee"."Salary Grade")
            {
            }
            column(SalaryNotchStep_HREmployee; "HR-Employee"."Salary Notch/Step")
            {
            }
            dataitem("prPeriod Transactions"; "prPeriod Transactions")
            {
                DataItemLink = "Employee Code" = FIELD("No."), "Payroll Period" = FIELD("Current Month Filter");
                column(TransactionCode_prPeriodTransactions; "prPeriod Transactions"."Transaction Code")
                {
                }
                column(GroupText_prPeriodTransactions; "prPeriod Transactions"."Group Text")
                {
                }
                column(TransactionName_prPeriodTransactions; "prPeriod Transactions"."Transaction Name")
                {
                }
                column(Amount_prPeriodTransactions; "prPeriod Transactions".Amount)
                {
                }
                column(Balance_prPeriodTransactions; "prPeriod Transactions".Balance)
                {
                }
                column(OriginalAmount_prPeriodTransactions; "prPeriod Transactions"."Original Amount")
                {
                }
                column(GroupOrder_prPeriodTransactions; "prPeriod Transactions"."Group Order")
                {
                }
                column(SubGroupOrder_prPeriodTransactions; "prPeriod Transactions"."Sub Group Order")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //ERROR('%1 vs %2 vs %3',"prPeriod Transactions"."Employee Code","prPeriod Transactions"."Transaction Code","prPeriod Transactions"."Payroll Period");
                end;
            }

            trigger OnPreDataItem()
            begin
                SetFilter("Current Month Filter", Format("Current Period Filter"));
                if "HR-Employee".GetFilter("HR-Employee"."Current Month Filter") = '' then
                    Error('You must specify current Period filter.');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Current Period Filter"; "Current Period Filter")
                {
                    Caption = 'Period Filter';
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

    trigger OnInitReport()
    begin
        //clear("HR-Employee"."Current Month Filter");
    end;

    trigger OnPreReport()
    begin
        //CompanyInfo.GET;
        //CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        "Current Period Filter": Date;
        SortOrder: Integer;
}


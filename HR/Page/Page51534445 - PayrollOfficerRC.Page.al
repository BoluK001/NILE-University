page 51534445 "Payroll Officer RC"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;
                systempart(Control1901420308; Outlook)
                {
                    ApplicationArea = all;
                }
            }
            group(Approvals) // jj270922  I added to profile
            {
                part(ApprovalsActivities; "Approvals Activities")
                {
                    ApplicationArea = Suite;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;
                part(Control17; "My Job Queue")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                part(Control1907692008; "My Customers")
                {
                    ApplicationArea = all;
                    Visible = false;  //jj270922
                }
                part(Control1902476008; "My Vendors")
                {
                    ApplicationArea = all;
                    Visible = false;  //jj270922
                }
                systempart(Control1901377608; MyNotes)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(Payslip)
            {
                Caption = 'Payslip';
                Image = "Report";
                RunObject = Report "prPaySlip2 Taxable1";
                ApplicationArea = all;
            }
            action("Employee List")
            {
                Caption = 'Employee List';
                ApplicationArea = all;
                Image = "Report";
            }
            /*  action("Negative Pay List")
             {
                 Caption = 'Payslip';
                 Image = "Report";
                 RunObject = Report "prPaySlip2 Non Taxable2";
                 ApplicationArea = all;
             } */


            action("Payroll Summary")
            {
                Caption = 'Payroll Summary';
                Image = "Report";
                ApplicationArea = all;
                RunObject = Report "Payroll Summary";
            }
            action("Basic Pay Listing")
            {
                Caption = 'Basic Pay Listing';
                Image = "Report";
                ApplicationArea = all;
                RunObject = Report "Basic Pay Listing";
            }
            action("Contract Summary Analysis-Dep")
            {
                // RunObject = Report Report39005673;
            }
            action("Contract Summary Analysis")
            {
                // RunObject = Report Report39005674;
            }
            action("Transactions - Summary")
            {
                Caption = 'Transactions - Summary';
                ApplicationArea = all;
                Image = "Report";
                RunObject = Report "Transactions Summary";
            }
            action("Transactions - Detailed")
            {
                Caption = 'Transactions - Detailed';
                ApplicationArea = all;
                Image = "Report";
                RunObject = Report "Transactions - Detailed";
            }
            action("Employee Earnings Summary")
            {
                Caption = 'Employee Earnings Summary';
                Image = "Report";
                ApplicationArea = all;
            }
            action("Employee Transaction History")
            {
                Caption = 'Employee Transaction History';
                Image = "Report";
                ApplicationArea = all;
                RunObject = Report "prLoan Payment History";
            }
            action("Staff Pension Contribution")
            {
                Caption = 'Staff Pension Contribution';
                Image = "Report";
                ApplicationArea = all;
                RunObject = Report "prStaff Pension Contrib";
            }
            action("Pension Advice Summary")
            {
                Caption = 'Pension Advice Summary';
                Image = "Report";
                ApplicationArea = all;
                RunObject = Report "Pension Advice Summary";
            }
            action("Gross & Net Pay Schedule")
            {
                Caption = 'Gross & Net Pay Schedule';
                Image = "Report";
                ApplicationArea = all;
                RunObject = Report "Gross & Net Pay Schedule";
            }
            action("NISTF Schedule")
            {
                Caption = 'NISTF Schedule';
                Image = "Report";
                ApplicationArea = all;
                RunObject = Report "NISTF Schedule";
            }
            action("NHF Schedule")
            {
                Caption = 'NHF Schedule';
                ApplicationArea = all;
                Image = "Report";
                RunObject = Report "NHF Schedule";
            }
            action("PAYE Schedule")
            {
                Caption = 'PAYE Schedule';
                Image = "Report";
                ApplicationArea = all;
                RunObject = Report "prPaye Schedule";
            }
            action("Bank Payment Schedule")
            {
                Caption = 'Bank Payment Schedule';
                Image = "Report";
                ApplicationArea = all;
                RunObject = Report "Bank Payment Schedule";
            }
            action("Bank Payment Schedule - Transaction")
            {
                Caption = 'Bank Payment Schedule - Transaction';
                Image = "Report";
                ApplicationArea = all;
            }
            action("Bank Advise Summary")
            {
                Caption = 'Bank Advise Summary';
                Image = "Report";
                ApplicationArea = all;
                RunObject = Report "Bank Advise Summary";
            }
            action("Overtime Report")
            {
                Caption = 'Overtime Report';
                ApplicationArea = all;
                Image = "Report";
            }
            action(Loans)
            {
                Caption = 'Loans';
                Image = "Report";
                ApplicationArea = all;
                RunObject = Report "Loans Report";
                Visible = false; //jj230622
            }
            action("Deductions to Organizations")
            {
                Caption = 'Deductions to Organizations';
                ApplicationArea = all;
                Image = "Report";
                RunObject = Report "Deductions to Organizations";
            }
            action("Other Deductions")
            {
                Caption = 'Other Deductions';
                ApplicationArea = all;
                Image = "Report";
                RunObject = Report "Other Deductions";
            }
            action("Staff Pension Balance")
            {
                Caption = 'Staff Pension Balance';
                Image = "Report";
                ApplicationArea = all;
                RunObject = Report "prStaff Pension Balance";
            }
            action("Generate Reconcilliation")
            {
                Caption = 'Generate Reconcilliation';
                ApplicationArea = all;
                Image = "Report";
                RunObject = Page "Salary List";
                Visible = false; //  jj230622 
            }
            action("Gross Reconcilliation")
            {
                Caption = 'Gross Reconcilliation';
                ApplicationArea = all;
                Image = "Report";
                RunObject = Report "Gross Reconcilliation";
                Visible = false; //  jj230622 
            }
            action("Reconciliations - By Transactions")
            {
                Caption = 'Reconciliations - By Transactions';
                Image = "Report";
                ApplicationArea = all;
            }
            action("Reconciliations - By Employee")
            {
                Caption = 'Reconciliations - By Employee';
                ApplicationArea = all;
                Image = "Report";
                RunObject = Report "Reconciliation - By Employee";
            }
            action("Reconciliations - By Entry/Exits")
            {
                Caption = 'Reconciliations - By Entry/Exits';
                ApplicationArea = all;
                Image = "Report";
                RunObject = Report "Reconciliation - By Entry/Exit";
                Visible = false; //  jj230622 
            }
            action("Reconciliations - Summary")
            {
                Caption = 'Reconciliations - Summary';
                Image = "Report";
                ApplicationArea = all;
                RunObject = Report "Reconciliations - Summary";
                Visible = false; //  jj230622 
            }
            action("Reconciliations - Summary Changes")
            {
                Caption = 'Reconciliations - Summary Changes';
                ApplicationArea = all;
                Image = "Report";
                RunObject = Report "Reconciliations - Summary Ch";
                Visible = false; //  jj230622 
            }
            action("Payroll Journal")
            {
                Caption = 'Payroll Journal';
                ApplicationArea = all;
                Image = "Report";
                RunObject = Report "Payroll Journal";
            }
            action(Action1102755082)
            {
                Caption = 'Overtime Report';
                Image = "Report";
                ApplicationArea = all;
            }
            action("Overtime Report - By Department")
            {
                Caption = 'Overtime Report - By Department';
                ApplicationArea = all;
            }
            action("Overtime Report - By Location Summary")
            {
                Caption = 'Overtime Report - By Location Summary';
                ApplicationArea = all;
            }
            action("Payroll Summary - SUG")
            {
                Caption = 'Payroll Summary - SUG';
                ApplicationArea = all;
            }
            /* action("Payroll Summary - AGRO")
            {
                Caption = 'Payslip';
                Image = "Report";
                RunObject = Report "prPaySlip2 Non Taxable2";
                ApplicationArea = all;
            } */


            action("Payroll Summary - By Location")
            {
                Caption = 'Payroll Summary - By Location';
                ApplicationArea = all;
            }
            action("Payroll Summary - By Location Summary")
            {
                Caption = 'Payroll Summary - By Location Summary';
                ApplicationArea = all;
            }
            action("Detailed Payroll Summary")
            {
                Caption = 'Detailed Payroll Summary';
                ApplicationArea = all;
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Payroll Summary Detailed";
            }
            separator(Action1000000001)
            {
            }
            action("Emp. Payslip")
            {
                Caption = 'Emp. Payslip';
                ApplicationArea = all;
                Image = "Report";
                RunObject = Report prPaySlipPerEmp;
            }
        }
        area(embedding)
        {
            action("General Journals")
            {
                Caption = 'General Journals';
                Image = Journal;
                ApplicationArea = all;
                Visible = false;    //jj290922  Made it not visible to users
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(General),
                                    Recurring = CONST(false));

            }

            action("Update Employee Transactions")
            {
                Caption = 'Update Employee Transactions';
                ApplicationArea = all;
                RunObject = Page "Employee Transaction List";
                visible = false;   //jj270922
            }

            action("Employee Loans")
            {
                Caption = 'Employee Loans';
                ApplicationArea = all;
                RunObject = Page prAssignEmployeeLoans;
                Visible = false; //jj230622
            }
            action("Processed Employee Loans")
            {
                Caption = 'Processed Employee Loans';
                ApplicationArea = all;
                RunObject = Page "Processed Employee Loans";
                Visible = false; //jj230622
            }
            action("Staff Loan Accounts")
            {
                Caption = 'Staff Loan Accounts';
                Image = Customer;
                ApplicationArea = all;
                RunObject = Page "Customer List";
                RunPageView = WHERE("Customer Posting Group" = CONST('STAFFLOAN'));
                Visible = false;
            }
            action("Staff Loans HR")
            {
                RunObject = Page "prAssignEmployeeLoans Admin";
                ApplicationArea = all;
                Visible = false; //jj230622
            }



        }
        area(sections)
        {
            group("Employee Management")
            {

                action("Employees Management")
                {
                    Caption = 'Employees Management';
                    ApplicationArea = all;
                    RunObject = Page "HR Employee List";
                }
                action("Employee Absence Registration")
                {
                    Caption = 'Employees Management';
                    ApplicationArea = all;
                    RunObject = Page "HR Employee List";
                    visible = false; //jj010322
                }

                action("Inactive Employees")
                {
                    Caption = 'Inactive Employees';
                    ApplicationArea = all;
                    RunObject = Page "HR Inactive Employees";
                }
            }
            group(Payroll)
            {
                Caption = 'Payroll';
                action(Salary)
                {
                    Caption = 'Salary';
                    ApplicationArea = all;
                    RunObject = Page "Salary List";
                }

                action("Transactions Setup")
                {
                    Caption = 'Transactions Setup';
                    ApplicationArea = all;
                    RunObject = Page "Pr Payroll Transactions Codes";
                }
                action("Salary Grades")
                {
                    Caption = 'Salary Grades';
                    ApplicationArea = all;
                    RunObject = Page "Salary Grades List";
                }
                action("Payroll Period")
                {
                    Caption = 'Period Management';
                    Image = AccountingPeriods;
                    ApplicationArea = all;
                    RunObject = Page "prPayroll Periods";
                }
                action(EmployeeSalaryDetails)
                {
                    Caption = 'Employee Salary Details';
                    RunObject = Page "Employee Salary Calculation Li";
                    ApplicationArea = all;
                    Visible = false;
                }
                action("<prP.A.Y.E Setup>")
                {
                    Caption = 'Page prP.A.Y.E Setup';
                    ApplicationArea = all;
                    RunObject = Page "prP.A.Y.E Setup";
                }
                action("Bank Structure")
                {
                    Caption = 'Bank Structure';
                    ApplicationArea = all;
                    RunObject = Page "prBank Structure";
                }
                action("HR User Setup")
                {
                    Caption = 'HR User Setup';
                    ApplicationArea = all;
                    RunObject = Page "HR User Setup";
                }
                action("Membership Groups")
                {
                    Caption = 'Membership Groups';
                    ApplicationArea = all;
                    RunObject = Page "prMembership Groups";
                }
                action("Payroll Type")
                {
                    Caption = 'Payroll Type';
                    RunObject = Page "prPayroll Type";
                    ApplicationArea = All;
                    Visible = false;
                }
                action("Posting Groups")
                {
                    Caption = 'Posting Groups';
                    ApplicationArea = all;
                    RunObject = Page "prEmployee Posting Group";
                }
                Action("Payroll Posting Group")
                {
                    ApplicationArea = All;
                    RunObject = page "Payroll Posting Groups";
                }
            }


            group("Leave Management")
            {


                action("Posted Leave Applications")
                {
                    RunObject = Page "Posted Leave Applications";
                    ApplicationArea = all;
                }
            }

            /*group("Disciplinary Case Mgt")   //jj290922  Made it not visible to users
            {
                Caption = 'Disciplinary Case Mgt';
                action("HR Query List")
                {
                    Caption = 'HR Query List';
                    ApplicationArea = All;
                    RunObject = Page "HR Query List";
                }
                action("Disciplinary Cases")
                {
                    Caption = 'Disciplinary Cases';
                    ApplicationArea = all;
                    RunObject = Page "HR Disciplinary Cases List";
                }
                action("Query")
                {
                    Caption = 'Query';
                    RunObject = Page "HR Query List";
                    ApplicationArea = all;
                    RunPageView = WHERE("Send to Hr" = CONST(true));
                }


            }   */   //jj290922  Made it not visible to users


            group("Approvals")
            {

                action("Approval Request Entries")
                {
                    Caption = 'Approval Request Entries';
                    ApplicationArea = all;
                    RunObject = Page "Approval Request Entries";
                }
                action("Requests to Approve")
                {
                    RunObject = page "Requests to Approve";
                    ApplicationArea = All;
                }
            }


        }
        area(creation)
        {
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Journal Transfer")
            {
                Caption = 'Journal Transfer';
                Image = TransferToGeneralJournal;
                ApplicationArea = all;
                RunObject = Report prPayrollJournalTransfer;
            }
            action("Rates & Ceilings")
            {
                Caption = 'Rates & Ceilings';
                Image = PayrollStatistics;
                ApplicationArea = all;
                RunObject = Page "prRates & Ceilings";
            }
            action(Action1102755036)
            {
                Caption = 'Posting Groups';
                Image = Group;
                ApplicationArea = all;
                RunObject = Page "prEmployee Posting Group";
            }


            action(" Import employee transactions ")
            {
                Caption = ' Import employee transactions ';
                RunObject = XmlPort "imp emp trans reviewed";
                ApplicationArea = all;
                visible = true;


            }
            action("Allowance Variations")
            {
                Caption = 'Allowance Variations';
                Image = Allocations;
                ApplicationArea = all;
                RunObject = Page "Allowance Var";
            }
            action("Deduction Variations")
            {
                Caption = 'Deduction Variations';
                Image = RemoveLine;
                ApplicationArea = all;
                RunObject = Page "Deductions Var";
            }
            action("Processed Allowance Variations")
            {
                Caption = 'Processed Allowance Variations';
                Image = CalculateCost;
                ApplicationArea = all;
                RunObject = Page "Processed Allowance Variations";
            }
            action("Processed Deduction Variations")
            {
                Caption = 'Processed Deduction Variations';
                Image = CalculateLines;
                ApplicationArea = all;
                RunObject = Page "Processed Deduction Variations";
            }
            action("Assign Employee Loan")
            {
                Caption = 'Assign Employee Loan';
                ApplicationArea = all;
                RunObject = Page prAssignEmployeeLoan;
                Visible = false; //jj230622
            }
            action("Generate 13th Month")
            {
                Caption = 'Generate 13th Month';
                ApplicationArea = all;
                Image = CalculateCalendar;
                RunObject = Report "Generate 13th Month";
                Visible = false; //jj230622
            }
            separator(Reset)
            {
                Caption = 'Reset';
            }
            action("Clear Weekend OT")
            {
                Caption = 'Clear Weekend OT';
                Image = ClearLog;
                ApplicationArea = all;
                RunObject = Report "Clear Weekend OT";
                Visible = false;
            }
            action("Clear Old Code Variations")
            {
                Caption = 'Clear Old Code Variations';
                Image = ClearLog;
                ApplicationArea = all;
                RunObject = Report "Clear Old Code Variations";
                Visible = false;
            }
            action("Up-Process Variations")
            {
                Caption = 'Up-Process Variations';
                Image = CalculateRegenerativePlan;
                ApplicationArea = all;
                RunObject = Report "Up-Process Variations";
                Visible = false;
            }
            separator("PAYE Reset")
            {
                Caption = 'PAYE Reset';
            }
            action("Mark as Does Not Pay PAYE")
            {
                Caption = 'Mark as Does Not Pay PAYE';
                ApplicationArea = all;
                Image = CheckList;
                RunObject = Report "Mark as DOES NOT pay PAYE";
                Visible = false;
            }
            action("Mark as Pays PAYE")
            {
                Caption = 'Mark as Pays PAYE';
                Image = CheckList;
                ApplicationArea = all;
                RunObject = Report "Mark as PAYS PAYE";
                Visible = false;
            }
            action("Update Employee PAYE")
            {
                Caption = 'Update Employee PAYE';
                Image = UpdateDescription;
                ApplicationArea = all;
                RunObject = Report "Update Employee PAYE";
                Visible = false;
            }
        }
    }
}


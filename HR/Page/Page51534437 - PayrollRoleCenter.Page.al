page 51534437 "Payroll Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            /* part(Control104; "Headline RC Order Processor")  //jj271022
             {
                 ApplicationArea = Basic, Suite;
             }  */
            group(OutlookNew)
            {
                systempart(Outlook; Outlook)
                {
                    ApplicationArea = all;
                }
            }
            group(New)
            {
                part("My Job Queue"; "My Job Queue")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                part("My Customers"; "My Customers")
                {
                    ApplicationArea = all;

                }
                part("My Vendors"; "My Vendors")
                {
                    ApplicationArea = all;

                }
                systempart(MyNotes; MyNotes)
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
            action("HR Staff Birthday & Age")
            {
                Caption = 'HR Staff Birthday & Age';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "HR Staff Age";
                ApplicationArea = all;
            }
            action("Training Applicants Report")
            {
                Caption = 'Training Applicants Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "HR Training Appl";
                ApplicationArea = all;
            }
            action("Finance Posting Rep Dep EXEC")
            {
                Caption = 'Finance Posting Rep Dep EXEC';
                RunObject = Report "Finance Posting Reprt-EXEC";
                ApplicationArea = all;
            }
            action(" Finance Posting Rep LOC EXEC")
            {
                Caption = ' Finance Posting Rep LOC EXEC';
                RunObject = Report "Finance Posting Reprt LOC EXEC";
                ApplicationArea = all;
            }
            action("Bank Pay Analysis EXEC")
            {
                Caption = ' Bank Pay Analysis EXEC';
                RunObject = Report "Bank Pay Analysis EXECUTIVES";
                ApplicationArea = all;
            }

            action(" Payroll Summary EXEC")
            {
                Caption = ' Payroll Summary EXEC';
                RunObject = Report "Payroll Summary Rep-EXECUTIVE";
                ApplicationArea = all;
            }
            action("Report Payroll Summ Dep not Tax EXEC")
            {
                Caption = 'Report Payroll Summ Dep not Tax EXEC';
                RunObject = Report "Payroll Sum - Dep Non Tax EXEC";
                ApplicationArea = all;
            }
            action("Pension Contrib Bal EXEC")
            {
                Caption = 'Pension Contrib Bal EXEC';
                RunObject = Report "Executive Pension Contrib Bal";
                ApplicationArea = all;
            }
            action("Finace Posting Report- Dept PERM")
            {
                Caption = 'Finace Posting Report- Dept PERM';
                RunObject = Report "Payroll Summary Analysis - Dep";
                ApplicationArea = all;
            }
            action("Finance Posting Report  LOCATION PERM")
            {
                Caption = 'Finance Posting Report  LOCATION PERM';
                RunObject = Report "Payroll Summary Analysis - Loc";
                ApplicationArea = all;
            }
            action(" Payroll Sum - Dep Non Tax PERM")
            {
                Caption = ' Payroll Sum - Dep Non Tax PERM';
                RunObject = Report "Payroll Summary - Dep Non Tax";
                ApplicationArea = all;
            }
            action("Finance Posting Summary- DEP NON TAXABLE1")
            {
                Caption = 'Finance Posting Summary- DEP NON TAXABLE';
                Image = "Report";
                RunObject = Report "PayrollSumAnalyDep NON CO";
                ApplicationArea = all;
            }
            action("Finance Posting Summary - LOC NON TAXABLE")
            {
                Caption = 'Finance Posting Summary - LOC NON TAXABLE';
                Image = "Report";
                RunObject = Report "Payroll Sum AnaLY - Loc NON";
                ApplicationArea = all;
            }
            action(Payslip)
            {
                Caption = 'Payslip';
                Image = "Report";
                RunObject = Report "prPaySlip2 Non Taxable2";
                ApplicationArea = all;
            }
            action("Finance Posting Summary- DEP NONTAXABLE")
            {
                Caption = 'Finance Posting Summary- DEP NON TAXABLE';
                Image = "Report";
                RunObject = Report "PayrollSumAnalyDep NON CO";
                ApplicationArea = all;
            }
            action(" HR Appraisal Result")
            {
                Caption = ' HR Appraisal Result';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Appraisal Result";
                ApplicationArea = all;
            }
            action("HR Appraisal Result Details")
            {
                Caption = 'HR Appraisal Result Details';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Appraisal Result Details";
                ApplicationArea = all;
            }
            action("Employee List")
            {
                Caption = 'Employee List';
                Image = "Report";
                ApplicationArea = all;
            }
            action("Payroll Summary")
            {
                Caption = 'Payroll Summary';
                Image = "Report";
                RunObject = Report "Payroll Summary";
                Visible = false;
                ApplicationArea = all;
            }
            action("Basic Pay Listing")
            {
                Caption = 'Basic Pay Listing';
                Image = "Report";
                RunObject = Report "Basic Pay Listing";
                Visible = false;
                ApplicationArea = all;
            }
            action(" Basic Pay Listing-PERM")
            {
                Caption = ' Basic Pay Listing-PERM';
                RunObject = Report "Basic Pay Listing-PERM";
                ApplicationArea = all;
            }
            action("Permanent Summary Analysis-Dep")
            {
                Caption = 'Permanent Summary Analysis-Dep';
                Image = "Report";
                RunObject = Report "Permanent Summary Analysis-Dep";
                ApplicationArea = all;
            }
            action("Transactions - Detailed")
            {
                Caption = 'Transactions - Detailed';
                Image = "Report";
                RunObject = Report "Transactions - Detailed";
                ApplicationArea = all;
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
                RunObject = Report "prLoan Payment History";
                ApplicationArea = all;
            }
            action("Staff Pension Contribution")
            {
                Caption = 'Staff Pension Contribution';
                Image = "Report";
                RunObject = Report "prStaff Pension Contrib";
                ApplicationArea = all;
            }
            action("Pension Advice Summary")
            {
                Caption = 'Pension Advice Summary';
                Image = "Report";
                RunObject = Report "Pension Advice Summary";
                Visible = false;
                ApplicationArea = all;
            }
            action("Gross & Net Pay Schedule")
            {
                Caption = 'Gross & Net Pay Schedule';
                Image = "Report";
                RunObject = Report "Gross & Net Pay Schedule";
                ApplicationArea = all;

            }
            action("NISTF Schedule")
            {
                Caption = 'NISTF Schedule';
                Image = "Report";
                RunObject = Report "HR NSITF Report";
                ApplicationArea = all;
            }
            action("NHF Schedule")
            {
                Caption = 'NHF Schedule';
                Image = "Report";
                RunObject = Report "NHF Schedule";
                ApplicationArea = all;
            }
            action("Paye Schedule per Location")
            {
                Caption = 'Paye Schedule per Location';
                RunObject = Report "prPaye Schedule per loc";
                ApplicationArea = all;
            }
            action("PAYE Schedule1")
            {
                Caption = 'PAYE Schedule';
                Image = "Report";
                RunObject = Report "prPaye Schedule";
                ApplicationArea = all;
            }
            action("Report Bank Payment Schedule1")
            {
                Caption = 'Report Bank Payment Schedule';
                RunObject = Report "Bank Payment Schedule";
                ApplicationArea = all;
            }
            action(" Bank Pay Schedule-NETPAY-SPALL")
            {
                Caption = ' Bank Pay Schedule-NETPAY-SPALL';
                RunObject = Report "Bank Pay Schedule-NETPAY-SPALL";
                ApplicationArea = all;
            }
            action(" Bank Pay Schedule SPECIAL ALLOWANCE")
            {
                Caption = ' Bank Pay Schedule SPECIAL ALLOWANCE';
                RunObject = Report "Bank Pay Schedule-SPECIAL ALLW";
                ApplicationArea = all;
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
                RunObject = Report "Bank Advise Summary";
                ApplicationArea = all;
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
                RunObject = Report "Loans Report";
                ApplicationArea = all;
            }
            action("Other Deductions")
            {
                Caption = 'Other Deductions';
                Image = "Report";
                RunObject = Report "Other Deductions";
                ApplicationArea = all;
            }
            action("Staff Pension Balance")
            {
                Caption = 'Staff Pension Balance';
                Image = "Report";
                RunObject = Report "prStaff Pension Balance";
                ApplicationArea = all;
            }
            action("Generate Reconcilliation")
            {
                Caption = 'Generate Reconcilliation';
                Image = "Report";
                RunObject = Page "Salary List";
                ApplicationArea = all;
            }
            action("Leave Payment Report")
            {
                Caption = 'Leave Payment Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Leave - Payment";
                ApplicationArea = all;
            }
            action("Outstanding Leave Report")
            {
                Caption = 'Outstanding Leave days';
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Outstanding Leave days";
                ApplicationArea = all;
            }
            action("TRAINING REPORT")
            {
                /// RunObject = Report 51534575; //RBS Dennis
                /// ApplicationArea = All;
            }
            action("Detailed Payroll Summary")
            {
                Caption = 'Detailed Payroll Summary';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Payroll Summary Detailed";
                ApplicationArea = all;
            }
            separator(l)
            {
            }
            action("Meal Ticket")
            {
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "HR Meal Ticket Report";
                ApplicationArea = all;
            }
            action("HR Query Report")
            {
                Caption = 'HR Query Report';
                Image = Report2;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "HR Query Report";
                ApplicationArea = all;
            }
            action("Hr HMO Class Report")
            {
                Caption = 'Hr HMO Class Report';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "Hr HMO Class Report";
                ApplicationArea = all;
            }
            action("Hr Hmo Dependants Summary")
            {
                Caption = 'Hr Hmo Dependants Summary';
                Image = Report;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "Hr Hmo Dependants Summary";
                ApplicationArea = all;
            }
            action("Hr Hmo Report")
            {
                Caption = 'Hr Hmo Report';
                Image = Report;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "Hr Hmo Report";
                ApplicationArea = all;
            }
            action("Appraisal Approval")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Appraisal Approver Report";
                ApplicationArea = all;
            }
            action("HR Jobs Report")
            {
                Caption = 'HR Jobs Report';
                RunObject = Report "HR Jobs Report";
                ApplicationArea = all;
            }

            separator(k)
            {
            }
            action("Leave Applications1")
            {
                Caption = 'Leave Applications';
                Image = Report2;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "HR Leave Applications List";
                ApplicationArea = all;
            }
        }
        area(embedding)
        {
            action("General Journals")
            {
                Caption = 'General Journals';
                Image = Journal;
                RunObject = Page 251;
                RunPageView = WHERE("Template Type" = CONST(General),
                                    Recurring = CONST(false));
                ApplicationArea = all;
            }
            action(Salary)
            {
                Caption = 'Salary';
                RunObject = Page "Salary List";
                ApplicationArea = all;
            }
            action("Leave Journal")
            {
                Caption = 'Leave Journal';
                RunObject = Page "HR Leave Jnl. Template List";
                ApplicationArea = all;
            }
            action("HMO Hospitals")
            {
                Caption = 'HMO Hospitals';
                RunObject = Page "HR HMO Hospitals";
                ApplicationArea = all;
            }
            action("Update Employee Transactions")
            {
                Caption = 'Update Employee Transactions';
                RunObject = Page "Employee Transaction List";
                ApplicationArea = all;
            }
            action("Salary(All)")
            {
                Caption = 'Salary(All)';
                RunObject = Page "Salary List Admin";
                ApplicationArea = all;
            }
            action("Employee Loans")
            {
                Caption = 'Employee Loans';
                RunObject = Page prAssignEmployeeLoans;
                ApplicationArea = all;
            }
            action("Processed Employee Loans")
            {
                Caption = 'Processed Employee Loans';
                RunObject = Page "Processed Employee Loans";
                ApplicationArea = all;
            }
            action("Employee Classification")
            {
                Caption = 'Employee Classification';
                RunObject = Page "Emplyee Classification";
                ApplicationArea = all;
            }
            action("Staff Loan Accounts")
            {
                Caption = 'Staff Loan Accounts';
                Image = Customer;
                RunObject = Page 22;
                RunPageView = WHERE("Customer Posting Group" = CONST('STAFFLOAN'));
                Visible = false;
                ApplicationArea = all;
            }
            action("Staff Loans HR")
            {
                RunObject = Page "prAssignEmployeeLoans Admin";
                ApplicationArea = all;
            }
            action("Staff Probation & Confirmation")
            {
                Caption = 'Staff Probation & Confirmation';
                RunObject = Page "HR Confirmation List (HR)";
                ApplicationArea = all;
            }
            action("Approved Leave Applications")
            {
                Caption = 'Approved Leave Applications';
                RunObject = Page "HR Leave Applications Admin";
                ApplicationArea = all;
            }
            action("Posted Leave Applications")
            {
                RunObject = Page "Posted Leave Applications";
                ApplicationArea = all;
            }
            action("Payment Journals")
            {
                Caption = 'Payment Journals';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Payments), Recurring = CONST(false));
                ApplicationArea = all;
            }
            action("Base Calendar")
            {
                RunObject = Page 7601;
                ApplicationArea = all;
            }
        }
        area(sections)
        {
            group("Employee Management")
            {
                Caption = 'Employee Management';
                action("Employees Management")
                {
                    Caption = 'Employees Management';
                    RunObject = Page "HR Employee List";
                    ApplicationArea = all;
                }
                action("Inactive Employee List")
                {
                    Caption = 'Inactive Employee List';
                    RunObject = Page "HR Employee List (Former)";
                    ApplicationArea = all;
                }
            }
            group("Recruitment Manager")
            {
                Caption = 'Recruitment Manager';
                action(Jobs)
                {
                    Caption = 'Jobs';
                    RunObject = Page "HR Jobs List";
                    ApplicationArea = all;
                }
                action("Employee Requisitons")
                {
                    Caption = 'Employee Requisitons';
                    RunObject = Page "HR Employee Requisitions List";
                    RunPageView = WHERE(Status = FILTER(Approved | "Pending Approval"));
                    ApplicationArea = all;
                }
                action("Job Applications")
                {
                    Caption = 'Job Applications';
                    RunObject = Page "HR Job Applications List";
                    ApplicationArea = all;
                }
                action("Applicants Test")
                {
                    Caption = 'Applicants Test';
                    RunObject = Page "Posted BRV";
                    ApplicationArea = all;
                }
                action(Shortlisting)
                {
                    Caption = 'Shortlisting';
                    RunObject = Page "HR Shortlisting List";
                    ApplicationArea = all;
                }
                action("Shortlisted Applicants")
                {
                    Caption = 'Shortlisted Applicants';
                    RunObject = Page "Hr Shortlisted Applicant";
                    ApplicationArea = all;
                }
                action("Interview Evaluation")
                {
                    Caption = 'Interview Evaluation';
                    RunObject = Page "Hr interview Evaluation List";
                    ApplicationArea = all;
                }
                action("<Page Keep In-view Evaluation ")
                {
                    Caption = 'Keep In-view';
                    RunObject = Page "Keep In-view Evaluation List";
                    ApplicationArea = all;
                }
                action("Shortlisting List (Test)")
                {
                    Caption = 'Shortlisting List (Test)';
                    RunObject = Page "HR Shortlisting List Test";
                    ApplicationArea = all;
                }
                action("HR Interview Evaluation Areas")
                {
                    Caption = 'HR Interview Evaluation Areas';
                    RunObject = Page "Hr Interview Evaluation Areas";
                    ApplicationArea = all;
                }
                action("Shortlisting List Interview")
                {
                    Caption = 'Shortlisting List Interview';
                    RunObject = Page "HR Shortlisting List Int";
                    ApplicationArea = all;
                }
                action("Shortlisted Candidates Interview")
                {
                    Caption = 'Shortlisted Candidates Interview';
                    RunObject = Page "Shortlisted Candidates Intvw";
                    ApplicationArea = all;
                }
            }
            group("Training Management")
            {
                Caption = 'Training Management';
                action("Training Needs")
                {
                    Caption = 'Training Needs';
                    RunObject = Page "HR Training Needs";
                    ApplicationArea = all;
                }
                action("Training Application1")
                {
                    Caption = 'Training Application';
                    RunObject = Page "HR Training Application List";
                    ApplicationArea = all;
                }
                action("HR Training Request")
                {
                    Caption = 'HR Training Request';
                    RunObject = Page "Hr Training Request List";
                    ApplicationArea = all;
                }
                action("HOD Training Request")
                {
                    Caption = 'HOD Training Request';
                    RunObject = Page "HR HOD Training Needs";
                    ApplicationArea = all;
                }
                action("Staff Training Evaluation1")
                {
                    Caption = 'Staff Training Evaluation';
                    RunObject = Page "Emp. Training Evaluation";
                    RunPageView = WHERE("Send to Hr" = CONST(true));
                    ApplicationArea = all;
                }
            }
            group("Leave Management")
            {
                Caption = 'Leave Management';
                action("Leave Types")
                {
                    Caption = 'Leave Types';
                    RunObject = Page "HR Leave Types";
                    ApplicationArea = all;
                }
                action("Leave Applications")
                {
                    Caption = 'Leave Applications';
                    RunObject = Page "HR Leave Applications List";
                    RunPageView = WHERE(Status = FILTER(Approved | "Pending Approval"));
                    ApplicationArea = all;
                }
                action("Leave Acknowledgements")
                {
                    Caption = 'Leave Acknowledgements';
                    RunObject = Page "HR Leave Acknowledgments";
                    RunPageView = WHERE(Status = FILTER(Approved | "Pending Approval"));
                    ApplicationArea = all;
                }
            }
            group("Appraisal Evaluation")
            {
                Caption = 'Appraisal Evaluation';
                action("<Page Appraisal Goal Setting Lish")
                {
                    Caption = 'Page Appraisal Goal Setting First';
                    RunObject = Page "Appraisal Goal Setting List";
                    ApplicationArea = all;
                }
                action("Appraisal Goal Setting List Second ")
                {
                    Caption = 'Appraisal Goal Setting List Second ';
                    RunObject = Page "Appraisal Goal Setting Second";
                    ApplicationArea = all;
                }
                action("Appraisal Goal Setting Supervisor First")
                {
                    Caption = 'Appraisal Goal Setting Supervisor First';
                    RunObject = Page "Appraisal Goal Setting Fi";
                    ApplicationArea = all;
                }
                action("Appraisal Goal Setting Supervisor Second")
                {
                    Caption = 'Appraisal Goal Setting Supervisor Second';
                    RunObject = Page "Appraisal Goal Setting List Se";
                    ApplicationArea = all;
                }
                action("Completed Appraisal List")
                {
                    Caption = 'Completed Appraisal List';
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Hr Appraisal List";
                    ApplicationArea = all;
                }
            }
            group("Disciplinary Case Mgt")
            {
                Caption = 'Disciplinary Case Mgt';
                action("Disciplinary Cases")
                {
                    Caption = 'Disciplinary Cases';
                    RunObject = Page "HR Disciplinary Cases List";
                    ApplicationArea = all;
                }
                action(Query)
                {
                    Caption = 'Query';
                    //RunObject = Page "Posted Cash Pay Vou. Subform";
                    //RunPageView = WHERE("Send to Hr"=CONST(true));ApplicationArea = all;}
                }
                group("Human Resources")
                {
                    Caption = 'Human Resources';
                    action(HMO1)
                    {
                        Caption = 'HMO';
                        RunObject = Page "HR HMO List";
                        RunPageView = WHERE(Status = FILTER("Pending Approval" | Approved));
                        ApplicationArea = all;

                    }
                    action("Company Activities")
                    {
                        Caption = 'Company Activities';
                        RunObject = Page "HR Company Activities List";
                        ApplicationArea = all;

                    }
                    action("HR Staff Activities")
                    {
                        Caption = 'HR Staff Activities';
                        RunObject = Page "HR Staff Activities List";
                        ApplicationArea = all;

                    }
                    action("Drivers List")
                    {
                        Caption = 'Drivers List';
                        RunObject = Page "HR Drivers List";
                        ApplicationArea = all;

                    }
                    action("HR Exit Interview List")
                    {
                        Caption = 'HR Exit Interview List';
                        RunObject = Page "HR Exit Interview HR List";
                        ApplicationArea = all;

                    }
                    action("Posted Canteen Applications")
                    {
                        Caption = 'Posted Canteen Applications';
                        RunObject = Page "Posted Canteen Applications";
                        ApplicationArea = all;

                    }
                    action("Exit Interview")
                    {
                        Caption = 'Exit Interview';
                        RunObject = Page "HR Exit Interview List";
                        ApplicationArea = all;

                    }
                    action("Canteen Application")
                    {
                        Caption = 'Canteen Application';
                        RunObject = Page "HR Canteen Application List";
                        ApplicationArea = all;

                    }
                    action("Exit Questions")
                    {
                        RunObject = Page "HR Exit Interview Template";
                        ApplicationArea = all;

                    }
                }
                /*
                group("Self Service")
                {
                    Caption = 'Self Service';
                    action("Staff Claims")
                    {
                        Caption = 'Staff Claims';
                        RunObject = Page 51534761;
                        RunPageMode = Create;ApplicationArea = all;}
                    action("<Page Staff Advance Request List")
                    {
                        Caption = 'Cash Advance Requests';
                        RunObject = Page 51534762;
                        RunPageMode = Create;ApplicationArea = all;}
                    action("Page Cash Advance Surrender Li")
                    {
                        Caption = 'Cash Advance Retire';
                        Image = Reconcile;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        RunObject = Page 51534757;
                        RunPageMode = Create;ApplicationArea = all;}
                    action("Payment Request")
                    {
                        Caption = 'Payment Request';
                        RunObject = Page 51534775;ApplicationArea = all;}
                    action("Staff Activities")
                    {
                        Caption = 'Staff Activities';
                        RunObject = Page 51534692;ApplicationArea = all;}
                    action("Employee Details")
                    {
                        Caption = 'Employee Details';
                        RunObject = Page 51534778;ApplicationArea = all;}
                    action(" Purchase Receive List")
                    {
                        Caption = ' Purchase Receive List';
                        RunObject = Page 51534401;ApplicationArea = all;}
                    action("Employee Requisition")
                    {
                        Caption = 'Employee Requisition';
                        RunObject = Page 51534472;ApplicationArea = all;}
                    action("Training Application")
                    {
                        Caption = 'Training Application';
                        RunObject = Page 51534943;ApplicationArea = all;}
                    action("Staff Training Evaluation")
                    {
                        Caption = 'Staff Training Evaluation';
                        RunObject = Page 51534950;ApplicationArea = all;}
                    action("Leave Application")
                    {
                        Caption = 'Leave Application';
                        RunObject = Page 51534946;ApplicationArea = all;}
                    action("Leave Acknowledgment")
                    {
                        Caption = 'Leave Acknowledgment';
                        RunObject = Page 51534947;ApplicationArea = all;}
                    action("Appraisal First Half")
                    {
                        Caption = 'Appraisal First Half';
                        RunObject = Page 51534948;ApplicationArea = all;}
                    action("Appraisal Second Half")
                    {
                        Caption = 'Appraisal Second Half';
                        RunObject = Page 51534949;ApplicationArea = all;}
                    action(HMO)
                    {
                        Caption = 'HMO';
                        RunObject = Page 51534658;ApplicationArea = all;}
                    action("Comfirmation & Probation")
                    {
                        Caption = 'Comfirmation & Probation';
                        RunObject = Page 51534416;ApplicationArea = all;}
                    action("Approver User Setup")
                    {
                        Caption = 'Approver User Setup';
                        RunObject = Page "Approver User Setup List";ApplicationArea = all;}
                    action("Purchase Invoices")
                    {
                        Caption = 'Purchase Invoices';
                        RunObject = Page 9308;ApplicationArea = all;}
                    action("Page HR Canteen Application Card")
                    {
                        Caption = 'Canteen Application';
                        RunObject = Page 51534657;ApplicationArea = all;}
                    action("Purchase Invoice")
                    {
                        RunObject = Page 9308;ApplicationArea = all;}
                    action("HR Exit Interview List Self")
                    {
                        Caption = 'HR Exit Interview List Self';
                        RunObject = Page 51534643;ApplicationArea = all;}
                    action("Appraisal Supervisor Review List (First) ")
                    {
                        Caption = 'Appraisal Supervisor Review List (First) ';
                        RunObject = Page 51534694;ApplicationArea = all;}
                    action("Appraisal Supervisor Review List (Second)")
                    {
                        Caption = 'Appraisal Supervisor Review List (Second)';
                        RunObject = Page 51534695;ApplicationArea = all;}
                    action("Canteen Application List")
                    {
                        RunObject = Page 51534555;ApplicationArea = all;}
                    action("Posted Canteen Application List")
                    {
                        RunObject = Page 51534587;ApplicationArea = all;}
                }
                */ //RBS
                group("HR Setup")
                {
                    Caption = 'HR Setup';
                    action(Setup)
                    {
                        Caption = 'Setup';
                        RunObject = Page "HR Setup List";
                        ApplicationArea = all;

                    }
                    action("LookUp Values")
                    {
                        Caption = 'LookUp Values';
                        RunObject = Page "HR Lookup Values List";
                        ApplicationArea = all;

                    }
                    action(Committees)
                    {
                        Caption = 'Committees';
                        RunObject = Page "HR Committees";
                        ApplicationArea = all;

                    }
                    action("Units Of Measure")
                    {
                        Caption = 'Units Of Measure';
                        RunObject = Page "Human Res. Units of Measure";
                        Visible = false;
                        ApplicationArea = all;

                    }
                    action("Causes Of Abscence")
                    {
                        Caption = 'Causes Of Abscence';
                        RunObject = Page "Causes of Absence";
                        Visible = false;
                        ApplicationArea = all;

                    }
                    action("Employee Requisition")
                    {
                        Caption = 'Employee Requisition';
                        RunObject = Page "HR Employee Requisitions List";
                        ApplicationArea = all;

                    }
                    action("Training Evaluation Template")
                    {
                        Caption = 'Training Evaluation Template';
                        RunObject = Page "HR Training Eva. Template";
                        ApplicationArea = all;

                    }
                    action(" Appraisal Objective Template")
                    {
                        Caption = ' Appraisal Objective Template';
                        RunObject = Page "HR Appraisal Objective List";
                        ApplicationArea = all;

                    }
                    action("HR Career Development Template")
                    {
                        Caption = 'HR Career Development Template';
                        RunObject = Page "HR Career Development Template";
                        ApplicationArea = all;

                    }
                    action("Causes Of Inactivity")
                    {
                        Caption = 'Causes Of Inactivity';
                        RunObject = Page "Causes of Inactivity";
                        Visible = false;
                        ApplicationArea = all;

                    }
                    action("HR EntitleMent Template")
                    {
                        Caption = ' HR EntitleMent Template';
                        RunObject = Page "HR EntitleMent Template";
                        ApplicationArea = all;

                    }
                    action("Misc. Articles")
                    {
                        Caption = 'Misc. Articles';
                        RunObject = Page "Misc. Articles";
                        Visible = false;
                        ApplicationArea = all;

                    }
                    action(Confidential)
                    {
                        Caption = 'Confidential';
                        RunObject = Page Confidential;
                        Visible = false;
                        ApplicationArea = all;

                    }
                    action("Leave Periods")
                    {
                        Caption = 'Leave Periods';
                        RunObject = Page "HR Leave Period List";
                        Visible = false;
                        ApplicationArea = all;

                    }
                    action("Job Requirements")
                    {
                        Caption = 'Job Requirements';
                        RunObject = Page "HR Job Requirement Lines";
                        Visible = false;
                        ApplicationArea = all;

                    }
                    action(Qualifications)
                    {
                        Caption = 'Qualifications';
                        RunObject = Page "HR Qualifications";
                        Visible = false;
                        ApplicationArea = all;

                    }
                    action("Comfirmation & Probation Reponsibilities")
                    {
                        Caption = 'Comfirmation & Probation Reponsibilities';
                        RunObject = Page "HR Confirmation Duties";
                        ApplicationArea = all;

                    }
                }
                group("Payroll Setup")
                {
                    Caption = 'Payroll Setup';
                    action(EmployeeSalaryDetails)
                    {
                        Caption = 'Employee Salary Details';
                        RunObject = Page EmployeeSalaryDetails;
                        ApplicationArea = all;
                    }
                    action(Dimensions)
                    {
                        Caption = 'Dimensions';
                        RunObject = Page Dimensions;
                        ApplicationArea = all;

                    }
                    action("Transactions Setup")
                    {
                        Caption = 'Transactions Setup';
                        RunObject = Page "Pr Payroll Transactions Codes";
                        ApplicationArea = all;

                    }
                    action("Salary Grades")
                    {
                        Caption = 'Salary Grades';
                        RunObject = Page "Salary Grades List";
                        ApplicationArea = all;

                    }
                    action("<prP.A.Y.E Setup>")
                    {
                        Caption = 'Page prP.A.Y.E Setup';
                        RunObject = Page "prP.A.Y.E Setup";
                        ApplicationArea = all;

                    }
                    action("Bank Structure")
                    {
                        Caption = 'Bank Structure';
                        RunObject = Page "prBank Structure";
                        ApplicationArea = all;

                    }
                    action("Deduction Account")
                    {
                        Caption = 'HR Deduction Account';
                        RunObject = Page "HR Deductions Account";
                        ApplicationArea = all;

                    }
                    action(" HR User Setup")
                    {
                        Caption = ' HR User Setup';
                        RunObject = Page "HR User Setup";
                        ApplicationArea = all;

                    }
                    action("Membership Groups")
                    {
                        Caption = 'Membership Groups';
                        RunObject = Page "prMembership Groups";
                        ApplicationArea = all;

                    }
                    action("Payroll Type")
                    {
                        Caption = 'Payroll Type';
                        RunObject = Page "prPayroll Type";
                        ApplicationArea = all;

                    }
                    action("Posting Groups1")
                    {
                        Caption = 'Posting Groups';
                        RunObject = Page "prEmployee Posting Group";
                        ApplicationArea = all;

                    }
                }
                group("Approval Entries")
                {
                    Caption = 'Approval Entries';
                    action("Requests to Approve")
                    {
                        Caption = 'Requests to Approve';
                        RunObject = Page "Requests to Approve";
                        ApplicationArea = all;

                    }
                    action("Approval Request Entries")
                    {
                        Caption = 'Approval Request Entries';
                        RunObject = Page "Approval Request Entries";
                        ApplicationArea = all;

                    }
                }
                group("Posted Documents")
                {
                    Caption = 'Posted Documents';
                    Image = FiledPosted;
                    action("Posted Sales Shipments")
                    {
                        Caption = 'Posted Sales Shipments';
                        Image = PostedShipment;
                        RunObject = Page "Posted Sales Shipments";
                        ApplicationArea = all;

                    }
                    action("Posted Sales Invoices")
                    {
                        Caption = 'Posted Sales Invoices';
                        Image = PostedOrder;
                        RunObject = Page "Posted Sales Invoices";
                        ApplicationArea = all;

                    }
                    action("Posted Return Receipts")
                    {
                        Caption = 'Posted Return Receipts';
                        Image = PostedReturnReceipt;
                        RunObject = Page "Posted Return Receipts";
                        ApplicationArea = all;

                    }
                    action("Posted Sales Credit Memos")
                    {
                        Caption = 'Posted Sales Credit Memos';
                        Image = PostedOrder;
                        RunObject = Page "Posted Sales Credit Memos";
                        ApplicationArea = all;

                    }
                    action("Posted Purchase Receipts")
                    {
                        Caption = 'Posted Purchase Receipts';
                        RunObject = Page "Posted Purchase Receipts";
                        ApplicationArea = all;

                    }
                    action("Posted Purchase Invoices")
                    {
                        Caption = 'Posted Purchase Invoices';
                        RunObject = Page "Posted Purchase Invoices";
                        ApplicationArea = all;

                    }
                    action("Posted Return Shipments")
                    {
                        Caption = 'Posted Return Shipments';
                        RunObject = Page "Posted Return Shipments";
                        ApplicationArea = all;

                    }
                    action("Posted Purchase Credit Memos")
                    {
                        Caption = 'Posted Purchase Credit Memos';
                        RunObject = Page "Posted Purchase Credit Memos";
                        ApplicationArea = all;

                    }
                    action("Issued Reminders")
                    {
                        Caption = 'Issued Reminders';
                        Image = OrderReminder;
                        RunObject = Page "Issued Reminder List";
                        ApplicationArea = all;

                    }
                    action("Issued Fi. Charge Memos")
                    {
                        Caption = 'Issued Fi. Charge Memos';
                        RunObject = Page "Issued Fin. Charge Memo List";
                        ApplicationArea = all;

                    }
                    /*action("Posted Payment Request List")
                    {
                        RunObject = Page 51534806;ApplicationArea = all;}
                    */
                    action("G/L Registers")
                    {
                        Caption = 'G/L Registers';
                        Image = GLRegisters;
                        RunObject = Page "G/L Registers";
                        ApplicationArea = all;

                    }
                }
            }
        }
        area(creation)
        {
            action("Payroll Transactions Items")
            {
                Image = PaymentJournal;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Payroll Transactions Items";
                ApplicationArea = all;
            }
            action("Report BackDating/Promotion Report")
            {
                //    Caption = 'Report BackDating/Promotion Report';
                //  RunObject = Report 50020;
            }
            action("Report Contract Summary Analy-Sales A")
            {
                Caption = 'Report Contract Summary Analy-Sales A';
                RunObject = Report "Contract Summary Analy-Sales A";
                ApplicationArea = all;
            }
            action("Report Contract Summary Analysis-Dep")
            {
                Caption = 'Report Contract Summary Analysis-Dep';
                RunObject = Report "Contract  Summary Analysis-Dep";
                ApplicationArea = all;
            }
            action("Report Contract Sum Analysis-OUTS")
            {
                Caption = 'Report Contract Sum Analysis-OUTS';
                Promoted = true;
                RunObject = Report "Contract Sum Analysis-OUTS";
                ApplicationArea = all;
            }
            action(" Bank Pay Analysis SALES")
            {
                Caption = ' Bank Pay Analysis SALES';
                RunObject = Report "Bank Payment Schedule Sales";
                ApplicationArea = all;
            }
            action("Report Payroll Summary - Dep Non Tax")
            {
                Caption = 'Report Payroll Summary - Dep Non Tax';
                RunObject = Report "Payroll Summary - Dep Non Tax";
                ApplicationArea = all;
            }
            action(" Bank Pay Analysis ITADHPRNYSC")
            {
                Caption = ' Bank Pay Analysis ITADHPRNYSC';
                RunObject = Report "Bank Pay Analysis ITADHPRNYSC";
                ApplicationArea = all;
            }
            action("Bank Pay Analysis AS|SNRAS|OU")
            {
                Caption = 'Bank Pay Analysis AS|SNRAS|OU';
                RunObject = Report "Bank Pay Analysis AS|SNRAS";
                ApplicationArea = all;
            }
            action(" Bank Pay Analysis OUT")
            {
                Caption = ' Bank Pay Analysis OUT';
                RunObject = Report "Bank Pay Analysis OUT";
                ApplicationArea = all;
            }
            action("Report Bank Payment Schedule")
            {
                Caption = 'Report Bank Payment Schedule';
                RunObject = Report "Bank Payment Schedule";
                ApplicationArea = all;
            }
            action("Report Bank Advise Summary")
            {
                Caption = 'Report Bank Advise Summary';
                RunObject = Report "Bank Advise Summary";
                ApplicationArea = all;
            }
            action(" Comission Summary Report-BANK")
            {
                Caption = ' Comission Summary Report-BANK';
                RunObject = Report "Comission Summary Report-BANK";
                ApplicationArea = all;
            }
            action("Report Cooperative Report")
            {
                RunObject = Report "Cooperative Report-pens";
                ApplicationArea = all;
            }
            action(" Comission  Summary Report")
            {
                Caption = ' Comission  Summary Report';
                RunObject = Report "Comission  Summary Report";
                ApplicationArea = all;
            }
            action("Report Contract Summary Analysis-IT/ADHOC")
            {
                Caption = 'Report Contract Summary Analysis-IT/ADHOC';
                RunObject = Report "Contract Sum Analysis-IT/AD/NY";
                ApplicationArea = all;
            }
            action("Report prStaff Pension Contrib")
            {
                Caption = 'Report prStaff Pension Contrib';
                RunObject = Report "prStaff Pension Contrib";
                ApplicationArea = all;
            }
            action("Report prPaye Schedule per loc")
            {
                Caption = 'Report prPaye Schedule per loc';
                RunObject = Report "prPaye Schedule per loc";
                ApplicationArea = all;
            }
            action("Report prPaye Schedule")
            {
                Caption = 'Report prPaye Schedule';
                RunObject = Report "prPaye Schedule";
                ApplicationArea = all;
            }
            action("Report NHF Schedule")
            {
                Caption = 'Report NHF Schedule';
                RunObject = Report "NHF Schedule";
                ApplicationArea = all;
            }
            action("Report NISTF Schedule")
            {
                Caption = 'Report NISTF Schedule';
                RunObject = Report "HR NSITF Report";
                ApplicationArea = all;
            }
            action(" HR Telephone Report")
            {
                Caption = ' HR Telephone Report';
                Image = "Report";
                RunObject = Report "HR Telephone Report";
                ApplicationArea = all;
            }
            action("Report Finance Posting Dept CONTRACT")
            {
                Caption = 'Report Finance Posting Dept CONTRACT';
                Image = "Report";
                RunObject = Report "Finance Posting Dept CONTRACT";
                ApplicationArea = all;
            }
            action("Report Fin Posting Location CONTRACT")
            {
                Caption = 'Report Fin Posting Location CONTRACT';
                Image = "Report";
                RunObject = Report "Fin Posting Location CONTRACT";
                ApplicationArea = all;
            }
            action("Finance Posting Summary- DEP NON TAXABLE")
            {
                Caption = 'Finance Posting Summary- DEP NON TAXABLE';
                Image = "Report";
                RunObject = Report "PayrollSumAnalyDep NON CO";
                ApplicationArea = all;
            }
            separator("Payroll Transaction Items Report")
            {
                Caption = 'Payroll Transaction Items Report';

            }
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
                RunObject = Report "prPJournalTransferperRBS";
                ApplicationArea = all;
            }
            action("Journal Tranfer per Loc")
            {
                Caption = 'Journal Tranfer per Loc';
                RunObject = Report "prPJournalTransferperRBS";
                ApplicationArea = all;
                Visible = false;
            }
            action("Period Management")
            {
                Caption = 'Period Management';
                Image = AccountingPeriods;
                RunObject = Page "prPayroll Periods";
                ApplicationArea = all;
            }
            action("Rates & Ceilings")
            {
                Caption = 'Rates & Ceilings';
                Image = PayrollStatistics;
                RunObject = Page "prRates & Ceilings";
                ApplicationArea = all;
            }
            action("Posting Groups")
            {
                Caption = 'Posting Groups';
                Image = Group;
                RunObject = Page "prEmployee Posting Group";
                ApplicationArea = all;
            }
            action(" Import employee transactions ")
            {
                Caption = ' Import employee transactions ';
                // RunObject = XMLport 50023; RBS
                ApplicationArea = all;
            }
            action(" Update Employee Leave Balance")
            {
                Caption = ' Update Employee Leave Balance';
                // RunObject = XMLport 39005493;RBS
                ApplicationArea = all;
            }
            action("Mass Update Transactions")
            {
                Caption = 'Mass Update Transactions';
                Image = UpdateDescription;
                RunObject = Report "Mass Update Transactions";
                ApplicationArea = all;
            }
            action("Allowance Variations")
            {
                Caption = 'Allowance Variations';
                Image = Allocations;
                RunObject = Page "Allowance Var";
                ApplicationArea = all;
            }
            action("Deduction Variations")
            {
                Caption = 'Deduction Variations';
                Image = RemoveLine;
                RunObject = Page "Deductions Var";
                ApplicationArea = all;
            }
            action("Processed Allowance Variations")
            {
                Caption = 'Processed Allowance Variations';
                Image = CalculateCost;
                RunObject = Page "Processed Allowance Variations";
                ApplicationArea = all;
            }
            action("Processed Deduction Variations")
            {
                Caption = 'Processed Deduction Variations';
                Image = CalculateLines;
                RunObject = Page "Processed Deduction Variations";
                ApplicationArea = all;
            }
            action("Assign Employee Loan")
            {
                Caption = 'Assign Employee Loan';
                RunObject = Page prAssignEmployeeLoan;
                ApplicationArea = all;
            }
            action("Outstanding Leave days")
            {
                Caption = 'Outstanding Leave days';
                RunObject = Report "Outstanding Leave days";
                ApplicationArea = all;
            }
            action("Generate 13th Month")
            {
                Caption = 'Generate 13th Month';
                Image = CalculateCalendar;
                RunObject = Report "Generate 13th Month";
                ApplicationArea = all;
            }
            separator(Reset)
            {
                Caption = 'Reset';
            }
            action("Clear Weekend OT")
            {
                Caption = 'Clear Weekend OT';
                Image = ClearLog;
                RunObject = Report "Clear Weekend OT";
                Visible = false;
                ApplicationArea = all;
            }
            action("Clear Old Code Variations")
            {
                Caption = 'Clear Old Code Variations';
                Image = ClearLog;
                RunObject = Report "Clear Old Code Variations";
                Visible = false;
                ApplicationArea = all;
            }
            action("Up-Process Variations")
            {
                Caption = 'Up-Process Variations';
                Image = CalculateRegenerativePlan;
                RunObject = Report "Up-Process Variations";
                Visible = false;
                ApplicationArea = all;
            }
            separator("PAYE Reset")
            {
                Caption = 'PAYE Reset';
            }
            action("Mark as Does Not Pay PAYE")
            {
                Caption = 'Mark as Does Not Pay PAYE';
                Image = CheckList;
                RunObject = Report "Mark as DOES NOT pay PAYE";
                Visible = false;
                ApplicationArea = all;
            }
            action("Mark as Pays PAYE")
            {
                Caption = 'Mark as Pays PAYE';
                Image = CheckList;
                RunObject = Report "Mark as PAYS PAYE";
                Visible = false;
                ApplicationArea = all;
            }
            action("Cooperative Report")
            {
                Caption = 'Cooperative Report';
                RunObject = Report "Cooperative Report-pens";
                ApplicationArea = all;
            }
            action("Update Employee PAYE")
            {
                Caption = 'Update Employee PAYE';
                Image = UpdateDescription;
                RunObject = Report "Update Employee PAYE";
                Visible = false;
                ApplicationArea = all;
            }
            action(" Payroll Summary - Dep Non Tax")
            {
                Caption = ' Payroll Summary - Dep Non Tax';
                RunObject = Report "Payroll Summary - Dep Non Tax";
                ApplicationArea = all;
            }
            action(" Payroll Transaction Report")
            {
                Caption = ' Payroll Transaction Report';
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "prCoop remmitance";
                ApplicationArea = all;
            }
            action("NHF Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report 51534548; RBS Dennis
                ApplicationArea = all;
            }
            action("PAYE SCHEDULE")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "PAYE Schedule Rep";
                ApplicationArea = all;
            }
        }
    }
}


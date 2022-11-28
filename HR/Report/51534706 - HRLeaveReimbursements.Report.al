report 51534706 "HR Leave Reimbursements"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRLeaveReimbursements.rdlc';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            RequestFilterFields = "No.", "Leave Period Filter";
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
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(HR_Employees__No__; "No.")
            {
            }
            column(HR_Employees__FullName; "HR Employees".FullName)
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_Leave_Reimbursement_ReportCaption; Employee_Leave_Reimbursement_ReportCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Employees__No__Caption; FieldCaption("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            dataitem("HR Leave Ledger Entries"; "HR Leave Ledger Entries")
            {
                DataItemLink = "Staff No." = FIELD ("No.");
                DataItemTableView = SORTING ("Entry No.") WHERE ("Leave Entry Type" = CONST (Reimbursement));
                column(HR_Leave_Ledger_Entries__Leave_Period_; "Leave Period")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Entry_Type_; "Leave Entry Type")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Type_; "Leave Type")
                {
                }
                column(HR_Leave_Ledger_Entries__No__of_days_; "No. of days")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Posting_Description_; "Leave Posting Description")
                {
                }
                column(HR_Leave_Ledger_Entries__Posting_Date_; "Posting Date")
                {
                }
                column(LeaveBalance; LeaveBalance)
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Entry_Type_Caption; FieldCaption("Leave Entry Type"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Type_Caption; FieldCaption("Leave Type"))
                {
                }
                column(HR_Leave_Ledger_Entries__No__of_days_Caption; FieldCaption("No. of days"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Posting_Description_Caption; FieldCaption("Leave Posting Description"))
                {
                }
                column(HR_Leave_Ledger_Entries__Posting_Date_Caption; FieldCaption("Posting Date"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Period_Caption; FieldCaption("Leave Period"))
                {
                }
                column(Leave_BalanceCaption; Leave_BalanceCaptionLbl)
                {
                }
                column(Day_s_Caption; Day_s_CaptionLbl)
                {
                }
                column(HR_Leave_Ledger_Entries_Entry_No_; "Entry No.")
                {
                }
                column(HR_Leave_Ledger_Entries_Staff_No_; "Staff No.")
                {
                }

                trigger OnPreDataItem()
                begin
                    "HR Leave Ledger Entries".SetFilter("HR Leave Ledger Entries"."Leave Type",
                    "HR Employees".GetFilter("HR Employees"."Leave Type Filter"));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //"HR Employees".VALIDATE("HR Employees"."Allocated Leave Days");
                //LeaveBalance:="HR Employees"."Leave Balance";
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
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        LeaveBalance: Decimal;
        EmployeeCaptionLbl: Label 'Employee';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employee_Leave_Reimbursement_ReportCaptionLbl: Label 'Employee Leave Reimbursement Report';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        NameCaptionLbl: Label 'Name';
        Leave_BalanceCaptionLbl: Label 'Leave Balance';
        Day_s_CaptionLbl: Label 'Day(s)';
}


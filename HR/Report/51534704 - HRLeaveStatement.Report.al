report 51534704 "HR Leave Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRLeaveStatement.rdlc';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            RequestFilterFields = "Leave Type Filter";
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
            column(HR_Employees__HR_Employees___Leave_Balance_; "HR Employees"."Leave Balance")
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_Leave_StatementCaption; Employee_Leave_StatementCaptionLbl)
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
            column(Leave_BalanceCaption; Leave_BalanceCaptionLbl)
            {
            }
            column(Day_s_Caption; Day_s_CaptionLbl)
            {
            }
            column(No; "No.")
            {
            }
            dataitem("HR Leave Ledger Entries"; "HR Leave Ledger Entries")
            {
                DataItemLink = "Staff No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");
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
                column(HR_Leave_Ledger_Entries_Entry_No_; "Entry No.")
                {
                }
                column(HR_Leave_Ledger_Entries_Staff_No_; "Staff No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    No := No + 1;
                end;

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

            trigger OnPreDataItem()
            begin
                SetRange("No.", EmpNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Filter")
                {
                    field(EmpNo; EmpNo)
                    {
                        Caption = 'Employee No.';
                        LookupPageID = "HR Employee List";
                        TableRelation = "HR Employees";
                    }
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
        CI.Get();
        CI.CalcFields(CI.Picture);
        /* IF usersetup.GET(USERID) THEN
         IF NOT usersetup.HR   THEN BEGIN
         HREmp.SETRANGE(HREmp."User ID",USERID);
         IF HREmp.FINDFIRST THEN BEGIN
         IF HREmp.Supervisor = FALSE THEN BEGIN
           HREmp.RESET;
           HREmp2.GET("HR Employees".GETFILTER("No."));
          //IF HREmp."User ID" <> "HR Employees".GETFILTER("No.") THEN
          IF USERID <> HREmp2."User ID" THEN
           CurrReport.QUIT;
          END;
         END;
         END;
         */

    end;

    var
        CI: Record "Company Information";
        LeaveBalance: Decimal;
        EmployeeCaptionLbl: Label 'Employee';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employee_Leave_StatementCaptionLbl: Label 'Employee Leave Statement';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        NameCaptionLbl: Label 'Name';
        Leave_BalanceCaptionLbl: Label 'Leave Balance';
        Day_s_CaptionLbl: Label 'Day(s)';
        No: Decimal;
        HREmp: Record "HR Employees";
        HREmp2: Record "HR Employees";
        usersetup: Record "User Setup";
        EmpNo: Code[20];
}


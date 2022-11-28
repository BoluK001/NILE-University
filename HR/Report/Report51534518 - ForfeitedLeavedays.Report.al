report 51534518 "Forfeited Leave days"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ForfeitedLeavedays.rdlc';

    dataset
    {
        dataitem("HR Leave Ledger Entries"; "HR Leave Ledger Entries")
        {
            DataItemTableView = SORTING("Leave Period", "Staff No.") ORDER(Ascending) WHERE("Leave Type" = CONST('ANNUAL'));
            RequestFilterFields = "Posting Date";
            column(LeavePeriod_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Period")
            {
            }
            column(StaffNo_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Staff No.")
            {
            }
            column(StaffName_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Staff Name")
            {
            }
            column(PostingDate_HRLeaveLedgerEntries; Format("Posting Date", 0, 4))
            {
            }
            column(MaximumLeaveDays_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Maximum Leave Days")
            {
            }
            column(Pic; CompInfo.Picture)
            {
            }
            column(UserID; UserId)
            {
            }
            column(Today; Format(Today, 0, 4))
            {
            }
            column(TotalLeaveTaken; TotalLeave)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TotalLeave := 0;
                if ("HR Leave Ledger Entries"."Leave Period" = LeavePeriod) and ("HR Leave Ledger Entries"."Staff No." = EmpNo) then
                    CurrReport.Skip
                else begin
                    EmpNo := '';
                    LeavePeriod := '';
                end;
                LeaveAPP.Reset;
                LeaveAPP.SetCurrentKey("Leave Period", "Staff No.");
                LeaveAPP.SetRange(LeaveAPP."Staff No.", "HR Leave Ledger Entries"."Staff No.");
                LeaveAPP.SetRange("Leave Period", "HR Leave Ledger Entries"."Leave Period");
                LeaveAPP.SetRange(LeaveAPP."Leave Type", 'ANNUAL', 'INTERMITENT');
                if LeaveAPP.FindSet then begin
                    repeat
                        TotalLeave += LeaveAPP."No. of days";
                    until LeaveAPP.Next = 0;
                    LeavePeriod := "HR Leave Ledger Entries"."Leave Period";
                    EmpNo := "HR Leave Ledger Entries"."Staff No.";
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
                group(Control2)
                {
                    ShowCaption = false;
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
        CompInfo.CalcFields(Picture);
    end;

    var
        LeaveBalance: array[2] of Decimal;
        CompInfo: Record "Company Information";
        PreviousYear: array[2] of Integer;
        CurrentYear: Integer;
        YearFilter: Date;
        i: Integer;
        LookUp: Record "HR Lookup Values";
        LeaveType: Record "HR Leave Types";
        TotalDays: array[2] of Decimal;
        MaximumDays: array[2] of Decimal;
        LeaveAPP: Record "HR Leave Ledger Entries";
        LeaveApplication: Record "HR Leave Application";
        MaxDays: Decimal;
        TotalLeave: Integer;
        EmpNo: Code[20];
        LeavePeriod: Code[20];
}


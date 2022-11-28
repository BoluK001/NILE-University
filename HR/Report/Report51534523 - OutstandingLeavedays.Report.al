report 51534523 "Outstanding Leave days"
{
    DefaultLayout = RDLC;
    RDLCLayout = './OutstandingLeavedays.rdlc';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            RequestFilterFields = "No.";
            column(Pic; CompInfo.Picture)
            {
            }
            column(Today; Format(Today, 0, 4))
            {
            }
            column(No_HREmployees; "HR Employees"."No.")
            {
            }
            column(FirstName_HREmployees; "HR Employees"."First Name")
            {
            }
            column(LastName_HREmployees; "HR Employees"."Last Name")
            {
            }
            column(DepartmentCode_HREmployees; "HR Employees"."Department Code")
            {
            }
            column(JobTitle_HREmployees; "HR Employees"."Job Title")
            {
            }
            column(JobLevel_HREmployees; "HR Employees"."Job Level")
            {
            }
            column(Leave1; LeaveBalance[1])
            {
            }
            column(Leave2; LeaveBalance[2])
            {
            }
            column(Year1; PreviousYear[1])
            {
            }
            column(Year2; PreviousYear[2])
            {
            }
            column(Total1; TotalDays[1])
            {
            }
            column(Total2; TotalDays[2])
            {
            }
            column(Max1; MaximumDays[1])
            {
            }
            column(Max2; MaximumDays[2])
            {
            }
            column(UserID; UserId)
            {
            }
            column(SerialNum; SerialNum)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TotalDays[1] := 0;
                TotalDays[2] := 0;

                LeaveBalance[1] := 0;
                LeaveBalance[2] := 0;


                Clear(MaximumDays[i]);
                Clear(MaximumDays[1]);
                MaximumDays[2] := 0;
                MaxDays := 0;

                for i := 1 to 2 do begin
                    LeaveAPP.Reset;
                    LeaveAPP.SetRange(LeaveAPP."Staff No.", "No.");
                    LeaveAPP.SetRange("Leave Period", Format(PreviousYear[i]));
                    LeaveAPP.SetFilter(LeaveAPP."Leave Type", '%1|%2', 'ANNUAL', 'INTERMITENT');
                    if LeaveAPP.FindFirst then begin
                        repeat
                            TotalDays[i] += LeaveAPP."No. of days";
                        until LeaveAPP.Next = 0;
                        MaximumDays[i] := LeaveAPP."Maximum Leave Days";
                        //MaximumDays[i]:= Emp."Total (Leave Days)";
                        LeaveBalance[1] := MaximumDays[1] - TotalDays[1];
                        LeaveBalance[2] := MaximumDays[2] - TotalDays[2];

                    end;
                end;

                //IF MaximumDays[2] = 0 THEN BEGIN
                //  LookUp.SETRANGE(LookUp.Type,LookUp.Type::"Job Level");
                //  LookUp.SETRANGE(LookUp.Code,"HR Employees"."Job Level");
                Emp.SetRange(Emp."No.", "No.");
                MaximumDays[2] := Emp."Total (Leave Days)";
                if Emp.FindFirst then
                    //MaximumDays[2]:=Emp."Total (Leave Days)";
                    //S MESSAGE('I got here %1',"Total (Leave Days)");
                    LeaveBalance[2] := MaximumDays[2] - TotalDays[2];
                //END;

                //IF (LeaveBalance[1] = 0) AND (LeaveBalance[2] = 0) THEN
                // CurrReport.SKIP;


                SerialNum += 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Period)
                {
                    field("Current Period"; YearFilter)
                    {
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

    trigger OnInitReport()
    begin
        CompInfo.CalcFields(Picture);
    end;

    trigger OnPreReport()
    begin
        if YearFilter = 0D then
            YearFilter := Today;

        for i := 1 to 2 do begin
            PreviousYear[i] := Date2DMY(YearFilter, 3);
            YearFilter := CalcDate('-1Y', YearFilter);
        end;
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
        SerialNum: Integer;
        Emp: Record "HR Employees";
}


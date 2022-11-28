report 51534538 "HR Create Leave Year"
{
    Caption = 'Create Leave Year';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PeriodCode; PeriodCode)
                    {
                        Caption = 'Period Code';
                    }
                    field(PeriodDescription; PeriodDescription)
                    {
                        Caption = 'Period Description';
                    }
                    field(LeaveYearStartDate; LeaveYearStartDate)
                    {
                        Caption = 'Period Starting Date';
                    }
                    field(NoOfPeriods; NoOfPeriods)
                    {
                        Caption = 'No. of Periods';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        Caption = 'Period Length';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if NoOfPeriods = 0 then begin
                NoOfPeriods := 12;
                Evaluate(PeriodLength, '<1M>');
            end;
            if HRLeavePeriod.Find('+') then
                LeaveYearStartDate := HRLeavePeriod."Starting Date";
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        HRLeavePeriod."Starting Date" := LeaveYearStartDate;  //010114
        HRLeavePeriod.TestField("Starting Date");

        if HRLeavePeriod.Find('-') then begin
            FirstPeriodStartDate := HRLeavePeriod."Starting Date";
            FirstPeriodLocked := HRLeavePeriod."Date Locked";
            if (LeaveYearStartDate < FirstPeriodStartDate) and FirstPeriodLocked then
                if not
                   Confirm(
                     Text000 +
                     Text001)
                then
                    exit;
            if HRLeavePeriod.Find('+') then
                LastPeriodStartDate := HRLeavePeriod."Starting Date";
        end else
            if not
               Confirm(
                 Text002 +
                 Text003)
            then
                exit;

        LeaveYearStartDate2 := LeaveYearStartDate;


        for i := 1 to NoOfPeriods + 1 do begin
            //Exit if the fiscal year to be created is a date BELOW the current Leave year
            if (LeaveYearStartDate <= FirstPeriodStartDate) and (i = NoOfPeriods + 1) then
                exit;

            if (FirstPeriodStartDate <> 0D) then
                if (LeaveYearStartDate >= FirstPeriodStartDate) and (LeaveYearStartDate < LastPeriodStartDate) then
                    Error(Text004);

            HRLeavePeriod.Init;
            HRLeavePeriod."Period Code" := PeriodCode;
            HRLeavePeriod."Period Description" := PeriodDescription;
            HRLeavePeriod."Starting Date" := LeaveYearStartDate;
            HRLeavePeriod.Validate("Starting Date");
            HRLeavePeriod.Validate("Period Description");

            if (i = 1) or (i = NoOfPeriods + 1) then begin
                HRLeavePeriod."New Fiscal Year" := true;
            end;

            if (FirstPeriodStartDate = 0D) and (i = 1) then
                HRLeavePeriod."Date Locked" := true;

            if (HRLeavePeriod."Starting Date" < FirstPeriodStartDate) and FirstPeriodLocked then begin
                HRLeavePeriod.Closed := true;
                HRLeavePeriod."Date Locked" := true;
            end;

            if not HRLeavePeriod.Find('=') then
                HRLeavePeriod.Insert;
            LeaveYearStartDate := CalcDate(PeriodLength, LeaveYearStartDate);
        end;

        HRLeavePeriod.Get(LeaveYearStartDate2);
        //HRLeavePeriod.UpdateAvgItems(0);
    end;

    var
        Text000: Label 'The new fiscal year begins before an existing fiscal year, so the new year will be closed automatically.\\';
        Text001: Label 'Do you want to create and close the fiscal year?';
        Text002: Label 'Once you create the new fiscal year you cannot change its starting date.\\';
        Text003: Label 'Do you want to create the fiscal year?';
        Text004: Label 'It is only possible to create new fiscal years before or after the existing ones.';
        HRLeavePeriod: Record "HR Leave Periods";
        NoOfPeriods: Integer;
        PeriodLength: DateFormula;
        LeaveYearStartDate: Date;
        LeaveYearStartDate2: Date;
        FirstPeriodStartDate: Date;
        LastPeriodStartDate: Date;
        FirstPeriodLocked: Boolean;
        i: Integer;
        PeriodCode: Code[20];
        PeriodDescription: Text;
}


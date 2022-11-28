page 51534381 "Payroll Period"
{
    APIGroup = 'Payroll';
    APIPublisher = 'Reeltech';
    APIVersion = 'v1.0';
    Caption = 'payrollPeriod';
    DelayedInsert = true;
    EntityName = 'payrollperiod';
    EntitySetName = 'PRPayrollPeriod';
    PageType = API;
    SourceTable = "prPayroll Periods";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(periodMonth; Rec."Period Month")
                {
                    Caption = 'Period Month';
                }
                field(periodYear; Rec."Period Year")
                {
                    Caption = 'Period Year';
                }
                field(periodName; Rec."Period Name")
                {
                    Caption = 'Period Name';
                }
                field(dateOpened; Rec."Date Opened")
                {
                    Caption = 'Date Opened';
                }
                field(dateClosed; Rec."Date Closed")
                {
                    Caption = 'Date Closed';
                }
                field(closed; Rec.Closed)
                {
                    Caption = 'Closed';
                }
                field(payrollCode; Rec."Payroll Code")
                {
                    Caption = 'Payroll Code';
                }
                field(quarter; Rec.Quarter)
                {
                    Caption = 'Quarter';
                }
                field(totalWorkingDays; Rec."Total Working Days")
                {
                    Caption = 'Total Working Days';
                }
            }
        }
    }
}

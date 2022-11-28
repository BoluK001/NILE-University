page 51534400 "Leave Applivation List API"
{
    APIGroup = 'ApplicationsLists';
    APIPublisher = 'Reeltech';
    APIVersion = 'v1.0';
    Caption = 'leaveApplivationListAPI';
    DelayedInsert = true;
    EntityName = 'LeaveApplication';
    EntitySetName = 'LeaveApplicationList';
    PageType = API;
    SourceTable = "HR Leave Application";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(applicationCode; Rec."Application Code")
                {
                    Caption = 'Application Code';
                }
                field(employeeNo; Rec."Employee No")
                {
                    Caption = 'Employee No';
                }
                field(names; Rec.Names)
                {
                    Caption = 'Names';
                }
                field(leaveType; Rec."Leave Type")
                {
                    Caption = 'Leave Type';
                }
                field(daysApplied; Rec."Days Applied")
                {
                    Caption = 'Days Applied';
                }
                field(startDate; Rec."Start Date")
                {
                    Caption = 'Start Date';
                }
                field(returnDate; Rec."Return Date")
                {
                    Caption = 'Return Date';
                }
                field(endDate; Rec."End Date")
                {
                    Caption = 'Return Date';
                }
                field(relieverName; Rec."Reliever Name")
                {
                    Caption = 'Reliever Name';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}

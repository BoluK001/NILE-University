page 51534648 "Leave Types API"
{
    APIGroup = 'Types';
    APIPublisher = 'Reeltech';
    APIVersion = 'v1.0';
    Caption = 'leaveTypesAPI';
    DelayedInsert = true;
    EntityName = 'LeaveTypes';
    EntitySetName = 'HRLeaveTypes';
    PageType = API;
    SourceTable = "HR Leave Types";

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
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(days; Rec.Days)
                {
                    Caption = 'Days';
                }
                field(acrueDays; Rec."Acrue Days")
                {
                    Caption = 'Acrue Days';
                }
                field(unlimitedDays; Rec."Unlimited Days")
                {
                    Caption = 'Unlimited Days';
                }
                field(gender; Rec.Gender)
                {
                    Caption = 'Gender';
                }
                field(balance; Rec.Balance)
                {
                    Caption = 'Balance';
                }
                field(maxCarryForwardDays; Rec."Max Carry Forward Days")
                {
                    Caption = 'Max Carry Forward Days';
                }
                field(carryForwardAllowed; Rec."Carry Forward Allowed")
                {
                    Caption = 'Carry Forward Allowed';
                }
                field(inclusiveOfNonWorkingDays; Rec."Inclusive of Non Working Days")
                {
                    Caption = 'Inclusive of Non Working Days';
                }
                field(recurring; Rec.Recurring)
                {
                    Caption = 'Recurring';
                }
                field(exam; Rec.Exam)
                {
                    Caption = 'Exam';
                }
                field(sick; Rec.Sick)
                {
                    Caption = 'Sick';
                }
                field(exception; Rec.Exception)
                {
                    Caption = 'Exception';
                }
                field(compassionate; Rec.Compassionate)
                {
                    Caption = 'Compassionate';
                }
                field(matPat; Rec."Mat/Pat")
                {
                    Caption = 'Mat/Pat';
                }
                field(maternity; Rec.Maternity)
                {
                    Caption = 'Maternity';
                }
            }
        }
    }
}

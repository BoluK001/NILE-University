page 51534399 "Leave Application API"
{
    APIGroup = 'Leaves';
    APIPublisher = 'Reeltech';
    APIVersion = 'v1.0';
    Caption = 'leaveApplicationAPI';
    DelayedInsert = true;
    EntityName = 'HRApplication';
    EntitySetName = 'HRleaveApplication';
    PageType = API;
    SourceTable = "HR Leave Application";

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
                field(applicationCode; Rec."Application Code")
                {
                    Caption = 'Application Code';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(employeeNo; Rec."Employee No")
                {
                    Caption = 'Employee No';
                }
                field(jobTittle; Rec."Job Tittle")
                {
                    Caption = 'Job Tittle';
                }
                field(supervisor; Rec.Supervisor)
                {
                    Caption = 'Supervisor';
                }
                field(supervisorEmail; Rec."Supervisor Email")
                {
                    Caption = 'Supervisor Email';
                }
                field(leavePeriod; Rec."Leave Period")
                {
                    Caption = 'Leave Period';
                }
                field(leaveType; Rec."Leave Type")
                {
                    Caption = 'Leave Type';
                }
                field(startDate; Rec."Start Date")
                {
                    Caption = 'Start Date';
                }
                field(returnDate; Rec."Return Date")
                {
                    Caption = 'Return Date';
                }
                field(approvedDays; Rec."Approved days")
                {
                    Caption = 'Approved days';
                }
                field(totalAnnualLeave; Rec."Total Annual Leave")
                {
                    Caption = 'Total Annual Leave';
                }
                field(totalLeaveDaysAllw; Rec."Total Leave Days Allw")
                {
                    Caption = 'Total Leave Days Allw';
                }
                field(newEntryMaxAnnualDays; Rec."New Entry Max Annual Days")
                {
                    Caption = 'New Entry Max Annual Days';
                }
                field(maximumLeaveDays; Rec."Maximum Leave Days")
                {
                    Caption = 'Maximum Leave Days';
                }
                field(applicationDate; Rec."Application Date")
                {
                    Caption = 'Application Date';
                }
                field(requestLeaveAllowance; Rec."Request Leave Allowance")
                {
                    Caption = 'Request Leave Allowance';
                }
                field(leaveAllowanceAmount; Rec."Leave Allowance Amount")
                {
                    Caption = 'Leave Allowance Amount';
                }
                field(payrollPeriod; Rec."Payroll Period")
                {
                    Caption = 'Payroll Period';
                }
                field(reliever; Rec.Reliever)
                {
                    Caption = 'Reliever';
                }
                field(relieverName; Rec."Reliever Name")
                {
                    Caption = 'Reliever Name';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(cellPhoneNumber; Rec."Cell Phone Number")
                {
                    Caption = 'Cell Phone Number';
                }
                field(eMailAddress; Rec."E-mail Address")
                {
                    Caption = 'E-mail Address';
                }
                field(detailsOfExamination; Rec."Details of Examination")
                {
                    Caption = 'Details of Examination';
                }
                field(dateOfExam; Rec."Date of Exam")
                {
                    Caption = 'Date of Exam';
                }
                field(numberOfPreviousAttempts; Rec."Number of Previous Attempts")
                {
                    Caption = 'Number of Previous Attempts';
                }

            }
        }
    }
}

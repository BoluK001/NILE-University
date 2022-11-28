report 51534528 "HR Employee Exit Interview"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HREmployeeExitInterview.rdlc';

    dataset
    {
        dataitem("HR Employee Exit Interviews"; "HR Employee Exit Interviews")
        {
            column(DateOfInterview; "HR Employee Exit Interviews"."Date Of Interview")
            {
            }
            column(InterviewDoneBy; "HR Employee Exit Interviews"."Interview Done By")
            {
            }
            column(DateOfLeaving; "HR Employee Exit Interviews"."Date Of Leaving")
            {
            }
            column(EmployeeNo; "HR Employee Exit Interviews"."Employee No.")
            {
            }
            column(EmployeeName; "HR Employee Exit Interviews"."Employee Name")
            {
            }
            column(InterviewerName; "HR Employee Exit Interviews"."Interviewer Name")
            {
            }
            column(DateofJoin; Format(DateofJoin, 0, 4))
            {
            }
            column(Supervisor; Supervisor)
            {
            }
            column(Department; Dept)
            {
            }
            column(today; Format(Today, 0, 4))
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Emp.Get("HR Employee Exit Interviews"."Employee No.");
                Supervisor := Emp."Supervisor/Manager";
                DateofJoin := Emp."Date Of Joining the Company";
                Dept := Emp."Department Code";
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        Emp: Record "HR Employees";
        Supervisor: Code[50];
        DateofJoin: Date;
        Dept: Code[20];
        CompInfo: Record "Company Information";
}


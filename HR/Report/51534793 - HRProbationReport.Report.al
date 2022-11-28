report 51534793 "HR Probation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRProbationReport.rdlc';

    dataset
    {
        dataitem("HR Employee Confirmation"; "HR Employee Confirmation")
        {
            DataItemTableView = WHERE ("Appraisal Type" = CONST (Probation));
            column(ApplicationNo_HREmployeeConfirmation; "HR Employee Confirmation"."Application No.")
            {
            }
            column(Score_HREmployeeConfirmation; "HR Employee Confirmation".Score)
            {
            }
            column(EmployeeName_HREmployeeConfirmation; "HR Employee Confirmation"."Employee Name")
            {
            }
            column(DateofEmployment_HREmployeeConfirmation; Format("Date of Employment"))
            {
            }
            column(DateofReview_HREmployeeConfirmation; Format("Date of Review"))
            {
            }
            column(Department_HREmployeeConfirmation; "HR Employee Confirmation".Department)
            {
            }
            column(Level_HREmployeeConfirmation; "HR Employee Confirmation".Level)
            {
            }
            column(From_HREmployeeConfirmation; Format("Start Date"))
            {
            }
            column(EndDate_HREmployeeConfirmation; Format("End Date"))
            {
            }
            column(Name; CompInfo.Name)
            {
            }
            column(DevelopmentAreas_HREmployeeConfirmation; "HR Employee Confirmation"."Development Areas")
            {
            }
            column(TrainingIdeas_HREmployeeConfirmation; "HR Employee Confirmation"."Training Ideas")
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(SecondLineSupervisorComment_HREmployeeConfirmation; "HR Employee Confirmation"."Second Line Supervisor Comment")
            {
            }
            column(EmployeeComment_HREmployeeConfirmation; "HR Employee Confirmation"."Employee Comment")
            {
            }
            column(Comment_HREmployeeConfirmation; "HR Employee Confirmation".Comment)
            {
            }
            column(Address; CompInfo.Address)
            {
            }
            dataitem("HR Employee Confirmation Line"; "HR Employee Confirmation Line")
            {
                DataItemLink = "Application No." = FIELD ("Application No.");
                column(EntryNo_HREmployeeConfirmationLine; "HR Employee Confirmation Line"."Entry No.")
                {
                }
                column(Responbilities_HREmployeeConfirmationLine; "HR Employee Confirmation Line".Responbilities)
                {
                }
                column(EmployeeRating_HREmployeeConfirmationLine; "HR Employee Confirmation Line"."Supervisor Rating")
                {
                }
                column(AvailableRating_HREmployeeConfirmationLine; "HR Employee Confirmation Line"."Available Rating")
                {
                }
            }
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
        CompInfo: Record "Company Information";
}


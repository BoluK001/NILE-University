report 51534795 "HR Prob & Confirmation List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRProbConfirmationList.rdlc';

    dataset
    {
        dataitem("HR Employee Confirmation"; "HR Employee Confirmation")
        {
            RequestFilterFields = "Appraisal Type";
            column(EmployeeNo_HREmployeeConfirmation; "HR Employee Confirmation"."Employee No.")
            {
            }
            column(EmployeeName_HREmployeeConfirmation; "HR Employee Confirmation"."Employee Name")
            {
            }
            column(Department_HREmployeeConfirmation; "HR Employee Confirmation".Department)
            {
            }
            column(Level_HREmployeeConfirmation; "HR Employee Confirmation".Level)
            {
            }
            column(DateofEmployment_HREmployeeConfirmation; Format("Date of Employment"))
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
            column(Picture; CompInfo.Picture)
            {
            }
            column(Address; CompInfo.Address)
            {
            }
            column(AppType; AppType)
            {
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

        AppType := "HR Employee Confirmation".GetFilter("Appraisal Type");
    end;

    var
        CompInfo: Record "Company Information";
        AppType: Code[20];
}


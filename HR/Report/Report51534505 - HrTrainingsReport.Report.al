report 51534505 "Hr Trainings Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HrTrainingsReport.rdlc';

    dataset
    {
        dataitem("HR Training Applications"; "HR Training Applications")
        {
            DataItemTableView = WHERE (Status = CONST (Approved));
            RequestFilterFields = "From Date";
            column(Picture; CompInfo.Picture)
            {
            }
            column(CourseTitle_HRTrainingApplications; "HR Training Applications"."Course Title")
            {
            }
            column(FromDate_HRTrainingApplications; Format("HR Training Applications"."From Date", 0, 4))
            {
            }
            column(ToDate_HRTrainingApplications; Format("HR Training Applications"."To Date", 0, 4))
            {
            }
            column(DurationUnits_HRTrainingApplications; "HR Training Applications"."Duration Units")
            {
            }
            column(Duration_HRTrainingApplications; "HR Training Applications".Duration)
            {
            }
            column(Description_HRTrainingApplications; "HR Training Applications".Description)
            {
            }
            column(ShortcutDimension1Code_HRTrainingApplications; "HR Training Applications"."Shortcut Dimension 1 Code")
            {
            }
            column(ApprovedCost_HRTrainingApplications; "HR Training Applications"."Approved Cost")
            {
            }
            column(ShortcutDimension2Code_HRTrainingApplications; "HR Training Applications"."Shortcut Dimension 2 Code")
            {
            }
            column(NoofApplicants_HRTrainingApplications; "HR Training Applications"."No. of Applicants")
            {
            }
            column(Location_HRTrainingApplications; "HR Training Applications".Location)
            {
            }
            column(ProviderName_HRTrainingApplications; "HR Training Applications"."Provider Name")
            {
            }
            column(Today; Format(Today, 0, 4))
            {
            }
            column(User; UserId)
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

    trigger OnInitReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
}


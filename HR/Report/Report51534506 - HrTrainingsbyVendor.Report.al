report 51534506 "Hr Trainings by Vendor"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HrTrainingsbyVendor.rdlc';

    dataset
    {
        dataitem("HR Training Applications"; "HR Training Applications")
        {
            DataItemTableView = SORTING (Provider) ORDER(Ascending) WHERE (Status = CONST (Approved));
            RequestFilterFields = Provider;
            column(Provider_HRTrainingApplications; "HR Training Applications".Provider)
            {
            }
            column(Description_HRTrainingApplications; "HR Training Applications".Description)
            {
            }
            column(ApplicationDate_HRTrainingApplications; Format("HR Training Applications"."Application Date", 0, 4))
            {
            }
            column(CourseTitle_HRTrainingApplications; "HR Training Applications"."Course Title")
            {
            }
            column(ProviderName_HRTrainingApplications; "HR Training Applications"."Provider Name")
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(Today; Format(Today, 0, 4))
            {
            }
            column(User; UserId)
            {
            }
            column(NoofApplicants_HRTrainingApplications; "HR Training Applications"."No. of Applicants")
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


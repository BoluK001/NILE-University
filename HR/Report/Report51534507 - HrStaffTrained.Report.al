report 51534507 "Hr Staff Trained"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HrStaffTrained.rdlc';

    dataset
    {
        dataitem("HR Training Applications"; "HR Training Applications")
        {
            DataItemTableView = WHERE(Status = CONST(Approved));
            RequestFilterFields = "From Date";
            column(FromDate_HRTrainingApplications; Format("HR Training Applications"."From Date", 0, 4))
            {
            }
            column(ToDate_HRTrainingApplications; Format("HR Training Applications"."To Date", 0, 4))
            {
            }
            column(TotalTrained; TotalApplicants)
            {
            }
            column(StaffTrainedPercent; StaffPercent)
            {
            }
            column(TotalEmployees; TotalEmp)
            {
            }
            column(UserID; UserId)
            {
            }
            column(Today; Format(Today, 0, 4))
            {
            }
            column(PeriodBegin; Format(PeriodBegin, 0, 4))
            {
            }
            column(Periodnd; Format(PeriodEnd, 0, 4))
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(CourseTitle_HRTrainingApplications; "HR Training Applications"."Course Title")
            {
            }
            column(Duration_HRTrainingApplications; "HR Training Applications".Duration)
            {
            }
            column(CostOfTraining_HRTrainingApplications; "HR Training Applications"."Cost Of Training")
            {
            }
            column(Location_HRTrainingApplications; "HR Training Applications".Location)
            {
            }
            column(Description_HRTrainingApplications; "HR Training Applications".Description)
            {
            }
            column(NoofApplicants_HRTrainingApplications; "HR Training Applications"."No. of Applicants")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Hremp.SetRange("No.");
                TotalEmp := Hremp.Count;

                TrainApp.SetFilter("From Date", '%1..%2', PeriodBegin, PeriodEnd);
                //TrainApp.SETRANGE(Status,Status::Posted);
                TrainApp.SetRange(TrainApp.Status, TrainApp.Status::Approved);
                if TrainApp.FindSet then
                    repeat
                        TrainApp.CalcFields(TrainApp."No. of Applicants");
                        TotalApplicants += TrainApp."No. of Applicants";
                    until TrainApp.Next = 0;

                StaffPercent := TotalApplicants / TotalEmp * 100;
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

    trigger OnInitReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    trigger OnPreReport()
    begin
        PeriodBegin := "HR Training Applications".GetRangeMin("From Date");
        PeriodEnd := "HR Training Applications".GetRangeMax("From Date");
    end;

    var
        Hremp: Record "HR Employees";
        TotalEmp: Decimal;
        PeriodBegin: Date;
        PeriodEnd: Date;
        TrainApp: Record "HR Training Applications";
        TotalApplicants: Integer;
        StaffPercent: Decimal;
        CompInfo: Record "Company Information";
}


report 51534513 "Hr Test Stage"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HrTestStage.rdlc';

    dataset
    {
        dataitem("HR Job Applications"; "HR Job Applications")
        {
            DataItemTableView = WHERE ("Interview Invitation Sent" = CONST (false));
            column(ApplicationNo_HRJobApplications; "HR Job Applications"."Application No")
            {
            }
            column(EMail_HRJobApplications; "HR Job Applications"."E-Mail")
            {
            }
            column(Age_HRJobApplications; "HR Job Applications".Age)
            {
            }
            column(JobAppliedFor_HRJobApplications; "HR Job Applications"."Job Applied For")
            {
            }
            column(EmployeeRequisitionNo_HRJobApplications; "HR Job Applications"."Employee Requisition No")
            {
            }
            column(TotalScore_HRJobApplications; "HR Job Applications"."Total Score")
            {
            }
            column(FirstName_HRJobApplications; "HR Job Applications"."First Name")
            {
            }
            column(MiddleName_HRJobApplications; "HR Job Applications"."Middle Name")
            {
            }
            column(LastName_HRJobApplications; "HR Job Applications"."Last Name")
            {
            }
            column(HomePhoneNumber_HRJobApplications; "HR Job Applications"."Home Phone Number")
            {
            }
            column(CellPhoneNumber_HRJobApplications; "HR Job Applications"."Cell Phone Number")
            {
            }
            column(WorkPhoneNumber_HRJobApplications; "HR Job Applications"."Work Phone Number")
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(User; UserId)
            {
            }
            column(Today; Format(Today, 0, 4))
            {
            }
            column(DateApplied_HRJobApplications; Format("Date Applied", 0, 4))
            {
            }
            dataitem("HR Applicant Test Details"; "HR Applicant Test Details")
            {
                DataItemLink = "Applicant No." = FIELD ("Application No"), "Requisition No." = FIELD ("Employee Requisition No");
                column(Score_HRApplicantTestDetails; "HR Applicant Test Details".Score)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                if "Total Score" < TotalScore then
                    CurrReport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    field("Pass Mark"; TotalScore)
                    {
                    }
                }
            }
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

    var
        TotalScore: Decimal;
        CompInfo: Record "Company Information";
}


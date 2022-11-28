report 51534687 "HR Job Occupants"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRJobOccupants.rdl';
    Caption = 'HR Job Occupants Report';

    dataset
    {
        dataitem("HR Jobs"; "HR Jobs")
        {
            RequestFilterFields = "Job ID", Status;
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(JobID_HRJobs; "HR Jobs"."Job ID")
            {
                IncludeCaption = true;
            }
            column(JobDescription_HRJobs; "HR Jobs"."Job Title")
            {
                IncludeCaption = true;
            }
            dataitem("HR Employees"; "HR Employees")
            {
                DataItemLink = "Job Title" = FIELD("Job ID");
                DataItemTableView = SORTING("No.") ORDER(Ascending);
                column(No_HREmployees; "HR Employees"."No.")
                {
                    IncludeCaption = true;
                }
                column(FirstName_HREmployees; "HR Employees"."First Name")
                {
                    IncludeCaption = true;
                }
                column(MiddleName_HREmployees; "HR Employees"."Middle Name")
                {
                    IncludeCaption = true;
                }
                column(LastName_HREmployees; "HR Employees"."Last Name")
                {
                    IncludeCaption = true;
                }
                column(JobTitle_HREmployees; "HR Employees"."Job Title")
                {
                    IncludeCaption = true;
                }
                column(DateOfJoiningtheCompany_HREmployees; Format("Date Of Joining the Company", 0, 4))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    HRJob.Reset;
                    HRJob.SetRange(HRJob."Job ID", "Job Title");
                    //if HRJob.Find('-') then
                    // CurrReport.ShowOutput := true;
                end;
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
        CI.Reset;
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HR_Job_OccupationsCaptionLbl: Label 'HR Job Occupations';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Job_OccupantsCaptionLbl: Label 'HR Job Occupants';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        NoCaptionLbl: Label 'No';
        NameCaptionLbl: Label 'Name';
        Company_E_MailCaptionLbl: Label 'Company E-Mail';
        Postal_AddressCaptionLbl: Label 'Postal Address';
        CityCaptionLbl: Label 'City';
        HRJob: Record "HR Jobs";
}


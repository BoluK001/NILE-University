report 51534697 "HR Job Applications"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRJobApplications.rdlc';

    dataset
    {
        dataitem("HR Job Applications"; "HR Job Applications")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Application No";
            column(SectionA; SectionA)
            {
            }
            column(ApplicationNo_HRJobApplications; "HR Job Applications"."Application No")
            {
                IncludeCaption = true;
            }
            column(FirstName_HRJobApplications; "HR Job Applications"."First Name")
            {
                IncludeCaption = true;
            }
            column(MiddleName_HRJobApplications; "HR Job Applications"."Middle Name")
            {
                IncludeCaption = true;
            }
            column(LastName_HRJobApplications; "HR Job Applications"."Last Name")
            {
                IncludeCaption = true;
            }
            column(JobAppliedFor_HRJobApplications; "HR Job Applications"."Job Applied For")
            {
                IncludeCaption = true;
            }
            column(City_HRJobApplications; "HR Job Applications".City)
            {
                IncludeCaption = true;
            }
            column(PostCode_HRJobApplications; "HR Job Applications"."Post Code")
            {
                IncludeCaption = true;
            }
            column(IDNumber_HRJobApplications; "HR Job Applications"."ID Number")
            {
                IncludeCaption = true;
            }
            column(Gender_HRJobApplications; "HR Job Applications".Gender)
            {
                IncludeCaption = true;
            }
            column(CountryCode_HRJobApplications; "HR Job Applications"."Country Code")
            {
                IncludeCaption = true;
            }
            column(SectionB; SectionB)
            {
            }
            column(HomePhoneNumber_HRJobApplications; "HR Job Applications"."Home Phone Number")
            {
                IncludeCaption = true;
            }
            column(CellPhoneNumber_HRJobApplications; "HR Job Applications"."Cell Phone Number")
            {
                IncludeCaption = true;
            }
            column(WorkPhoneNumber_HRJobApplications; "HR Job Applications"."Work Phone Number")
            {
                IncludeCaption = true;
            }
            column(EMail_HRJobApplications; "HR Job Applications"."E-Mail")
            {
                IncludeCaption = true;
            }
            column(PostalAddress_HRJobApplications; "HR Job Applications"."Postal Address")
            {
                IncludeCaption = true;
            }
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
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(CI_EMail; CI."E-Mail")
            {
                IncludeCaption = true;
            }
            column(CI_HomePage; CI."Home Page")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            dataitem("HR Applicant Qualifications"; "HR Applicant Qualifications")
            {
                DataItemLink = "Application No" = FIELD ("Application No");
                DataItemTableView = SORTING ("Application No", "Qualification Type", "Qualification Code") ORDER(Ascending);
                PrintOnlyIfDetail = false;
                column(SectionC; SectionC)
                {
                }
                column(QualificationType_HRApplicantQualifications; "HR Applicant Qualifications"."Qualification Type")
                {
                    IncludeCaption = true;
                }
                column(QualificationCode_HRApplicantQualifications; "HR Applicant Qualifications"."Qualification Code")
                {
                    IncludeCaption = true;
                }
                column(QualificationDescription_HRApplicantQualifications; "HR Applicant Qualifications"."Qualification Description")
                {
                    IncludeCaption = true;
                }
                column(InstitutionCompany_HRApplicantQualifications; "HR Applicant Qualifications"."Institution/Company")
                {
                    IncludeCaption = true;
                }
                column(FromDate_HRApplicantQualifications; "HR Applicant Qualifications"."From Date")
                {
                    IncludeCaption = true;
                }
                column(ToDate_HRApplicantQualifications; "HR Applicant Qualifications"."To Date")
                {
                    IncludeCaption = true;
                }
            }
            dataitem("HR Applicant Referees"; "HR Applicant Referees")
            {
                DataItemLink = "Job Application No" = FIELD ("Application No");
                DataItemTableView = SORTING ("Job Application No", Names) ORDER(Ascending);
                PrintOnlyIfDetail = false;
                column(SectionD; SectionD)
                {
                }
                column(Names_HRApplicantReferees; "HR Applicant Referees".Names)
                {
                    IncludeCaption = true;
                }
                column(Designation_HRApplicantReferees; "HR Applicant Referees".Designation)
                {
                    IncludeCaption = true;
                }
                column(Institution_HRApplicantReferees; "HR Applicant Referees".Institution)
                {
                    IncludeCaption = true;
                }
                column(Address_HRApplicantReferees; "HR Applicant Referees".Address)
                {
                    IncludeCaption = true;
                }
                column(TelephoneNo_HRApplicantReferees; "HR Applicant Referees"."Telephone No")
                {
                    IncludeCaption = true;
                }
                column(EMail_HRApplicantReferees; "HR Applicant Referees"."E-Mail")
                {
                    IncludeCaption = true;
                }
                column(Hobby_HRApplicantHobbies; Hobby_HRApplicantHobbies)
                {
                    IncludeCaption = false;
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
        CI.Get();
        CI.CalcFields(CI.Picture);

        //GET FILTER
        JobApplicationNo := "HR Job Applications".GetFilter("HR Job Applications"."Application No");
        if JobApplicationNo = '' then begin
            Message('Please select a Job Application Number before printing a report');
            CurrReport.Quit;
        end;
    end;

    var
        CI: Record "Company Information";
        SectionA: Label 'Section A :: Personal Details';
        SectionB: Label 'Section B :: Contact Details';
        SectionC: Label 'Section C :: Academic and Qualification Information';
        SectionD: Label 'Section D :: Applicant''s Refferees';
        JobApplicationNo: Text;
        Hobby_HRApplicantHobbies: Text;
}


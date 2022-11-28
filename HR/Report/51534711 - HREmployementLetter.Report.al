report 51534711 "HR Employement Letter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HREmployementLetter.rdlc';

    dataset
    {
        dataitem("HR Job Applications"; "HR Job Applications")
        {
            column(ApplicationNo_HRJobApplications; "HR Job Applications"."Application No")
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
            column(Initials_HRJobApplications; "HR Job Applications".Initials)
            {
            }
            column(SearchName_HRJobApplications; "HR Job Applications"."Search Name")
            {
            }
            column(PostalAddress_HRJobApplications; "HR Job Applications"."Postal Address")
            {
            }
            column(ResidentialAddress_HRJobApplications; "HR Job Applications"."Residential Address")
            {
            }
            column(City_HRJobApplications; "HR Job Applications".City)
            {
            }
            column(PostCode_HRJobApplications; "HR Job Applications"."Post Code")
            {
            }
            column(County_HRJobApplications; "HR Job Applications".County)
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
            column(Ext_HRJobApplications; "HR Job Applications"."Ext.")
            {
            }
            column(EMail_HRJobApplications; "HR Job Applications"."E-Mail")
            {
            }
            column(IDNumber_HRJobApplications; "HR Job Applications"."ID Number")
            {
            }
            column(Gender_HRJobApplications; "HR Job Applications".Gender)
            {
            }
            column(CountryCode_HRJobApplications; "HR Job Applications"."Country Code")
            {
            }
            column(Status_HRJobApplications; "HR Job Applications".Status)
            {
            }
            column(Comment_HRJobApplications; "HR Job Applications".Comment)
            {
            }
            column(FaxNumber_HRJobApplications; "HR Job Applications"."Fax Number")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(JobAppliedFor_HRJobApplications; "HR Job Applications"."Job Applied For")
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}


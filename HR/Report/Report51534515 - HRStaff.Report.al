report 51534515 "HR Staff"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRStaff.rdlc';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            RequestFilterFields = "No.", Religion, Tribe, Gender, "Job Level", Age, "Ethnic Origin";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
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
            column(HR_Employees__No__; "No.")
            {
            }
            column(HR_Employees__ID_Number_; "ID Number")
            {
            }
            column(HR_Employees__Job_Description_; "Job Description")
            {
            }
            column(HR_Employees__Date_Of_Joining_the_Company_; "Date Of Joining the Company")
            {
            }
            column(HR_Employees__FullName; "HR Employees".FullName)
            {
            }
            column(HR_Employees__Cell_Phone_Number_; "Cell Phone Number")
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_ListCaption; Employee_ListCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Employees__No__Caption; FieldCaption("No."))
            {
            }
            column(HR_Employees__ID_Number_Caption; FieldCaption("ID Number"))
            {
            }
            column(HR_Employees__Job_Description_Caption; FieldCaption("Job Description"))
            {
            }
            column(HR_Employees__Date_Of_Joining_the_Company_Caption; FieldCaption("Date Of Joining the Company"))
            {
            }
            column(Full_NamesCaption; Full_NamesCaptionLbl)
            {
            }
            column(HR_Employees__Cell_Phone_Number_Caption; FieldCaption("Cell Phone Number"))
            {
            }
            column(SNo; SNo)
            {
            }
            column(DateOfLeavingtheCompany_HREmployees; "HR Employees"."Date Of Leaving the Company")
            {
            }
            column(Gender_HREmployees; "HR Employees".Gender)
            {
            }
            column(EthnicOrigin_HREmployees; "HR Employees"."Ethnic Origin")
            {
            }
            column(Tribe_HREmployees; "HR Employees".Tribe)
            {
            }
            column(Religion_HREmployees; "HR Employees".Religion)
            {
            }
            column(JobLevel_HREmployees; "HR Employees"."Job Level")
            {
            }
            column(EmployeeFilters; EmpFilters)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
            end;

            trigger OnPreDataItem()
            begin
                EmpFilters := "HR Employees".GetFilters;
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
        CI.Get();
        CI.CalcFields(CI.Picture);
        SNo := 0;
    end;

    var
        CI: Record "Company Information";
        EmployeeCaptionLbl: Label 'Employee';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employee_ListCaptionLbl: Label 'Employee List';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        Full_NamesCaptionLbl: Label 'Full Names';
        SNo: Integer;
        EmpFilters: Text[100];
}


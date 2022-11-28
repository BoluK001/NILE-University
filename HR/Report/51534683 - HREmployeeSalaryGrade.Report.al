report 51534683 "HR Employee Salary Grade"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HREmployeeSalaryGrade.rdlc';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = SORTING("Salary Grade", "Salary Notch/Step");
            RequestFilterFields = "No.", "Department Code", "Office Filter", "Salary Grade", "Salary Notch/Step";
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
            column(HR_Employees__FullName; FullName)
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
            column(Full_NamesCaption; Full_NamesCaptionLbl)
            {
            }
            column(SNo; SNo)
            {
            }
            column(SalaryNotchStep_HREmployee; "HR-Employee"."Salary Notch/Step")
            {
            }
            column(SalaryGrade_HREmployee; "HR-Employee"."Salary Grade")
            {
            }
            column(FirstName_HREmployee; "HR-Employee"."First Name")
            {
            }
            column(MiddleName_HREmployee; "HR-Employee"."Middle Name")
            {
            }
            column(LastName_HREmployee; "HR-Employee"."Last Name")
            {
            }
            column(Initials_HREmployee; "HR-Employee".Initials)
            {
            }
            column(JobTitle_HREmployee; "HR-Employee"."Job Title")
            {
            }
            column(DepartmentCode_HREmployee; "HR-Employee"."Department Code")
            {
            }
            column(Office_HREmployee; "HR-Employee".Office)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
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
}


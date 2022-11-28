report 51534690 "HR Employee PIF"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HREmployeePIF.rdl';
    UseRequestPage = false;

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
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
            column(HR_Employees__No__; "No.")
            {
            }
            column(HR_Employees__Date_Of_Joining_the_Company_; "Date Of Joining the Company")
            {
            }
            column(HR_Employees__ID_Number_; "ID Number")
            {
            }
            column(Job_Level; "Job Level")
            {
            }
            column(Employment_Type; "Employment Type")
            {
            }
            column(Faculty_Code; "Shortcut Dimension 4 Code")
            {
            }
            column(Company_E_Mail; "Company E-Mail")
            {
            }
            column(HR_Employees__Date_Of_Birth_; "Date Of Birth")
            {
            }
            column(HR_Employees__Marital_Status_; "Marital Status")
            {
            }
            column(HR_Employees__PIN_Number_; "PIN Number")
            {
            }
            column(HR_Employees__NSSF_No__; "NSSF No.")
            {
            }
            column(HR_Employees__NHIF_No__; "NHIF No.")
            {
            }
            column(HR_Employees__Cell_Phone_Number_; "Cell Phone Number")
            {
            }
            column(HR_Employees__Postal_Address_; "Postal Address")
            {
            }
            column(HR_Employees_City; City)
            {
            }
            column(HR_Employees__Post_Code_; "Post Code")
            {
            }
            column(HR_Employees__Main_Bank_; "Main Bank")
            {
            }
            column(HR_Employees__Branch_Bank_; "Branch Bank")
            {
            }
            column(HR_Employees__Bank_Account_Number_; "Bank Account Number")
            {
            }
            column(HR_Employees__FullName; "HR Employees".FullName)
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Personal_Information_FormCaption; Personal_Information_FormCaptionLbl)
            {
            }
            column(Section_A__Personal_DetailsCaption; Section_A__Personal_DetailsCaptionLbl)
            {
            }
            column(HR_Employees__NHIF_No__Caption; FieldCaption("NHIF No."))
            {
            }
            column(HR_Employees__NSSF_No__Caption; FieldCaption("NSSF No."))
            {
            }
            column(HR_Employees__PIN_Number_Caption; FieldCaption("PIN Number"))
            {
            }
            column(HR_Employees__Marital_Status_Caption; FieldCaption("Marital Status"))
            {
            }
            column(HR_Employees__Date_Of_Birth_Caption; FieldCaption("Date Of Birth"))
            {
            }
            column(HR_Employees__ID_Number_Caption; FieldCaption("ID Number"))
            {
            }
            column(HR_Employees__Date_Of_Joining_the_Company_Caption; FieldCaption("Date Of Joining the Company"))
            {
            }
            column(HR_Employees__No__Caption; FieldCaption("No."))
            {
            }
            column(HR_Employees__Cell_Phone_Number_Caption; FieldCaption("Cell Phone Number"))
            {
            }
            column(HR_Employees__Postal_Address_Caption; FieldCaption("Postal Address"))
            {
            }
            column(Section_B__ContactsCaption; Section_B__ContactsCaptionLbl)
            {
            }
            column(HR_Employees_CityCaption; FieldCaption(City))
            {
            }
            column(HR_Employees__Post_Code_Caption; FieldCaption("Post Code"))
            {
            }
            column(Section_C__Bank_Account_DetailsCaption; Section_C__Bank_Account_DetailsCaptionLbl)
            {
            }
            column(HR_Employees__Main_Bank_Caption; FieldCaption("Main Bank"))
            {
            }
            column(HR_Employees__Branch_Bank_Caption; FieldCaption("Branch Bank"))
            {
            }
            column(HR_Employees__Bank_Account_Number_Caption; FieldCaption("Bank Account Number"))
            {
            }
            column(PictureCaption; PictureCaptionLbl)
            {
            }
            column(NamesCaption; NamesCaptionLbl)
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
            dataitem("HR Employee Qualifications"; "HR Employee Qualifications")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", "Line No.");
                column(HR_Employee_Qualifications__Qualification_Type_; "Qualification Type")
                {
                }
                column(HR_Employee_Qualifications__Qualification_Code_; "Qualification Code")
                {
                }
                column(HR_Employee_Qualifications__Qualification_Description_; "Qualification Description")
                {
                }
                column(Section_D__Academic_and_Professional_QualificationsCaption; Section_D__Academic_and_Professional_QualificationsCaptionLbl)
                {
                }
                column(HR_Employee_Qualifications__Qualification_Type_Caption; FieldCaption("Qualification Type"))
                {
                }
                column(HR_Employee_Qualifications__Qualification_Description_Caption; FieldCaption("Qualification Description"))
                {
                }
                column(Qualification_CodeCaption; Qualification_CodeCaptionLbl)
                {
                }
                column(HR_Employee_Qualifications_Employee_No_; "Employee No.")
                {
                }
                column(HR_Employee_Qualifications_Line_No_; "Line No.")
                {
                }
            }
            dataitem("HR Employment History"; "HR Employment History")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", "Company Name") WHERE("Company Name" = FILTER(<> '""'));
                PrintOnlyIfDetail = false;
                column(HR_Employment_History__Company_Name_; "Company Name")
                {
                }
                column(HR_Employment_History_From; From)
                {
                }
                column(HR_Employment_History__To_Date_; "To Date")
                {
                }
                column(HR_Employment_History__Job_Title_; "Job Title")
                {
                }
                column(HR_Employment_History__Key_Experience_; "Key Experience")
                {
                }
                column(Section_E__Employment_HistoryCaption; Section_E__Employment_HistoryCaptionLbl)
                {
                }
                column(HR_Employment_History__Company_Name_Caption; FieldCaption("Company Name"))
                {
                }
                column(HR_Employment_History_FromCaption; FieldCaption(From))
                {
                }
                column(HR_Employment_History__To_Date_Caption; FieldCaption("To Date"))
                {
                }
                column(HR_Employment_History__Job_Title_Caption; FieldCaption("Job Title"))
                {
                }
                column(HR_Employment_History__Key_Experience_Caption; FieldCaption("Key Experience"))
                {
                }
                column(HR_Employment_History_Employee_No_; "Employee No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                //"HR Employees".GET("HR Employees"."No.");
                "HR Employees".CalcFields("HR Employees".Picture);
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

        // if HrEmp.Get("HR Employees".GetFilter("HR Employees"."No.")) then begin
        //     if HrEmp."User ID" <> UserId then
        //         CurrReport.Quit;
        // end;

        // if "HR Employees".GetFilter("HR Employees"."No.") = '' then
        //     CurrReport.Quit; Dennis
    end;

    var
        CI: Record "Company Information";
        EmployeeCaptionLbl: Label 'Employee';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Personal_Information_FormCaptionLbl: Label 'Personal Information Form';
        Section_A__Personal_DetailsCaptionLbl: Label 'Section A: Personal Details';
        Section_B__ContactsCaptionLbl: Label 'Section B: Contacts';
        Section_C__Bank_Account_DetailsCaptionLbl: Label 'Section C: Bank Account Details';
        PictureCaptionLbl: Label 'Picture';
        NamesCaptionLbl: Label 'Names';
        Section_D__Academic_and_Professional_QualificationsCaptionLbl: Label 'Section D: Academic and Professional Qualifications';
        Qualification_CodeCaptionLbl: Label 'Qualification Code';
        Section_E__Employment_HistoryCaptionLbl: Label 'Section E: Employment History';
        HrEmp: Record "HR Employees";
}


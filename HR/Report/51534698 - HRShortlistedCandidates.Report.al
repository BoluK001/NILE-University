report 51534698 "HR Shortlisted Candidates"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRShortlistedCandidates.rdlc';

    dataset
    {
        dataitem("HR Employee Requisitions"; "HR Employee Requisitions")
        {
            RequestFilterFields = "Requisition No.";
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
            column(HR_Employee_Requisitions__Requisition_No__; "Requisition No.")
            {
            }
            column(HR_Employee_Requisitions__Requisition_Type_; "Recruitment Type")
            {
            }
            column(HR_Employee_Requisitions__Requisition_Date_; "Requisition Date")
            {
            }
            column(HR_Employee_Requisitions__Reason_For_Request_; "Reason For Request")
            {
            }
            column(HR_Employee_Requisitions__Type_of_Contract_Required_; "Type of Contract Required")
            {
            }
            column(HR_Employee_Requisitions_Requestor; Requestor)
            {
            }
            column(HR_Employee_Requisitions__Job_ID_; "Job ID")
            {
            }
            column(HR_Employee_Requisitions__Job_Description_; "Job Description")
            {
            }
            column(HR_Employee_RequisitionsCaption; HR_Employee_RequisitionsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Shortlisted_CandidatesCaption; HR_Shortlisted_CandidatesCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(Job_Requisition_DetailsCaption; Job_Requisition_DetailsCaptionLbl)
            {
            }
            column(HR_Employee_Requisitions__Requisition_Type_Caption; FieldCaption("Recruitment Type"))
            {
            }
            column(HR_Employee_Requisitions__Requisition_Date_Caption; FieldCaption("Requisition Date"))
            {
            }
            column(HR_Employee_Requisitions__Reason_For_Request_Caption; FieldCaption("Reason For Request"))
            {
            }
            column(HR_Employee_Requisitions__Type_of_Contract_Required_Caption; FieldCaption("Type of Contract Required"))
            {
            }
            column(HR_Employee_Requisitions_RequestorCaption; FieldCaption(Requestor))
            {
            }
            column(HR_Employee_Requisitions__Requisition_No__Caption; FieldCaption("Requisition No."))
            {
            }
            column(HR_Employee_Requisitions__Job_ID_Caption; FieldCaption("Job ID"))
            {
            }
            column(HR_Employee_Requisitions__Job_Description_Caption; FieldCaption("Job Description"))
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
            dataitem("HR Shortlisted Applicants"; "HR Shortlisted Applicants")
            {
                DataItemLink = "Employee Requisition No" = FIELD ("Requisition No.");
                DataItemTableView = SORTING ("Employee Requisition No", "Job Application No");
                column(HR_Shortlisted_Applicants__Job_Application_No_; "Job Application No")
                {
                }
                column(HR_Shortlisted_Applicants__First_Name_; "First Name")
                {
                }
                column(HR_Shortlisted_Applicants__Middle_Name_; "Middle Name")
                {
                }
                column(HR_Shortlisted_Applicants__Last_Name_; "Last Name")
                {
                }
                column(HR_Shortlisted_Applicants__ID_No_; "ID No")
                {
                }
                column(HR_Shortlisted_Applicants_Gender; Gender)
                {
                }
                column(HR_Shortlisted_Applicants_Qualified; Qualified)
                {
                }
                column(HR_Shortlisted_Applicants__Job_Application_No_Caption; FieldCaption("Job Application No"))
                {
                }
                column(HR_Shortlisted_Applicants__Last_Name_Caption; FieldCaption("Last Name"))
                {
                }
                column(HR_Shortlisted_Applicants__First_Name_Caption; FieldCaption("First Name"))
                {
                }
                column(HR_Shortlisted_Applicants__Middle_Name_Caption; FieldCaption("Middle Name"))
                {
                }
                column(HR_Shortlisted_Applicants__ID_No_Caption; FieldCaption("ID No"))
                {
                }
                column(HR_Shortlisted_Applicants_GenderCaption; FieldCaption(Gender))
                {
                }
                column(HR_Shortlisted_Applicants_QualifiedCaption; FieldCaption(Qualified))
                {
                }
                column(Shortlisted_ApplicantsCaption; Shortlisted_ApplicantsCaptionLbl)
                {
                }
                column(HR_Shortlisted_Applicants_Employee_Requisition_No; "Employee Requisition No")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                No := No + 1;
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
    end;

    var
        CI: Record "Company Information";
        HR_Employee_RequisitionsCaptionLbl: Label 'HR Employee Requisitions';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        HR_Shortlisted_CandidatesCaptionLbl: Label 'HR Shortlisted Candidates';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        Job_Requisition_DetailsCaptionLbl: Label 'Job Requisition Details';
        Shortlisted_ApplicantsCaptionLbl: Label 'Shortlisted Applicants';
        No: Integer;
}


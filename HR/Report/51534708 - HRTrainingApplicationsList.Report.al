report 51534708 "HR Training Applications List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRTrainingApplicationsList.rdlc';

    dataset
    {
        dataitem("HR Training Applications"; "HR Training Applications")
        {
            RequestFilterFields = "Application No";
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
            column(HR_Training_Applications__Application_No_; "Application No")
            {
            }
            column(HR_Training_Applications__Application_Date_; "Application Date")
            {
            }
            column(HR_Training_Applications__Employee_No__; "Employee No.")
            {
            }
            column(HR_Training_Applications__Employee_Name_; "Employee Name")
            {
            }
            column(HR_Training_Applications__Employee_Department_; "Shortcut Dimension 1 Code")
            {
            }
            column(HR_Training_Applications__Course_Title_; "Course Title")
            {
            }
            column(HR_Training_Applications__Purpose_of_Training_; "Reason for Training")
            {
            }
            column(HR_Training_ApplicationsCaption; HR_Training_ApplicationsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(Training_Applications_ListCaption; Training_Applications_ListCaptionLbl)
            {
            }
            column(HR_Training_Applications__Application_No_Caption; FieldCaption("Application No"))
            {
            }
            column(HR_Training_Applications__Application_Date_Caption; FieldCaption("Application Date"))
            {
            }
            column(HR_Training_Applications__Employee_No__Caption; FieldCaption("Employee No."))
            {
            }
            column(HR_Training_Applications__Employee_Name_Caption; FieldCaption("Employee Name"))
            {
            }
            column(HR_Training_Applications__Employee_Department_Caption; FieldCaption("Shortcut Dimension 1 Code"))
            {
            }
            column(HR_Training_Applications__Course_Title_Caption; FieldCaption("Course Title"))
            {
            }
            column(HR_Training_Applications__Purpose_of_Training_Caption; FieldCaption("Reason for Training"))
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
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            dataitem("HR Training Need Participant"; "HR Training Need Participant")
            {
                DataItemLink = "Document No." = FIELD ("Application No");
                column(DocumentNo_HRTrainingNeedParticipant; "HR Training Need Participant"."Document No.")
                {
                }
                column(EmployeeCode_HRTrainingNeedParticipant; "HR Training Need Participant"."Employee Code")
                {
                }
                column(EmployeeName_HRTrainingNeedParticipant; "HR Training Need Participant"."Employee Name")
                {
                }
                column(Department_HRTrainingNeedParticipant; "HR Training Need Participant".Department)
                {
                }
                column(JobTitle_HRTrainingNeedParticipant; "HR Training Need Participant"."Job Title")
                {
                }
                column(StaffCourseTitle_HRTrainingNeedParticipant; "HR Training Need Participant"."Staff Course Title")
                {
                }
                column(CourseTitle_HRTrainingNeedParticipant; "HR Training Need Participant"."Course Title")
                {
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


        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.FindFirst then begin
            if HREmp.Supervisor = false then begin
                HRTrainingNeedParticipant.SetRange("Document No.", "HR Training Applications".GetFilter("HR Training Applications"."Application No"));
                HRTrainingNeedParticipant.SetRange("Employee Code", HREmp."No.");
                if not HRTrainingNeedParticipant.FindFirst then
                    CurrReport.Quit;
            end;
        end;
    end;

    var
        CI: Record "Company Information";
        HR_Training_ApplicationsCaptionLbl: Label 'HR Training Applications';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        Training_Applications_ListCaptionLbl: Label 'Training Applications List';
        HRTrainingNeedParticipant: Record "HR Training Need Participant";
        HRTrainingApplications: Record "HR Training Applications";
        HREmp: Record "HR Employees";
}


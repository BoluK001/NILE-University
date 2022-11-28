report 51534666 "Mark Employee as Discharged"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MarkEmployeeasDischarged.rdlc';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = Status, "Status Change Date", "Location/Division Code", "Department Code", "Cost Center Code", "Salary Grade", "Salary Notch/Step";
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
            column(GETFILTERS; GetFilters)
            {
            }
            column(HR_Employee__No__; "No.")
            {
            }
            column(First_Name___________Middle_Name___________Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(HR_Employee_Gender; Gender)
            {
            }
            column(DeptName; DeptName)
            {
            }
            column(HR_Employee__Job_Title_; "Job Title")
            {
            }
            column(HR_Employee_Status; Status)
            {
            }
            column(HR_Employee__Status_Change_Date_; "Status Change Date")
            {
            }
            column(RCount; RCount)
            {
            }
            column(Employee_ListCaption; Employee_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Employee__No__Caption; FieldCaption("No."))
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(HR_Employee_GenderCaption; FieldCaption(Gender))
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(HR_Employee__Job_Title_Caption; FieldCaption("Job Title"))
            {
            }
            column(HR_Employee_StatusCaption; FieldCaption(Status))
            {
            }
            column(HR_Employee__Status_Change_Date_Caption; FieldCaption("Status Change Date"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                RCount := RCount + 1;
                DeptName := '';

                DValue.Reset;
                DValue.SetRange(DValue."Dimension Code", 'DEPARTMENT');
                DValue.SetRange(DValue.Code, "HR-Employee"."Department Code");
                if DValue.Find('-') then
                    DeptName := DValue.Name;

                "HR-Employee".Status := "HR-Employee".Status::Discharged;
                "HR-Employee".Modify;
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

    var
        RCount: Integer;
        DeptName: Text[200];
        DValue: Record "Dimension Value";
        Employee_ListCaptionLbl: Label 'Employee List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NamesCaptionLbl: Label 'Names';
        DepartmentCaptionLbl: Label 'Department';
}


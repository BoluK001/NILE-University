report 51534503 "Training Evaluation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TrainingEvaluation.rdlc';

    dataset
    {
        dataitem("HR Training Applications"; "HR Training Applications")
        {
            DataItemTableView = WHERE(Posted = CONST(true));
            RequestFilterFields = "Employee No.";
            column(EmployeeNo_HRTrainingApplications; "HR Training Applications"."Employee No.")
            {
            }
            column(CourseTitle_HRTrainingApplications; "HR Training Applications"."Course Title")
            {
            }
            column(FromDate_HRTrainingApplications; Format("HR Training Applications"."From Date", 0, 4))
            {
            }
            column(Duration_HRTrainingApplications; "HR Training Applications".Duration)
            {
            }
            column(Location_HRTrainingApplications; "HR Training Applications".Location)
            {
            }
            column(Provider_HRTrainingApplications; "HR Training Applications".Provider)
            {
            }
            column(ShortcutDimension1Code_HRTrainingApplications; "HR Training Applications"."Shortcut Dimension 1 Code")
            {
            }
            column(DepartmentCode; DeptCode)
            {
            }
            column(EmployeeName; EmpName)
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(Today; Format(Today, 0, 4))
            {
            }
            column(UserID; UserId)
            {
            }
            dataitem("Training Evaluation Template"; "Training Evaluation Template")
            {
                DataItemLink = "Request No." = FIELD("Application No");
                DataItemTableView = WHERE(Type = CONST(" "));
                column(Question_TrainingEvaluation; "Training Evaluation Template".Question)
                {
                }
                column(Answer_TrainingEvaluation; "Training Evaluation Template".Answer)
                {
                }
                column(Remarks_TrainingEvaluation; "Training Evaluation Template".Remarks)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                DeptCode := '';
                EmpName := '';
                if Emp.Get("Employee No.") then begin
                    DeptCode := Emp."Department Code";
                    EmpName := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                end;
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

    trigger OnInitReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var
        Emp: Record "HR Employees";
        DeptCode: Code[20];
        EmpName: Text[100];
        CompInfo: Record "Company Information";
}


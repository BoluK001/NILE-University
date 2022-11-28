report 51534803 "HR Appraisal Training Needs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRAppraisalTrainingNeeds.rdlc';

    dataset
    {
        dataitem("HR Appraisal Goal Setting H"; "HR Appraisal Goal Setting H")
        {
            RequestFilterFields = "Appraisal Period", "Appraisal Half";
            column(AppraisalPeriod_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Appraisal Period")
            {
            }
            column(EmployeeName_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Employee Name")
            {
            }
            column(Department_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H".Department)
            {
            }
            column(SalaryGrade_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Salary Grade")
            {
            }
            column(Surname; HREmp."Last Name")
            {
            }
            column(Location; HREmp."Department Code")
            {
            }
            column(BU; HREmp."Global Dimension 2 Code")
            {
            }
            column(Sn; Sn)
            {
            }
            column(EmployeeNo_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Employee No")
            {
            }
            column(FirstName; HREmp."First Name")
            {
            }
            column(JobLevel; HREmp."Job Level")
            {
            }
            dataitem("HR Appraisal Career Dev"; "HR Appraisal Career Dev")
            {
                DataItemLink = "Appraisal Code" = FIELD("Appraisal No");
                column(Question_HRAppraisalCareerDev; "HR Appraisal Career Dev".Question)
                {
                }
                column(Answer_HRAppraisalCareerDev; "HR Appraisal Career Dev".Answer)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                Sn += 1;
                //if HREmp.Get("HR Appraisal Goal Setting H"."Employee No") then
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
        HREmp: Record "HR Employees";
        Sn: Integer;
}


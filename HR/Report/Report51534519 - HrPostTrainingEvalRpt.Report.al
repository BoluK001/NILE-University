report 51534519 "Hr Post Training Eval Rpt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HrPostTrainingEvalRpt.rdlc';

    dataset
    {
        dataitem("Emp Traing Eval. Questionaire"; "Emp Traing Eval. Questionaire")
        {
            DataItemTableView = WHERE("Training Evaluation Category" = CONST(Post));
            RequestFilterFields = "Training Code", "Emp Code";
            column(EmpCode_EmpTraingEvalQuestionaire; "Emp Traing Eval. Questionaire"."Emp Code")
            {
            }
            column(TrainingEvaluationCategory_EmpTraingEvalQuestionaire; "Emp Traing Eval. Questionaire"."Training Evaluation Category")
            {
            }
            column(EvaluationDate_EmpTraingEvalQuestionaire; Format("Evaluation Date", 0, 4))
            {
            }
            column(TrainingCode_EmpTraingEvalQuestionaire; "Emp Traing Eval. Questionaire"."Training Code")
            {
            }
            column(User; UserId)
            {
            }
            column(Department; Department)
            {
            }
            column(Name; EmpName)
            {
            }
            column(Loc; Location)
            {
            }
            column(Course; Course)
            {
            }
            column(Header; StrSubstNo(Text001, "Emp Traing Eval. Questionaire"."Training Evaluation Category"))
            {
            }
            column(StartDate; Format(StartDate, 0, 4))
            {
            }
            column(TrainingProvider; Provider)
            {
            }
            column(TODAY; Format(Today, 0, 4))
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            dataitem("Hr Traing Eval. Quest. Line"; "Hr Traing Eval. Quest. Line")
            {
                DataItemLink = "Emp Code" = FIELD("Emp Code"), "Training Code" = FIELD("Training Code"), "Training Evaluation Category" = FIELD("Training Evaluation Category");
                column(EvaluationquestionNo_HrTraingEvalQuestLine; "Hr Traing Eval. Quest. Line"."Evaluation question No")
                {
                }
                column(TraningEvaluationQuestion_HrTraingEvalQuestLine; "Hr Traing Eval. Quest. Line"."Traning Evaluation Question")
                {
                }
                column(EmployeeAnswer_HrTraingEvalQuestLine; "Hr Traing Eval. Quest. Line"."Employee Answer")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                Department := '';
                Provider := '';
                Course := '';
                EmpName := '';

                if TrainingApp.Get("Training Code") then begin
                    Location := TrainingApp.Location;
                    Course := TrainingApp."Course Title";
                    Provider := TrainingApp."Provider Name";
                    StartDate := TrainingApp."From Date";
                end;

                if Employees.Get("Emp Code") then begin
                    Department := Employees."Department Code";
                    EmpName := Employees."Last Name" + ' ' + Employees."First Name" + ' ' + Employees."Middle Name";
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        Department: Code[20];
        Provider: Text[50];
        Location: Text[30];
        Course: Text[30];
        TrainingApp: Record "HR Training Applications";
        Employees: Record "HR Employees";
        CompInfo: Record "Company Information";
        EmpName: Text[50];
        StartDate: Date;
        Text001: Label '%1 Training Evaluation';
}


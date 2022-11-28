table 51534559 "Emp Traing Eval. Questionaire"
{
    DrillDownPageID = "Emp. Training Evaluation";
    LookupPageID = "Emp. Training Evaluation";

    fields
    {
        field(1; "Emp Code"; Code[20])
        {
            TableRelation = "HR Employees"."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                // CALCFIELDS("Training Evaluation Category");
            end;
        }
        field(2; "Traning Evaluation Type"; Option)
        {
            OptionCaption = ' ,Learning Academy,in-Plant,Open Course,Foreign Course,Knowledge Sharing';
            OptionMembers = " ","Learning Academy","in-Plant","Open Course","Foreign Course","Knowledge Sharing";
        }
        field(3; "Training Evaluation Category"; Option)
        {
            OptionCaption = ' ,Pre,Post,3 Months Post';
            OptionMembers = " ",Pre,Post,"3 Months Post";

            trigger OnValidate()
            begin
                TestField("Emp Code");
                TestField("Training Code");


                EvaluationLine.Reset;
                EvaluationLine.SetRange(EvaluationLine."Training Code", Rec."Training Code");
                EvaluationLine.SetRange(EvaluationLine."Training Evaluation Category", Rec."Training Evaluation Category");
                EvaluationLine.SetRange(EvaluationLine."Emp Code", Rec."Emp Code");
                EvaluationLine.DeleteAll;

                TrainingEvaluationQuestions.Reset;
                TrainingEvaluationQuestions.SetRange(TrainingEvaluationQuestions."Training Category", Rec."Training Evaluation Category");
                if TrainingEvaluationQuestions.FindSet then begin
                    repeat
                        EvaluationLine.Reset;
                        EvaluationLine.Init;
                        EvaluationLine."Line No." := 0;
                        EvaluationLine."Training Evaluation Category" := Rec."Training Evaluation Category";
                        EvaluationLine."Training Code" := Rec."Training Code";
                        EvaluationLine."Emp Code" := Rec."Emp Code";
                        EvaluationLine."Evaluation question No" := TrainingEvaluationQuestions."Training Eval Question No.";
                        EvaluationLine."Traning Evaluation Question" := TrainingEvaluationQuestions."Training Eval. Question";
                        EvaluationLine."Evaluation Date" := WorkDate;
                        EvaluationLine.Insert;
                    until TrainingEvaluationQuestions.Next = 0;
                end
            end;
        }
        field(4; "Evaluation question No"; Integer)
        {

            trigger OnValidate()
            begin
                //TESTFIELD("Emp Code");
                //ESTFIELD("Training Evaluation Category");
                //TESTFIELD("Emp Code");

                //CALCFIELDS("Traning Evaluation Question");
            end;
        }
        field(5; "Employee Answer"; Text[250])
        {
        }
        field(6; "Traning Evaluation Question"; Text[250])
        {
            CalcFormula = Lookup("Training Eval. question line"."Training Eval. Question" WHERE("Training Category" = FIELD("Training Evaluation Category"),
                                                                                                 "Training Eval Question No." = FIELD("Evaluation question No")));
            FieldClass = FlowField;
        }
        field(7; "Evaluation Date"; Date)
        {
        }
        field(8; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(9; "Date Filter"; DateFormula)
        {
            FieldClass = FlowFilter;
        }
        field(10; "Training Code"; Code[20])
        {
            TableRelation = "HR Training Applications";

            trigger OnValidate()
            var
                TrainingApp: Record "HR Training Need Participant";
                Text001: Label 'you are not qualified for this training program';
            begin
                TestField("Emp Code");
                TrainingApp.SetRange(TrainingApp."Document No.", "Training Code");
                TrainingApp.SetRange(TrainingApp."Employee Code", "Emp Code");
                TrainingApp.SetRange(TrainingApp.Selected, true);
                if not TrainingApp.FindFirst then
                    Error(Text001);
            end;
        }
        field(11; "User ID"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(12; "Send to Hr"; Boolean)
        {
        }
        field(13; "Date Sent"; Date)
        {
        }
        field(14; "Employee Name"; Text[100])
        {
        }
        field(15; "Sent to HR"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Emp Code", "Entry No.", "Training Code", "Training Evaluation Category")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User ID" := UserId;
    end;

    var
        TrainingEvaluationQuestions: Record "Training Eval. question line";
        EvaluationLine: Record "Hr Traing Eval. Quest. Line";
        i: Integer;
}


table 51534561 "Hr Traing Eval. Quest. Line"
{
    DrillDownPageID = "Emp. Training Evaluation";
    LookupPageID = "Emp. Training Evaluation";

    fields
    {
        field(1; "Emp Code"; Code[50])
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
        }
        field(4; "Evaluation question No"; Integer)
        {
        }
        field(5; "Employee Answer"; Text[250])
        {
        }
        field(6; "Traning Evaluation Question"; Text[250])
        {
            FieldClass = Normal;
        }
        field(7; "Evaluation Date"; Date)
        {
        }
        field(8; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(9; "Date Filter"; DateFormula)
        {
            FieldClass = FlowFilter;
        }
        field(10; "Training Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", "Training Evaluation Category", "Training Code", "Emp Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        TrainingEvaluationQuestions: Record "Training Eval. question line";
}


page 51534600 "Emp Pre-Train Eval. Subform"
{
    Caption = 'Questionnaire';
    MultipleNewLines = false;
    PageType = ListPart;
    RefreshOnActivate = false;
    SaveValues = false;
    SourceTable = "Hr Traing Eval. Quest. Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                FreezeColumn = "Emp Code";
                field("Emp Code"; "Emp Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Training Code"; "Training Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Training Evaluation Category"; "Training Evaluation Category")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Traning Evaluation Type"; "Traning Evaluation Type")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Evaluation question No"; "Evaluation question No")
                {
                    ApplicationArea = all;
                }
                field("Traning Evaluation Question"; "Traning Evaluation Question")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Employee Answer"; "Employee Answer")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Evaluation Date"; "Evaluation Date")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}


page 51534601 "HR Evaluation Answer FB"
{
    Caption = 'Answer';
    PageType = CardPart;
    SourceTable = "Hr Traing Eval. Quest. Line";

    layout
    {
        area(content)
        {
            field(Question; "Evaluation question No")
            {
                Editable = false;
                ApplicationArea = all;
                Visible = true;
            }
            group(Answer)
            {
                field("Emp Code"; "Emp Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Training Evaluation Category"; "Training Evaluation Category")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Employee Answer"; "Employee Answer")
                {
                    MultiLine = true;
                    //Editable = false;
                    ApplicationArea = all;
                    ShowCaption = false;
                }
                field("Training Code"; "Training Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}


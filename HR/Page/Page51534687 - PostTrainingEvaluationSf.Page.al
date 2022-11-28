page 51534687 "Post Training Evaluation Sf"
{
    PageType = ListPart;
    SourceTable = "Training Evaluation Template";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No."; "Request No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Question; Question)
                {
                    ApplicationArea = All;
                }
                field(Answer; Answer)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}


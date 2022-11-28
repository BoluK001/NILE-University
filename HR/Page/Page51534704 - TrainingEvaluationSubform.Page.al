page 51534704 "Training Evaluation Subform"
{
    PageType = ListPart;
    SourceTable = "Training Evaluation Template";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Question; Question)
                {
                    ApplicationArea = all;
                }
                field(Answer; Answer)
                {
                    ApplicationArea = all;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}


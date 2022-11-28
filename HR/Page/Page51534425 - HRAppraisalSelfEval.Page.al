page 51534425 "HR Appraisal Self Eval"
{
    PageType = ListPart;
    SourceTable = "HR Appraisal Evaluation Areas";

    layout
    {
        area(content)
        {
            group(New)
            {

                ShowCaption = false;
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
            repeater(Group)
            {
                field("Self Evaluation"; Rec."Self Evaluation")
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


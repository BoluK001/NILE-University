page 51534564 "HR Appraisal Evaluation Descri"
{
    PageType = ListPart;
    SourceTable = "HR Appraisal Evaluation Descri";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; "Line No")
                {
                    ApplicationArea = all;
                }
                field("Evaluation Description"; "Evaluation Description")
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


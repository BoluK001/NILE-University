page 51534573 "Hr Interview Specific Evalt SF"
{
    PageType = ListPart;
    SourceTable = "Hr Interview Specific Evaluatn";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Evaluation Code"; "Evaluation Code")
                {
                    ApplicationArea = all;
                }
                field("Evaluation Description"; "Evaluation Description")
                {
                    ApplicationArea = all;
                }
                field("Interview Rating"; "Interview Rating")
                {
                    Visible = false;
                }
                field("Interview1 Stage 1 Score"; "Interview1 Stage 1 Score")
                {
                    ApplicationArea = all;
                }
                field("Interview1 Stage 2 Score"; "Interview1 Stage 2 Score")
                {
                    ApplicationArea = all;
                }
                field("Interview1 Stage 3 Score"; "Interview1 Stage 3 Score")
                {
                    ApplicationArea = all;
                }
                field("Total Target"; "Total Target")
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


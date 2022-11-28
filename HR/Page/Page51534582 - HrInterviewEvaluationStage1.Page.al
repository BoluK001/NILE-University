page 51534582 "Hr Interview Evaluation Stage1"
{
    PageType = ListPart;
    SourceTable = "Hr Interview Specific Evaluatn";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Stage; Stage)
                {
                    ApplicationArea = all;
                }
                field("Evaluation Code"; "Evaluation Code")
                {
                    ApplicationArea = all;
                }
                field("Evaluation Description"; "Evaluation Description")
                {
                    ApplicationArea = all;
                }
                field("Interview1 Stage 1 Score"; "Interview1 Stage 1 Score")
                {
                    Caption = 'Interviewer 1 Stage 1 Score';
                    ApplicationArea = all;
                }
                field("Interview2 Stage 1 Score"; "Interview2 Stage 1 Score")
                {
                    Caption = 'Interviewer 2 Stage 1 Score';
                    ApplicationArea = all;
                }
                field("Total Target"; "Total Target")
                {
                    ApplicationArea = all;
                }
                field(Weight; Weight)
                {
                    ApplicationArea = all;
                }
                field("Average Score"; "Average Score")
                {
                    ApplicationArea = all;
                }
                field("Total Score"; "Total Score")
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


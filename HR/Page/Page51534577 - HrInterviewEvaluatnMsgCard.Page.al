page 51534577 "Hr Interview Evaluatn Msg Card"
{
    Caption = 'Interview Evaluation Message  Card';
    PageType = Card;
    SourceTable = "Hr Interview Evaluatn Message";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                    ApplicationArea = all;
                }
                field(Stages; Stages)
                {
                    ApplicationArea = all;
                }
                field(Subject; Subject)
                {
                    ApplicationArea = all;
                }
                field(Message; Message)
                {
                    ApplicationArea = all;
                }
                field(Venue; Venue)
                {
                    ApplicationArea = all;
                }
                field(Date; Date)
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


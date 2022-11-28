page 51534576 "Hr Interview Evaluatn Msg List"
{
    Caption = 'Interview Evaluation  Message List';
    CardPageID = "Hr Interview Evaluatn Msg Card";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Interview Evaluation  Message List';
    SourceTable = "Hr Interview Evaluatn Message";

    layout
    {
        area(content)
        {
            repeater(Group)
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


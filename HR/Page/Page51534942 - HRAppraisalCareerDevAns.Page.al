page 51534942 "HR Appraisal Career Dev Ans"
{
    PageType = CardPart;
    SourceTable = "HR Appraisal Career Dev";

    layout
    {
        area(content)
        {
            field("Line No."; "Line No.")
            {
                Caption = 'Question No.';
                Enabled = false;
                ApplicationArea = All;
            }
            field("Appraisal Code"; "Appraisal Code")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field(Answer; Answer)
            {
                MultiLine = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}


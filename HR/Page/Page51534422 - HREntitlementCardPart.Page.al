page 51534422 "HR Entitlement CardPart"
{
    PageType = CardPart;
    SourceTable = "HR Entitlement Lines";

    layout
    {
        area(content)
        {
            field("Line No."; "Line No.")
            {
                ApplicationArea = all;
            }
            field("Application No."; "Application No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Answer; Answer)
            {
                MultiLine = true;
                ApplicationArea = all;
            }
        }
    }

    actions
    {
    }
}


page 51534959 "HR Exit Interview Answer"
{
    PageType = CardPart;
    SourceTable = "HR Emp. Exit Interview Line";

    layout
    {
        area(content)
        {
            field(Question; Question)
            {
                Editable = false;
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


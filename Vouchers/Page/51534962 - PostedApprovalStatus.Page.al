page 51534962 "Posted Approval Status"
{
    PageType = Card;
    SourceTable = "Posted Approval Entry";

    layout
    {
        area(content)
        {
            repeater(New)
            {
                Editable = false;
                field("Approver ID"; "Approver ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}


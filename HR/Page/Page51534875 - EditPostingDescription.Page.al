page 51534875 "Edit Posting Description"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Purch. Inv. Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Name"; "Pay-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Description"; "Posting Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}


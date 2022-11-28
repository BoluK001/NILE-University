page 51534841 "Employee Trans Line"
{
    PageType = ListPart;
    SourceTable = "HR Emp Transaction Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field(Transaction; Transaction)
                {
                    ApplicationArea = All;
                }
                field("Transaction Name"; "Transaction Name")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
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


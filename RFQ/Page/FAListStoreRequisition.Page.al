page 51534372 "FA List-Store Requisition"
{
    PageType = List;
    SourceTable = "Fixed Asset";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = All;
                }
                // field("User Of Asset"; "User Of Asset")
                // {
                // } Dennis
                field("FA Location Code"; "FA Location Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5600), "No." = FIELD("No.");
            }
        }
    }

    actions
    {
    }
}


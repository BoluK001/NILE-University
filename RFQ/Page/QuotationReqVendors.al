page 51534374 "Quotation Req. Vendors"
{
    Caption = 'Quotation Request Vendors';
    PageType = ListPart;
    SourceTable = "Quotation Request Vendors";
    ApplicationArea = All;
    UsageCategory = Lists;


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
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; "Vendor Name")
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


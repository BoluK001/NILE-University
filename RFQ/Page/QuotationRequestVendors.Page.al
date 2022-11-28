page 51534358 "Quotation Request Vendors"
{
    PageType = List;
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
    var



}


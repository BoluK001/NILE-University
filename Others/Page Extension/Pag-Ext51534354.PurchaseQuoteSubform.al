pageextension 51534355 "Purchase Quote Subform" extends "Purchase Quote Subform"
{
    layout
    {
        addbefore(type)
        {
            field("Expense No."; "Expense No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {

            field("Description 2"; "Description 2")
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        addbefore(SelectMultiItems)
        {
            action("Upload File")
            {
                Description = 'No., Document Type, LineNo, Description, Location Code,Shortcut Dimension 1 Code, Shortcut Dimension 2 Code	Quantity';
                ApplicationArea = All;
                RunObject = codeunit "Import Excel to Requisition";
            }
        }
    }

}

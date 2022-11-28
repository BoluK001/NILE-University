pageextension 51534353 InventorySetup extends "Inventory Setup"
{
    layout
    {
        addafter(Dimensions)
        {
            group(Template)
            {
                field("Item Jnl Template"; "Item Jnl Template")
                {
                    ApplicationArea = All;
                }
                field("Item Jnl Batch"; "Item Jnl Batch") { ApplicationArea = All; }
                field("Item Journal Nos"; "Item Journal Nos") { ApplicationArea = All; }
                field("Item Batch Nos"; "Item Batch Nos") { ApplicationArea = All; }
            }
        }
        addafter("Posted Invt. Shipment Nos.")
        {
            field("Internal Requsition No."; Rec."Internal Requsition No.")
            {
                ToolTip = 'Specifies the value of the Internal Requsition No. field.';
                ApplicationArea = All;
            }
            field("Material Requisition Nos"; Rec."Material Requisition Nos")
            {
                ToolTip = 'Specifies the value of the Material Requisition Nos field.';
                ApplicationArea = All;
            }
            field("Package Nos."; Rec."Package Nos.")
            {
                ToolTip = 'Specifies the value of the Package Nos. field.';
                ApplicationArea = All;
            }
            field("Store Issue Nos"; Rec."Store Issue Nos")
            {
                ToolTip = 'Specifies the value of the Store Issue Nos field.';
                ApplicationArea = All;
            }
            field("Store Return Nos"; Rec."Store Return Nos")
            {
                ToolTip = 'Specifies the value of the Store Return Nos field.';
                ApplicationArea = All;
            }
            field("Issues Nos"; Rec."Issues Nos")
            {
                ToolTip = 'Specifies the value of the Issues Nos field.';
                ApplicationArea = All;
            }
        }
    }
}

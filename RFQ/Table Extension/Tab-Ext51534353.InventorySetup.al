tableextension 51534353 InventorySetup extends "Inventory Setup"
{
    fields
    {
        Field(50000; "Material Requisition Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        Field(50001; "Issues Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        Field(50004; "Transfer Requisition No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        Field(50005; "Internal Requsition No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        Field(50006; "Store Issue Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        Field(50007; "Store Return Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        Field(50008; "Item Journal Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        Field(50009; "Item Batch Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50010; "Item Jnl Template"; Code[20])
        {
            TableRelation = "Item Journal Template";
        }
        field(50011; "Item Jnl Batch"; Code[20])
        {
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Item Jnl Template"));
        }
    }
}

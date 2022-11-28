pageextension 51534981 RespCenterExt extends "Responsibility Center List"
{
    layout
    {
        addafter("Location Code")
        {
            // Add changes to table fields here
            field("CPV Nos."; "CPV Nos.")
            {
                ApplicationArea = all;
                TableRelation = "No. Series";
            }
            field("BPV Nos."; "BPV Nos.")
            {
                ApplicationArea = all;
            }
            field("CRV Nos."; "CRV Nos.")
            {
                ApplicationArea = all;
                //TableRelation = "No. Series"; 
            }
            field("BRV Nos."; "BRV Nos.")
            {
                ApplicationArea = all;
                // TableRelation = "No. Series"; 
            }
            field("JV Nos."; "JV Nos.")
            {
                ApplicationArea = all;
                //TableRelation = "No. Series";
            }
            field("Posted CPV Nos."; "Posted CPV Nos.")
            {
                ApplicationArea = all;
                //TableRelation = "No. Series";
            }
            field("Posted BPV Nos."; "Posted BPV Nos.")
            {
                ApplicationArea = all;
                //TableRelation = "No. Series"; 
            }
            field("Posted CRV Nos."; "Posted CRV Nos.")
            {
                ApplicationArea = all;
                //TableRelation = "No. Series"; 
            }
            field("Posted BRV Nos."; "Posted BRV Nos.")
            {
                ApplicationArea = all;
                // TableRelation = "No. Series"; 
            }
            field("Posted JV Nos."; "Posted JV Nos.")
            {
                ApplicationArea = all;
                //TableRelation = "No. Series"; 
            }
            field("Posted Contra Voucher Nos."; "Posted Contra Voucher Nos.")
            {
                ApplicationArea = all;
                //TableRelation = "No. Series"; 
            }
            field("Petty Cash Nos"; "Petty Cash Nos")
            {
                ApplicationArea = all;
                //TableRelation = "No. Series";
            }
            field("Posted Petty Cash Nos"; "Posted Petty Cash Nos")
            {
                ApplicationArea = all;
                // TableRelation = "No. Series"; 
            }
            field("Contra Voucher Nos."; "Contra Voucher Nos.")
            {
                ApplicationArea = all;
                // TableRelation = "No. Series"; 
            }

        }

    }
}
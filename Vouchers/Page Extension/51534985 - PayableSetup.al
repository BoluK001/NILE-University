pageextension 51534985 PayableSetupExt extends "Purchases & Payables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            group("Vendor Setup")
            {
                field("Requisition No"; "Requisition No")
                {
                    ApplicationArea = all;
                }
                field("Local Vendor"; "Local Vendor")
                {
                    Caption = 'Local Vendor';
                    ApplicationArea = all;
                }

                field("Import Vendor"; "Import Vendor")
                {
                    Caption = 'Import Vendor';
                    ApplicationArea = all;
                }

                field("Foreign Vendor"; "Foreign Vendor")
                {
                    Caption = 'Foreign Vendor';
                    ApplicationArea = all;
                }

                field("Cash Vendor"; "Cash Vendor")
                {
                    Caption = 'Cash Vendor';
                    ApplicationArea = all;

                }
                field("WHT No."; "WHT No.")
                {
                    Caption = 'WHT Vendor No.';
                    ApplicationArea = all;
                }

                //added to capture re to Quote No
                field("Purcahse Req"; "Purchase Req")
                {
                    Caption = 'Purcahse Req';
                    ApplicationArea = all;

                }

                field("Vendor Requisition No"; "Vendor Requisition No")
                {
                    Caption = 'Vendor Requisition No';
                    ApplicationArea = all;

                }
                field("With Holding Tax No."; "WHT No.")
                {
                    //Caption = 'Vendor Requisition No';
                    ApplicationArea = all;
                }
                field("Quotation Request No"; "Quotation Request No")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
pageextension 51534351 "Purchasing Agent" extends "Purchasing Agent Role Center"
{
    actions
    {
        modify("Assembly Orders")
        {
            Visible = false;
        }
        modify("Sales Orders")
        {
            Visible = false;
        }
        modify("Catalog Items")
        {
            Visible = false;
        }
        modify("Stockkeeping Units")
        {
            Visible = false;
        }
        modify("Purchase Journals")
        {
            Visible = false;
        }
        modify(RequisitionWorksheets)
        {
            Visible = false;
        }
        modify(SubcontractingWorksheets)
        {
            Visible = false;
        }
        modify("Standard Cost Worksheets")
        {
            Visible = false;
        }
        modify("&Purchase Journal")
        {
            Visible = false;
        }
        modify("Order Plan&ning")
        {
            Visible = false;
        }
        modify("Requisition &Worksheet")
        {
            Visible = false;
        }
        modify("Purchase &Line Discounts")
        {
            Visible = false;
        }
        modify("Purchase Analysis Reports")
        {
            Visible = false;
        }
        modify("Inventory Analysis Reports")
        {
            Visible = false;
        }
        modify("Navi&gate")
        {
            Visible = false;
        }
        modify("Blanket Purchase Orders")
        {
            Visible = false;
        }
        modify("Purchase &Return Order")
        {
            Visible = false;
        }
        modify("Purchase Return Orders")
        {
            Visible = false;
        }
        modify ("Purchase &Invoice")
        {
            Visible = false;
        }
        modify("Purchase Invoices")
        {
            Visible = false;
        }
        addafter("Posted Documents")
        {
            group("Purchase Requisition")
            {
                action("Purch. Requisition")
                {
                    RunObject = page "Purchase requisitions";
                    ApplicationArea = All;
                }
                action("Approved Purchase Requisition")
                {
                    RunObject = page "Approved Purchase Requisition";
                    ApplicationArea = All;
                }
                action("Request For Quotation")
                {
                    RunObject = page "RFQ List";
                    ApplicationArea = All;
                }
                action("Store Requisition List")
                {
                    RunObject = page "Store Requisition List";
                    ApplicationArea = all;
                }
                action("Quotation Request Vendors")
                {
                    RunObject = page "Quotation Request Vendors";
                    ApplicationArea = all;
                }
                action("Closed RFQ")
                {
                    RunObject = page "Closed RFQ List";
                    ApplicationArea = all;
                }
                action("CAPEX Requisition")
                {
                    //ApplicationArea = all;
                    Visible = false;
                }
                action("Quote Specifiaction List")
                {
                    RunObject = page "Quote Specifications List";
                    ApplicationArea = all;
                    Visible = false;
                }
                action(Requisition)
                {
                    RunObject = page Requisitions;
                    ApplicationArea = all;
                    Visible = false;
                }
                action("Purchase Quote Parameters")
                {
                    RunObject = page "Purchase Quote Parameters";
                    ApplicationArea = all;
                    Visible = false;
                }
                action("FA List Store Requisition")
                {
                    RunObject = page "FA List-Store Requisition";
                    ApplicationArea = all;
                    Visible = false;
                }
                action("Bid Analysis")
                {
                    RunObject = page "Closed RFQ List";
                    ApplicationArea = all;
                    Visible = false;
                }
            }
            group(Approvals)
            {
                action("Requests to Approve")
                {
                    RunObject = page "Requests to Approve";
                    ApplicationArea = All;
                }
                action("Approval Request Entries")
                {
                    RunObject = page "Approval Request Entries";
                    ApplicationArea = All;
                }
            }
        }
        addafter("Posted Purchase Credit Memos")
        {
            action("Posted Store Requisition")
            {
                RunObject = page "Posted Store Requisitions List";
                ApplicationArea = All;
            }
        }
        addafter("Inventory &Cost and Price List")
        {

            action("Vendor-Summary aging")
            {
                RunObject = report "305";
                ApplicationArea = all;
            }
            action("Vendor-trial balance")
            {
                RunObject = report "329";
                ApplicationArea = all;
            }
            action("Vendor-Detailed trial balance")
            {
                RunObject = report "304";
                ApplicationArea = all;
            }
            action("Inventory-transaction details")
            {
                RunObject = report "704";
                ApplicationArea = all;
            }
            action("Inventory Analysis views")
            {
                RunObject = page "9372";
                ApplicationArea = all;
            }

        }
    }
}

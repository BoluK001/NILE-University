reportextension 51534351 PurchaseReceiptcustom extends "Purchase - Receipt"
{
    RDLCLayout = './PurchaseReceipt.rdl';
    dataset
    {
        add("Purch. Rcpt. Header")
        {
            column(PaytoAddress_PurchRcptHeader; "Pay-to Address")
            {
            }
            column(Buy_from_Address; "Buy-from Address")
            {
            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {
            }
            column(Buy_from_Contact_No_; "Buy-from Contact No.")
            {

            }
            column(User_ID; "User ID")
            {

            }
            column(Vendor_Website; "Vendor Website")
            {

            }
        }

    }
}
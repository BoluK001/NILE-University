reportextension 51534350 PurchaseOrder extends "Order"
{
    RDLCLayout = './Order.rdl';
    dataset
    {

        addafter(RoundLoop)
        {
            dataitem("Company Information"; "Company Information")
            {
                column(Address; Address)
                {

                }
            }
            dataitem("Purchase Header1"; "Purchase Header")
            {

                column(Buy_from_Address; "Buy-from Address")
                {

                }


            }
            dataitem(Vendor; Vendor)
            {
                column(Home_Page; "Home Page")
                {

                }
                column(Phone_No_; "Phone No.")
                {

                }
                column(E_Mail; "E-Mail")
                {

                }
            }
        }
       
        add("Roundloop")
        {
            column(Specification; "Purchase Line"."Description 2")
            {

            }
        }
        //dataitem("Purchase Header"; "Purchase Header")
        add("Purchase Header")
        {
            column(VendorWebsite_PurchaseHeade; "Vendor Website")
            {

            }

            column(Requested_Receipt_Date1; "Requested Receipt Date")
            {

            }
            column(Expected_Receipt_Date; "Expected Receipt Date")
            {

            }
            column(Assigned_User_ID; "Assigned User ID")
            {

            }
        }
    }

    trigger OnPreReport()
    begin
        // "Purchase Header".CalcFields("Vendor Website");

    end;


    var
        Website: Text[150];
        Vend: Record Vendor;
}

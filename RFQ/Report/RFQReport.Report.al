report 51534932 "RFQ Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RFQReport.rdl';

    dataset
    {
        dataitem("Purchase Quote Header"; "Purchase Quote Header")
        {
            column(No_PurchaseQuoteHeader; "Purchase Quote Header"."No.")
            {
            }
            column(Assigned_User_ID; "Assigned User ID")
            {

            }
            column(VendorNamedynamics; VendorNamedynamics)
            {

            }
            column(ShiptoCode_PurchaseQuoteHeader; "Purchase Quote Header"."Ship-to Code")
            {
            }
            column(ShiptoName_PurchaseQuoteHeader; "Purchase Quote Header"."Ship-to Name")
            {
            }
            column(ShiptoAddress_PurchaseQuoteHeader; "Purchase Quote Header"."Ship-to Address")
            {
            }
            column(LocationCode_PurchaseQuoteHeader; "Purchase Quote Header"."Location Code")
            {
            }
            column(ShortcutDimension1Code_PurchaseQuoteHeader; "Purchase Quote Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchaseQuoteHeader; "Purchase Quote Header"."Shortcut Dimension 2 Code")
            {
            }
            column(PostingDescription_PurchaseQuoteHeader; "Purchase Quote Header"."Posting Description")
            {
            }
            column(ExpectedClosingDate_PurchaseQuoteHeader; "Purchase Quote Header"."Expected Closing Date")
            {
            }
            column(CompayInfoName; CompayInfo.Name)
            {
            }
            column(CompayInfoPicture; CompayInfo.Picture)
            {
            }
            column(CompayInfoAddress; CompayInfo.Address)
            {

            }
            column(CompayInfoEmail; CompayInfo."E-Mail")
            {

            }
            column(PostingDate_PurchaseQuoteHeader; "Purchase Quote Header"."Posting Date")
            {
            }
            column(Quote_Vendor_Name; "Quote Vendor Name")
            {

            }

            dataitem("Quotation Request Vendors"; "Quotation Request Vendors")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                column(VendorNo_QuotationRequestVendors; "Quotation Request Vendors"."Vendor No.")
                {
                }
                column(VendorName_QuotationRequestVendors; "Quotation Request Vendors"."Vendor Name")
                {
                }
                column(Vendor_Address;"Vendor Address")
                 {}
                column(vendor_Phone_No_; "vendor Phone No.")
                { }
                column(vendor_Email; "vendor Email")
                { }
                column(vendor_Website; "vendor Website")
                { }
                column(VendorWebsite; VendorWebsite)
                {

                }
                trigger OnAfterGetRecord()
                var
                    Vend: Record Vendor;
                    VendorWebsite: Text[100];
                begin
                    if Vend.GET("Quotation Request Vendors"."Vendor No.") then
                        Vend.SetRange("No.", "Quotation Request Vendors"."Vendor No.");
                    if Vend.Find('-') then begin
                        VendorWebsite := Vend."Home Page";
                        // Message('jjjjjj :%1  :%2', VendorWebsite, "Quotation Request Vendors"."Vendor No.");
                    end;


                end;
            }


            dataitem("Purchase Quote Line"; "Purchase Quote Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                column(Type_PurchaseQuoteLine; "Purchase Quote Line".Type)
                {
                }
                column(No_PurchaseQuoteLine; "Purchase Quote Line"."No.")
                {
                }
                column(Amount_Including_VAT; "Direct Unit Cost")
                {

                }
                column(Amount; Amount)
                {

                }
                column(Description_PurchaseQuoteLine; "Purchase Quote Line".Description)
                {
                }
                column(Description2_PurchaseQuoteLine; "Purchase Quote Line"."Description 2")   //jj 160922
                {
                }
                column(UnitofMeasure_PurchaseQuoteLine; "Purchase Quote Line"."Unit of Measure")
                {
                }
                column(Quantity_PurchaseQuoteLine; "Purchase Quote Line".Quantity)
                {
                }
                column(LineNo_PurchaseQuoteLine; "Purchase Quote Line"."Line No.")
                {
                }

            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
    [Scope('OnPrem')]
    procedure setVendornAme(vname: text)
    begin
        VendorNamedynamics := vname;
    end;

    trigger OnPreReport()
    begin
        CompayInfo.GET;
        CompayInfo.CALCFIELDS(Picture);
    end;

    var
        CompayInfo: Record "Company Information";
        Vendor: Record Vendor;
        VendorNamedynamics: Text;
        VendorWebsite: Text[100];
}


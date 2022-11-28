pageextension 51534356 PurchaseQuote extends "Purchase Quote"
{
    layout
    {
        modify("Responsibility Center")
        {
            Visible = false;
        }
        addafter("Buy-from Vendor Name")
        {

            field("RFQ No."; Rec."RFQ No.")
            {
                ToolTip = 'Specifies the value of the Request for Quotation Document No. field.';
                ApplicationArea = All;

                trigger OnValidate()
                var
                    RFQLines: Record "Purchase Quote Line";
                    PurchaseLines: Record "Purchase Line";
                    PurchaseLines2: Record "Purchase Line";
                    PurchHeader: Record "Purchase Header";
                    Vends: Record "Quotation Request Vendors";
                begin
                    PurchHeader.SetRange("No.", Rec."No.");
                    if PurchHeader.find('-') then
                        PurchaseLines2.SetRange("Document No.", PurchHeader."No.");
                    if PurchaseLines2.find('-') then
                        PurchaseLines2.DeleteAll();
                    RFQLines.INIT;
                    RFQLines.SetRange("Document No.", "RFQ No.");
                    IF RFQLines.FIND('-') then begin
                        REPEAT
                            PurchaseLines.INIT;
                            PurchaseLines.TRANSFERFIELDS(RFQLines);
                            PurchaseLines."Document Type" := PurchaseLines."Document Type"::Quote;
                            PurchaseLines."Document No." := "No.";
                            //PurchaseLines."RFQ No." := "RFQ No.";
                            PurchaseLines."Expense No." := RFQLines."Expense No.";
                            PurchaseLines."PRF No." := RFQLines."PRF No";
                            PurchaseLines."RFQ No." := RFQLines."Document No.";
                            PurchaseLines."Purchase Type" := "Purchase Type"::Local;
                            PurchaseLines.INSERT;
                        UNTIL RFQLines.NEXT = 0;
                    end;
                end;
            }
        }

    }

}

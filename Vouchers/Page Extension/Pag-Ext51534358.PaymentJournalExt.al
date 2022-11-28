pageextension 51534358 PaymentJournalExt extends "Payment Journal"
{

    actions
    {
        addafter(SuggestVendorPayments)
        {
            action(SuggestWHTVendorPayments)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Suggest WHT Vendor Payments';
                Ellipsis = true;
                Image = SuggestVendorPayments;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Create payment suggestions as lines in the payment journal for WHT Vendor';

                trigger OnAction()
                var
                    SuggestVendorPayments: Report "Suggest WHt Vendor Payments";
                begin
                    Clear(SuggestVendorPayments);
                    SuggestVendorPayments.SetGenJnlLine(Rec);
                    SuggestVendorPayments.RunModal;
                end;
            }

        }
    }
}
pageextension 51534352 PurchaseQuotes extends "Purchase Quotes"
{
    layout
    {
        modify(Status)
        {
            Visible = true;
        }
    }



    
    trigger OnOpenPage()
    begin
        Setfilter("Purchase Type", '%1', 0);
    end;
}

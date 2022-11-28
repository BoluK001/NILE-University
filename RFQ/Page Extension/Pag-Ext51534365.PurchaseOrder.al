pageextension 51534365 PurchaseOrder extends "Purchase Order"
{
    layout
    {
        modify("Posting Description")
        {
            Visible = true;
            ApplicationArea = All;
        }
    }
    actions
    {
        modify(Release)
        {
            Visible = false;
        }
        modify(Reopen)
        {
            Visible = false;
        }
    }

    //  trigger OnOpenPage()
    //  begin
    //      if Rec.Status <> Rec.Status::Open then begin
    //          CurrPage.Editable(false);
    //      end;
    //  end;

}

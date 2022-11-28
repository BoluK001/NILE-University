pageextension 51534364 Items extends "Item Card"
{
    layout{
        addafter(Blocked)
        {
            field(Status;Rec.Status)
            {
                ApplicationArea = all;
                Editable = true;
            }
        }
    }
}

pageextension 51534415 PageExtension50000 extends "Employee Card"
{
    layout
    {
        addafter("Privacy Blocked")
        {
            field("No. Series81738"; Rec."No. Series")
            {
                ApplicationArea = All;
                Editable = true;
            }

        }
        modify("No.")
        {
            Visible = true;
        }
    }
}

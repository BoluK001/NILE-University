pageextension 51534357 CustomerCard extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field("Customer Type"; "Customer Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
            }
        }
    }
}
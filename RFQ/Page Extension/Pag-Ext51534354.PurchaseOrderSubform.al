#pragma implicitwith disable
pageextension 51534354 "Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        addbefore(type)
        {
            field("Expense No."; Rec."Expense No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = all;
            }
        }

    }
}

#pragma implicitwith restore

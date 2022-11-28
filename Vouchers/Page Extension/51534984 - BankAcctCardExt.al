pageextension 51534984 BankAccExt extends "Bank Account Card"
{
    layout
    {
        addafter("Bank Account No.")
        {
            field("Bank Type"; "Bank Type")
            {
                ApplicationArea = all;
            }
            field(Cash; Cash)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Bank; Bank)
            {
                ApplicationArea = all;
                Visible = false;
            }

        }
    }
}
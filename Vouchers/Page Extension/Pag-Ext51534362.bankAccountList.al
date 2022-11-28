pageextension 51534362 bankAccountList extends "Bank Account List"
{
    layout
    {
        addafter(Contact)
        {

            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Net Change field.';
            }
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Net Change (LCY) field.';
            }
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the bank account''s current balance denominated in the applicable foreign currency.';
            }
            field("Balance (LCY)"; Rec."Balance (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the bank account''s current balance in LCY.';
            }
        }
    }
}

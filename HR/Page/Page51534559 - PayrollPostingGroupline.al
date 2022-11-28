page 51534559 "Payroll Posting Group Line"
{
    PageType = ListPart;
    SourceTable = "Payroll Posting Group Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Pay Element"; "Pay Element")
                {
                    ApplicationArea = All;
                }
                field("Debit Account Type"; "Debit Account Type")
                {
                    ApplicationArea = All;
                }
                field("Debit Account No."; "Debit Account No.")
                {
                    ApplicationArea = All;
                }
                field("Credit Account Type"; "Credit Account Type")
                {
                    ApplicationArea = All;
                }
                field("Credit Account No."; "Credit Account No.")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    //ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Group Code field.';
                }
            }
        }
    }

    actions
    {
    }
}



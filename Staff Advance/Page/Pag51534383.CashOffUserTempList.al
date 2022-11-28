page 51534383 "Cash Off. User Temp. List"
{
    Caption = 'Cash Office User Template';
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    CardPageId = "Cash Office User Template";
    UsageCategory = Administration;
    SourceTable = "Cash Office User Template";



    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(UserID; rec.UserID)
                {
                    ApplicationArea = All;

                }
                field("Journal Voucher Template"; "Journal Voucher Template")
                {
                    ApplicationArea = All;
                }
                field("Journal Voucher Batch"; "Journal Voucher Batch")
                {
                    ApplicationArea = All;
                }
                field("Payment Journal Template"; "Payment Journal Template")
                {
                    ApplicationArea = All;
                }
                field("Payment Journal Batch"; "Payment Journal Batch")
                {
                    ApplicationArea = All;
                }
                field("Receipt Journal Template"; "Receipt Journal Template")
                {
                    ApplicationArea = All;
                }

                field("Receipt Journal Batch"; "Receipt Journal Batch")
                {
                    ApplicationArea = All;
                }
                field("Bank Pay In Journal Template"; "Bank Pay In Journal Template")
                {
                    ApplicationArea = All;
                }
                field("Bank Pay In Journal Batch"; "Bank Pay In Journal Batch")
                {
                    ApplicationArea = All;
                }
                field("Default Payment Bank"; "Default Payment Bank")
                {
                    ApplicationArea = All;
                }

                field("Default Petty Cash Bank"; "Default Petty Cash Bank")
                {
                    ApplicationArea = All;
                }

                field("Default Receipts Bank"; "Default Receipts Bank")
                {
                    ApplicationArea = All;
                }
                field("Petty Cash Template"; "Petty Cash Template")
                {
                    ApplicationArea = All;
                }
                field("Petty Cash Batch"; "Petty Cash Batch")
                {
                    ApplicationArea = All;
                }
                field("Advance Surr Template"; "Advance Surr Template") { }
                field("Advance Surr Batch"; "Advance Surr Batch") { }
                field("Claim Template"; "Claim Template") { }
                field("Claim  Batch"; "Claim  Batch") { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}

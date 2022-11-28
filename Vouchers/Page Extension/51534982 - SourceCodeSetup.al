pageextension 51534982 "SourceCode Setup" extends "Source Code Setup"
{
    layout
    {
        addafter("Cost Accounting")
        {
            group(Vouchers)
            {
                field("Cash Receipt Voucher"; "Cash Receipt Voucher") { }
                field("Cash Payment Voucher"; "Cash Payment Voucher") { }
                field("Bank Receipt Voucher"; "Bank Receipt Voucher") { }
                field("Bank Payment Voucher"; "Bank Payment Voucher") { }
                field("Journal Voucher"; "Journal Voucher") { }
                field("IOU Voucher"; "IOU Voucher") { }
                field("IOU Retirement Voucher"; "IOU Retirement Voucher") { }
                field("Petty Cash Voucher"; "Petty Cash Voucher") { }
                field("Import Purchase"; "Import Purchase") { }
                field("Import File - Charge Invoice"; "Import File - Charge Invoice") { }
                field("Contra Voucher"; "Contra Voucher") { }

            }
        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
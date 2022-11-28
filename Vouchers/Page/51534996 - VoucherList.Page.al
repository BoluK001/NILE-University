page 51534996 "Voucher List"
{
    CardPageID = "Journal Voucher";
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Voucher Header";
    AdditionalSearchTerms = 'Voucher List';
    SourceTableView = WHERE("Voucher Type" = CONST(JV));

    layout
    {
        area(content)
        {
            repeater(New)
            {
                field("Created By"; "Created By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Created Time"; "Created Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Debit Amount"; "Debit Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Credit Amount"; "Credit Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    Visible = false;
                    ApplicationArea = all;
                    Editable = false;
                }

            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(51534980), "No." = FIELD("No.");

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CalcTotals;
    end;

    var
        Amount: Decimal;
        TotalAmount: Decimal;
        VoucherHeader: Record "Voucher Header";
        TotalCredit: Decimal;

    [Scope('OnPrem')]
    procedure CalcTotals()
    begin
        VoucherHeader.COPY(Rec);

        TotalAmount := 0;
        TotalCredit := 0;
        VoucherHeader.SETRANGE("Voucher Type", "Voucher Type");
        IF VoucherHeader.FINDSET THEN
            REPEAT
                VoucherHeader.CALCFIELDS("Debit Amount");
                VoucherHeader.CALCFIELDS("Credit Amount");
                TotalAmount := TotalAmount + VoucherHeader."Debit Amount";
                TotalCredit := TotalCredit + VoucherHeader."Credit Amount";
            UNTIL VoucherHeader.NEXT = 0;
    end;
}


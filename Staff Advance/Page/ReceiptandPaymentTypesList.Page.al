page 51534719 "Receipt and Payment Types List"
{
    PageType = List;
    SourceTable = "Receipts and Payment Types";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(n)
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ApplicationArea = all;
                }
                field("VAT Chargeable"; "VAT Chargeable")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Withholding Tax Chargeable"; "Withholding Tax Chargeable")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("VAT Code"; "VAT Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Withholding Tax Code"; "Withholding Tax Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Default Grouping"; "Default Grouping")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("G/L Account"; "Account No.")
                {
                    ApplicationArea = all;
                }
                field("Pending Voucher"; "Pending Voucher")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bank Account"; "Bank Account")
                {
                    ApplicationArea = all;
                }
                field("Transation Remarks"; "Transation Remarks")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}


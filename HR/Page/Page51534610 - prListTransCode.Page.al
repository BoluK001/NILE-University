page 51534610 "prList TransCode"
{
    CardPageID = "prTransaction Code";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "prTransaction Codes";
    SourceTableView = WHERE("Non-Transactional" = CONST(false));
    AdditionalSearchTerms = 'List TransCode';

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Enabled = true;
                ShowCaption = false;
                field("Transaction Code"; "Transaction Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Transaction Name"; "Transaction Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = true;
                }
                field(Frequency; Frequency)
                {
                    Editable = true;
                    ApplicationArea = all;
                    Enabled = true;
                }
                field("Transaction Category"; "Transaction Category")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Taxable; Taxable)
                {
                    Editable = true;
                    ApplicationArea = all;
                    Enabled = true;
                }
                field("Balance Type"; "Balance Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = true;
                }
                field("Transfer to"; "Transfer to")
                {
                    ApplicationArea = all;
                }
                field("Gross Variation"; "Gross Variation")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("IsCoop/LnRep"; "IsCoop/LnRep")
                {
                    ApplicationArea = all;
                }
                field("coop parameters"; "coop parameters")
                {
                    ApplicationArea = all;
                }
                field("Is Cash"; "Is Cash")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = true;
                }
                field("Is Formula"; "Is Formula")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = true;
                }
                field(Subledger; Subledger)
                {
                    ApplicationArea = all;
                }
                field(Formula; Formula)
                {
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = true;
                }
                field("Amount Preference"; "Amount Preference")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = true;
                }
                field("Special Transactions"; "Special Transactions")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = true;
                }
                field("Deduct Premium"; "Deduct Premium")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = true;
                }
                field("Nominal Interest Rate"; "Nominal Interest Rate")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = true;
                }
                field("GL Account"; "GL Account")
                {
                    ApplicationArea = all;
                }
                field("Repayment Method"; "Repayment Method")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = true;
                }
                field("Fringe Benefit"; "Fringe Benefit")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(View)
            {
                Caption = 'View';
                action("SetUp Card")
                {
                    Caption = 'SetUp Card';
                    RunObject = Page "prTransaction Code";
                    RunPageLink = "Transaction Code" = FIELD("Transaction Code");
                    RunPageView = SORTING("Transaction Code");
                }
            }
        }
    }
}


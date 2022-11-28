tableextension 51534402 GenLedgerSetup extends "General Ledger Setup"
{
    fields
    {
        field(51534000; "Journal Voucher Nos."; Code[20])
        {
            Caption = 'Journal Voucher Nos.';
            TableRelation = "No. Series";
        }
        field(51534001; "Cash Payment Voucher No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534002; "Cash Receipt Voucher No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534003; "Bank Payment Voucher No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534004; "Bank Receipt Voucher No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534005; "Requisition No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534006; "Petty Cash No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534007; "Retirement No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534008; "Loan Number Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(51534009; "Bank Transfer No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534010; "Refund Receipt No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534011; "Payment Request"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534012; "Expense Request Nos."; Code[20])
        {
        }
        field(51534013; "Bank Balances"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Bank Account Ledger Entry"."Amount (LCY)" WHERE("Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                "Posting Date" = FIELD("Date Filter")));
            Caption = 'Bank Balances';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51534014; "GjnlBatch Approval No"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(51534015; "LCY Code Decimals"; Code[20])
        {
        }
        field(51534016; "Pending L.O.P"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Outstanding Amount (LCY)" WHERE("Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                "Expected Receipt Date" = FIELD("Date Filter"),
                                                                                Amount = FILTER(<> 0),
                                                                                "Document Type" = FILTER(<> Quote)));
            FieldClass = FlowField;
        }
        field(51534017; "Base No. Series"; Option)
        {
            OptionCaption = ' ,Responsibility Center,Shortcut Dimension 1,Shortcut Dimension 2,Shortcut Dimension 3,Shortcut Dimension 4';
            OptionMembers = " ","Responsibility Center","Shortcut Dimension 1","Shortcut Dimension 2","Shortcut Dimension 3","Shortcut Dimension 4","Shortcut Dimension 5","Shortcut Dimension 6","Shortcut Dimension 7","Shortcut Dimension 8";
        }
        field(51534019; "Expense Code"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534018; "Stores Requisition No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534020; "Default SA Code"; Code[20])
        {
            Caption = 'Default SA Code';
            DataClassification = ToBeClassified;
        }
        field(51534021; "Posted Contra Voucher Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534022; "Posted Journal Voucher Nos."; Code[20])
        {
            TableRelation = "No. Series";
            //ApplicationArea = all;
        }
        field(51534023; "Posted Cash Payment Voucher No"; Code[20])
        {
            TableRelation = "No. Series";

        }
        field(51534024; "Posted Cash Receipt Voucher No"; Code[20])
        {
            TableRelation = "No. Series";

        }
        field(51534025; "Posted Bank Payment Voucher No"; Code[20])
        {
            TableRelation = "No. Series";

        }
        field(51534026; "Posted Bank Receipt Voucher No"; Code[20])
        {
            TableRelation = "No. Series";

        }
        field(51534027; "Contra Voucher Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534028; "Petty Cash Voucher No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534029; "Posted Petty Cash No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51534030; "Default Posting Date"; Option)
        {
            OptionMembers = "Work Date","No Date";
        }
        field(50018; "Act. Emp Lia No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50019; "Staff Claim No."; Code[20])
        {
            Caption = 'Staff Claim No';
            TableRelation = "No. Series";
        }
        field(50020; "Staff Advance No."; Code[20])
        {
            Caption = 'Other Staff Advance No';
            TableRelation = "No. Series";
        }
        field(50021; "Staff Advance Surrender No."; Code[20])
        {
            Caption = 'Staff Adv. Surrender No';
            TableRelation = "No. Series";
        }
        field(50022; "Collection Dist. %"; Decimal)
        {

        }
        field(50025; StaffAdvanceBudget; Boolean)
        {

        }
        field(50026; StaffClaimBudget; Boolean)
        {

        }
        field(50027; VoucherBudget; Boolean)
        {

        }
        field(50028; PurchaseBudget; Boolean)
        {

        }


    }
}

pageextension 51534402 GenLedgerSetupExt extends "General Ledger Setup"
{
    layout
    {
        addafter(Application)
        {
            Group("Number Series")
            {
                field("Posted Contra Voucher Nos."; "Posted Contra Voucher Nos.")
                {
                    TableRelation = "No. Series";
                    ApplicationArea = all;

                }
                field("Journal Voucher Nos."; "Journal Voucher Nos.")
                {
                    TableRelation = "No. Series";
                    ApplicationArea = All;
                }
                field("Cash Payment Voucher No"; "Cash Payment Voucher No")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series";
                }
                field("Cash Receipt Voucher No"; "Cash Receipt Voucher No")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series";
                }
                field("Bank Payment Voucher No"; "Bank Payment Voucher No")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series";
                }
                field("Bank Receipt Voucher No"; "Bank Receipt Voucher No")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series";
                }
                field("Staff Advance No."; "Staff Advance No.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series";
                }
                field("Staff Advance Surrender No."; "Staff Advance Surrender No.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series";
                }
                field("Staff Claim No."; "Staff Claim No.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series";
                }
                field("Posted Journal Voucher Nos."; "Posted Journal Voucher Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series";
                }
                field("Posted Cash Payment Voucher No"; "Posted Cash Payment Voucher No")
                {
                    TableRelation = "No. Series";
                    ApplicationArea = all;
                }
                field("Posted Cash Receipt Voucher No"; "Posted Cash Receipt Voucher No")
                {
                    TableRelation = "No. Series";
                    ApplicationArea = all;
                }
                field("Posted Bank Payment Voucher No"; "Posted Bank Payment Voucher No")
                {
                    TableRelation = "No. Series";
                    ApplicationArea = all;
                }
                field("Posted Bank Receipt Voucher No"; "Posted Bank Receipt Voucher No")
                {
                    TableRelation = "No. Series";
                    ApplicationArea = all;
                }
                field("Contra Voucher Nos."; "Contra Voucher Nos.")
                {
                    TableRelation = "No. Series";
                    ApplicationArea = all;
                }
                field("Petty Cash Voucher No"; "Petty Cash Voucher No")
                {
                    TableRelation = "No. Series";
                    ApplicationArea = all;
                }
                field("Posted Petty Cash No"; "Posted Petty Cash No")
                {
                    TableRelation = "No. Series";
                    ApplicationArea = all;
                }
                field("Expense Request Nos."; "Expense Request Nos.")
                {
                    TableRelation = "No. Series";
                }
                field("Default Posting Date"; "Default Posting Date")
                {
                    ApplicationArea = All;
                    OptionCaption = 'Work Date","No Date';
                }
                field("Act. Emp Lia No."; "Act. Emp Lia No.")
                {
                    ApplicationArea = All;
                }
                field("Stores Requisition No"; "Stores Requisition No")
                {
                    ApplicationArea = All;
                }
                field(StaffAdvanceBudget; Rec.StaffAdvanceBudget)
                {
                    ApplicationArea = All;
                }
                field(StaffClaimBudget; Rec.StaffClaimBudget)
                {
                    ApplicationArea = All;
                }
                field(VoucherBudget; Rec.VoucherBudget)
                {
                    ApplicationArea = All;
                }
                field(PurchaseBudget; Rec.PurchaseBudget)
                {
                    ApplicationArea = All;
                }

            }
        }
        addafter("Bank Account Nos.")
        {
            field("Collection Dist. %"; "Collection Dist. %")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
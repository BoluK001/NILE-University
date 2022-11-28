page 51534984 "Bank Payment Voucher Subform"
{
    //ApplicationArea=all;
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Voucher Line";
    MultipleNewLines = true;
    SourceTableView = SORTING("Voucher Type", "Document No.", "Line No.")
                      WHERE("Voucher Type" = FILTER(BPV));

    layout
    {
        area(content)
        {
            repeater(BPVS)
            {
                field(Account; Account)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //ShowShortcutDimCode(ShortcutDimCode);
                        Clear("Account No.");
                        Clear("Account Name");
                    end;
                }
                field("Account Type"; "Account Type")
                {
                    Visible = false;
                    //Editable = false;
                    ApplicationArea = all;
                }
                field("Account No."; "Account No.")
                {
                    //Visible = False;
                    ApplicationArea = All;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Exchange Rate"; "Exchange Rate")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Currency Factor"; "Currency Factor")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("W/Tax Code"; Rec."W/Tax Code")
                {
                    ToolTip = 'Specifies the value of the WHT Code field.';
                    ApplicationArea = All;
                }
                field("W/Tax Rate"; Rec."W/Tax Rate")
                {
                    ToolTip = 'Specifies the value of the WHT Rate field.';
                    ApplicationArea = All;
                }
                field("WHT Amount"; Rec."WHT Amount")
                {
                    ToolTip = 'Specifies the value of the WHT Amount field.';
                    ApplicationArea = All;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Amount field.';
                }

                field("WHT Vendor Code"; Rec."WHT Vendor Code")
                {
                    ToolTip = 'Specifies the value of the WHT Vendor Code field.';
                    ApplicationArea = All;
                }
                field("Debit Amount"; "Debit Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = all;
                    //Editable = false;
                    Visible = false;
                }
                field("Teller / Cheque No."; "Teller / Cheque No.")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field(Narration; Narration)
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Customer No."; "Customer No.")
                {
                    Caption = 'Client No.';
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Customer Name"; "Customer Name")
                {
                    Caption = 'Client Name';
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    //Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    //  Visible = false;
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = all;
                    // Visible = false;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    // Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; "Shortcut Dimension 5 Code")
                {
                    // Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; "Shortcut Dimension 6 Code")
                {
                    // Visible = false;
                    ApplicationArea = All;
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Posting No. Series"; "Posting No. Series")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("External Document No."; "External Document No.")
                {
                    //caption = 'Voucher No.';
                    ApplicationArea = all;
                }

            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
            }
        }
    }

    var
        JVHeader: Record "Voucher Header";
        GenJrnlLine: Record "Gen. Journal Line";
        ReportPrint: Codeunit "Test Report-Print";
        CurrentJnlBatchName: Code[20];
        ChangeExchangeRate: Page "Change Exchange Rate";

    [Scope('OnPrem')]
    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;
}


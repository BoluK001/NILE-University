page 51534997 "Voucher Subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Voucher Line";

    layout
    {
        area(content)
        {
            repeater(New)
            {
                field(Account; Account)
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = all;
                    // Editable = false;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Narration; Narration)
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = all;
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
                field("Debit Amount"; "Debit Amount")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Credit Amount"; "Credit Amount")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Bal. Account Type"; "Bal. Account Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //Visible = false;
                }
                field("Bal. Account No."; "Bal. Account No.")
                {
                    ApplicationArea = all;
                    //Visible = false;
                }
                field("Bal. Account Name"; "Bal. Account Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //Visible = false;
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                    //Visible = false;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    // Visible = false;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    // Visible = false;
                }
                field("Shortcut Dimension 5 Code"; "Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;
                    // Visible = false;
                }
                field("Shortcut Dimension 6 Code"; "Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                    // Visible = false;
                }
                field("Shortcut Dimension 7 Code"; "Shortcut Dimension 7 Code")
                {
                    ApplicationArea = All;
                    // Visible = false;
                }
                field("Shortcut Dimension 8 Code"; "Shortcut Dimension 8 Code")
                {
                    ApplicationArea = All;
                    // Visible = false;
                }

                field("FA Posting Type"; "FA Posting Type")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Posting Group"; "Posting Group")
                {
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

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CLEAR(ShortcutDimCode);
    end;

    var
        CurrentJnlBatchName: Code[20];
        ChangeExchangeRate: Page "Change Exchange Rate";
        ShortcutDimCode: array[15] of Code[20];
        VoucherHeader: Record "Voucher Header";

    [Scope('OnPrem')]
    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;
}


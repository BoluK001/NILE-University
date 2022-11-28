page 51534986 "Bank Receipt Voucher Subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Voucher Line";
    SourceTableView = SORTING("Voucher Type", "Document No.", "Line No.")
                      WHERE("Voucher Type" = FILTER(BRV));

    layout
    {
        area(content)
        {
            repeater(BRVS)
            {
                field(Account; Account)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        ShowShortcutDimCode(ShortcutDimCode);
                        Clear("Account No.");
                        Clear("Account Name");
                    end;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("External Document No."; "External Document No.")
                {
                    caption = 'Receipt No.';
                    ApplicationArea = all;
                    //Editable = false;
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
                field("Teller / Cheque No."; "Teller / Cheque No.")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Credit Amount"; "Credit Amount")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Debit Amount"; "Debit Amount")
                {
                    Visible = false;
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field(Narration; Narration)
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    //Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    //Visible = false;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    // Visible = false;
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    // Visible = false;
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 5 Code"; "Shortcut Dimension 5 Code")
                {
                    ApplicationArea = all;
                    //Visible = false;
                }
                field("Shortcut Dimension 6 Code"; "Shortcut Dimension 6 Code")
                {
                    // Visible = false;
                    ApplicationArea = All;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Posting Group"; "Posting Group")
                {
                    ApplicationArea = all;
                    //Editable = false;
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
            action("Apply Entries")
            {
                Caption = 'Apply Entries';
                Image = ApplyEntries;
                Promoted = true;
                ApplicationArea = all;
                PromotedIsBig = true;
                RunObject = Codeunit "Voucher Apply Entries";
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
        JVHeader: Record "Voucher Header";
        GenJrnlLine: Record "Gen. Journal Line";
        ReportPrint: Codeunit "Test Report-Print";
        CurrentJnlBatchName: Code[20];
        ChangeExchangeRate: Page "Change Exchange Rate";
        ShortcutDimCode: array[8] of Code[20];

    [Scope('OnPrem')]
    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;
}


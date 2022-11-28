page 51534990 "Cash Payment Voucher Subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    //ApplicationArea = all;

    SourceTable = "Voucher Line";

    layout
    {
        area(content)
        {
            repeater(new)
            {
                field(Account; Account)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        //ShowShortcutDimCode(ShortcutDimCode);
                        Clear("Account No.");
                        Clear("Account Name");
                    end;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = all;
                    //Editable = false;
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
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field("FA Posting Type"; "FA Posting Type")
                {
                    //Visible = false;
                    ApplicationArea = all;
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    Editable = false;
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
                    //Editable = false;
                }
                field("Currency Factor"; "Currency Factor")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    //  Editable = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    // Editable = false;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    // Visible = false;
                    ApplicationArea = All;
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
                field("Shortcut Dimension 7 Code"; "Shortcut Dimension 7 Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Expat Name"; "Expat Name")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 8 Code"; "Shortcut Dimension 8 Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    //Editable = false;
                    ApplicationArea = all;
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
                field("WHT Vendor Code"; Rec."WHT Vendor Code")
                {
                    ToolTip = 'Specifies the value of the WHT Vendor Code field.';
                    ApplicationArea = All;
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
                action(Dimension)
                {
                    Caption = 'Dimension';
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

    [Scope('OnPrem')]
    procedure UpdateSubform()
    begin
        CurrPage.UPDATE(FALSE);
    end;
}


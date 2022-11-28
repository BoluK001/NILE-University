page 51534993 "Cash Receipt Voucher Subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Voucher Line";
    SourceTableView = SORTING("Voucher Type", "Document No.", "Line No.")
                      WHERE("Voucher Type" = FILTER(CRV));

    layout
    {
        area(content)
        {
            repeater(New)
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
                    //Editable = false;
                }

                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;
                    caption = 'Receipt No.';
                }
                field(Narration; Narration)
                {
                    ApplicationArea = all;
                    //Editable = false;
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
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
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
                    ApplicationArea = All;
                    //Visible = false;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
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
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
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
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
            }
            action("Apply Entries")
            {
                Caption = 'Apply Entries';
                ApplicationArea = all;
                RunObject = Codeunit "Voucher Apply Entries";
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


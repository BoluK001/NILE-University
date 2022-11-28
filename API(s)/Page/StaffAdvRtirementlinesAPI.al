page 51534395 "Staff Adv Retirement lines API"
{
    APIGroup = 'SARLines';
    APIPublisher = 'Reeltech';
    APIVersion = 'v1.0';
    Caption = 'staffAdvRtirementLinesAPI';
    DelayedInsert = true;
    EntityName = 'StaffAdvSur';
    EntitySetName = 'StaffAdvSurAPI';
    PageType = API;
    SourceTable = "Staff Advanc Surrender Details";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(imprestType; Rec."Imprest Type")
                {
                    Caption = 'Imprest Type';
                }
                field(accountNo; Rec."Account No.")
                {
                    Caption = 'Account No:';
                }
                field(accountName; Rec."Account Name")
                {
                    Caption = 'Account Name';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(actualSpent; Rec."Actual Spent")
                {
                    Caption = 'Actual Spent';
                }
                field(cashReceiptNo; Rec."Cash Receipt No")
                {
                    Caption = 'Cash Receipt No';
                }
                field(applyTo; Rec."Apply to")
                {
                    Caption = 'Apply to';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Posting Location';
                }
                field(advanceHolder; Rec."Advance Holder")
                {
                    Caption = 'Advance Holder';
                }
                field(surrenderDocNo; Rec."Surrender Doc No.")
                {
                    Caption = 'Surrender Doc No.';
                }
                field(appliesToDocType; Rec."Applies-to Doc. Type")
                {
                    Caption = 'Applies-to Doc. Type';
                }
                field(appliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Applies-to Doc. No.';
                }
                field(appliesToID; Rec."Applies-to ID")
                {
                    Caption = 'Applies-to ID';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}

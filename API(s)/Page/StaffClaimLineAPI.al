page 51534393 "Staff Claim Line API"
{
    APIGroup = 'Claims';
    APIPublisher = 'Reeltech';
    APIVersion = 'v1.0';
    Caption = 'staffClaimLineAPI';
    DelayedInsert = true;
    EntityName = 'StaffClaim';
    EntitySetName = 'StaffclaimAPI';
    PageType = API;
    SourceTable = "Staff Claim Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(advanceType; Rec."Advance Type")
                {
                    Caption = 'Claim Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No';
                }
                field(accountType; Rec."Account type")
                {
                    Caption = 'Account type';
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
                field(claimReceiptNo; Rec."Claim Receipt No")
                {
                    Caption = 'Claim Receipt No';
                }
                field(expenditureDate; Rec."Expenditure Date")
                {
                    Caption = 'Expenditure Date';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}

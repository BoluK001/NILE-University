page 51534388 StaffAdvanceLine
{
    APIGroup = 'StaffAdvance';
    APIPublisher = 'RBS';
    APIVersion = 'v1.0';
    Caption = 'staffAdvanceLine';
    DelayedInsert = true;
    EntityName = 'StaffAdvanceLine';
    EntitySetName = 'StaffAdvanceLine';
    PageType = API;
    SourceTable = "Staff Advance Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(accountNo; Rec."Account No.")
                {
                    Caption = 'Account No.';
                }
                field(accountName; Rec."Account Name")
                {
                    Caption = 'Account Name';
                }
                field(accountType; Rec."Account Type")
                {
                    Caption = 'Account Type';
                }
                field(actualSpent; Rec."Actual Spent")
                {
                    Caption = 'Actual Spent';
                }
                field(advanceHolder; Rec."Advance Holder")
                {
                    Caption = 'Advance Holder';
                }
                field(advanceNarration; Rec."Advance Narration")
                {
                    Caption = 'Advance Narration';
                }
                field(advanceType; Rec."Advance Type")
                {
                    Caption = 'Advance Type';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(dateIssued; Rec."Date Issued")
                {
                    Caption = 'Date Issued';
                }
                field(dateTaken; Rec."Date Taken")
                {
                    Caption = 'Date Taken';
                }
                field(expenditureDate; Rec."Expenditure Date")
                {
                    Caption = 'Expenditure Date';
                }
                field(externalDocNo; Rec."External Doc No.")
                {
                    Caption = 'External Doc No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(purpose; Rec.Purpose)
                {
                    Caption = 'Purpose';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
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
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    Caption = 'Shortcut Dimension 4 Code';
                }
                field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code")
                {
                    Caption = 'Shortcut Dimension 5 Code';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(typeOfSurrender; Rec."Type of Surrender")
                {
                    Caption = 'Type of Surrender';
                }
            }
        }
    }
}

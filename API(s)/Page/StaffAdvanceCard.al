page 51534387 StaffAdvanceCard
{
    APIGroup = 'StaffAdvance';
    APIPublisher = 'RBS';
    APIVersion = 'v1.0';
    Caption = 'staffAdvanceCard';
    DelayedInsert = true;
    EntityName = 'StaffAdvanceCard';
    EntitySetName = 'StaffAdvanceCard';
    PageType = API;
    SourceTable = "Staff Advance Header";
    ODataKeyFields = "No.";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(accountNo; Rec."Account No.")
                {
                    Caption = 'Account No.';
                }
                field(chequeNo; Rec."Cheque No.")
                {
                    Caption = 'Cheque No.';
                }
                field(externalDocNo; Rec."External Doc No.")
                {
                    Caption = 'External Doc No.';
                }
                field(accountType; Rec."Account Type")
                {
                    Caption = 'Account Type';
                }
                field(bankName; Rec."Bank Name")
                {
                    Caption = 'Bank Name';
                }
                field("date"; Rec."Date")
                {
                    Caption = 'Date';
                }
                field(payMode; Rec."Pay Mode")
                {
                    Caption = 'Pay Mode';
                }
                field(payee; Rec.Payee)
                {
                    Caption = 'Payee';
                }
                field(onBehalfOf; Rec."On Behalf Of")
                {
                    Caption = 'On Behalf Of';
                }
                field(payingBankAccount; Rec."Paying Bank Account")
                {
                    Caption = 'Paying Bank Account';
                }
                field(paymentReleaseDate; Rec."Payment Release Date")
                {
                    Caption = 'Payment Release Date';
                }
                field(paymentType; Rec."Payment Type")
                {
                    Caption = 'Payment Type';
                }
                field(posted; Rec.Posted)
                {
                    Caption = 'Posted';
                }
                field(postedBy; Rec."Posted By")
                {
                    Caption = 'Posted By';
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
                field(cashier; Rec.Cashier)
                {
                    Caption = 'Cashier';
                }
                field(budgetCenterName; Rec."Budget Center Name")
                {
                    Caption = 'Budget Center Name';
                }
                field(cancellationRemarks; Rec."Cancellation Remarks")
                {
                    Caption = 'Cancellation Remarks';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(datePosted; Rec."Date Posted")
                {
                    Caption = 'Date Posted';
                }
            }
            part(StaffAdvanceLine; StaffAdvanceLine)
            {
                Caption = 'Line';
                EntityName = 'StaffAdvanceLine';
                EntitySetName = 'StaffAdvanceLine';
                SubPageLink = "No." = Field("No.");
            }
        }
    }
}
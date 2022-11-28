page 51534394 "Staff Claims API"
{
    APIGroup = 'StaffClaHead';
    APIPublisher = 'Reeltech';
    APIVersion = 'v1.0';
    Caption = 'staffClaimsAPI';
    DelayedInsert = true;
    EntityName = 'StaffClaims';
    EntitySetName = 'StaffclaimAPI';
    PageType = API;
    SourceTable = "Staff Claims Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field("date"; Rec."Date")
                {
                    Caption = 'Date';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(functionName; Rec."Function Name")
                {
                    Caption = 'Function Name';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(budgetCenterName; Rec."Budget Center Name")
                {
                    Caption = 'Budget Center Name';
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                }
                field(ecuCodeDescription; Rec."ECU Code Description")
                {
                    Caption = 'ECU Code Description';
                }
                field(accountNo; Rec."Account No.")
                {
                    Caption = 'Account No.';
                }
                field(payee; Rec.Payee)
                {
                    Caption = 'Payee';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(payMode; Rec."Pay Mode")
                {
                    Caption = 'Pay Mode';
                }
                field(payingBankAccount; Rec."Paying Bank Account")
                {
                    Caption = 'Paying Bank Account';
                }
                field(bankName; Rec."Bank Name")
                {
                    Caption = 'Bank Name';
                }
                field(purpose; Rec.Purpose)
                {
                    Caption = 'Purpose';
                }
                field(cashier; Rec.Cashier)
                {
                    Caption = 'Cashier';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(totalNetAmount; Rec."Total Net Amount")
                {
                    Caption = 'Total Net Amount';
                }
                field(totalNetAmountLCY; Rec."Total Net Amount LCY")
                {
                    Caption = 'Total Net Amount LCY';
                }
                field(paymentReleaseDate; Rec."Payment Release Date")
                {
                    Caption = 'Payment Release Date';
                }
                field(chequeNo; Rec."Cheque No.")
                {
                    Caption = 'Cheque No.';
                }
                field(attachment; Rec.Attachment)
                {
                    Caption = 'Attachment';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(groupHeadToApprove; Rec."Group Head to Approve")
                {
                    Caption = 'Group Head to Approve';
                }
                field(rebursehandlerID; Rec."Rebursehandler ID")
                {
                    Caption = 'Rebursehandler ID';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}

page 51534397 "Staff Advance Retirment API"
{
    APIGroup = 'Surrender';
    APIPublisher = 'Reeltech';
    APIVersion = 'v1.0';
    Caption = 'staffAdvanceRetirmentAPI';
    DelayedInsert = true;
    EntityName = 'StaffadvanceSurrHead';
    EntitySetName = 'StaffAdvancesurrHeadAPI';
    PageType = API;
    SourceTable = "Staff Advance Surrender Header";

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
                field(imprestIssueDocNo; Rec."Imprest Issue Doc. No")
                {
                    Caption = 'Advance Issue Doc. No';
                }
                field(surrenderDate; Rec."Surrender Date")
                {
                    Caption = 'Surrender Date';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
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
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(surrendered; Rec.Surrendered)
                {
                    Caption = 'Surrendered';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}

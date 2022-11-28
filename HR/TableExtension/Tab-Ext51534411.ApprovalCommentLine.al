tableextension 51534411 ApprovalCommentLine extends "Approval Comment Line"
{
    fields
    {
        field(51534400; "Approved Days"; Decimal)
        {
            Caption = 'Approved Days';
            DataClassification = ToBeClassified;
        }
        field(51534401; "Approved Start Date"; Date)
        {
            Caption = 'Approved Start Days';
            DataClassification = ToBeClassified;
        }
        field(51534402; "Approved Return Date"; Date)
        {
            Caption = 'Approved Return Date';
            DataClassification = ToBeClassified;
        }
        field(51534403; Reason; Text[100])
        {
            Caption = 'Reason';
            DataClassification = ToBeClassified;
        }
        field(51534404; "Leave Allowance Granted"; decimal)
        {
            Caption = 'Leave Allowance Granted';
            DataClassification = ToBeClassified;
        }

    }
}

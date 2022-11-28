table 51534403 "With-Holding Tax Setup"
{
    DrillDownPageId = "With-Holding Tax Setup";
    LookupPageId = "With-Holding Tax Setup";
    Caption = 'With-Holding Tax Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;

        }
        field(2; Discription; Text[50])
        {
            Caption = 'Discription';
            DataClassification = ToBeClassified;
        }
        field(3; "W/Tax Rate"; Decimal)
        {
            Caption = '%Rate';
            DataClassification = ToBeClassified;
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}

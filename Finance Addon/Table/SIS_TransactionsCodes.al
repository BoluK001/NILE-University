table 51534363 SIS_Transactions_Codes
{
    Caption = 'SIS_Transactions_Codes';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; CodeID; Integer)
        {
            Caption = 'CodeID';
            DataClassification = ToBeClassified;
        }
        field(2; TransCode; Code[20])
        {
            Caption = 'TransCode';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Date Created"; DateTime)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
        }
        field(5; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date';
            DataClassification = ToBeClassified;
        }
        field(6; IsActive; Boolean)
        {
            Caption = 'Active';
            DataClassification = ToBeClassified;
        }
        field(7; "Under Graduate GL Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting), Blocked = CONST(false), "Direct Posting" = const(true));
        }
        field(8; "Post Graduate GL Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting), Blocked = CONST(false), "Direct Posting" = const(true));
        }
        field(9; "Premilary GL Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting), Blocked = CONST(false), "Direct Posting" = const(true));
        }
    }
    keys
    {
        key(PK; CodeID)
        {
            Clustered = true;
        }
    }
}

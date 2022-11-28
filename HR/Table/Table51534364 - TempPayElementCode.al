table 51534400 "Temp Pay Element Code"
{
    Caption = 'Temp Pay Element Code';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "G/L Code"; Code[20])
        {
            Caption = 'G/L Code';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Pay Element Code")
        {
            Clustered = true;
        }
    }

}

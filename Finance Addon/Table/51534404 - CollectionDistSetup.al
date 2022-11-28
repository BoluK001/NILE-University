table 51534404 "Collection Dist. Setup"
{
    Caption = 'Collection Dist. Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
            trigger OnValidate()
            var
                BankAcct: Record "Bank Account";
            begin
                If BankAcct.get("Bank Code") then
                    "Bank Name" := BankAcct.Name;
            end;
        }
        field(2; "Bank Name"; Text[100])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Distribution Percentage"; Decimal)
        {
            Caption = 'Distribution Percentage';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                GLSetup: Record "General Ledger Setup";
                DistPerc: Decimal;
            begin
                /*   GLSetup.Reset();
                   GLSetup.Get();
                   if "Distribution Percentage" > GLSetup."Collection Dist. %" then
                       Error('The total Percentage Distribution has exceed 100%');
                       */
            end;
        }
    }
    keys
    {
        key(PK; "Bank Code")
        {
            Clustered = true;
        }
    }

}

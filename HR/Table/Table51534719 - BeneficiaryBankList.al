table 51534719 "Beneficiary Bank List"
{
    Caption = 'Beneficiary Bank List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20]) { DataClassification = ToBeClassified; }
        field(2; "Bank Code"; Code[20]) { DataClassification = ToBeClassified; }
        field(3; "Branch Code"; Code[20]) { DataClassification = ToBeClassified; }
        field(4; "Bank Name"; Text[30]) { DataClassification = ToBeClassified; }
        field(5; "SWIFT CODE"; Text[30]) { DataClassification = ToBeClassified; }
    }
    KEYS
    {
        key(Key1; Code, "Bank Name")
        {
            Clustered = true;
        }
    }
}

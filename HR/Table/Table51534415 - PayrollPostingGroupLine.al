table 51534415 "Payroll Posting Group Line"
{

    fields
    {
        field(1; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Pay Element"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "prTransaction Codes"."Transaction Code";
        }
        field(3; "Debit Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Vendor,Customer';
            OptionMembers = "G/L Account",Vendor,Customer;
        }
        field(4; "Debit Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Debit Account Type" = Filter("G/L Account")) "G/L Account"
            ELSE
            IF ("Debit Account Type" = FILTER(Vendor)) Vendor
            ELSE
            IF ("Debit Account Type" = FILTER(Customer)) Customer;

            trigger OnValidate()
            begin
                "Credit Account No." := '';
            end;
        }
        field(5; "Credit Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Vendor,Customer';
            OptionMembers = "G/L Account",Vendor,Customer;
        }
        field(6; "Credit Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Credit Account Type" = FILTER("G/L Account")) "G/L Account"
            ELSE
            IF ("Credit Account Type" = FILTER(Customer)) Customer
            ELSE
            IF ("Credit Account Type" = FILTER(Vendor)) Vendor;

            trigger OnValidate()
            begin
                "Debit Account No." := '';
            end;
        }
    }

    keys
    {
        key(Key1; "Group Code", "Pay Element")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


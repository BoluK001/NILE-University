table 51534407 "Bank Allocation Rate"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bank Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
            trigger OnValidate()
            var
                BankCode: Record "Bank Account";
            begin

                if BankCode.get("Bank Code") then
                    "Bank Name" := BankCode.Name;
            end;

        }
        field(2; "Bank Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                pebank: Record "Bank Allocation Rate";
                totper: Decimal;
            begin
                pebank.Reset();
                if pebank.FindFirst()
                then
                    repeat
                        totper += pebank.Percentage;
                    until pebank.Next() = 0;
                if totper > 100 then
                    error('Total Allocation percentage Cannot be More Than 100');

            end;
        }

    }

    keys
    {
        key(Pk; "Bank Code")
        {
            Clustered = true;
        }
    }

    var
        BankAll: Record "Bank Allocation Rate";

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
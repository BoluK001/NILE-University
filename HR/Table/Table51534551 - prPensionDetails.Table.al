table 51534551 "prPension Details"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(2; "Pension Number"; Code[50])
        {
            NotBlank = true;
        }
        field(3; Company; Text[100])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; "Deduct premium"; Boolean)
        {
        }
        field(6; balance; Decimal)
        {
        }
        field(7; lumpsumitems; Boolean)
        {
            Description = 'lump sum the values';
        }
        field(8; "Is Insurance policy"; Boolean)
        {
            Description = 'True if its an insurance policy';
        }
        field(9; "Transaction Code"; Code[20])
        {
            TableRelation = "prTransaction Codes"."Transaction Code";
        }
        field(10; "Inception Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Pension Number", Company)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


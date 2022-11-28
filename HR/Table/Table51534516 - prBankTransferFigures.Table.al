table 51534516 "prBank Transfer Figures"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(2; "Bank Code"; Code[20])
        {
        }
        field(3; "Branch Code"; Code[20])
        {
        }
        field(4; "Account No"; Text[50])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Period Month"; Integer)
        {
        }
        field(7; "Period Year"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


table 51534639 "HR Applicant Test Details"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Test Code"; Code[20])
        {
            TableRelation = "HR Applicant Test";
        }
        field(3; "Applicant No."; Code[20])
        {
            TableRelation = "HR Job Applications";
        }
        field(4; "Requisition No."; Code[20])
        {
            TableRelation = "HR Employee Requisitions";
        }
        field(5; Score; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Applicant No.", "Requisition No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


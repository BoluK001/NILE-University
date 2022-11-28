table 51534638 "HR Applicant Test"
{

    fields
    {
        field(1; "Test Code"; Code[20])
        {
        }
        field(2; "Requsition Number"; Code[20])
        {
            TableRelation = "HR Employee Requisitions";
        }
        field(3; Date; Date)
        {
        }
        field(4; Venue; Text[100])
        {
        }
        field(5; Time; Time)
        {
        }
        field(6; "Pass Mark"; Decimal)
        {
        }
        field(15; Score; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Test Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


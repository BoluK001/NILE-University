table 51534644 "HR Training Development PlanL1"
{

    fields
    {
        field(1; "Training Application No."; Code[30])
        {
            TableRelation = "HR Training Applications"."Application No";
        }
        field(2; "Key Development Area"; Code[30])
        {
            TableRelation = "HR Training Needs".Code;
        }
        field(3; "KDA Description"; Text[250])
        {
        }
        field(4; "Purpose of Training"; Text[250])
        {
        }
        field(5; "Start Date"; Date)
        {
        }
        field(6; "End Date"; Date)
        {
        }
        field(7; "Duration Units"; Option)
        {
            OptionMembers = " ",Hours,Days,Weeks,Months,Years;
        }
        field(8; Duration; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Training Application No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        mDay: Integer;
        HRLeaveApp: Record "HR Leave Application";
        HRTrainNeeds: Record "HR Training Needs";
}


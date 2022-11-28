table 51534630 "HR Appraisal Obj Template"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; Grade; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST(Grade));
        }
        field(4; Criteria; Text[250])
        {
        }
        field(5; "Behavioural Category"; Code[50])
        {
            TableRelation = "HR Appraisal Behaviourals";
        }
        field(6; Level; Option)
        {
            OptionCaption = ' ,1-4,5-8';
            OptionMembers = " ","1-4","5-8";
        }
        field(7; Description; Text[200])
        {
        }
        field(8; "Weigthed Score"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
    }

    keys
    {
        key(Key1; "Line No.", Level)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


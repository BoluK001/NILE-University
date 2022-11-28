table 51534610 "HR Appraisal Career Dev"
{

    fields
    {
        field(1; "Appraisal Code"; Code[20])
        {
        }
        field(2; Question; Text[200])
        {
        }
        field(3; Answer; Text[200])
        {
        }
        field(4; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(5; "Appraisal Half"; Option)
        {
            OptionMembers = " ",First,Second;
        }
        field(6; "Employee No."; Code[20])
        {
        }
        field(9; "Appraisal Period"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Appraisal Code", "Line No.", "Employee No.")
        {
            Clustered = true;
        }
        key(Key2; Question, Answer)
        {
        }
    }

    fieldgroups
    {
    }

    var
        HRAppraisalRating: Record "HR Appraisal Career Dev";
}


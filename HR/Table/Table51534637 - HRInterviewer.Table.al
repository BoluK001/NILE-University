table 51534637 "HR Interviewer"
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = "HR-Employee";

            trigger OnValidate()
            begin
                if HrEmployee.Get("Employee No.") then begin
                    "First Name" := HrEmployee."First Name";
                    "Middle Name" := HrEmployee."Middle Name";
                    "Last Name" := HrEmployee."Last Name";
                end;
            end;
        }
        field(2; "Interview No."; Text[30])
        {
            TableRelation = "Hr Interview Evaluation"."Interview No." WHERE ("Interview No." = FIELD ("Interview No."));
        }
        field(3; "First Name"; Text[30])
        {
        }
        field(4; "Middle Name"; Text[30])
        {
        }
        field(5; "Last Name"; Text[30])
        {
        }
        field(6; Stage; Option)
        {
            OptionCaption = ' ,Stage1,Stage2,Stage3';
            OptionMembers = " ",Stage1,Stage2,Stage3;
        }
        field(7; "ED/MD Recommendation"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Interview No.", "Employee No.", Stage)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HrEmployee: Record "HR-Employee";
}


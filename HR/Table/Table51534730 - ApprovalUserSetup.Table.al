table 51534730 "Approval User Setup"
{

    fields
    {
        field(1; "Approval Type"; Option)
        {
            OptionMembers = Appraisal;
        }
        field(2; "Approver ID"; Code[50])
        {
            TableRelation = "User Setup";

            trigger OnValidate()
            begin
                Users.SetRange(Users."User Name", "Approver ID");
                if Users.FindFirst then
                    "Approver Name" := Users."Full Name";

                if UserSetup.Get("Approver ID") then
                    "E-Mail" := UserSetup."E-Mail"
            end;
        }
        field(3; "Approver Name"; Text[150])
        {
        }
        field(4; "E-Mail"; Text[250])
        {
        }
        field(5; "Sequence No."; Integer)
        {
            AutoIncrement = false;
        }
        field(6; "User ID"; Code[50])
        {
            TableRelation = "User Setup";
        }
    }

    keys
    {
        key(Key1; "Approval Type", "Approver ID", "Sequence No.")
        {
            Clustered = true;
        }
        key(Key2; "Sequence No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User ID" := UserId;
    end;

    var
        Users: Record User;
        UserSetup: Record "User Setup";
}


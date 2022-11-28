table 51534587 "HR Human Resource Comments"
{

    fields
    {
        field(1; "Table Name"; Option)
        {
            OptionMembers = Employee,Relative,"Relation Management","Correspondence History",Images,"Absence and Holiday","Cost to Company","Pay History","Bank Details",Maternity,"SAQA Training History","Absence Information","Incident Report","Emp History","Medical History","Career History",Appraisal,Disciplinary,"Exit Interviews",Grievances,"Existing Qualifications","Proffesional Membership","Education Assistance","Learning Intervention","NOSA or other Training","Company Skills Plan","Development Plan","Skills Plan","Emp Salary",Unions;
        }
        field(2; "No."; Code[20])
        {
            /*
            TableRelation = IF ("Table Name" = CONST(Employee)) Table39005681.Field1
            ELSE
            IF ("Table Name" = CONST(Relative)) Table39005689.Field1
            ELSE
            IF ("Table Name" = CONST("Relation Management")) Table39005692.Field1
            ELSE
            IF ("Table Name" = CONST("Correspondence History")) Table39005695.Field1
            ELSE
            IF ("Table Name" = CONST(Images)) Table39005696.Field1
            ELSE
            IF ("Table Name" = CONST("Absence and Holiday")) "HR Absence and Holiday"."Employee No."
            ELSE
            IF ("Table Name" = CONST("Cost to Company")) "HR Training Development Plan L"."Training Application No."
            ELSE
            IF ("Table Name" = CONST("Bank Details")) Table39005703.Field1
            ELSE
            IF ("Table Name" = CONST(Maternity)) Table39005706.Field1
            ELSE
            IF ("Table Name" = CONST("SAQA Training History")) Table39005707.Field1
            ELSE
            IF ("Table Name" = CONST("Absence Information")) Table39005716.Field1;
            */
        }
        field(3; "Table Line No."; Integer)
        {
        }
        field(4; "Key Date"; Date)
        {
        }
        field(6; "Line No."; Integer)
        {
        }
        field(7; Date; Date)
        {
        }
        field(8; "Code"; Code[20])
        {
        }
        field(9; Comment; Text[80])
        {
        }
        field(10; User; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Table Name", "Table Line No.")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lRec_UserTable: Record User;
    begin

        lRec_UserTable.Get(UserId);
        User := lRec_UserTable."Full Name";
        Date := WorkDate;
    end;

    trigger OnModify()
    var
        lRec_UserTable: Record User;
    begin

        lRec_UserTable.Get(UserId);
        User := lRec_UserTable."Full Name";
        Date := WorkDate;
    end;

    [Scope('OnPrem')]
    procedure SetUpNewLine()
    var
        HumanResCommentLine: Record "HR Human Resource Comments";
    begin
        HumanResCommentLine := Rec;
        HumanResCommentLine.SetRecFilter;
        HumanResCommentLine.SetRange("Line No.");
        if not HumanResCommentLine.Find('-') then
            Date := WorkDate;
    end;
}


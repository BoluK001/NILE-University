table 51534405 "Sub. Department"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Sub. Dept.";
    LookupPageID = "Sub. Dept.";
    Caption = 'Unit/Section';

    fields
    {

        field(2; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Name; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1; "Dept. Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department.Code;
        }
        field(4; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Code, "Dept. Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Description)
        {
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}

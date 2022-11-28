table 51534406 Department
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Dept.";
    LookupPageID = "Dept.";
    Caption = 'Division';

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Dim. Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".code where("Global Dimension No." = filter(3));
            trigger OnValidate()
            var
                DimValue: Record "Dimension Value";
            begin
                //if DimValue.get()
            end;
        }

        field(3; "Department Name"; Text[50])
        {

        }
    }

    keys
    {
        key(Key1; "Dim. Code", Code)
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


table 51534412 "Semester Setup"
{

    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Semester Code"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Semester Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Semester Districption"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Start Date" = 0D Then
                    error('Start Date Must Be Enter');
                "Days in Semester" := ("End Date" - "Start Date") + 1;

            end;
        }

        field(6; "Days in Semester"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Semester Code", "Semester Year")
        {
            Clustered = true;
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
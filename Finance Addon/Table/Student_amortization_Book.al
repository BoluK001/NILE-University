table 51534411 "Student Amortization Book"
{

    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

        }
        field(2; "Semester Code"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Semester Setup"."Semester Code";
        }
        field(3; "Semester Year"; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                SemSetup: Record "Semester Setup";
            begin
                if SemSetup.get("Semester Code", "Semester Year") then begin
                    "Semester Start Date" := SemSetup."Start Date";
                    "Semester End Date" := SemSetup."End Date";
                    "Days In Semester" := SemSetup."Days in Semester";

                end;
            end;
        }
        field(4; "Semester Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Semester End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Days In Semester"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Semester School Fees"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Amortized School Fees"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Last Date Amortized"; Date)
        {
            DataClassification = ToBeClassified;
        }




    }

    keys
    {
        key(PK; "Student Code", "Semester Code", "Semester Year")
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
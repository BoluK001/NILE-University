table 51534570 "HR Job Requirements"
{

    fields
    {
        field(1; "Job Id"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HR Jobs"."Job ID";
        }
        field(2; "Qualification Type"; Code[20])
        {
            NotBlank = false;
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER("Qualification Type"));
        }
        field(3; "Qualification Code"; Code[30])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = "HR Qualifications".Code WHERE("Qualification Type" = FIELD("Qualification Type"));

            trigger OnValidate()
            begin
                /*.SETFILTER(Requirments."Qualification Type","Qualification Type");
                Requirments.SETFILTER(Requirments.Code,"Qualification Code");
                IF Requirments.FIND('-') THEN
                 Qualification := Requirments.Description; */


                if HRQualifications.Get("Qualification Type", "Qualification Code") then
                    "Qualification Description" := HRQualifications.Description;

            end;
        }
        field(6; Priority; Option)
        {
            OptionMembers = " ",High,Medium,Low;
        }
        field(8; "Score ID"; Decimal)
        {
        }
        field(9; "Need code"; Code[20])
        {
            //TableRelation = Table0;
        }
        field(10; "Stage Code"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST(Scores));
        }
        field(11; Mandatory; Boolean)
        {
        }
        field(12; "Desired Score"; Decimal)
        {
        }
        field(13; "Total (Stage)Desired Score"; Decimal)
        {
        }
        field(14; "Qualification Description"; Text[100])
        {
        }
        field(15; "Class of Degree"; Option)
        {
            OptionMembers = " ",Distinction,"First Class","Second Class Upper","Second Class Lower","Third Class",Pass;
        }
    }

    keys
    {
        key(Key1; "Job Id", "Qualification Type", "Qualification Code")
        {
            Clustered = true;
            SumIndexFields = "Score ID";
        }
    }

    fieldgroups
    {
    }

    var
        HRQualifications: Record "HR Qualifications";
}


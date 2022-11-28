table 51534738 "HR Oral Interview Template"
{

    fields
    {
        field(1; "Oral Interview Code"; Text[50])
        {
        }
        field(2; "Oral Interview Group"; Code[50])
        {
            TableRelation = "HR Oral Interview Group";
        }
        field(3; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(4; "Target Score"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(5; "Experience Level"; Option)
        {
            OptionMembers = " ","0-4 Years","5 Years & Above";
        }
        field(6; Rating; Option)
        {
            OptionCaption = 'Below,Good/Average,Above Average,Outstanding,Foundation,Last Stage/Progress,Qualified';
            OptionMembers = Below,"Good/Average","Above Average",Outstanding,Foundation,"Last Stage/Progress",Qualified;
        }
    }

    keys
    {
        key(Key1; "Oral Interview Group")
        {
            Clustered = true;
        }
        key(Key2; "Experience Level", "Oral Interview Code", "Entry No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Oral Interview Group", "Oral Interview Code")
        {

        }
    }
}


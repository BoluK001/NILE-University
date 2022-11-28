table 51534401 "HR Applicant Hobbies"
{

    fields
    {
        field(1; "Job Application No"; Code[20])
        {
            TableRelation = "HR Job Applications"."Application No";
        }
        field(2; Hobby; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Job Application No", Hobby)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


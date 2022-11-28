table 51534600 "HR E-Mail Parameters"
{

    fields
    {
        field(1; "Associate With"; Option)
        {
            Caption = 'Associate With';
            //OptionMembers = "Vacancy Advertisements","Interview Invitations",General,"Training Application","Disciplinary Commitee","Query",Communication,Birthday;  //jj i remmed 300922
            OptionMembers = "Vacancy Advertisements","Interview Invitations",General,"Training Application","Disciplinary Commitee","Query",Communication,Birthday;  //jj i remmed 300922
            OptionCaption = ',,,Training Application,,,';
        }
        field(2; "Sender Name"; Text[30])
        {
        }
        field(3; "Sender Address"; Text[100]) // jj270422 I increased char lenght from 30
        {
        }
        field(4; Recipients; Text[150])
        {
        }
        field(5; Subject; Text[100])
        {
        }
        field(6; Body; Text[250])
        {
        }
        field(7; "Body 2"; Text[250])
        {
        }
        field(8; HTMLFormatted; Boolean)
        {
        }
        field(9; "Body 3"; Text[250])
        {
        }
        field(10; "Body 4"; Text[250])
        {
        }
        field(11; "Body 5"; Text[250])
        {
        }
        field(12; Image; BLOB)
        {
            SubType = Bitmap;
        }
    }

    keys
    {
        key(Key1; "Associate With")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


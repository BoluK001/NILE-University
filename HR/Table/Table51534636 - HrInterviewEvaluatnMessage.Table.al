table 51534636 "Hr Interview Evaluatn Message"
{

    fields
    {
        field(10; "Code"; Code[20])
        {
        }
        field(20; Stages; Option)
        {
            OptionMembers = " ","Invite for Interview","Recommend for Stage 2","Recommend for Stage 3","Recommend for Hire","Recommend for HMO",Successful,"Not Successful",Pending,"Invite for Test";
        }
        field(25; Subject; Text[250])
        {
        }
        field(30; Message; Text[250])
        {
        }
        field(40; Venue; Text[250])
        {
        }
        field(50; Date; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


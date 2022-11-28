tableextension 51534412 MiscArticleInfo extends "Misc. Article Information"
{
    fields
    {
        field(51534400; Returned; Boolean)
        {
        }
        field(51534401; "Status On Return"; Option)
        {
            OptionMembers = Ok,"Needs Repair","Needs Maintenance";
        }
        field(51534402; "Date Returned"; Date)
        {
        }
        field(51534403; Recommendations; Text[150])
        {
        }
        field(51534404; "Received By"; Code[30])
        {
            Editable = false;
        }
    }
}



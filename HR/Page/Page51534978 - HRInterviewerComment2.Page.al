page 51534978 "HR Interviewer Comment2"
{
    PageType = ListPart;
    SourceTable = "HR Interviewer Comment";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Interview No."; "Interview No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Interviewer No."; "Interviewer No.")
                {
                    ApplicationArea = all;
                }
                field("Interviewer Name"; "Interviewer Name")
                {
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                }
                field(Recommendation; Recommendation)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}


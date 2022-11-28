page 51534426 "Hr Test List"
{
    AdditionalSearchTerms = 'Hr Test List';
    ApplicationArea = all;
    PageType = List;
    CardPageID = "Hr Applicant Test Card";
    SourceTable = "HR Applicant Test";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Test Code"; "Test Code")
                {
                    ApplicationArea = all;
                }
                field("Requsition Number"; "Requsition Number")
                {
                    ApplicationArea = all;
                }
                field(Date; Date)
                {
                    ApplicationArea = all;
                }
                field(Venue; Venue)
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Notes)
            {
            }
        }
    }

    actions
    {
    }
}


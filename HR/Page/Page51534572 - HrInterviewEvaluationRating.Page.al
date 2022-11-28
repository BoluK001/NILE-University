page 51534572 "Hr Interview Evaluation Rating"
{
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'Hr Interview Evaluation Rating';
    UsageCategory = Lists;
    SourceTable = "Hr Interview Evalution Rating";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Score; Score)
                {
                    ApplicationArea = all;
                }
                field(Recommendations; Recommendations)
                {
                    ApplicationArea = all;
                }
                field("Description 2"; "Description 2")
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


page 51534574 "Hr Interview Evaluation Areas"
{
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'Hr Interview Evaluation Areas';
    UsageCategory = Lists;
    SourceTable = "Hr Interview Evaluation Areas";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Evaluation Code"; "Evaluation Code")
                {
                    ApplicationArea = all;
                }
                field("Evaluation Description"; "Evaluation Description")
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


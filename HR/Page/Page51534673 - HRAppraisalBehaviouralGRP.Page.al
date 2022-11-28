page 51534673 "HR Appraisal Behavioural GRP"
{
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Appraisal Behaviourals";
    AdditionalSearchTerms = 'HR Appraisal Behavioural GRP';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Behavioural Group"; "Behavioural Group")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Rating; Rating)
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


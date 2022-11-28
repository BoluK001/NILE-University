page 51534586 "Job Training Needs Subform"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Jobx Training Needs";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Job Training Needs Subform';

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
            }
        }
    }

    actions
    {
    }
}


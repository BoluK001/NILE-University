page 51534689 "HR Appraisal Objective List"
{
    CardPageID = "HR Appraisal Objective Header";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Appraisal Objective List';
    SourceTable = "HR Appraisal Objective Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Level; Level)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}


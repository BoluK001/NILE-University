page 51534594 "HR Appraisal DevelopmentLines1"
{
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Appraisal Evaluations";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Category; Category)
                {
                    ApplicationArea = all;
                }
                field("<Groups>"; Group)
                {
                    ApplicationArea = all;
                }
                field("Sub Category"; "Sub Category")
                {
                    ApplicationArea = all;
                }
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


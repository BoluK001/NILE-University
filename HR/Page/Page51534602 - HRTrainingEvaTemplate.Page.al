page 51534602 "HR Training Eva. Template"
{
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Training Eval. question line";
    AdditionalSearchTerms = 'HR Training Eva. Template';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Training Eval Question No."; "Training Eval Question No.")
                {
                    ApplicationArea = all;
                }
                field("Training Category"; "Training Category")
                {
                    ApplicationArea = all;
                }
                field("Training Eval. Question"; "Training Eval. Question")
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

